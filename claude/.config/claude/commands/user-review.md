---
allowed-tools: Read, Glob, Grep, Task, Bash, TodoRead, TodoWrite
description: Deploy review sub-agents to analyze implementation and create remediation tasks
---

# user-review

Deploy QA, Code Reviewer, and Security Engineer sub-agents to comprehensively review the implementation, then synthesize their findings into actionable tasks for implementation agents.

## Implementation

1. **Preparation Phase**:
   - Read requirements.md to understand acceptance criteria
   - Check root tasks.md to identify active implementation agents
   - Run git diff to identify all modified files
   - Prepare context for review agents

2. **Deploy Review Sub-Agents in Parallel**:
   
   **QA Sub-Agent**:
   - Task: Test functionality against requirements.md
   - Create test report in `.claude/tasks/qa-tasks.md`
   - Identify missing functionality, defects, and integration issues
   - Verify acceptance criteria are met
   
   **Code Reviewer Sub-Agent**:
   - Task: Review code quality and logic
   - Create review report in `.claude/tasks/code-reviewer-tasks.md`
   - Identify logic bugs, performance issues, architectural concerns
   - Check adherence to CLAUDE.md conventions
   
   **Security Engineer Sub-Agent**:
   - Task: Scan for security vulnerabilities
   - Create security report in `.claude/tasks/security-engineer-tasks.md`
   - Identify credential exposure, injection risks, access control issues
   - Review cryptography and data protection

3. **Synthesis Phase**:
   - Collect all findings from review agents
   - Categorize issues by severity and responsible agent
   - Create remediation tasks for each implementation agent

4. **Task Creation**:
   Update implementation agent task lists with remediation tasks:
   - Backend Engineer: API fixes, logic corrections, performance improvements
   - Frontend Engineer: UI bugs, accessibility issues, state management fixes
   - Infrastructure Engineer: Security hardening, monitoring gaps
   - Data Engineer: Data quality issues, pipeline failures
   - ML Engineer: Model performance issues, training problems

5. **Priority Assignment**:
   - Critical: Security vulnerabilities, data loss risks
   - High: Functional defects, performance problems
   - Medium: Code quality issues, missing tests
   - Low: Style issues, minor improvements

## Review Agent Reports

### QA Report Structure
Created in `.claude/tasks/qa-tasks.md`:
```markdown
# QA Test Report

## Test Summary
- Total Requirements Tested: X
- Passed: X
- Failed: X

## Critical Defects
- [ ] [Feature]: Description of functional failure
  - Steps to reproduce
  - Expected vs Actual behavior

## Requirements Gap Analysis
- [ ] Missing: [Requirement not implemented]
- [ ] Partial: [Requirement partially implemented]
```

### Code Reviewer Report Structure
Created in `.claude/tasks/code-reviewer-tasks.md`:
```markdown
# Code Review Summary

## Critical Issues
- [ ] [File:Line]: Logic error description
- [ ] [File:Line]: Performance bottleneck

## Major Concerns
- [ ] Architecture: [Design issue]
- [ ] Complexity: [Refactoring needed]

## Minor Suggestions
- [ ] Style: [Convention violation]
- [ ] Documentation: [Missing docs]
```

### Security Engineer Report Structure
Created in `.claude/tasks/security-engineer-tasks.md`:
```markdown
# Security Assessment Report

## Critical Vulnerabilities
- [ ] [Type]: SQL Injection in [File:Line]
  - Risk: High
  - Recommendation: Use parameterized queries

## High-Priority Findings
- [ ] [Type]: Missing authentication on [Endpoint]
- [ ] [Type]: Sensitive data in logs

## Compliance Issues
- [ ] GDPR: Personal data not encrypted
- [ ] OWASP: Missing security headers
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
Assistant: I'll deploy review sub-agents to analyze the implementation and create remediation tasks.

Preparing review context...
- Requirements: Real-time notification system
- Active agents: Backend, Frontend, Infrastructure
- Modified files: 12 files across all domains

Deploying review sub-agents in parallel...

[QA Sub-Agent]
Testing against requirements.md...
✅ Real-time updates working (<100ms)
✅ 1000+ concurrent connections supported
❌ Missing: Notification persistence for offline users
❌ Defect: Notifications lost on reconnection
⚠️  Partial: Read receipts only work for online users

Created test report with 2 critical defects, 1 missing feature

[Code Reviewer]
Analyzing code quality...
⚠️  WebSocketManager.handleReconnection() - 45 lines (too complex)
⚠️  Missing error handling in notification service
✅ API contracts well-defined
✅ Good separation of concerns
⚠️  3 functions missing TypeScript types

Created review report with 3 major issues, 2 minor suggestions

[Security Engineer]
Scanning for vulnerabilities...
🔴 Critical: Rate limiting not implemented (DoS risk)
⚠️  High: User IDs exposed in WebSocket frames
✅ JWT validation properly implemented
✅ No credential leaks detected
⚠️  Medium: Add CSP headers for WebSocket endpoints

Created security report with 1 critical, 1 high priority issue

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

**Infrastructure Engineer Tasks Added:**
- [ ] Critical: Configure WAF rate limiting rules
- [ ] High: Add CSP headers to load balancer
- [ ] Medium: Set up monitoring for WebSocket metrics

## Summary Report

**Critical Issues (2):**
1. Rate limiting missing (Security)
2. Notifications lost on reconnection (QA)

**High Priority (3):**
1. User ID exposure in frames
2. Offline notification persistence
3. CSP headers needed

**Total New Tasks:** 11 (Backend: 4, Frontend: 3, Infrastructure: 3)

All findings have been added to respective agent task lists. Use /user-start to begin remediation.
```

## Notes

- Deploys QA, Code Reviewer, and Security Engineer sub-agents
- Each agent creates their own report in their task list
- Findings are synthesized into tasks for implementation agents
- Only creates tasks for active agents (from root tasks.md)
- Prioritizes issues by severity (Critical, High, Medium, Low)
- Review agents have read-only access (cannot modify code)
- Creates actionable remediation tasks, not just findings
- Integrates with distributed task management system