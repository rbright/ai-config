---
description: Run lint/typecheck/tests, then run `codex review` (and optionally CodeRabbit CLI) to decide whether changes are ready for human review.
---

Follow the `pre-review-gate` workflow:
1) Identify the repo’s canonical lint/typecheck/test commands (prefer CI).
2) Run lint → typecheck → tests; fix failures.
3) Run `codex review` as the final gate (`--uncommitted` during iteration, or `--base main` before PR). For maximum thoroughness, use `~/.codex/skills/pre-review-gate/scripts/codex_review_thorough.sh` (it uses a high‑recall rubric and collects staged/unstaged/untracked changes).
4) If available, run `coderabbit --prompt-only` for a second opinion.
5) End with a concise “Gate Report” and a clear verdict (ready / not ready).
