---
name: pre-review-gate
description: Run the local "ready for review" gate before asking for human review or opening a PR. Use to (1) run the repo’s lint/typecheck/tests (prefer the same commands CI runs), then (2) run `codex review` as a final automated review pass, and optionally (3) run CodeRabbit CLI (`coderabbit --prompt-only`) to catch additional issues and reduce GitHub Actions feedback loops.
---

# Pre-Review Gate

## Goal
Run the same quality gates you expect in CI, then run an automated code review pass locally before considering changes “ready for human review”.

## 1) Determine the project’s canonical commands
Prefer *exactly* what CI runs.

1. If the repo has GitHub Actions workflows (`.github/workflows/*.yml`), extract the lint/typecheck/test commands from `run:` steps and use those locally.
2. Otherwise, look for a project runner (in this order):
   - `justfile` (`just lint`, `just typecheck`, `just test`)
   - `Makefile` (`make lint`, `make test`)
   - `package.json` scripts (`npm|pnpm|yarn run lint|typecheck|test`)
   - Language-native defaults (only if there is no repo runner):
     - Python: `ruff check .`, `pyright`, `pytest`
     - TypeScript: `eslint .`, `tsc -p . --noEmit`, `vitest`
     - Go: `golangci-lint run`, `go test ./...`
     - Rust: `cargo fmt --check`, `cargo clippy`, `cargo test`

If the repo uses a monorepo task runner (Nx/Turbo/Bazel/etc.), use it rather than ad-hoc per-package commands.

## 2) Run quality gates (stop on first failure)
Run in this order:
1. **Lint / formatting checks**
2. **Type checking**
3. **Tests**

If anything fails, fix it and re-run from the failing step forward.

## 3) Final gate: run Codex local review
Use `codex review` as the last gate *after* lint/typecheck/tests pass.

Recommended modes:
- Working tree review (best during iteration): `codex review --uncommitted`
- Branch review vs base (best before opening a PR): `codex review --base main`

To increase review **thoroughness/recall**, use the bundled wrapper script (it feeds a high‑recall prompt and asks Codex to gather staged/unstaged/untracked diffs):
- `~/.codex/skills/pre-review-gate/scripts/codex_review_thorough.sh --uncommitted`
- `~/.codex/skills/pre-review-gate/scripts/codex_review_thorough.sh --base main`

If you prefer the built-in `codex review --uncommitted` / `--base` modes, you can still make output more expansive via config overrides:
- `codex review --uncommitted -c 'model_verbosity="high"' -c 'model_reasoning_effort="xhigh"'`

If you need stricter guidance, pass a short custom prompt such as:
- “Focus on correctness, missing tests, and footguns. List **Blockers** first, then **Suggested improvements**, then **Nitpicks**. Include file paths and concrete fixes.”

## 4) Optional: run CodeRabbit CLI (second opinion)
If CodeRabbit CLI is installed/configured, run it after `codex review` to catch additional issues:
- Uncommitted changes: `coderabbit --prompt-only --type uncommitted`
- Against a base branch: `coderabbit --prompt-only --base main`

Notes:
- CodeRabbit CLI can take ~7–30+ minutes; run it in the background if needed and come back when it finishes.
- Avoid running it more than ~3 times per change set to keep iterations efficient.

## 5) Produce a “Gate Report”
Conclude with a short report:
- Commands run + pass/fail (and any failures fixed)
- Codex review: blockers + actions taken
- CodeRabbit (if run): blockers + actions taken
- Verdict: **Ready for human review** / **Not ready** (with next steps)
