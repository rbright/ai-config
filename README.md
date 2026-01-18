# AI Configuration

This repo is a home for version-controlled AI coding configurations.

Today the primary “daily driver” is **Codex CLI**, while the **Claude Code** configuration is kept intact for future use.

## Quick start

```sh
# See what you can run
just --list

# Install repo-managed config into $HOME via GNU Stow
# (and sync Codex `~/.codex/config.toml` as a real file)
just install
```

Re-sync Codex config defaults anytime (Codex rewrites `~/.codex/config.toml`, so this is copy-based, not Stow):

```sh
just codex-sync-config
```

## Docs

- Codex CLI: `codex/README.md`
- Claude Code: `claude/README.md`
