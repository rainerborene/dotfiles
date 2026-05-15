#!/usr/bin/env node

const args = process.argv.slice(2);
let numResults = 5;

const nIndex = args.indexOf("-n");
if (nIndex !== -1 && args[nIndex + 1]) {
  numResults = parseInt(args[nIndex + 1], 10);
  args.splice(nIndex, 2);
}

const query = args.join(" ").trim();
const apiKey = process.env.JINA_API_KEY;

if (!query) {
  console.log('Usage: websearch.js "query" [-n 5]');
  console.log("\nOptions:");
  console.log("  -n <number>  Number of results to show (default: 5)");
  console.log("\nEnvironment:");
  console.log("  JINA_API_KEY Required. Your Jina AI API key.");
  process.exit(1);
}

if (!apiKey) {
  console.error("Error: JINA_API_KEY environment variable is required.");
  process.exit(1);
}

try {
  const res = await fetch(`https://s.jina.ai/?q=${encodeURIComponent(query)}`, {
    headers: {
      Authorization: `Bearer ${apiKey}`,
      Accept: "application/json",
    },
  });

  if (!res.ok) throw new Error(`HTTP ${res.status}: ${res.statusText}\n${await res.text()}`);

  const json = await res.json();
  const results = (json.data ?? []).slice(0, numResults);

  if (results.length === 0) {
    console.error("No results found.");
    process.exit(0);
  }

  for (let i = 0; i < results.length; i++) {
    const r = results[i];
    console.log(`--- Result ${i + 1} ---`);
    console.log(`Title: ${r.title ?? ""}`);
    console.log(`Link: ${r.url ?? ""}`);
    console.log(`Snippet: ${r.description ?? ""}`);
    if (r.content) console.log(`Content:\n${r.content}`);
    console.log("");
  }
} catch (err) {
  console.error(`Error: ${err.message}`);
  process.exit(1);
}
