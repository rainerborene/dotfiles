#!/usr/bin/env node

let url = process.argv[2];
const apiKey = process.env.JINA_API_KEY;

if (!url) {
  console.log("Usage: webfetch.js <url>");
  console.log("\nEnvironment:");
  console.log("  JINA_API_KEY Required. Your Jina AI API key.");
  process.exit(1);
}

if (!apiKey) {
  console.error("Error: JINA_API_KEY environment variable is required.");
  process.exit(1);
}

try {
  new URL(url);
} catch {
  console.error("Error: URL must be fully formed, e.g. https://example.com/page");
  process.exit(1);
}

// Match Claude WebFetch behavior: prefer HTTPS for plain HTTP URLs.
if (url.startsWith("http://")) url = `https://${url.slice("http://".length)}`;

try {
  const res = await fetch(`https://r.jina.ai/http://${url}`, {
    headers: {
      Authorization: `Bearer ${apiKey}`,
      Accept: "text/markdown",
    },
  });

  if (!res.ok) throw new Error(`HTTP ${res.status}: ${res.statusText}\n${await res.text()}`);

  console.log(await res.text());
} catch (err) {
  console.error(`Error: ${err.message}`);
  process.exit(1);
}
