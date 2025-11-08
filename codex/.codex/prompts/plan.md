---
description: Create REQUIREMENTS.md and TASKS.md from a problem or issue.
argument-hint: ISSUE_URL=<tracker URL used to build the plan>
---

## Implementation

1. Gather context
   - If provided, fetch and summarize details from `$ISSUE_URL`.
   - Extract goals, constraints, stakeholders, and success criteria from user input and repo context.

2. Write `REQUIREMENTS.md`
   - Include: Overview, In/Out of Scope, Functional Requirements, Non‑Functional Requirements, Dependencies, Risks, Acceptance Criteria.
   - Use numbered requirements with stable IDs (FR-1, NFR-1).

3. Create `TASKS.md`
   - Derive concrete tasks from requirements; group by phases.
   - For each task: checkbox, short description, dependency notes, and an optional owner field.
   - Add a "Next Up" section with the first unblocked items.

4. Validate plan
   - Check that every requirement maps to at least one task.
   - Flag gaps or assumptions clearly.

## Boundaries
- Planning only; do not change code.
- Save output to root `REQUIREMENTS.md` and `TASKS.md`.
