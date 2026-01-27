# Agent Configuration

This repo is a home for version-controlled AI development configurations. Codex is the primary agent used and consumes `AGENTS.md` for shared instructions.

## Install

```sh
# See available workflows
just --list

# Install all agent configs
just install

# Install a single package (codex/claude/opencode/agents)
just install codex
```

## Supported agents

| Agent                                                             | Instructions                                                                                                                                                                  |
| ----------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Codex CLI](https://developers.openai.com/codex/config-reference) | <details><summary><a href="codex/">codex/</a></summary>Install: `just install codex`<br>Sync defaults: `just sync codex`<br>Review gate: `just codex-review`</details> |
| [Claude Code](https://code.claude.com/docs/en/settings)           | <details><summary><a href="claude/">claude/</a></summary>Install: `just install claude`</details>                                                                             |
| [OpenCode](https://opencode.ai/docs/config/)                      | <details><summary><a href="opencode/">opencode/</a></summary>Install: `just install opencode`</details>                                                                       |

## Skills

Stored under `agents/.agents/skills/`, stowed to `~/.agents/skills/`, and symlinked into `codex/.codex/skills/`.

| Skill | Description |
| --- | --- |
| [aikido](https://help.aikido.dev/ide-plugins/aikido-mcp/openai-codex-cli-mcp) | Security-focused guidance and MCP integration for Codex CLI. |
| [`commit-and-pr`](agents/.agents/skills/commit-and-pr/SKILL.md) | Split staged changes into Conventional Commits, push, and open a PR via `gh`. |
| [find-skills](https://skills.sh/vercel-labs/skills/find-skills) | Discover and fetch skills from the skills registry. |
| [frontend-design](https://skills.sh/anthropics/skills/frontend-design) | UI/UX layout, typography, motion, and visual system guidance. |
| [`gh-address-bot-feedback`](agents/.agents/skills/gh-address-bot-feedback/SKILL.md) | Fetch and address CodeRabbit/Codex Connector feedback on the current PR. |
| [mermaid-diagrams](https://skills.sh/softaworks/agent-toolkit/mermaid-diagrams) | Generate Mermaid diagrams (flows, sequences, and architecture). |
| [`pre-review-gate`](agents/.agents/skills/pre-review-gate/SKILL.md) | Run lint/typecheck/tests, Aikido scan, Codex review, and CodeRabbit for a second opinion. |
| [`update-agent-instructions`](agents/.agents/skills/update-agent-instructions/SKILL.md) | Consolidate AGENTS.md/CLAUDE.md/.agents instructions with link checks. |
| [`update-docs`](agents/.agents/skills/update-docs/SKILL.md) | Audit and reorganize docs with progressive disclosure and link checks. |
| [vercel-react-best-practices](https://skills.sh/vercel-labs/agent-skills/vercel-react-best-practices) | Guidance for React + Vercel app structure, patterns, and pitfalls. |
