---
allowed-tools: Bash, Read, Grep, Edit, LS, TodoRead, TodoWrite
description: Document new code patterns in the most relevant CLAUDE.md file
---

# user-rules-update

Automatically document new patterns in the CLAUDE.md file of the most relevant directory.

## Implementation

1. **Create task plan**:
   - Use TodoWrite to create structured task list for pattern documentation
   - Break down into analysis, extraction, and documentation phases
   - Track progress for each pattern discovered
   - Organize by location and priority

2. **Analyze recent code changes to identify new patterns**:
   - Run `git diff` to see unstaged changes
   - Run `git diff --cached` to see staged changes
   - Look for repeated code structures or emerging conventions
   - Identify which directories/components are affected

3. **Determine the most relevant location for the pattern**:
   - API-specific patterns → `apps/api/CLAUDE.md`
   - Frontend patterns → `apps/frontend/CLAUDE.md`
   - Service-specific → `services/[service-name]/CLAUDE.md`
   - Database patterns → `libs/database/CLAUDE.md`
   - Component-specific → `components/[component]/CLAUDE.md`
   - Cross-cutting patterns → root `CLAUDE.md` or `AGENTS.md`

4. **Extract pattern examples from actual code**:
   - Mark pattern extraction as in_progress
   - Include the actual code snippet that demonstrates the pattern
   - Show both good and bad examples when applicable
   - Use real file paths for reference
   - Complete pattern extraction task

5. **Format the new pattern documentation**:
   ```markdown
   ### [Pattern Name]

   **Description**: [What this pattern does and why]

   **✅ Good Example**:
   ```language
   # Actual code example
   ```

   **🎯 When to use**:
   - [Specific use case]
   - [Another use case]

   **✨ Benefits**:
   - [Key benefit]
   - [Another benefit]
   ```

6. **Update the appropriate CLAUDE.md**:
   - Mark documentation update as in_progress
   - Find or create CLAUDE.md in the most relevant directory
   - Add new pattern in logical section
   - Ensure patterns are scoped appropriately
   - Update root CLAUDE.md imports if needed
   - Complete all documentation tasks

## Location Selection Logic

The command determines the best location by:
1. **Scope Analysis**: Where are the changes located?
   - Single directory → That directory's CLAUDE.md
   - Single service/app → That service's CLAUDE.md
   - Multiple related components → Common parent directory
   - Cross-cutting → Root CLAUDE.md

2. **Impact Analysis**: Who needs to know about this pattern?
   - API team only → `apps/api/CLAUDE.md`
   - Frontend team only → `apps/frontend/CLAUDE.md`
   - Everyone → Root `CLAUDE.md` or `AGENTS.md`

## Example Usage

```text
User: /user-rules-update
Assistant: I'll analyze recent changes to identify new patterns and document them in the appropriate location.

Analyzing code changes...

Found new patterns in recent changes:

1. **API Rate Limiting Pattern**
   - Location: apps/api/middleware/
   - Implements token bucket algorithm
   - Affects: API endpoints only

2. **React Query Cache Pattern**
   - Location: apps/frontend/hooks/
   - Caches API responses with TTL
   - Affects: Frontend components only

3. **Repository Transaction Pattern**
   - Location: libs/database/repositories/
   - Ensures database consistency
   - Affects: All services using repositories

Determining best locations for documentation...

Pattern 1 → apps/api/CLAUDE.md (API-specific)
Pattern 2 → apps/frontend/CLAUDE.md (Frontend-specific)
Pattern 3 → libs/database/CLAUDE.md (Shared library)

Updating CLAUDE.md files...

Updated apps/api/CLAUDE.md:
✅ Added "API Rate Limiting Pattern" section

Updated apps/frontend/CLAUDE.md:
✅ Added "React Query Cache Pattern" section

Updated libs/database/CLAUDE.md:
✅ Added "Repository Transaction Pattern" section

Patterns documented in their most relevant locations!
```

## Directory Structure Examples

```text
project/
├── CLAUDE.md (cross-cutting patterns)
├── apps/
│   ├── api/
│   │   └── CLAUDE.md (API-specific patterns)
│   └── frontend/
│       └── CLAUDE.md (Frontend patterns)
├── services/
│   ├── auth/
│   │   └── CLAUDE.md (Auth service patterns)
│   └── billing/
│       └── CLAUDE.md (Billing patterns)
└── libs/
    ├── database/
    │   └── CLAUDE.md (Database patterns)
    └── shared/
        └── CLAUDE.md (Shared utilities)
```

## Notes

- Places patterns in the most relevant directory's CLAUDE.md
- Creates CLAUDE.md files as needed in appropriate directories
- Avoids cluttering root with component-specific patterns
- Maintains clear ownership and relevance
- Helps teams find patterns relevant to their work