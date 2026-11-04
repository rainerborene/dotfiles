// WSL: spaces in Linux, through WSL 2. herdr-wsl, github.com/emoss08/herdr-wsl
//
// The WSL distro is a Herdr machine (named `wsl` by default) reached over ssh:
// setup.ps1 puts an sshd on 127.0.0.1 inside the distro, a key and a `Host wsl`
// entry on Windows, and runs `hc machine add`. Spaces made on it run their shell,
// git and agents in Linux, and Herdr follows their Linux folders.
//
// This mod keeps the distro running (WSL stops an idle distro, and the machine with
// it), reconnects the machine as soon as the distro is back, shows the connection,
// and opens new spaces there (`wsl.new-space`, the + button). mods/wsl/config.json,
// written by setup.ps1, names the machine and the distro when they aren't the
// defaults; `"redirect_local": true` there replaces plain shell spaces made on this
// computer with WSL spaces.
import { View, div } from "gpui-kit";
import { h_flex } from "gpui-base";
import { appHome, exec, hc, machines, nextCommand, panes, readTextFile, run, spaces, terminals, theme } from "herdr";

const KEEPALIVE = "wsl-keepalive"; // hidden local terminal holding a wsl.exe session open
const NUDGE_EVERY = 15000;        // ms between reconnect attempts while the machine is offline
const REDIRECT_AFTER = 2500;      // ms a new local space has to show it's more than a bare shell

const STATE = {
  ready: { word: "connected", color: (t) => t.ansi2 },
  loading: { word: "connecting", color: (t) => t.ansi3 },
  unavailable: { word: "offline", color: (t) => t.blocked },
  missing: { word: "not set up: run setup.ps1", color: (t) => t.dim },
};

// WSL's default distro: the `*` row of `wsl -l -v`. wsl.exe writes UTF-16, hence the NULs.
async function defaultDistro() {
  try {
    const r = await exec("wsl.exe", ["-l", "-v"]);
    const text = r.stdout.replaceAll("\u0000", "").replaceAll(String.fromCharCode(0xfeff), "");
    const row = text.split(/\r?\n/).find((l) => l.trim().startsWith("*"));
    return row?.trim().slice(1).trim().split(/\s+/)[0] || null;
  } catch { return null; }
}

export default class Wsl extends View {
  init(_props, cx) {
    this.width = 240;
    this.machine = "wsl";
    this.distro = null;      // null: WSL's default distro
    this.redirect = false;   // config redirect_local
    this.why = null;         // hc's reason while the machine is offline
    this.lastNudge = 0;
    this.launched = 0;       // when the keepalive was last started
    this.seen = new Set(spaces().map((s) => s.id)); // spaces there at start are never redirected
    cx.spawn(async (cx) => {
      try {
        const cfg = JSON.parse((await readTextFile(`${appHome()}/mods/wsl/config.json`)) ?? "{}");
        this.machine = cfg.machine || this.machine;
        this.distro = cfg.distro || null;
        this.redirect = cfg.redirect_local === true;
      } catch { /* defaults */ }
      this.distro ??= await defaultDistro();
      this.keepAlive();
      cx.notify();
    });
    // On timers, not on render: an idle window doesn't render, and the session must
    // come back after `wsl --shutdown`. Both checks read only Herdr's live data.
    cx.timer.every(5000, (cx) => this.health(cx));
    cx.timer.every(1000, (cx) => this.watchLocal(cx));
    cx.spawn(async (cx) => {
      for (;;) {
        const c = await nextCommand();
        if (c === "new-space") this.newSpace();
        if (c === "reconnect") this.wake(cx, true);
        cx.notify();
      }
    });
  }

  state() {
    return machines().find((x) => x.name === this.machine)?.layout ?? "missing";
  }

  // The keepalive, and while the machine is offline a reconnect every NUDGE_EVERY.
  health(cx) {
    this.keepAlive();
    if (this.state() === "unavailable") this.wake(cx, false);
    else if (this.why) { this.why = null; cx.notify(); }
  }

  keepAlive() {
    if (terminals().some((t) => t.name === KEEPALIVE && t.state === "live")) return false;
    // One launch at a time: terminals() lists the new one only once hc has started it.
    if (Date.now() - this.launched < 10000) return false;
    this.launched = Date.now();
    hc(["run", "--bg", "--no-parent", "--no-notify", "--rm", "--name", KEEPALIVE,
      "--label", "wsl.role=keepalive",
      "wsl.exe", ...(this.distro ? ["-d", this.distro] : []), "--", "sleep", "infinity"]).catch(() => {});
    return true;
  }

  // Start the distro if it's down, then make hc dial the machine now instead of at its
  // next retry (a no-op command there: `hc machine login` needs a terminal); remember
  // why it's offline for the tooltip. now: asked for (a click).
  wake(cx, now) {
    const t = Date.now();
    if (!now && t - this.lastNudge < NUDGE_EVERY) return;
    this.lastNudge = t;
    this.keepAlive();
    cx.spawn(async (cx) => {
      try {
        await hc(["exec", "--on", this.machine, "true"]);
        const r = await hc(["machine", "ls", "--json"]);
        const m = (JSON.parse(r.stdout).machines ?? []).find((x) => x.name === this.machine);
        this.why = m && m.state !== "connected" ? (m.why || m.state.replace(/_/g, " ")) : null;
      } catch (e) { this.why = String(e?.message ?? e); }
      cx.notify();
    });
  }

  // redirect_local: a new space on this computer that is still a bare shell after
  // REDIRECT_AFTER (not an agent, nothing run in it) is replaced by a WSL space.
  watchLocal(cx) {
    for (const s of spaces()) {
      if (this.seen.has(s.id)) continue;
      this.seen.add(s.id);
      if (!this.redirect || s.machine || this.state() !== "ready") continue;
      cx.timer.after(REDIRECT_AFTER, () => {
        // WSL may have dropped meanwhile: then the local space stays.
        if (this.state() !== "ready") return;
        const now = spaces().find((x) => x.id === s.id);
        if (!now || now.tabs.length !== 1) return;
        const ps = panes().filter((p) => p.tab === now.tabs[0].id);
        const bare = ps.length === 1 && ps[0].terminal && ps[0].program?.key === "shell" && !ps[0].status;
        if (!bare) return;
        run("space.new", { machine: this.machine });
        run("space.close", { id: now.id, confirmed: true });
      });
    }
  }

  newSpace() {
    run("space.new", { machine: this.machine });
  }

  render() {
    const t = theme();
    const state = this.state();
    // A state this version doesn't know (a newer Herdr) shows as itself.
    const s = STATE[state] ?? { word: String(state).replace(/_/g, " "), color: (t) => t.dim };
    const ready = state === "ready";
    const offline = state === "unavailable";
    // Connected, the row opens a space; offline, it wakes WSL and reconnects.
    const act = (_e, cx) => (ready ? this.newSpace() : offline ? this.wake(cx, true) : null);
    const tip = ready ? "New WSL space" : offline ? `Offline: ${this.why ?? "WSL isn't reachable"}. Click to reconnect.`
      : state === "loading" ? "Connecting to WSL…" : state === "missing" ? "Run setup.ps1 from the herdr-wsl folder"
      : `WSL is ${s.word}`;
    const dot = div().size(7).rounded(4).bg(s.color(t));
    const root = h_flex().id("wsl-root").size_full().items_center().text_size(12.5).text_color(t.muted)
      .on_size_change((size, cx) => { this.width = size.width; cx.notify(); });
    // Narrower than 160px the sidebar is a rail: just the dot.
    if (this.width < 160) {
      return root.justify_center().child(div().id("wsl-act").p(6).rounded(6).tooltip(tip)
        .hover((st) => st.bg(t.hover)).on_click(act).child(dot));
    }
    return root.px(14).gap(8)
      .child(dot)
      .child(div().text_color(t.foreground).child("WSL"))
      .child(div().id("wsl-state").flex_1().truncate().text_color(offline ? t.blocked : t.dim).tooltip(tip)
        .when(offline, (el) => el.cursor_pointer().on_click(act))
        .child(this.distro ? `${this.distro} · ${s.word}` : s.word))
      .when(ready || offline, (el) => el.child(div().id("wsl-act").px(6).rounded(4).text_size(15).text_color(t.muted)
        .tooltip(tip)
        .hover((st) => st.bg(t.hover).text_color(t.foreground))
        .on_click(act).child(ready ? "+" : "↻")));
  }
}
