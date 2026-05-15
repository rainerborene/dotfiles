---
name: jina-ai
description: Search the web and fetch readable page content using the Jina AI Reader/Search APIs. Use when users ask to search the web, look up current information, or retrieve webpage contents. Requires JINA_API_KEY.
---

# Jina Web

Use this skill for web search (`websearch.js`) and webpage fetching (`webfetch.js`) through Jina AI.

## Requirements

- `JINA_API_KEY` must be set in the environment.
- Scripts use Node.js 18+ built-in `fetch`; no npm dependencies are required.
- This skill is read-only and does not modify files unless the user explicitly asks you to save results.

## Web Search

Use web search to find up-to-date information, current events, recent documentation, or information beyond the model's knowledge cutoff.

Run from this skill directory:

```bash
scripts/websearch.js "search query" [-n 5]
```

This calls `https://s.jina.ai/` and prints result blocks with title, link, snippet, and content when returned by Jina.

### Search Guidance

- Use the current year in queries for recent information, documentation, and current events.
- Search is best for discovery and finding multiple sources.
- After using search to answer the user, include a final `Sources:` section with all relevant URLs as markdown links:

```markdown
Sources:
- [Source Title](https://example.com)
```

## Web Fetch

Use web fetch when the user provides a URL or when you need to inspect a specific search result.

Run from this skill directory:

```bash
scripts/webfetch.js https://example.com/page
```

This calls Jina Reader via `https://r.jina.ai/http://<url>` and prints readable Markdown content.

### Fetch Guidance

- The URL must be fully formed, e.g. `https://example.com/page`.
- Plain `http://` URLs are automatically upgraded to `https://`.
- Use the user's question as the analysis prompt: fetch the page, then extract or summarize only the information needed to answer.
- Results may be long; focus on the relevant sections.
- If a fetched page indicates a redirect to a different host, fetch the redirect URL explicitly.
- For GitHub URLs, prefer using local git/`gh`/raw GitHub access when appropriate; otherwise `webfetch.js` works well for raw files and public pages.

## Usage Guidance

- Use `websearch.js` when the user needs discovery, current facts, or multiple sources.
- Use `webfetch.js` when the user provides a URL or when fetching a specific result from `websearch.js`.
- Cite source URLs in your response whenever you use web results.
