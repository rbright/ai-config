# Claude Code Configuration Guide

## Overview

This repository contains a sophisticated multi-agent command system for Claude Code that implements AI-assisted development workflows. The system focuses on command generalization, tool restriction optimization, and multi-agent coordination patterns.

## Key Principles

- **Minimal Tool Access**: Each command uses only necessary tools for optimal performance
- **Multi-Agent Coordination**: Commands leverage specialized agents for complex workflows
- **Generalized Patterns**: Commands are designed to work across different projects
- **Quality Gates**: Integrated linting, testing, and review processes

## Creating New Commands

### Command Structure

Commands are stored in `claude/.config/claude/commands/` and follow this structure:

```markdown
---
allowed-tools:
  - Read
  - Grep
  - Agent
  - TodoWrite
description: "Brief description of command purpose"
---

# Command Name

Brief command description and usage instructions.

## Implementation

Detailed implementation instructions including:
1. Multi-agent deployment patterns
2. Tool usage guidelines
3. Integration with external services
4. Quality gate requirements

## Example Usage

```text
User: /command-name
Assistant: [Expected behavior and output]
```


### Tool Restriction Guidelines

Each command should specify minimal necessary tools in YAML frontmatter:

**Planning Commands** (research/analysis):
- `Read`, `Glob`, `Grep`, `Agent`, `TodoWrite`, `WebFetch`

**Development Commands** (implementation):
- `Read`, `TodoWrite`, `TodoRead`, `Bash`, `Edit`, `MultiEdit`, `Write`

**Quality Commands** (linting/testing):
- `Bash`, `LS`, `Grep`, `Read`

**Git Commands** (version control):
- `Bash`, `Read`, `Grep`, `Agent`, `WebFetch`

### Multi-Agent Patterns

#### Parallel Agent Deployment
For research and planning commands:
```text
Deploy specialized agents simultaneously:
- Architecture Agent (structure analysis)
- Implementation Agent (solution research)
- Testing Agent (test strategy)
- Documentation Agent (pattern discovery)
```

#### Sequential Agent Review
For quality assurance commands:
```text
Deploy agents in sequence:
- Code Quality Agent → Security Agent → Best Practices Agent
- Each builds on previous findings
```

#### Pipeline Agent Processing
For git integration commands:
```text
Deploy agents in pipeline:
- Grouping Agent → Sequencing Agent → Type Agent
- Transform data through each stage
```

## Integration Requirements

### External Tool Integration
- **GitHub**: Use `gh` CLI for repository operations
- **Linear**: Use Linear MCP for issue tracking
- **Sentry**: Use Sentry MCP for error monitoring
- **Language Tools**: Standardize on `ruff`/`pyright` (Python), `eslint`/`vitest` (TypeScript), `sqlfluff` (SQL)

### Task Management Integration
- Commands should integrate with `tasks.md` for task planning
- Use `TodoWrite`/`TodoRead` for progress tracking
- Support session continuity with `user-save`

## Command Categories

### Planning and Architecture
- **user-plan**: Multi-agent research and execution planning
- **user-review**: Comprehensive pre-PR review
- **user-save**: Session state management

### Development Workflow
- **user-start**: Task execution from `tasks.md`
- **user-lint**: Language-specific linting
- **user-test**: Focused test execution

### Git Integration
- **user-git-commit**: Conventional commits with logical grouping
- **user-git-pr**: GitHub PR creation

### Documentation
- **user-docs-update**: Documentation synchronization
- **user-docs-refactor**: Documentation restructuring

## Best Practices

### Command Design
1. **Single Responsibility**: Each command should have a clear, focused purpose
2. **Minimal Tools**: Use only essential tools for performance
3. **Error Handling**: Provide clear error messages and recovery guidance
4. **User Experience**: Include helpful examples and usage patterns

### Multi-Agent Coordination
1. **Agent Specialization**: Each agent should have distinct expertise
2. **Parallel Execution**: Use parallel agents when possible for performance
3. **Result Synthesis**: Combine agent findings into unified recommendations
4. **Failure Recovery**: Handle agent failures gracefully

### External Integration
1. **MCP Tools**: Prefer MCP integrations for external services
2. **Authentication**: Use system credentials and tokens appropriately
3. **Rate Limiting**: Respect external service limits
4. **Error Handling**: Provide fallback options for service failures

## Configuration Management

### Settings Hierarchy
Commands follow this configuration priority:
1. Command YAML frontmatter (highest)
2. `.claude/settings.local.json`
3. `claude/.config/claude/settings.json`
4. Claude Code defaults (lowest)

### Tool Access Control
Tool access is controlled at multiple levels:
- **Command Level**: `allowed-tools` in YAML frontmatter
- **Local Level**: Permission overrides in local settings
- **Global Level**: System-wide restrictions

## Development Guidelines

### Documentation Standards
- **Avoid docs/ directory**: This repository should not contain extensive documentation hierarchies
- **Focus on README.md**: Keep core documentation in the main README
- **Command Self-Documentation**: Commands should be self-documenting with clear examples
- **CLAUDE.md**: Use this file for development guidance and command creation instructions

### Testing Commands
- Test commands in isolation before integration
- Verify tool restrictions work correctly
- Test multi-agent coordination patterns
- Validate external service integrations

### Version Control
- Use conventional commits for all changes
- Group related changes logically
- Include command updates in commit messages
- Link to relevant issues when applicable

## Performance Considerations

### Tool Optimization
- **Minimal Tool Sets**: Reduce startup time and resource usage
- **Tool Caching**: Leverage tool caching when available
- **Parallel Execution**: Use parallel agents for improved performance
- **Resource Limits**: Respect timeout and resource constraints

### Agent Efficiency
- **Specialized Agents**: Use focused agents for specific tasks
- **Result Sharing**: Avoid duplicate analysis between agents
- **Early Termination**: Stop agent execution when sufficient results obtained
- **Resource Management**: Monitor agent resource usage

## Troubleshooting

### Common Issues
1. **Tool Access Denied**: Check `allowed-tools` in command YAML
2. **Agent Failures**: Verify agent coordination patterns
3. **External Service Errors**: Check MCP tool configuration
4. **Performance Issues**: Review tool usage and agent patterns

### Debugging Commands
- Use `user-save` to capture session state
- Check tool restrictions in command frontmatter
- Verify external service authentication
- Review multi-agent coordination logs

## Example Command Template

```markdown
---
allowed-tools:
  - Read
  - Grep
  - Agent
  - TodoWrite
description: "Template for new command creation"
---

# user-template

Template command for creating new AI-assisted development workflows.

## Implementation

1. **Parse user input and context**
2. **Deploy specialized agents if needed**
3. **Execute core functionality**
4. **Integrate with task management**
5. **Provide clear output and next steps**

## Multi-Agent Pattern

```text
IF complex analysis required
THEN deploy specialized agents:
  - Agent A (specific domain)
  - Agent B (specific domain)
  - Agent C (specific domain)
ELSE use single-agent approach
```

## Example Usage

```text
User: /user-template
Assistant: I'll analyze your request and execute the template workflow.

[Agent deployment and execution details]

Template workflow complete. Next steps: [specific guidance]
```

## Integration Points

- **Task Management**: Updates `tasks.md` with progress
- **External Services**: Integrates with relevant MCP tools
- **Quality Gates**: Includes appropriate validation steps
- **Documentation**: Updates related documentation as needed