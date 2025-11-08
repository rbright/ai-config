---
description: Review changes against REQUIREMENTS.md and record prioritized findings in TASKS.md.
---

## Implementation

1. Prepare
   - Read `REQUIREMENTS.md` to enumerate acceptance criteria and constraints.
   - Inspect recent changes (`git status`, `git diff`, and committed diffs as needed).

2. Assess
   - Verify functionality against acceptance criteria.
   - Identify defects, missing coverage, security or performance risks.
   - Note requirement gaps or unclear assumptions.

3. Record findings
   - Append a "Review Findings" section to `TASKS.md` with prioritized, actionable items.
   - For each finding include: severity, summary, evidence (file/lines), and a remediation task.

## Boundaries
- Read‑only analysis of code; write findings and tasks into `TASKS.md` only.
