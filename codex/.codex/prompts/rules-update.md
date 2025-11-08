---
description: Document new patterns in the most relevant AGENTS.md, with concise examples and guidance.
---

## Implementation

1. Analyze changes
   - Use `git diff` (staged and unstaged) to spot repeated structures or conventions.

2. Choose location
   - Component/service‑specific patterns → that directory’s `AGENTS.md`.
   - Cross‑cutting patterns → root `AGENTS.md`.

3. Document
   - Add a short section per pattern: name, description, good example (code), when to use, and benefits.

## Boundaries

- Documentation only; do not change behavior.
- Avoid duplication—link to existing rules where possible.
