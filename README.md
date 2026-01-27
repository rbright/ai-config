# Agent Configuration

This repo is a home for version-controlled AI development configurations. Codex is the primary agent used and consumes `AGENTS.md` for shared instructions.

## Install

```sh
# See available workflows
just --list

# Install all agent configs
just install

# Install a single agent config (codex/claude/opencode)
just install codex
```

## Supported agents

| Agent                                                             | Instructions                                                                                                                                                                  |
| ----------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Codex CLI](https://developers.openai.com/codex/config-reference) | <details><summary><a href="codex/">codex/</a></summary>Install: `just install codex`<br>Sync defaults: `just codex-sync-config`<br>Review gate: `just codex-review`</details> |
| [Claude Code](https://code.claude.com/docs/en/settings)           | <details><summary><a href="claude/">claude/</a></summary>Install: `just install claude`</details>                                                                             |
| [OpenCode](https://opencode.ai/docs/config/)                      | <details><summary><a href="opencode/">opencode/</a></summary>Install: `just install opencode`</details>                                                                       |

## Codex skills

Installed under `codex/.codex/skills/`.

| Skill                                                                                                 | Description                                                        |
| ----------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| [find-skills](https://skills.sh/vercel-labs/skills/find-skills)                                       | Discover and fetch skills from the skills registry.                |
| [aikido](https://help.aikido.dev/ide-plugins/aikido-mcp/openai-codex-cli-mcp)                         | Security-focused guidance and MCP integration for Codex CLI.       |
| [vercel-react-best-practices](https://skills.sh/vercel-labs/agent-skills/vercel-react-best-practices) | Guidance for React + Vercel app structure, patterns, and pitfalls. |
| [frontend-design](https://skills.sh/anthropics/skills/frontend-design)                                | UI/UX layout, typography, motion, and visual system guidance.      |
| [mermaid-diagrams](https://skills.sh/softaworks/agent-toolkit/mermaid-diagrams)                       | Generate Mermaid diagrams (flows, sequences, and architecture).    |
