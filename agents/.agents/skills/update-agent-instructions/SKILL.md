---
name: update-agent-instructions
description: Consolidate and refresh AGENTS.md (and related instruction files) into a clear, progressive-disclosure structure with verified links.
---

# Update Agent Instructions

## Goal
Keep agent instructions accurate, deduplicated, and easy to navigate using progressive disclosure.

## 1) Discover instruction sources
- Locate root `AGENTS.md` and any imported instruction files.
- Identify other instruction entry points (`CLAUDE.md`, `.agents/instructions/`).
- Audit all entrypoints: `AGENTS.md`, `CLAUDE.md`, and `.agents/instructions/`.
- Note duplication and conflicting guidance.

## 2) Reorganize with progressive disclosure
Use a general → specific hierarchy:
- **Entry point**: concise overview + quick reference.
- **Expanded detail**: link to domain- or component-specific rule files.
- **Appendices**: long examples or advanced guidance.

Guidelines:
- One source of truth per rule; replace duplicates with links.
- Use tables or `<details>` blocks for optional depth.
- Keep headings consistent across files.
- Standardize rule entries (Name → Description → Example → When to use → Benefits).

## 3) Document new patterns
- Review recent changes (`git diff` staged/unstaged) for repeated patterns.
- Add concise entries with: name, description, example, when to use, and benefits.

## 4) Validate and fix links
Run the bundled checker from the repo root:

```sh
python3 ~/.codex/skills/update-docs/check-doc-links.py
```

Fix any broken relative links in instruction files.

## Output
Provide a short summary of the updated instruction structure and where to start.

## Boundaries
- Instruction content only; do not change code behavior.
- Preserve intent; improve structure and clarity.
