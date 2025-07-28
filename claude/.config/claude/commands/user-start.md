---
allowed-tools: Read, Task, TodoWrite, TodoRead
description: Deploy active sub-agents to execute their tasks based on root tasks.md
---

# user-start

Deploy the active sub-agents identified in root `tasks.md` to begin parallel execution of their respective task lists.

## Implementation

1. Read root tasks.md to identify active agents:
   - Parse the "Active Sub-Agents" section
   - Extract list of agents involved in current work
   - Identify task list locations for each agent
   - Note coordination points between agents

2. Deploy Orchestrator first:
   - Task: Coordinate the execution across all active agents
   - Review current state of all task lists
   - Identify any blocking dependencies
   - Create execution order based on dependencies

3. Deploy implementation agents in parallel:
   For each active agent identified in tasks.md:
   
   - **Backend Engineer**: Work on tasks in `.claude/tasks/backend-engineer-tasks.md`
   - **Frontend Engineer**: Work on tasks in `.claude/tasks/frontend-engineer-tasks.md`  
   - **Infrastructure Engineer**: Work on tasks in `.claude/tasks/infra-engineer-tasks.md`
   - **Data Engineer**: Work on tasks in `.claude/tasks/data-engineer-tasks.md`
   - **Machine Learning Engineer**: Work on tasks in `.claude/tasks/machine-learning-engineer-tasks.md`

4. Execution instructions for each agent:
   - Start with highest priority unblocked tasks
   - Mark tasks as "in_progress" when starting
   - Implement following project conventions (CLAUDE.md)
   - Run appropriate quality checks (linting, tests)
   - Mark tasks as "completed" when done
   - Check for new tasks or dependencies

5. Orchestrator monitors progress:
   - Track completion across all agents
   - Identify when dependencies are resolved
   - Coordinate handoffs between agents
   - Report overall progress to user

## Agent Coordination Patterns

### Dependency Management
- Infrastructure tasks often block others
- Backend API contracts block Frontend
- Data pipelines may block ML training
- Orchestrator manages these dependencies

### Parallel Execution
- Agents work independently when possible
- Frontend and Backend can work in parallel after API contract defined
- Infrastructure and Data pipelines can run concurrently

### Quality Gates
Each agent maintains quality through:
- Following CLAUDE.md conventions
- Running domain-specific linters
- Writing and running tests
- Updating their task lists continuously

## Example Usage

```text
User: /user-start
Assistant: I'll deploy the active sub-agents identified in tasks.md to begin execution.

Reading root tasks.md...

Active Sub-Agents:
✅ Backend Engineer - API and business logic development
✅ Frontend Engineer - UI components and user experience  
✅ Infrastructure Engineer - Resource provisioning

Deploying Orchestrator to coordinate execution...

[Orchestrator]
Reviewing task lists:
- Backend: 8 tasks (2 completed, 6 pending)
- Frontend: 6 tasks (1 completed, 5 pending)
- Infrastructure: 4 tasks (3 completed, 1 pending)

Dependencies identified:
- Frontend waiting on Backend API contract
- Backend waiting on Infrastructure database setup

Execution order: Infrastructure → Backend → Frontend

Deploying active implementation agents...

[Infrastructure Engineer]
Working on: Provision RDS database instance
Status: Terraform apply in progress...
✅ Database provisioned successfully
Task marked complete

[Backend Engineer]
Unblocked! Starting: Design user model schema
✅ Schema created with auth fields
✅ Tests written and passing
Task marked complete

[Frontend Engineer]  
Starting: Create login form component
✅ Component built with validation
✅ Tests passing
Task marked complete

[Orchestrator]
Progress Update:
- Infrastructure: 4/4 tasks complete ✅
- Backend: 3/8 tasks complete 
- Frontend: 2/6 tasks complete
- Next: Backend API endpoint, then Frontend integration

All agents working in parallel where possible. No blockers detected.
```

## Notes

- Only deploys agents listed as active in root tasks.md
- Orchestrator manages dependencies between agents
- Agents work in parallel when possible
- Each agent maintains their own task list
- Quality checks are domain-specific per agent
- Progress tracked across all active agents
- Works with distributed task management system