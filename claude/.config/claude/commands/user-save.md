---
allowed-tools: Bash, TodoRead, Read, Write
description: Save current work progress to tasks.md for session continuity
---

# user-save

Capture current work progress and relevant files to `tasks.md` for seamless session continuity.

## Implementation

1. **Check current git status and changes**:
   - Run `git status --porcelain` to identify all file states
   - Run `git diff --name-only` to get list of modified files
   - Run `git diff --cached --name-only` for staged files
   - Categorize files by their change type

2. **Read current todo list**:
   - Use TodoRead tool to get current task status
   - Organize tasks by status (in_progress, completed, pending)
   - Calculate progress percentage
   - Identify blocked tasks

3. **Analyze recent work**:
   - Get last few commits with `git log --oneline -5`
   - Identify which files might need documentation updates
   - Check for patterns that emerged during work
   - Note any technical decisions made

4. **Generate comprehensive session summary**:
   - Current context and what was being worked on
   - In-progress tasks with their current status
   - Completed tasks from this session
   - Modified files grouped by purpose
   - Any new patterns or insights discovered
   - Technical decisions and trade-offs
   - Next steps for continuation

5. **Update or create `tasks.md`**:
   - If file exists, append new session with timestamp
   - If new file, create with full structure
   - Preserve any existing content
   - Add clear session separator
   - Include session metadata (duration, focus area)

## Example Usage

```sh
User: /user-save
Assistant: I'll capture the current session progress and save it to tasks.md.

Analyzing current work state...

Git Status:
- 5 modified files
- 2 new files
- 1 staged file

Todo Status:
- 3 completed tasks
- 2 in-progress tasks
- 4 pending tasks

Generating session summary...

Session saved to tasks.md:
- Context: Implementing authentication system
- Progress: 3 of 9 tasks completed (33%)
- Completed: JWT token generation, login endpoint, user model
- In Progress: Password reset flow (60%), profile endpoints (30%)
- Modified: 7 files across auth, models, and tests
- Key Decision: Using Redis for token blacklisting
- Next steps: Complete password reset, add tests, security review

✅ Session successfully saved for continuation!
```

## Notes

- Always append to existing tasks.md rather than overwrite
- Include enough context for resuming work later
- Keep summaries concise but comprehensive
- Focus on actionable information
- Highlight blockers prominently
- Include both technical and product decisions
- Use consistent emoji indicators (✅, ⚠️, ❌)
- Preserve the narrative flow of development