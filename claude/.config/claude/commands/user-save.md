---
allowed-tools: Read, Task, TodoRead, Write
description: Deploy active agents to update their task lists with current progress
---

# user-save

Deploy all active sub-agents to update their respective task lists with current progress, ensuring accurate state representation across the distributed system.

## Implementation

1. **Read root tasks.md**:
   - Identify all active sub-agents from "Active Sub-Agents" section
   - Extract task list locations for each agent
   - Note the project context and current phase

2. **Deploy each active agent to update their state**:
   For each active agent in tasks.md, deploy them with instructions to:

   - **Review their current task list** in `.claude/tasks/[agent-name]-tasks.md`
   - **Analyze recent work** in their domain (git diff, file changes)
   - **Update task statuses**:
     - Mark completed tasks with completion date
     - Update progress on in-progress tasks
     - Add any new tasks discovered during work
     - Note any blockers or dependencies

3. **Agent-specific updates**:

   **Implementation Agents** (Backend, Frontend, Infrastructure, Data, ML):
   - Update completion percentage on current tasks
   - Document technical decisions made
   - Add new tasks for discovered edge cases
   - Note integration points with other agents

   **Review Agents** (QA, Code Reviewer, Security):
   - Update findings from latest reviews
   - Mark resolved issues as complete
   - Add new issues discovered

4. **Create session summary**:
   After all agents update their lists, create a summary in root tasks.md:
   ```markdown
   ## Session Update - [Timestamp]

   ### Progress Summary
   - Backend: X/Y tasks complete (Z% progress)
   - Frontend: X/Y tasks complete (Z% progress)
   - Infrastructure: X/Y tasks complete (Z% progress)

   ### Key Accomplishments
   - [Agent]: [What was completed]

   ### Blockers
   - [Agent]: [What's blocking progress]

   ### Next Session Focus
   - Priority tasks across agents
   ```

5. **Synchronization check**:
   - Verify all agent task lists were updated
   - Check for any conflicting information
   - Ensure dependencies are properly noted

## Example Usage

```text
User: /user-save
Assistant: I'll deploy all active agents to update their task lists with current progress.

Reading root tasks.md...

Active Agents:
- Backend Engineer
- Frontend Engineer
- Infrastructure Engineer

Deploying agents to update their task lists...

[Backend Engineer]
Updating .claude/tasks/backend-engineer-tasks.md...
✅ Marked complete: Implement JWT authentication
✅ Marked complete: Create user login endpoint
⚙️  Updated progress: Password reset flow (70% complete)
📝 Added new task: Handle edge case for expired tokens
Blocked: Waiting on email service configuration

[Frontend Engineer]
Updating .claude/tasks/frontend-engineer-tasks.md...
✅ Marked complete: Login form component
⚙️  Updated progress: Password reset UI (40% complete)
📝 Added new task: Add loading states for auth flows
📝 Added new task: Implement remember me checkbox
Note: Need API contract for profile endpoints

[Infrastructure Engineer]
Updating .claude/tasks/infra-engineer-tasks.md...
✅ Marked complete: Redis cluster for sessions
✅ Marked complete: Email service configuration
⚙️  Updated progress: Rate limiting setup (90% complete)
Technical decision: Using AWS SES for email delivery

Creating session summary in root tasks.md...

## Session Update - 2024-01-20 15:30

### Progress Summary
- Backend: 5/9 tasks complete (56% progress)
- Frontend: 3/8 tasks complete (38% progress)
- Infrastructure: 6/7 tasks complete (86% progress)

### Key Accomplishments
- Backend: JWT auth and login endpoint working
- Frontend: Login UI complete with validation
- Infrastructure: Redis and email service ready

### Blockers
- Backend: Needs email templates for password reset
- Frontend: Waiting on profile API contract

### Next Session Focus
- Complete password reset flow (Backend + Frontend)
- Implement rate limiting (Infrastructure)
- Add comprehensive auth tests

✅ All agent task lists updated successfully!
```

## Notes

- Deploys only active agents listed in root tasks.md
- Each agent updates their own task list independently
- Creates unified progress summary in root tasks.md
- Preserves distributed task management structure
- Captures technical decisions and blockers per agent
- Enables accurate progress tracking across all domains
- Session summaries appended, never overwritten
- Synchronizes state across the entire system