---
name: commit-and-pr
description: Split staged changes into a sequence of Conventional Commits (reusing repo commit types/scopes), then push and create a GitHub PR via `gh` using the repo’s PR template.
metadata:
  short-description: Auto-commit and open PR
---

# Commit and PR

## Goal
Turn a “ready for review” working tree into a clean series of Conventional Commits, then open a GitHub pull request using `gh` and the repo’s PR template.

## When to use
- The plan is implemented, requirements are met, and gates are green.
- All intended changes are staged (index is the source of truth).

## Preflight state (before splitting commits)
0. **Quality gates already run** (use the `pre-review-gate` skill if available).
1. **Not on a protected branch**: don’t run on `main`/`master` (or your repo’s default branch).
   - `git branch --show-current`
2. **There are staged changes to commit** (the index is your “snapshot” to split).
   - `git diff --cached --name-only` should be non-empty
3. **No extra unstaged changes at the start** (so the index is the single source of truth).
   - `git diff --name-only` should be empty
4. **`gh` is authenticated** (and the repo has a GitHub remote).
   - `gh auth status`
   - `git remote -v`

If any guardrail fails, stop and fix the state (don’t “power through”).

Important: During this workflow you will intentionally create **unstaged changes** as you move files/hunks between commits (e.g. via `git reset -- <paths>`). That is expected. The preflight requirement is only that the starting point is unambiguous.

## 1) Learn this repo’s Conventional Commit taxonomy
The goal is to reuse whatever the repo already does (types, scopes, naming), not to invent a new style.

1. Collect recent commit subjects (prefer the current branch + recent default-branch history):
   - `git log --format=%s -n 200`
2. Extract existing Conventional Commit patterns:
   - `type(scope): subject`
   - `type: subject` (no scope)
3. Build a short “allowed” set from what you see:
   - Types used (common: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `ci`, `build`, `perf`)
   - Scopes used (prefer lowercase kebab-case)

**Scope normalization rules**
- Prefer existing scopes verbatim if they already match repo conventions.
- Normalize new scopes to lowercase kebab-case (e.g. `business-search`, not `BusinessSearch` or `business_search`).
- If history contains an obvious typo variant (e.g. `busines-search` vs `business-search`), prefer the corrected/most common form and keep future commits consistent.
- If there is no clear Conventional Commit history, default to `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `ci`, `build`, `perf` and keep scopes minimal.

## 2) Propose a commit plan (from the staged diff)
Work only from the staged changes:
- `git diff --cached --name-status`
- `git diff --cached --stat`
- `git diff --cached`

Create a short ordered list of commits. Each commit should be:
- Coherent (one “why”)
- Reviewable (small enough to understand)
- Consistent with repo taxonomy (type/scope)

**Default ordering (adjust as needed)**
1. `build` / `ci` / `chore` (tooling + scaffolding)
2. `refactor` (internal-only behavior-preserving reshapes)
3. `feat` / `fix` (user-facing behavior changes)
4. `test` (coverage and regression tests)
5. `docs` (documentation)

For each planned commit, specify:
- **Message**: `type(scope): imperative summary`
- **Files**: list of staged paths
- **Body (optional)**: why/notes; include `BREAKING CHANGE:` footer when applicable
- **Test evidence**: reference the exact commands and results already run

## 3) Execute the commit plan (default: file-grouped, automatable)
### File-grouped mode (recommended)
This mode is deterministic and can be automated end-to-end, but it assumes that a given file belongs to exactly one commit.

Execution pattern:
1. Capture the staged file set (the “universe” of changes you’re splitting):
   - `all_paths=$(git diff --cached --name-only)`
2. For each commit in the plan:
   1) Remove out-of-scope files from the index (keeps working tree unchanged):
      - `git reset -- <paths-not-in-this-commit>`
   2) Verify staged contents match intent:
      - `git diff --cached --stat`
   3) Commit using Conventional Commits:
      - `git commit -m "type(scope): summary"`
      - Add a body with a second `-m` when it materially helps review.
   4) Re-stage remaining files for the next commit:
      - `git add -- $all_paths`
   5) Sanity check that the working tree only contains expected (unstaged) files:
      - `git status --porcelain`

### Hunk-splitting mode (when a file spans multiple commits)
If a single file must be split across commits, switch to hunk-based staging:
- Use `git reset -p` to unstage hunks that belong in later commits.
- Use `git add -p` to stage hunks for the current commit.

This is more interactive and harder to make fully automatic, but it preserves intent when file boundaries aren’t sufficient.

## 4) Push the branch
1. Ensure you’re on the correct branch:
   - `branch=$(git branch --show-current)`
2. Push (set upstream if needed):
   - `git push -u origin HEAD`

## 5) Create the PR via `gh` (using the repo template)
### Find the repo’s PR template
Prefer these locations (in order):
- `.github/PULL_REQUEST_TEMPLATE.md`
- `.github/pull_request_template.md`
- `.github/PULL_REQUEST_TEMPLATE/*.md`

If there are multiple templates, pick the best match for this change (or the “default”).

### Choose PR title + body
- **Title**: Conventional Commits format. Usually mirror the “primary” commit (e.g. first `feat`/`fix`), or summarize the overall change.
- **Body**:
  - Start from the PR template content (don’t ignore it).
  - Fill in Summary / Test Plan / Notes using facts from the commits and staged diff.
  - Keep it concise and reviewer-focused.

### Create the PR (non-interactive)
1. Determine base branch.
   - Default: the repo’s default branch.
   - Optional override (per-branch): `git config branch.$(git branch --show-current).gh-merge-base <base>`
2. Create a body file (in `/tmp`) using the repo’s template as the starting point, then fill it in.
3. Create the PR:
   - `gh pr create --base "$base" --head "$branch" --title "$title" --body-file "$body_file"`

Note: `gh pr create` also supports `--template "$template_path"`, but behavior can vary when combined with explicit `--body`/`--body-file`. Keep this workflow deterministic by **always** inlining template content into `"$body_file"` yourself and using `--body-file`.

Example template discovery + body-file creation:

```sh
branch="$(git branch --show-current)"
base="$(gh repo view --json defaultBranchRef -q .defaultBranchRef.name 2>/dev/null || echo main)"

template_path="$(
  git ls-files |
    grep -Ei '^\\.github/(PULL_REQUEST_TEMPLATE\\.md|pull_request_template\\.md|PULL_REQUEST_TEMPLATE/.+\\.md)$' |
    head -n 1
)"

body_file="$(mktemp /tmp/pr-body.XXXXXX)"

if [ -n "$template_path" ]; then
  cat "$template_path" >"$body_file"
else
  : >"$body_file"
fi

cat >>"$body_file" <<'EOF'

## Summary
- …

## Test Plan
- …
EOF
```

## Boundaries
- Do not rewrite history (no `rebase`, `reset --hard`, `push --force`) unless explicitly requested.
- Do not auto-merge. Creating the PR is the end of this workflow.
- If `gh` cannot find a PR template or repo metadata, stop and report what’s missing.
