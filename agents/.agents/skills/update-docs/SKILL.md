---
name: update-docs
description: Audit, reorganize, and refresh repository documentation into a consistent, progressive-disclosure structure; verify links with the bundled checker.
---

# Update Docs

## Goal
Keep documentation accurate, consistent, and easy to scan. Use progressive disclosure so the top-level docs stay concise while deeper detail lives in focused files.

## 1) Inventory and audit
1. Identify canonical docs (`README.md`, architecture notes, runbooks, ADRs, etc.).
2. Map duplicates, stale sections, and missing topics.
3. Note which docs are authoritative vs. derivative.

## 2) Reorganize with progressive disclosure
Use a general → specific flow:
- **Top level**: quick start, key commands, high-level architecture, and links to deeper docs.
- **Deeper docs**: detailed guides, workflows, troubleshooting, and diagrams.

Guidelines:
- Prefer short summaries with links over long walls of text.
- Use tables or `<details>` blocks for optional depth.
- Consolidate duplicates; link to a single source of truth.
- Standardize doc structure where possible (Purpose → Audience → How to use → References).

## 3) Update content to match the code
- Refresh commands, scripts, and workflows (prefer CI or `just` definitions).
- Sync architecture and component descriptions with current code.
- Add or update Mermaid diagrams when they clarify flows.

## 4) Validate and fix links
Run the bundled link checker from the repo root:

```sh
python3 ~/.codex/skills/update-docs/check-doc-links.py
```

If using the repo copy directly:

```sh
python3 codex/.codex/skills/update-docs/check-doc-links.py
```

Fix any reported broken relative links.

## Output
Provide a short summary of what changed and where readers should start.

## Boundaries
- Documentation only; do not change runtime behavior.
- Prefer updating existing docs over adding new doc trees unless the repo already uses them.
