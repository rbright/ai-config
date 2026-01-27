# Codex CLI Configuration

This directory contains the repo-managed **Codex CLI** setup:

- `codex/.codex/config.toml` — preferred Codex defaults (model, MCP servers, sandbox/approvals, etc.)
- `agents/.agents/skills/` — shared skills (source of truth)
- `codex/.codex/skills/` — Codex-visible skills (symlinked to `~/.agents/skills/`)
- `codex/.codex/AGENTS.md` — global “how to work” instructions for Codex sessions in this repo

Codex itself stores auth/history/session state in `~/.codex/`, so this repo **stows only the version-controlled assets that are stable as symlinks** (skills and `AGENTS.md`). Shared skills are stowed to `~/.agents/skills`, and Codex skill entries point there.

## Install into `~/.codex`

From the repo root:

```sh
# Stow Codex skills/AGENTS.md into ~/.codex
stow codex

# Stow shared skills into ~/.agents/skills
stow agents
```

Or use the repo’s `justfile` wrapper (also installs `claude/` + `opencode/`):

```sh
# Also syncs `~/.codex/config.toml` (copy-based) as part of install.
just install
```

## `config.toml` (Codex defaults)

Codex loads config from `~/.codex/config.toml` by default, but **Codex rewrites this file** and will replace a symlink with a newly-written regular file.

That means `config.toml` is *not* safe to manage as a Stow symlink. This repo:
- Keeps the canonical config at `codex/.codex/config.toml`
- Configures Stow to ignore `config.toml` via `.stowrc`
- Provides a copy-based sync script to update your local config when desired:

```sh
scripts/codex-sync-config.sh
```

Or via `just`:

```sh
just sync codex
```

## Skills

Skills live in `agents/.agents/skills/`. After `stow agents`, they land in `~/.agents/skills/`, and the Codex skill entries point to that home directory.

Included skills:
- `codex/.codex/skills/pre-review-gate/SKILL.md` — local “ready for review” gating workflow:
  - run lint/typecheck/tests (prefer CI’s exact commands)
  - run Aikido security scan
  - run a high-recall Codex review pass
  - run CodeRabbit CLI (`coderabbit --prompt-only`) for a second opinion
- `codex/.codex/skills/gh-address-bot-feedback/SKILL.md` — fetch and address CodeRabbit / Codex Connector feedback on an open GitHub PR using `gh`
- `codex/.codex/skills/commit-and-pr/SKILL.md` — split staged changes into Conventional Commits, push, and open a PR via `gh`
- `codex/.codex/skills/update-docs/SKILL.md` — audit and reorganize documentation with progressive disclosure + link checks
- `codex/.codex/skills/update-agent-instructions/SKILL.md` — consolidate AGENTS.md and instruction files into a consistent structure

### High-recall Codex reviews

Codex can sometimes surface additional feedback on subsequent runs. To push it toward **more comprehensive** feedback in one pass, this repo includes:

- `codex/.codex/skills/pre-review-gate/references/codex_review_prompt.md` — a multi-pass, high-recall review rubric
- `codex/.codex/skills/pre-review-gate/scripts/codex_review_thorough.sh` — wrapper that forces higher verbosity/reasoning and instructs Codex to gather staged/unstaged/untracked diffs

Example:

```sh
~/.codex/skills/pre-review-gate/scripts/codex_review_thorough.sh --uncommitted
```

## MCP integrations

`codex/.codex/config.toml` configures MCP servers for:
- Linear
- Sentry
- Todoist

When you include a Linear/Sentry/Todoist URL in a Codex session, the workflow expects Codex to fetch the resource via MCP rather than asking you to paste content.
