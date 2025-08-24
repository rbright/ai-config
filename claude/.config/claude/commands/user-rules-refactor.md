---
allowed-tools: Agent, Glob, Grep, MultiEdit, Read, TodoRead, TodoWrite, Write
description: Refactor CLAUDE.md/AGENTS.md and rules files for optimal organization
---

# user-rules-refactor

Analyze and refactor CLAUDE.md or AGENTS.md and their imported rules files into an optimal structure, eliminating duplication and improving readability.

## Implementation

1. **Create task plan**:
   - Use TodoWrite to create comprehensive refactoring task list
   - Break down into discovery, analysis, planning, and execution phases
   - Track progress for each refactoring step
   - Organize by file and complexity

2. **Discovery Phase**:
   - Find CLAUDE.md or AGENTS.md in project root
   - Identify all imported rule files
   - Scan for `.ai/instructions/` or similar directories
   - Map current file structure and dependencies

3. **Analysis Phase**:
   - Deploy parallel agents to analyze different aspects:
     - **Structure Agent**: Analyze file organization and imports
     - **Duplication Agent**: Find repeated rules across files
     - **Categorization Agent**: Identify logical groupings of rules
     - **Readability Agent**: Assess flow and clarity of each file

4. **Planning Phase**:
   - Create optimal file structure under `.ai/instructions/`
   - Group related rules together
   - Eliminate duplication by consolidating similar rules
   - Ensure each file has a clear, focused purpose

5. **Refactoring Phase**:
   - Mark refactoring tasks as in_progress
   - Create new directory structure
   - Move rules to appropriate files
   - Update CLAUDE.md/AGENTS.md to reference new structure
   - Ensure smooth reading flow in each file
   - Complete refactoring tasks

6. **Validation Phase**:
   - Verify no rules were lost
   - Check all imports work correctly
   - Ensure improved readability
   - Complete all validation tasks

## Optimal Structure Pattern

```text
CLAUDE.md or AGENTS.md (main entry point)
├── Project overview and context
├── Quick reference to common patterns
└── Imports from .ai/instructions/

.ai/instructions/
├── 01-architecture.md      # System design patterns
├── 02-development.md        # Coding standards and practices
├── 03-testing.md           # Testing strategies and patterns
├── 04-api.md               # API design and patterns
├── 05-database.md          # Database patterns and migrations
├── 06-security.md          # Security best practices
├── 07-performance.md       # Performance optimization
├── 08-deployment.md        # CI/CD and deployment
└── 09-project-specific.md  # Unique project patterns
```

## Example Usage

```text
User: /user-rules-refactor
Assistant: I'll analyze your instruction files to create an optimal structure.

Discovering current structure...

Found:
- AGENTS.md (main file)
- .ai/instructions/ directory with 12 files
- Some rules duplicated across 3 files

Deploying analysis agents...

[Structure Agent]
- Current structure mixes concerns across files
- Import chain is 3 levels deep
- Some files have unclear purposes

[Duplication Agent]
- Found 5 instances of API validation rules
- Testing patterns repeated in 3 files
- Database patterns scattered

[Categorization Agent]
- Identified 8 logical rule categories
- Current 12 files can be consolidated to 9
- Clear hierarchy possible

[Readability Agent]
- Long files need splitting (python-standards.md has 500+ lines)
- Missing table of contents in main file
- Import order affects understanding

Creating refactoring plan...

## Refactoring Plan

### New Structure
1. **Consolidate** duplicate rules into single sources
2. **Reorganize** into 9 focused files under .ai/instructions/
3. **Improve** AGENTS.md as clear entry point
4. **Add** table of contents to each file

### File Movements
- Merge API validation from 3 files → 04-api.md
- Extract testing patterns → 03-testing.md
- Consolidate database rules → 05-database.md

Ready to proceed with refactoring? This will:
- Reduce files from 12 to 9
- Eliminate all duplication
- Improve navigation and readability
- Maintain all existing rules
```

## Refactoring Principles

1. **Single Responsibility**: Each file should cover one domain
2. **No Duplication**: Each rule defined exactly once
3. **Clear Hierarchy**: Logical flow from general to specific
4. **Easy Navigation**: Clear file names and structure
5. **Searchability**: Related rules grouped together

## Notes

## Boundaries & Scope
- Do not alter the intent of documented rules; refactor structure only
- Keep content in `CLAUDE.md` and related instruction files; avoid new doc trees

## Repo Conventions
- Follow `CLAUDE.md` for structure and style standards
- Minimize duplication; prefer cross-references over repetition

## Task List References
- Use `TodoWrite` to track refactor subtasks and open questions in `tasks.md`

## Templates/Reports
```markdown
### Rules Refactor Summary
- Files touched:
- Sections reorganized:
- Duplicates removed:
- Follow-ups:
```

- Works with either CLAUDE.md or AGENTS.md as main file
- Preserves all existing rules while improving organization
- Creates backup of original structure
- Updates all import references automatically
- Improves discoverability of patterns
- Makes maintenance easier
