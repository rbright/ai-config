---
description: Capture current progress and sync it to TASKS.md.
---

## Implementation

1. Read plan files
   - Load `TASKS.md` and `REQUIREMENTS.md` for context.

2. Summarize progress
   - From recent commits/diffs, update task statuses, add completion dates, and record blockers.
   - Append a time‑stamped "Session Update" section to `TASKS.md` with progress, blockers, and next focus.

3. Consistency check
   - Ensure tasks reflect actual code changes; add follow‑ups where gaps exist.

## Boundaries

- Synchronize plan state only; do not modify code.
