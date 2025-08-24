---
allowed-tools: Agent, Glob, Grep, MultiEdit, Read, TodoRead, TodoWrite, Write
description: Refactor README and documentation into organized structure
---

# user-docs-refactor

Restructure README.md into a clear table of contents and consolidate documentation per repo conventions (avoid a separate `docs/` directory). Focus on self-documenting commands and updating core files.

## Implementation

1. **Create task plan**:
   - Use TodoWrite to create structured refactoring task list
   - Break down into discovery, analysis, and execution phases
   - Track progress for each refactoring step
   - Organize tasks by priority and dependencies

2. **Discovery Phase**:
   - Analyze current README.md content
   - Find existing documentation files scattered in project
   - Map current documentation structure

3. **Analysis Phase**:
   - Deploy parallel agents to analyze documentation:
     - **Content Agent**: Categorize documentation by type
     - **Structure Agent**: Identify logical groupings
     - **Coverage Agent**: Find documentation gaps
     - **Navigation Agent**: Assess current discoverability

4. **Planning Phase**:
   - Design an optimal README table of contents and section flow
   - Decide what content belongs in README vs. `CLAUDE.md` vs. command files
   - Create logical navigation using anchors and concise cross-links

5. **Refactoring Phase**:
   - Mark refactoring tasks as in_progress
   - Transform README.md into a clear table of contents with anchors
   - Consolidate scattered docs into README and `CLAUDE.md` where appropriate
   - Link to command files in `claude/.config/claude/commands/` for self-documentation
   - Update task status as completed

6. **Enhancement Phase**:
   - Fill identified documentation gaps
   - Add examples where needed
   - Ensure consistent formatting
   - Create index for quick reference
   - Complete all remaining tasks

## Optimal Documentation Structure (Repo-Conformant)

```text
README.md (Table of Contents)
├── Project Overview
├── Quick Start
├── Key Commands (links to `claude/.config/claude/commands/*`)
├── Architecture Overview (brief; deeper details in code/diagrams)
├── Development Workflow (link to CLAUDE.md)
└── Troubleshooting & FAQs

CLAUDE.md
├── Agent and command development guidance
├── Repository conventions and standards
└── Multi-agent coordination patterns

tasks.md
├── Active initiatives and audits
└── Checklists and acceptance criteria
```

## Example Usage

```text
User: /user-docs-refactor
Assistant: I'll analyze your documentation and create an organized structure.

Analyzing current documentation...

Found:
- README.md (3000 lines, mixed content)
- Scattered docs in 5 different locations
- API docs embedded in code comments
- Setup instructions in multiple files

Deploying analysis agents...

[Content Agent]
- Found 8 distinct documentation categories
- README contains 60% setup, 20% API, 20% misc
- Missing deployment and troubleshooting docs

[Structure Agent]
- Current structure is flat and hard to navigate
- Related docs are in different directories
- No clear hierarchy

[Coverage Agent]
- Missing: Architecture decisions, troubleshooting
- Incomplete: API examples, deployment guide
- Well covered: Setup, development workflow

## Boundaries & Scope
- Do not create a `docs/` directory; follow repo convention to centralize in README and command files
- Do not change code or business logic; documentation only
- Keep changes limited to README, CLAUDE.md, tasks.md, and command self-docs

## Repo Conventions
- Follow guidance in `CLAUDE.md` for documentation standards
- Keep core documentation in `README.md`; avoid deep documentation hierarchies
- Ensure command files are self-documenting with clear usage

## Task List References
- Use `TodoWrite` to add/refine tasks in `tasks.md` for documentation work
- Record completion and any follow-ups in the appropriate audit sections

## Templates/Reports
```markdown
### Docs Refactor Summary
- Scope:
- Files updated:
- Major changes:
- Open questions:
- Follow-up tasks:
```

---

[Navigation Agent]
- Current README too long to navigate
- No index or search functionality
- Links between docs are broken

Creating refactoring plan...

## Documentation Refactoring Plan

### New Structure
1. **Transform** README.md into concise table of contents
2. **Create** organized docs/ directory with 6 categories
3. **Extract** embedded documentation from code
4. **Add** missing documentation sections

### Content Movement
- Extract setup guide → docs/getting-started/
- Move API docs → docs/api/
- Create new → docs/troubleshooting/

### README.md Structure
```markdown
# Project Name

Brief project description (2-3 lines)

## Quick Start
See [Getting Started Guide](docs/getting-started/quick-start.md)

## Documentation
- [Architecture Overview](docs/architecture/overview.md)
- [Development Guide](docs/development/setup.md)
- [API Reference](docs/api/overview.md)
- [Deployment Guide](docs/deployment/environments.md)

## Contributing
See [Contributing Guidelines](docs/contributing/guidelines.md)
```

## Refactoring Principles

1. **README as Hub**: Concise entry point to all documentation
2. **Logical Grouping**: Related docs in same directory
3. **Progressive Disclosure**: Overview → Details → Reference
4. **Cross-Linking**: Easy navigation between related docs
5. **Maintainability**: Clear structure for adding new docs
6. **No Community Docs**: Do NOT include Code of Conduct, Community Guidelines, or similar sections - focus only on technical documentation

## Notes

- Preserves all existing documentation content
- Improves navigation and discoverability
- Makes documentation easier to maintain
- Follows common documentation patterns
- Enables better documentation versioning
