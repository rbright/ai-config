
# user-plan

Analyze a problem statement to create comprehensive requirements documentation and execution plans using specialized sub-agents for each technical domain.

## Implementation

1. Parse input to extract problem context:
   - Check for issue tracker links (use MCP tools to fetch details)
   - Identify specific requirements or user stories
   - Extract any technical constraints mentioned
   - Determine the initial scope of work

2. Deploy Orchestrator sub-agent (requirements owner):
   - **Task**: Analyze the problem and create comprehensive `requirements.md`
   - **Input**: Problem statement, issue tracker details, user context
   - **Output**: Structured requirements document with:
     - Functional requirements
     - Non-functional requirements
     - Technical breakdown by domain (Backend, Frontend, ML)
     - Acceptance criteria
     - Out of scope items

3. Analyze requirements to identify needed sub-agents:
   Based on the requirements.md created by Orchestrator, determine which agents are needed:

   - **Backend Engineer**: If API development, business logic, or data models are required
   - **Frontend Engineer**: If UI components, user interfaces, or client-side logic are needed
   - **Machine Learning Engineer**: If ML models, training pipelines, or AI features are required

4. Deploy ONLY relevant implementation sub-agents in parallel:
   For each identified domain, deploy the corresponding agent to create their execution plan:

   - Each agent creates tasks in their respective `.claude/tasks/[agent-name]-tasks.md`
   - Agents analyze only their domain-specific requirements
   - Cross-team dependencies are identified and documented

5. Create root-level tasks.md:
   Document which agents are involved in this work:
   ```markdown
   # Project: [Project Name]

   ## Active Sub-Agents
   - [ ] Backend Engineer - APIs, data/ETL, and infrastructure (Terraform)
   - [ ] Frontend Engineer - UI components and user experience
   - [ ] ML Engineer - Model development and inference

   ## Task Lists
   - Backend: `.claude/tasks/backend-engineer-tasks.md`
   - Frontend: `.claude/tasks/frontend-engineer-tasks.md`
   - ML: `.claude/tasks/ml-engineer-tasks.md`

   ## Coordination Points
   - Backend ↔ Frontend: API contract definition
   - Backend (Infra) → All: Resource provisioning must complete before integration
   ```

6. Deploy Orchestrator sub-agent:
   - Synthesize execution plans from active agents only
   - Identify cross-team dependencies
   - Create coordination timeline
   - Generate unified project overview

7. Present comprehensive planning results:
   - Summary of requirements from Product Manager
   - List of active sub-agents and why they're needed
   - Overview of each active team's execution plan
   - Key dependencies and coordination points
   - Timeline and resource requirements
   - Risks and mitigation strategies

8. Request user approval:
   - Present the complete plan
   - Show which agents will be involved
   - Highlight any concerns or clarifications needed
   - Confirm readiness to proceed with implementation

## Sub-Agent Deployment

### Product Manager
- Synthesizes problem statement into formal requirements
- Creates comprehensive `requirements.md` document
- Breaks down requirements by technical domain
- Defines acceptance criteria and scope

### Backend Engineer
- Analyzes backend requirements from Product Manager
- Creates detailed task list for API development
- Plans data model and business logic implementation
- Identifies integration points with other services

### Frontend Engineer
- Reviews UI/UX requirements from Product Manager
- Plans component architecture and state management
- Creates tasks for API integration and user flows
- Identifies responsive design and accessibility needs

### Infrastructure Engineer
- Assesses infrastructure requirements across all domains
- Plans resource provisioning and scaling strategy
- Creates deployment pipeline tasks
- Identifies monitoring and security needs

### Data Engineer
- Analyzes data pipeline requirements
- Plans ETL workflows and transformations
- Creates tasks for data quality and validation
- Identifies integration with ML and backend needs

### Machine Learning Engineer
- Reviews ML opportunities in requirements
- Plans model development and evaluation tasks
- Creates training pipeline architecture
- Identifies data dependencies and deployment needs

### Orchestrator
- Coordinates information flow between agents
- Identifies cross-team dependencies
- Creates unified project timeline
- Manages integration points

## Output Structure

The command creates distributed execution plans across multiple files:

### 1. Requirements Document (`requirements.md`)
Created by Product Manager sub-agent:

```markdown
# Feature: [Feature Name]

## Overview
[High-level description of the feature and its business value]

## Functional Requirements
- FR1: [Detailed requirement]
- FR2: [Detailed requirement]

## Non-Functional Requirements
- Performance: [Specific metrics]
- Security: [Security requirements]
- Scalability: [Scaling needs]

## Technical Breakdown

### Backend Requirements
- API endpoints needed
- Data models and schemas
- Business logic rules
- Integration points

### Frontend Requirements
- UI components and layouts
- User interaction flows
- State management needs
- Responsive design requirements

### Infrastructure Requirements
- Deployment architecture
- Resource requirements
- Monitoring and alerting
- Security configurations

### Machine Learning Requirements
- Model performance targets
- Training data needs
- Inference latency requirements

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Out of Scope
- Item 1
- Item 2
```

### 2. Backend Tasks (`.claude/tasks/backend-engineer-tasks.md`)
Created by Backend Engineer sub-agent:

```markdown
# Backend Engineer Tasks

## In Progress
- [ ] Task: [Current task description]

## To Do
- [ ] API: POST /api/notifications - Create notification endpoint
- [ ] Model: Design notification data schema
- [ ] Service: Implement notification business logic
- [ ] Integration: Connect to message queue

## Completed
- [x] Setup: Initialize project structure (completed: 2024-01-15)
```

### 3. Frontend Tasks (`.claude/tasks/frontend-engineer-tasks.md`)
Created by Frontend Engineer sub-agent:

```markdown
# Frontend Engineer Tasks

## In Progress
- [ ] Component: Building notification panel

## To Do
- [ ] Component: Create notification bell icon
- [ ] State: Implement notification store
- [ ] Integration: Connect WebSocket client
- [ ] UI: Add real-time update animations

## Completed
- [x] Setup: Configure React project (completed: 2024-01-15)
```

### 4. ML Tasks (`.claude/tasks/ml-engineer-tasks.md`)
Created by ML Engineer sub-agent (if applicable):

```markdown
# Machine Learning Engineer Tasks

## In Progress
- [ ] Model: Training notification prioritization model

## To Do
- [ ] Data: Prepare training dataset
- [ ] Train: Implement model training pipeline
- [ ] Evaluate: Create evaluation metrics
- [ ] Deploy: Prepare model for inference

## Completed
```

## Example Usage

```text
User: /user-plan Implement real-time notifications for workflow status changes
Assistant: I'll analyze the requirements and deploy specialized sub-agents to create execution plans.

Deploying Orchestrator to analyze requirements...

[Orchestrator]
Created requirements.md with:
- Functional requirements for real-time notifications
- Performance requirement: <100ms latency
- Technical breakdown identifying need for:
  - Backend: WebSocket API implementation
  - Frontend: Real-time UI components
  - Backend (Infra): WebSocket load balancing
  - ML: Not required for this feature

Identifying required sub-agents based on requirements...
✅ Backend Engineer - Required for WebSocket API
✅ Frontend Engineer - Required for notification UI
❌ Machine Learning Engineer - Not needed

Deploying required implementation sub-agents...

[Backend Engineer]
Created execution plan in .claude/tasks/backend-engineer-tasks.md:
- Design WebSocket connection manager
- Implement notification event handlers
- Create message queue integration
- Add authentication for WebSocket

[Frontend Engineer]
Created execution plan in .claude/tasks/frontend-engineer-tasks.md:
- Build notification bell component
- Implement WebSocket client service
- Create notification panel UI
- Add real-time state management

Backend (Infra) plan added to .claude/tasks/backend-engineer-tasks.md:
- Provision WebSocket load balancer
- Configure auto-scaling for WebSocket servers
- Set up monitoring for connection metrics
- Implement failover strategy

Created root tasks.md with:
- Active agents: Backend, Frontend
- Task list locations for each agent
- Key coordination points identified

[Orchestrator]
Coordination timeline:
1. Backend provisions resources (Day 1-2)
2. Backend implements API (Day 2-4)
3. Frontend builds UI in parallel (Day 2-4)
4. Integration testing (Day 5)
5. Production deployment (Day 6)

Dependencies identified:
- Frontend blocked on Backend API contract
- Both blocked on Infrastructure provisioning

Ready to proceed? Use /user-start to begin execution with the active agents.
```

## Notes

- Deploys Orchestrator first to create formal requirements
- Analyzes requirements to identify which sub-agents are needed
- Only deploys relevant implementation agents (no unnecessary agents)
- Each agent maintains their own task list in `.claude/tasks/[agent-name]-tasks.md`
- Creates root `tasks.md` listing active agents and coordination points
- Orchestrator coordinates only between active agents
- Always requests user approval before proceeding
- Integrates with issue tracking tools via MCP when applicable

## Boundaries & Scope
- Planning and requirements only; do not implement code changes
- Delegate implementation to domain agents per requirements
- Keep scope focused on current problem statement

## Repo Conventions
- Follow `CLAUDE.md` for requirements structure and terminology
- Use acceptance criteria that are measurable and testable

## Task List References
- Use `TodoWrite` to create/organize plan tasks in `tasks.md`
- Record agent assignments and decision points

## Templates/Reports
```markdown
### Planning Summary
- Feature:
- Assumptions:
- Risks:
- Agents:
- Next steps:
```
