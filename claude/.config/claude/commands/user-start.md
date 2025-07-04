---
allowed-tools: Read, TodoWrite, TodoRead, Bash, Edit, MultiEdit, Write
description: Begin executing the plan from tasks.md
---

# user-start

Begin executing the plan created in `tasks.md` with focus on implementation best practices.

## Implementation

1. Load and validate the execution plan:
   - Read `tasks.md` to understand the current plan
   - Use TodoWrite to load tasks into tracking system
   - Identify the first pending task to work on
   - Verify all prerequisites are met

2. Follow development workflow:
   - Consider test-first approach when appropriate
   - Implement code following project patterns
   - Run linters and fix issues
   - Update documentation as needed

3. Continuous quality checks:
   - Run appropriate linters after implementation
   - Run relevant tests based on file types
   - Check for new patterns that should be documented

4. Task progression workflow:
   - Mark current task as `in_progress`
   - Complete implementation
   - Run all quality checks
   - Mark task as `completed`
   - Move to next task

5. Progress reporting:
   - Provide clear status updates after each task
   - Highlight any blockers or issues
   - Show test results and linting status
   - Summarize what was accomplished

## Development Patterns

### General Implementation
1. Understand existing patterns in the codebase
2. Write clean, maintainable code
3. Add tests when creating new functionality
4. Run linters to ensure code quality
5. Document complex logic

### Quality Checks
- Python: Run `ruff` and `pyright`
- Go: Run `golangci-lint`
- TypeScript: Run `eslint`
- SQL: Run `sqlfluff`
- Tests: Run `pytest` or `vitest` as appropriate

## Example Usage

```sh
User: /user-start
Assistant: I'll begin executing the plan from tasks.md.

Loading execution plan...

Found plan: "Implement user authentication system"
Total tasks: 8 (2 completed, 6 pending)

Loading tasks into tracking system...

Starting with next task: "Create user model with authentication fields"

Implementing user model...
[Creates user model with email, password hash, created_at fields]

Running quality checks...
✅ Linting passed
✅ Tests passed

Task completed! Moving to next task...

Progress Update:
- Completed: 3 of 8 tasks
- Current: User model created with auth fields
- Next: Implement password hashing service
- No blockers encountered
```

## Notes

- Flexible approach to development (test-first when beneficial)
- Continuously runs quality checks
- Tracks progress using todo tools
- Provides clear status updates
- Works with any project structure