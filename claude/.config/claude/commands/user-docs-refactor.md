---
allowed-tools: Read, Glob, Grep, Agent, Write, MultiEdit, TodoRead, TodoWrite
description: Refactor README and documentation into organized structure
---

# user-docs-refactor

Transform README.md into a table of contents and organize all documentation into a structured `docs/` directory.

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
   - Design optimal `docs/` directory structure
   - Plan README.md as navigation hub
   - Create logical flow for readers

5. **Refactoring Phase**:
   - Mark refactoring tasks as in_progress
   - Create `docs/` directory structure
   - Move documentation to appropriate files
   - Transform README.md into table of contents
   - Add navigation links between documents
   - Update task status as completed

6. **Enhancement Phase**:
   - Fill identified documentation gaps
   - Add examples where needed
   - Ensure consistent formatting
   - Create index for quick reference
   - Complete all remaining tasks

## 📊 Optimal Documentation Structure

```
📋 README.md (Table of Contents)
├── Project Overview
├── Quick Start
├── Documentation Index
└── Links to all docs

docs/
├── 🚀 getting-started/
│   ├── installation.md
│   ├── quick-start.md
│   └── first-steps.md
├── 🏗️ architecture/
│   ├── overview.md
│   ├── design-decisions.md
│   └── system-components.md
├── 💻 development/
│   ├── setup.md
│   ├── coding-standards.md
│   └── workflow.md
├── 📡 api/
│   ├── overview.md
│   ├── endpoints.md
│   └── examples.md
├── 🛠️ deployment/
│   ├── environments.md
│   ├── configuration.md
│   └── monitoring.md
├── 🤝 contributing/
│   ├── guidelines.md
│   ├── pull-requests.md
│   └── code-review.md
└── 📚 reference/
    ├── commands.md
    ├── configuration.md
    └── troubleshooting.md
```

## Example Usage

```sh
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

### 📋 README.md Structure
```markdown
# Project Name

Brief project description (2-3 lines)

## 🚀 Quick Start
See [Getting Started Guide](docs/getting-started/quick-start.md)

## 📚 Documentation
- [🏗️ Architecture Overview](docs/architecture/overview.md)
- [💻 Development Guide](docs/development/setup.md)
- [📡 API Reference](docs/api/overview.md)
- [🛠️ Deployment Guide](docs/deployment/environments.md)

## 🤝 Contributing
See [Contributing Guidelines](docs/contributing/guidelines.md)
```

Ready to refactor? This will:
- Reduce README.md from 3000 to ~100 lines
- Create organized docs/ structure
- Improve documentation discoverability
- Make it easier to maintain docs
```

## 📝 Refactoring Principles

1. **README as Hub**: Concise entry point to all documentation
2. **Logical Grouping**: Related docs in same directory
3. **Progressive Disclosure**: Overview → Details → Reference
4. **Cross-Linking**: Easy navigation between related docs
5. **Maintainability**: Clear structure for adding new docs

## Notes

- Preserves all existing documentation content
- Improves navigation and discoverability
- Makes documentation easier to maintain
- Follows common documentation patterns
- Enables better documentation versioning