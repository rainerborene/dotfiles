---
description: Generate a Conventional Commit message for staged changes
argument-hint: "[type] [scope]"
---
Use this when you want a Conventional Commit message for the currently staged changes.

Follow these steps:

1. Run `git status --short` to confirm there are staged changes. If nothing is staged, explain the situation and stop.
2. Inspect the staged diff with commands like `git diff --cached` (and `--stat` if helpful) to understand the changes.
3. Choose an appropriate Conventional Commit **type** (`feat`, `fix`, `docs`, `style`, `refactor`, `test`, `build`, `ci`, `perf`, `chore`, `revert`).
   - If `$1` is provided, treat it as the desired commit type override.
4. Optionally set a **scope**. Use `$2` when provided; otherwise infer a concise scope (e.g., top-level package, area, or file) or omit it entirely if none fits well.
5. Write the commit message:
   - First line: `type[optional scope]: summary`.
   - Keep the summary ≤ 72 characters, imperative mood, no trailing period.
   - Add a body when needed to explain motivation or implementation details. Reference important files, functions, or decisions. Wrap at ~72 characters.
   - Use bullet points (`-`) when listing multiple changes.
   - Include a `BREAKING CHANGE: ` section if applicable.
6. Do not mention unstaged changes or instructions. The output must be exactly the commit message, nothing else, wrapped in a fenced code block tagged `text`.
