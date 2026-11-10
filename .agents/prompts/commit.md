---
description: Write a single-line conventional commit message for the staged changes
allowed-tools: Bash(git diff:*), Bash(git diff --cached:*), Bash(git status:*), Bash(git log:*)
---

Run `git diff --cached` to see the staged changes, then output a single-line commit message in conventional commits style (`type(scope): description` or `type: description`). Do not commit.

Rules:
- One line only — no body, no footer, no co-author trailer.
- Use lowercase imperative mood for the description.
- Pick the appropriate type: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert.
- Scope is optional; include it only when it adds clarity.
- Keep the full message under 72 characters.
- If nothing is staged, report that and stop.
