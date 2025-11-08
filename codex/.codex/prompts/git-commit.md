---
description: Group changes and create Conventional Commits with clear, focused messages.
---

## Implementation

1. Inspect changes
   - Use `git status --porcelain`, `git diff`, and `git diff --cached` to list and review changes.

2. Group logically
   - Group by feature/fix/config; isolate breaking changes.
   - Order: config → fixes → features → tests/docs → style.

3. Commit
   - Stage each group and write a proper message: `type(scope): summary`.
   - Add a body when helpful; include "BREAKING CHANGE:" footer if applicable.

## Conventional Commit Types

- feat, fix, docs, style, refactor, test, chore, perf, ci

## Boundaries

- Create local commits only; no force‑push or history rewrites unless asked.
- Keep changes focused; avoid mixing refactors with features/fixes.
