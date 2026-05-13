---
description: Find safe code simplifications, reuse opportunities, and cleanup refactors
argument-hint: "<file|scope|changed files> [--apply]"
---

Analyze this code for simplification opportunities: $ARGUMENTS

Your goal is to reduce accidental complexity while preserving behavior. Prefer boring, local, high-confidence changes over clever rewrites.

## Default behavior

- Do not edit files unless the arguments include `--apply` or the user explicitly asks you to make changes.
- Prefer small, safe simplifications over large rewrites.
- Preserve public behavior, APIs, data formats, error semantics, performance characteristics, and tests.
- Avoid cosmetic churn. A simplification should make the code easier to understand, reuse, test, or operate.

## Scope resolution

If the scope is unclear:
1. Inspect staged changes: `git diff --cached`
2. Inspect unstaged changes: `git diff`
3. Inspect recently changed files from `git status`
4. Use files, directories, commits, or instructions mentioned in `$ARGUMENTS`

If there are no git changes, review the files explicitly mentioned by the user or recently edited in this conversation.

## Review protocol

First inspect the diff or target files, then read surrounding code and nearby utilities only as needed. Review from three angles:

### 1. Reuse review

Look for code that duplicates existing project concepts:
- Newly added functions that duplicate an existing helper, utility, hook, type guard, parser, formatter, validator, or component.
- Inline hand-rolled logic where the codebase already has a shared utility.
- Custom string/path/env/date/error handling that should use an existing library or local convention.
- Overly generic code used in only one place.
- Copy-paste with slight variation that can be unified without hiding important differences.

When proposing reuse, name the existing function/module and verify it actually matches the needed semantics.

### 2. Quality review

Look for complexity that can be removed safely:
- Redundant state: cached/derived values, duplicated source of truth, effects/observers that could be direct computation.
- Parameter sprawl: new flags/parameters that should be an options object, a clearer data structure, or a different boundary.
- Leaky abstractions: exposing internals, breaking layering, or passing implementation details through many call sites.
- Stringly typed code where constants, enums, string unions, branded types, or schemas already exist.
- Complex conditionals: nested `if`/`else`, ternary chains, switch nesting, or boolean logic that can be flattened with guard clauses, early returns, lookup tables, or clearer predicates.
- Unnecessary wrappers, adapters, indirection, configuration, classes, factories, or abstraction layers.
- Long functions that can be clarified without fragmenting into tiny helpers.
- Dead code, unused branches, redundant checks, unreachable fallbacks, or obsolete compatibility paths.
- Comments that narrate WHAT the code does or reference the task/change; keep only useful WHY comments for constraints, invariants, or workarounds.
- Tests that are noisy, duplicated, snapshot-heavy, or unclear when a focused assertion would be better.

### 3. Efficiency and operability review

Look for simplifications that remove unnecessary work:
- Repeated computations, repeated file reads, duplicate network/API calls, N+1 patterns.
- Independent async operations run sequentially when parallel execution is equally safe and clearer.
- Blocking or expensive work added to startup, per-request, per-render, polling, or event-handler hot paths.
- Recurring no-op updates: state/store updates in loops, intervals, subscriptions, or event handlers that should guard against unchanged values.
- Existence pre-checks before file/resource operations when direct operation plus error handling would avoid TOCTOU complexity.
- Unbounded data structures, missing cleanup, event listener leaks, or needless retention.
- Overly broad operations: loading all data when one item/range is needed, reading whole files when a portion is enough.

## What to avoid

- Changing behavior without tests or a strong proof that behavior is preserved.
- Introducing cleverness, dense abstractions, or premature generalization.
- Splitting code into tiny helpers without a clear readability or reuse payoff.
- Refactors that make debugging harder or obscure control flow.
- Replacing explicit domain logic with generic machinery.
- Large rewrites unless the user explicitly asks for one.

## Applying changes

If `--apply` was provided:
- Apply only high-confidence safe changes.
- Keep edits minimal and localized.
- Run relevant tests/typechecks/linters when practical, or explain why not.
- If a tempting simplification is risky or needs broader context, report it instead of applying it.

## Output exactly this structure

## Best simplifications
For each item:
- Impact: high/medium/low
- Safety: safe/needs tests/risky
- Location:
- Current complexity:
- Proposed simplification:
- Why behavior is preserved:

If nothing is worth changing, say `No worthwhile simplifications found.`

## Suggested patch plan
Give a short ordered plan. If `--apply` was provided, summarize what you changed instead.

## Risks / avoid
Mention tempting simplifications that should be avoided, false positives, or areas needing tests. If none, say `None.`

## Checks
List tests/typechecks/linters run, or say `Not run.`
