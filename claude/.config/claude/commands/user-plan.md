---
allowed-tools: Read, Glob, Grep, Agent, TodoWrite, WebFetch
description: Research and analyze a problem to create a comprehensive execution plan
---

# user-plan

Research and analyze a problem statement to create a comprehensive execution plan using parallel agents.

## Implementation

1. Parse input to extract problem context:
   - Check for issue tracker links (use MCP tools to fetch details)
   - Identify file paths mentioned
   - Extract key requirements and constraints
   - Determine the scope of work

2. Launch parallel research agents:
   - **Architecture Agent**: Analyze codebase structure and patterns
   - **Implementation Agent**: Research similar implementations and solutions
   - **Testing Agent**: Identify testing requirements and strategies
   - **Documentation Agent**: Find relevant documentation and patterns

3. Synthesize research findings:
   - Compile discoveries from all agents
   - Identify technical challenges and risks
   - Find relevant patterns in documentation
   - Determine required dependencies and tools

4. Create comprehensive execution plan:
   - Break down work into concrete, actionable tasks
   - Estimate complexity for each task
   - Identify dependencies between tasks
   - Note potential blockers or uncertainties

5. Generate structured plan in `tasks.md`:
   - Use markdown task list format
   - Include context, objectives, and success criteria
   - Add discovered patterns and architectural decisions
   - List clarifying questions for user

6. Request user approval:
   - Present summary of the plan
   - Highlight any concerns or risks
   - Wait for user confirmation before proceeding

## Research Agent Patterns

### Architecture Agent
- Reviews project structure and existing patterns
- Identifies where new code should be placed
- Finds similar features for reference
- Checks architectural constraints

### Implementation Agent
- Searches for existing code to reuse or extend
- Identifies required models, services, or components
- Finds relevant utilities and helpers
- Checks for potential conflicts

### Testing Agent
- Identifies existing test patterns
- Determines test data requirements
- Finds relevant test utilities and fixtures
- Plans test scenarios

### Documentation Agent
- Searches project documentation for patterns
- Finds relevant technical documentation
- Identifies documentation that needs updates
- Checks for coding conventions

## tasks.md Structure

The command creates a detailed execution plan in tasks.md with the following structure:

```markdown
# [Project/Feature Name]

## Context
[Problem description and background]

## Objectives
- [ ] Primary goal 1
- [ ] Primary goal 2
- [ ] Primary goal 3

## Technical Approach
[High-level solution architecture]

## Execution Plan

### Phase 1: Foundation
- [ ] Task 1.1: Set up WebSocket infrastructure
  - Create WebSocket endpoint in backend
  - Configure connection handling
  - Add authentication middleware
  - **Complexity**: Medium
  - **Dependencies**: None

- [ ] Task 1.2: Create event listener service
  - Subscribe to workflow events
  - Implement event filtering
  - Add error handling
  - **Complexity**: High
  - **Dependencies**: Task 1.1

### Phase 2: Implementation
- [ ] Task 2.1: Frontend WebSocket client
  - Set up WebSocket connection
  - Handle reconnection logic
  - Implement message handlers
  - **Complexity**: Medium
  - **Dependencies**: Task 1.1

- [ ] Task 2.2: Real-time UI updates
  - Create notification components
  - Update state management
  - Add visual indicators
  - **Complexity**: Low
  - **Dependencies**: Task 2.1

### Phase 3: Production Readiness
- [ ] Task 3.1: Error handling and recovery
  - Implement circuit breaker
  - Add retry logic
  - Create fallback mechanisms
  - **Complexity**: Medium
  - **Dependencies**: Tasks 2.1, 2.2

- [ ] Task 3.2: Performance optimization
  - Add connection pooling
  - Implement message batching
  - Optimize payload size
  - **Complexity**: High
  - **Dependencies**: All previous tasks

## Technical Decisions
- **WebSockets vs SSE**: Chose WebSockets for bidirectional communication
- **Auth Strategy**: JWT tokens in connection params
- **Scaling Approach**: Redis pub/sub for multi-instance support

## Risks & Mitigations
- **Risk**: High concurrent connections
  - **Mitigation**: Connection pooling and rate limiting
- **Risk**: Network instability
  - **Mitigation**: Automatic reconnection with exponential backoff

## Success Criteria
- [ ] Real-time updates within 100ms
- [ ] Support 1000+ concurrent connections
- [ ] 99.9% uptime for notification service
- [ ] Zero message loss during reconnections

## Open Questions
1. Should we implement message persistence for offline users?
2. What's the retention policy for notifications?
3. Do we need read receipts for notifications?
```

## Example Usage

```text
User: /user-plan Implement real-time notifications for workflow status changes
Assistant: I'll research the requirements and create a comprehensive execution plan.

Launching parallel research agents to analyze the problem...

[Architecture Agent]
- Current system uses REST APIs without WebSocket support
- Frontend uses modern React with state management
- No existing real-time infrastructure found
- Backend framework supports WebSocket implementation

[Implementation Agent]
- WebSocket libraries available for chosen framework
- Frontend would need WebSocket client setup
- Consider Server-Sent Events as simpler alternative
- Message queue might be needed for reliability

[Testing Agent]
- WebSocket testing requires special fixtures
- Need to mock real-time event streams
- Frontend testing with mock WebSocket server
- Integration tests for full flow

[Documentation Agent]
- No real-time patterns in current docs
- WebSocket patterns would be new architecture
- Need to document event flow and error handling
- Security considerations for auth over WebSocket

Synthesizing research and creating execution plan...

✅ Created comprehensive plan in tasks.md with:
- 6 actionable tasks across 3 phases
- Clear dependencies and complexity estimates
- Technical decisions documented
- Risk mitigation strategies
- Success criteria defined

The plan includes Foundation (WebSocket setup), Implementation (client integration), and Production Readiness phases. Each task has clear acceptance criteria.

Ready to proceed with implementation? Use /user-start to begin execution.
```

## Notes

- Uses multiple specialized agents for comprehensive research
- Creates detailed, actionable plans based on actual codebase analysis
- Identifies technical challenges and architectural decisions upfront
- Always requests user approval before proceeding with implementation
- Integrates with issue tracking tools via MCP when applicable
- Creates structured task lists in tasks.md for execution
- Each task includes complexity estimates and dependencies
- Plan includes risk assessment and success criteria