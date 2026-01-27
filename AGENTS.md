# Agent Instructions

This repository is a home for **version-controlled AI coding configuration** across multiple agents. Codex is the primary agent and reads this `AGENTS.md`; Claude Code imports it via `@AGENTS.md`.

This `AGENTS.md` is intentionally **repo-specific**. Do not copy/paste the global Codex instructions from
`codex/.codex/AGENTS.md` into here; that file is meant to be installed into `~/.codex/AGENTS.md` and used across repos.

## Entry points

- `just --list` — discover available workflows (preferred starting point)
- `just install` — install all repo-managed configs into `$HOME` via GNU Stow
- `just install agents` — install shared skills into `~/.agents/skills`
- `just install codex` — install a specific agent config (also works for `claude`/`opencode`)
- `just sync codex` — copy-sync `codex/.codex/config.toml` → `~/.codex/config.toml`
- `just codex-review` — run the local high-recall Codex review gate for the working tree

## Repo layout (what to edit)

- `README.md` — minimal root entry point (links out)
- `agents/` — shared skills installed under `~/.agents/skills`
- `codex/` — Codex CLI assets (skills, global `AGENTS.md`, canonical `config.toml`)
- `claude/` — Claude Code config
- `opencode/` — OpenCode config
- `scripts/` — small local helpers (avoid adding dependencies unless necessary)

## Working conventions for this repo

- Treat changes as **dotfiles/config** changes: keep them portable, deterministic, and free of secrets.
- Prefer editing the **repo source of truth** (e.g. `codex/.codex/...`) rather than anything under `$HOME`.
- Keep Stow packages **symlink-safe** (Codex rewrites `~/.codex/config.toml`, so we sync it as a regular file).
- For multi-step work, keep `PLAN.md` and `SESSION.md` updated (checklists + decisions/trade-offs).

## Validation expectations (practical, local)

- Always run `just --list` after changing the `justfile`.
- If you change install paths or Stow structure, run a dry-run: `stow -n -R agents` (and/or `codex`, `claude`, `opencode`).
- If you change Codex defaults, run `just sync codex` and sanity-check Codex starts with the expected config.
