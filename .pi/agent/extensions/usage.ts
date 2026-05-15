import type { ExtensionAPI, ExtensionCommandContext } from "@earendil-works/pi-coding-agent";
import { matchesKey, truncateToWidth } from "@earendil-works/pi-tui";
import { readFile, writeFile } from "node:fs/promises";
import { homedir } from "node:os";
import { join } from "node:path";

const PI_AUTH_PATH = join(homedir(), ".pi", "agent", "auth.json");
const CODEX_AUTH_PATH = join(homedir(), ".codex", "auth.json");
const CODEX_USAGE_URL = "https://chatgpt.com/backend-api/wham/usage";
const OPENAI_OAUTH_TOKEN_URL = "https://auth.openai.com/oauth/token";
const OPENAI_CODEX_CLIENT_ID = "app_EMoamEEZ73f0CkXaXp7hrann";
const TOKEN_REFRESH_SKEW_MS = 60_000;
const BAR_WIDTH = 54;

type JsonObject = Record<string, unknown>;

type Credential = {
  kind: "pi" | "codex";
  path: string;
  root: JsonObject;
  node: JsonObject;
  accessToken: string;
  refreshToken?: string;
  accountId?: string;
  expiresAt?: number;
};

type RateLimitWindow = {
  used_percent?: number;
  reset_at?: number;
};

type UsagePayload = {
  rate_limit?: {
    allowed?: boolean;
    limit_reached?: boolean;
    primary_window?: RateLimitWindow | null;
    secondary_window?: RateLimitWindow | null;
  } | null;
  credits?: {
    has_credits?: boolean;
    unlimited?: boolean;
    overage_limit_reached?: boolean;
    balance?: string | null;
  } | null;
  rate_limit_reached_type?: { type?: string } | string | null;
};

type SessionStats = {
  cost: number;
  input: number;
  output: number;
  cacheRead: number;
  cacheWrite: number;
  wallSeconds: number | null;
  contributors24h: Array<{ label: string; tokens: number; percent: number }>;
};

export default function usageExtension(pi: ExtensionAPI) {
  pi.registerCommand("usage", {
    description: "Show OpenAI Codex usage limits",
    handler: async (_args, ctx) => {
      try {
        const credential = await loadCredential();
        if (!credential) {
          ctx.ui.notify("Codex usage unavailable: no OpenAI Codex login found. Run /login openai-codex first.", "error");
          return;
        }

        const [usage, stats] = await Promise.all([fetchUsage(credential), Promise.resolve(collectSessionStats(ctx))]);
        const output = formatUsage(usage, stats);

        if (ctx.hasUI) {
          await showUsageModal(ctx, output);
        } else {
          ctx.ui.notify(output, "info");
        }
      } catch (error) {
        ctx.ui.notify(`Codex usage failed: ${errorMessage(error)}`, "error");
      }
    },
  });
}

async function showUsageModal(ctx: ExtensionCommandContext, output: string): Promise<void> {
  await ctx.ui.custom<void>((_tui, _theme, _keybindings, done) => ({
    render(width: number): string[] {
      return [...output.split("\n"), "", "Esc/q to close"].map((line) => truncateToWidth(line, width));
    },
    handleInput(data: string): void {
      if (matchesKey(data, "escape") || matchesKey(data, "ctrl+c") || data === "q") done();
    },
    invalidate(): void { },
  }));
}

async function loadCredential(): Promise<Credential | null> {
  return (await loadPiCredential()) ?? (await loadCodexCredential());
}

async function loadPiCredential(): Promise<Credential | null> {
  const root = await readJson(PI_AUTH_PATH);
  const node = object(root?.["openai-codex"]);
  const accessToken = string(node?.access);
  if (!root || !node || !accessToken) return null;

  return {
    kind: "pi",
    path: PI_AUTH_PATH,
    root,
    node,
    accessToken,
    refreshToken: string(node.refresh),
    accountId: string(node.accountId),
    expiresAt: number(node.expires) ?? jwtExpiresAt(accessToken),
  };
}

async function loadCodexCredential(): Promise<Credential | null> {
  const root = await readJson(CODEX_AUTH_PATH);
  const node = object(root?.tokens);
  const accessToken = string(node?.access_token);
  if (!root || !node || !accessToken) return null;

  return {
    kind: "codex",
    path: CODEX_AUTH_PATH,
    root,
    node,
    accessToken,
    refreshToken: string(node.refresh_token),
    accountId: string(node.account_id),
    expiresAt: jwtExpiresAt(accessToken),
  };
}

async function fetchUsage(credential: Credential): Promise<UsagePayload> {
  let current = isExpired(credential) ? await refreshCredential(credential) : credential;
  let response = await requestUsage(current);

  if (response.status === 401 && current.refreshToken) {
    current = await refreshCredential(current);
    response = await requestUsage(current);
  }

  const body = await response.text();
  if (!response.ok) throw new Error(`HTTP ${response.status}: ${trimBody(body)}`);
  return JSON.parse(body) as UsagePayload;
}

async function requestUsage(credential: Credential): Promise<Response> {
  const headers: Record<string, string> = {
    accept: "application/json",
    authorization: `Bearer ${credential.accessToken}`,
    "user-agent": "codex-cli",
  };
  if (credential.accountId) headers["ChatGPT-Account-ID"] = credential.accountId;

  return fetch(process.env.CODEX_USAGE_URL ?? CODEX_USAGE_URL, { headers });
}

async function refreshCredential(credential: Credential): Promise<Credential> {
  if (!credential.refreshToken) throw new Error("access token expired and no refresh token is available");

  const response = await fetch(process.env.CODEX_REFRESH_TOKEN_URL ?? OPENAI_OAUTH_TOKEN_URL, {
    method: "POST",
    headers: { "content-type": "application/json" },
    body: JSON.stringify({
      client_id: OPENAI_CODEX_CLIENT_ID,
      grant_type: "refresh_token",
      refresh_token: credential.refreshToken,
    }),
  });

  const body = await response.text();
  if (!response.ok) throw new Error(`token refresh failed with HTTP ${response.status}: ${trimBody(body)}`);

  const refresh = JSON.parse(body) as { access_token?: string; refresh_token?: string; id_token?: string };
  const accessToken = refresh.access_token;
  if (!accessToken) throw new Error("token refresh response did not include an access token");

  const current: Credential = {
    ...credential,
    accessToken,
    refreshToken: refresh.refresh_token ?? credential.refreshToken,
    expiresAt: jwtExpiresAt(accessToken),
  };

  persistTokens(current, { ...refresh, access_token: accessToken });
  await writeJson(current.path, current.root);
  return current;
}

function persistTokens(credential: Credential, refresh: { access_token: string; refresh_token?: string; id_token?: string }): void {
  if (credential.kind === "pi") {
    credential.node.access = refresh.access_token;
    if (refresh.refresh_token) credential.node.refresh = refresh.refresh_token;
    if (credential.expiresAt) credential.node.expires = credential.expiresAt;
    return;
  }

  credential.node.access_token = refresh.access_token;
  if (refresh.refresh_token) credential.node.refresh_token = refresh.refresh_token;
  if (refresh.id_token) credential.node.id_token = refresh.id_token;
  credential.root.last_refresh = new Date().toISOString();
}

function collectSessionStats(ctx: ExtensionCommandContext): SessionStats {
  const now = Date.now();
  const contributors = new Map<string, number>();
  const stats = { cost: 0, input: 0, output: 0, cacheRead: 0, cacheWrite: 0 };
  let firstTimestamp: number | null = null;

  for (const entry of ctx.sessionManager.getBranch() as unknown as Array<JsonObject>) {
    const entryTimestamp = timestampMs(entry.timestamp);
    if (entryTimestamp !== null) firstTimestamp = firstTimestamp === null ? entryTimestamp : Math.min(firstTimestamp, entryTimestamp);
    if (entry.type !== "message") continue;

    const message = object(entry.message);
    const usage = object(message?.usage);
    if (message?.role !== "assistant" || !usage) continue;

    const input = number(usage.input) ?? 0;
    const output = number(usage.output) ?? 0;
    const cacheRead = number(usage.cacheRead) ?? 0;
    const cacheWrite = number(usage.cacheWrite) ?? 0;
    const totalTokens = number(usage.totalTokens) ?? input + output + cacheRead + cacheWrite;
    const model = [string(message.provider), string(message.model)].filter(Boolean).join("/") || "unknown model";

    stats.input += input;
    stats.output += output;
    stats.cacheRead += cacheRead;
    stats.cacheWrite += cacheWrite;
    stats.cost += number(object(usage.cost)?.total) ?? 0;

    if (entryTimestamp !== null && now - entryTimestamp <= 24 * 60 * 60 * 1000) {
      contributors.set(model, (contributors.get(model) ?? 0) + totalTokens);
    }
  }

  return {
    ...stats,
    wallSeconds: firstTimestamp === null ? null : Math.max(0, Math.round((now - firstTimestamp) / 1000)),
    contributors24h: contributorList(contributors),
  };
}

function formatUsage(payload: UsagePayload, stats: SessionStats): string {
  const timeZone = Intl.DateTimeFormat().resolvedOptions().timeZone || "local";
  const primary = payload.rate_limit?.primary_window ?? null;
  const secondary = payload.rate_limit?.secondary_window ?? null;
  const reached = reachedLabel(payload);
  const lines = [
    "Session",
    "",
    kv("Total cost:", money(stats.cost)),
    kv("Total duration (wall):", stats.wallSeconds === null ? "n/a" : duration(stats.wallSeconds)),
    kv("Usage:", `${integer(stats.input)} input, ${integer(stats.output)} output, ${integer(stats.cacheRead)} cache read, ${integer(stats.cacheWrite)} cache write`),
    "",
    "Current session",
    bar(primary),
    reset(primary, timeZone),
    "",
    "Current week (all models)",
    bar(secondary),
    reset(secondary, timeZone),
  ];

  if (reached) lines.push("", reached);

  lines.push(
    "",
    "What's contributing to your limits usage?",
    "Approximate, based on local Pi sessions on this machine - does not include other devices or chatgpt.com",
    "",
    "Last 24h · these are independent characteristics of your usage, not a breakdown",
    ...formatContributors(stats.contributors24h),
    "",
    "Extra usage",
    extraUsage(payload.credits),
  );

  return lines.join("\n");
}

function bar(window: RateLimitWindow | null): string {
  if (!window) return "Limits: data not available yet";
  const used = clamp(number(window.used_percent) ?? 0, 0, 100);
  const filled = Math.round((used / 100) * BAR_WIDTH);
  return `${"█".repeat(filled)}${"░".repeat(BAR_WIDTH - filled)} ${Math.round(used)}% used`;
}

function reset(window: RateLimitWindow | null, timeZone: string): string {
  const resetAt = number(window?.reset_at);
  return resetAt ? `Resets ${resetTime(resetAt, timeZone)} (${timeZone})` : "Resets unknown";
}

function reachedLabel(payload: UsagePayload): string | null {
  const raw = typeof payload.rate_limit_reached_type === "string" ? payload.rate_limit_reached_type : payload.rate_limit_reached_type?.type;
  if (raw) return `Status: limit reached (${raw.replace(/_/g, " ")})`;
  return payload.rate_limit?.allowed === false || payload.rate_limit?.limit_reached ? "Status: limit reached" : null;
}

function formatContributors(contributors: SessionStats["contributors24h"]): string[] {
  const visible = contributors.filter((item) => item.percent >= 10).slice(0, 5);
  if (visible.length === 0) return ["Nothing over 10% in this period."];

  return visible.map((item) => `${pad(truncate(item.label, 34), 34)} ${`${Math.round(item.percent)}%`.padStart(4)} ${integer(item.tokens)} tokens`);
}

function contributorList(values: Map<string, number>): SessionStats["contributors24h"] {
  const total = [...values.values()].reduce((sum, value) => sum + value, 0);
  return total <= 0
    ? []
    : [...values.entries()]
      .map(([label, tokens]) => ({ label, tokens, percent: (tokens / total) * 100 }))
      .sort((a, b) => b.tokens - a.tokens);
}

function extraUsage(credits: UsagePayload["credits"]): string {
  if (!credits) return "Usage credits data not available";
  if (credits.unlimited) return "Extra usage enabled · unlimited credits";
  if (credits.has_credits) return `Extra usage enabled · balance ${credits.balance ?? "unknown"}`;
  return "Extra usage not enabled · chatgpt.com/codex/settings/usage";
}

function resetTime(resetAtSeconds: number, timeZone: string): string {
  const resetDate = new Date(resetAtSeconds * 1000);
  const sameDay = resetDate.toDateString() === new Date().toDateString();
  const options: Intl.DateTimeFormatOptions = sameDay
    ? { hour: "numeric", minute: "2-digit" }
    : { month: "short", day: "numeric", hour: "numeric", minute: "2-digit" };
  return resetDate.toLocaleString(undefined, { ...options, timeZone }).replace(/\s?([AP])M\b/, (_, meridiem) => meridiem.toLowerCase() + "m");
}

function duration(seconds: number): string {
  const units: Array<[number, string]> = [
    [86_400, "d"],
    [3_600, "h"],
    [60, "m"],
    [1, "s"],
  ];
  const parts: string[] = [];
  let remaining = Math.max(0, Math.round(seconds));

  for (const [size, suffix] of units) {
    const value = Math.floor(remaining / size);
    if (value > 0 || (suffix === "s" && parts.length === 0)) parts.push(`${value}${suffix}`);
    remaining %= size;
    if (parts.length === 2) break;
  }

  return parts.join(" ");
}

function kv(label: string, value: string): string {
  return `${pad(label, 30)}${value}`;
}

function money(value: number): string {
  return `$${value.toFixed(4)}`;
}

function integer(value: number): string {
  return Math.round(value).toLocaleString();
}

function truncate(value: string, width: number): string {
  return value.length <= width ? value : `${value.slice(0, Math.max(0, width - 1))}…`;
}

function pad(value: string, width: number): string {
  return value + " ".repeat(Math.max(0, width - value.length));
}

function timestampMs(value: unknown): number | null {
  if (typeof value === "number" && Number.isFinite(value)) return value;
  if (typeof value !== "string") return null;
  const parsed = Date.parse(value);
  return Number.isFinite(parsed) ? parsed : null;
}

function isExpired(credential: Credential): boolean {
  return credential.expiresAt !== undefined && credential.expiresAt <= Date.now() + TOKEN_REFRESH_SKEW_MS;
}

function jwtExpiresAt(token: string): number | undefined {
  const payload = token.split(".")[1];
  if (!payload) return undefined;

  try {
    const exp = number(JSON.parse(Buffer.from(payload, "base64url").toString("utf8"))?.exp);
    return exp ? exp * 1000 : undefined;
  } catch {
    return undefined;
  }
}

async function readJson(path: string): Promise<JsonObject | null> {
  try {
    return JSON.parse(await readFile(path, "utf8")) as JsonObject;
  } catch (error) {
    if (error instanceof Error && "code" in error && error.code === "ENOENT") return null;
    throw error;
  }
}

async function writeJson(path: string, data: JsonObject): Promise<void> {
  await writeFile(path, `${JSON.stringify(data, null, 2)}\n`, { mode: 0o600 });
}

function object(value: unknown): JsonObject | null {
  return value && typeof value === "object" && !Array.isArray(value) ? (value as JsonObject) : null;
}

function string(value: unknown): string | undefined {
  return typeof value === "string" && value.length > 0 ? value : undefined;
}

function number(value: unknown): number | undefined {
  return typeof value === "number" && Number.isFinite(value) ? value : undefined;
}

function clamp(value: number, min: number, max: number): number {
  return Math.min(max, Math.max(min, value));
}

function trimBody(body: string): string {
  return body.replace(/\s+/g, " ").trim().slice(0, 500) || "empty response";
}

function errorMessage(error: unknown): string {
  return error instanceof Error ? error.message : String(error);
}
