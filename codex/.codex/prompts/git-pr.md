---
description: Create a GitHub pull request with a Conventional Commits title and a concise, useful body.
---

## Implementation

1. Analyze changes
   - `git branch --show-current`, `git log origin/main..HEAD --oneline`, and `git diff origin/main --name-only --stat`.
   - Infer primary change type and scope from commits and paths.

2. Title (Conventional Commits)
   - Format: `type(scope): description` in imperative mood.

3. Body
   - Include: Summary (what/why), Test Plan, Related Issues, Breaking Changes (if any).

4. Create PR
   - Use `gh pr create` with generated title/body and appropriate labels/reviewers/draft status.

## Boundaries

- Create PRs only; do not auto‑merge or rewrite history.
- Keep scope focused and clearly described.
