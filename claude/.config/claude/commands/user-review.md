---
allowed-tools: Agent, Bash, Grep, LS, Read, TodoRead, TodoWrite
description: Deploy consolidated Reviewer sub-agent to analyze implementation and create remediation tasks
---

# user-review

Deploy the consolidated Reviewer sub-agent to comprehensively validate functionality against requirements, review code quality, and assess security posture. Synthesize findings into actionable remediation tasks for implementation agents.

## Implementation

1. **Preparation Phase**:
   - Read requirements.md to understand acceptance criteria
   - Check root tasks.md to identify active implementation agents
   - Run git diff to identify all modified files
   - Prepare context for review agents

2. **Deploy Reviewer**:
   - Task: Perform QA testing, code review, and security assessment
   - Create consolidated review report in `.claude/tasks/reviewer-tasks.md`
   - Identify missing functionality, defects, logic errors, and vulnerabilities
   - Verify acceptance criteria and quality standards are met

3. **Synthesis Phase**:
   - Collect all findings from review agents
   - Categorize issues by severity and responsible agent
   - Create remediation tasks for each implementation agent

4. **Task Creation**:
   Update implementation agent task lists with remediation tasks:
   - Backend Engineer: API fixes, ETL/data quality issues, infra hardening, performance improvements
   - Frontend Engineer: UI bugs, accessibility issues, state management fixes
   - ML Engineer: Model/inference issues surfaced via review

5. **Priority Assignment**:
   - Critical: Security vulnerabilities, data loss risks
   - High: Functional defects, performance problems
   - Medium: Code quality issues, missing tests
   - Low: Style issues, minor improvements

## Reviewer Report Structure

Created in `.claude/tasks/reviewer-tasks.md`:
```markdown
# Review Summary

## Executive Overview
- Overall readiness and risk areas

## Critical Findings
- [ ] [Area] – [Summary]
  - Evidence:
  - Impact:
  - Recommendation:

## Major Findings
- [ ] [Area] – [Summary]

## Minor Suggestions
- [ ] [Area] – [Suggestion]

## Requirements Gap Analysis
- [ ] Missing: [Requirement]
- [ ] Partial: [Requirement]

## Security Findings
- [ ] [Type]: [Vulnerability]
  - Risk:
  - Recommendation:
```

## tasks.md Review Structure

The review command validates implementation against the tasks.md execution plan:

```markdown
# Review Checklist for [Feature Name]

## Task Completion Verification

### Phase 1: Foundation ✅
- [x] Task 1.1: Set up WebSocket infrastructure
  - ✅ WebSocket endpoint created and tested
  - ✅ Connection handling implemented
  - ✅ Authentication middleware functional
  - **Review**: Code follows established patterns

- [x] Task 1.2: Create event listener service
  - ✅ Event subscription working
  - ✅ Event filtering implemented correctly
  - ⚠️  Error handling could be more robust
  - **Review**: Consider adding circuit breaker

### Phase 2: Implementation ✅
- [x] Task 2.1: Frontend WebSocket client
  - ✅ Connection established successfully
  - ✅ Reconnection logic tested
  - ✅ Message handlers comprehensive
  - **Review**: Good error recovery patterns

### Phase 3: Production Readiness ⚠️
- [x] Task 3.1: Error handling and recovery
  - ✅ Circuit breaker implemented
  - ⚠️  Retry logic needs exponential backoff
  - ✅ Fallback mechanisms in place
  - **Review**: Address retry timing issue

## Technical Decision Validation
- ✅ WebSockets implemented as specified
- ✅ JWT auth in connection params working
- ⚠️  Redis pub/sub not yet configured for scaling

## Success Criteria Assessment
- [x] Real-time updates < 100ms (avg: 45ms) ✅
- [x] Supports 1000+ connections (tested: 1200) ✅
- [ ] 99.9% uptime (monitoring not yet configured) ❌
- [x] Zero message loss during reconnects ✅

## Code Review Findings

### Critical Issues (0)
None found.

### High Priority (1)
1. Redis pub/sub configuration missing for multi-instance support

### Medium Priority (2)
1. Exponential backoff needed in retry logic
2. Complex function in WebSocketManager (needs refactoring)

### Low Priority (3)
1. Missing TypeScript types in 3 functions
2. Consider rate limiting on connection endpoint
3. Add metrics collection for monitoring
```

## Example Usage

```text
User: /user-review
Assistant: I'll deploy the consolidated Reviewer to analyze the implementation and create remediation tasks.

Preparing review context...
- Requirements: Real-time notification system
- Active agents: Backend, Frontend, Infrastructure
- Modified files: 12 files across all domains

Deploying consolidated Reviewer...

[Reviewer]
Validating against requirements.md, reviewing code quality, and assessing security...
✅ Real-time updates working (<100ms)
✅ 1000+ concurrent connections supported
❌ Missing: Notification persistence for offline users (requirements gap)
❌ Defect: Notifications lost on reconnection (functional)
⚠️  Major: WebSocketManager.handleReconnection() too complex
🔴 Critical: Rate limiting not implemented (DoS risk)
⚠️  High: User IDs exposed in WebSocket frames
✅ JWT validation properly implemented

Created consolidated review report with prioritized findings

Synthesizing findings into implementation tasks...

**Backend Engineer Tasks Added:**
- [ ] Critical: Implement rate limiting for WebSocket connections
- [ ] High: Fix notification persistence on reconnection
- [ ] Medium: Refactor complex WebSocketManager method
- [ ] Medium: Add comprehensive error handling

**Frontend Engineer Tasks Added:**
- [ ] High: Implement offline notification queue
- [ ] Medium: Add missing TypeScript types
- [ ] Low: Improve read receipt UI for offline users

**Backend Engineer Tasks Added:** (additional infra hardening)
- [ ] Critical: Configure rate limiting at API gateway/load balancer
- [ ] High: Add CSP headers and security middleware
- [ ] Medium: Add metrics and dashboards for WebSocket performance

## Summary Report

**Critical Issues (2):**
1. Rate limiting missing (Security)
2. Notifications lost on reconnection (Functional)

**High Priority (3):**
1. User ID exposure in frames
2. Offline notification persistence
3. CSP headers needed

**Total New Tasks:** 10 (Backend: 7, Frontend: 3)

All findings have been added to respective agent task lists. Use /user-start to begin remediation.
```

## Notes

## Boundaries & Scope
- Read-only analysis; do not modify code or infrastructure
- Focus on QA, code quality, and security; avoid scope creep

## Repo Conventions
- Follow `CLAUDE.md` for review standards and severity levels
- Keep findings concise, evidence-based, and non-duplicative

## Task List References
- Write consolidated findings to `.claude/tasks/reviewer-tasks.md`
- Create remediation tasks in each implementation agent’s task list

## Templates/Reports
```markdown
### Review Summary
- Scope assessed:
- Critical/High issues:
- Medium/Low issues:
- Evidence links:

### Remediation Plan
- Backend:
- Frontend:
- ML:
```

- Deploys consolidated Reviewer agent
- Reviewer creates a single report in `.claude/tasks/reviewer-tasks.md`
- Findings are synthesized into tasks for implementation agents
- Only creates tasks for active agents (from root tasks.md)
- Prioritizes issues by severity (Critical, High, Medium, Low)
- Reviewer has read-only access (cannot modify code)
- Creates actionable remediation tasks, not just findings
- Integrates with distributed task management system
