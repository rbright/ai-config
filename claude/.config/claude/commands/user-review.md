---
allowed-tools: Read, Glob, Grep, Agent, Bash, TodoRead
description: Comprehensive pre-PR review using specialized agents
---

# user-review

Comprehensive pre-PR review using specialized agents to analyze code changes for quality, logic bugs, security vulnerabilities, and verification that linting and tests pass.

## Implementation

1. **Git Analysis**: Check current branch and compare against main to identify all modified files

2. **Requirements Verification**: 
   - Check for linked issues and verify changes satisfy requirements
   - Review tasks.md to ensure all planned tasks are complete
   - Verify acceptance criteria from task definitions
   - Check technical decisions were implemented as documented

3. **Agent Assignment**: Deploy 3 specialized agents to analyze the changes:
   - **Code Quality Agent**: Identify logic bugs, performance issues, and architectural concerns
   - **Security Agent**: Scan for security vulnerabilities, credential exposure, and safety issues
   - **Best Practices Agent**: Verify adherence to language-specific patterns and conventions

4. **Automated Checks**: Run linting and tests to ensure code quality

5. **Summary Report**: 
   - Compile findings from all agents with prioritized recommendations
   - Verify all tasks.md items are marked as completed
   - Confirm success criteria are met
   - Identify any deviations from the plan

## Agent Specializations

### Code Quality Agent
Identifies technical issues:
- Logic bugs: Null pointer exceptions, off-by-one errors, race conditions
- Performance issues: N+1 queries, inefficient algorithms, memory leaks
- Architecture concerns: Circular dependencies, tight coupling
- Code complexity: Large functions, deeply nested conditionals
- Error handling: Missing try/catch blocks, improper exception propagation

### Security Agent
Scans for security vulnerabilities:
- Credential exposure: API keys, passwords, tokens in code
- Input validation: SQL injection, XSS, command injection risks
- Data exposure: Sensitive information in logs or error messages
- Access control: Missing authorization checks
- Cryptography: Weak encryption, insecure random generation

### Best Practices Agent
Reviews against established patterns:
- Language conventions: Naming, formatting, idiomatic code
- Design patterns: Proper use of established patterns
- Testing coverage: Adequate test scenarios
- Documentation: Clear comments and docstrings
- Dependencies: Secure and up-to-date packages

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

```sh
User: /user-review
Assistant: I'll conduct a comprehensive pre-PR review of your changes and validate against the execution plan.

Reading tasks.md to verify implementation completeness...

Analyzing current branch changes...
Found changes in 12 files implementing real-time notifications.

Deploying 3 specialized review agents...

**Agent 1 - Code Quality Analysis**
✅ WebSocket implementation follows patterns
✅ Event handling properly structured
⚠️  WebSocketManager.handleReconnection() is complex (45 lines)
✅ Memory management implemented correctly

**Agent 2 - Security Analysis**
✅ JWT validation in WebSocket handshake
✅ No credential exposure detected
✅ Input sanitization present
⚠️  Consider rate limiting connections per user

**Agent 3 - Best Practices Analysis**
✅ TypeScript interfaces well-defined
⚠️  Missing types in utility functions
✅ Error boundaries implemented
✅ Logging follows standards

**Task Completion Review**
Phase 1: ✅ All foundation tasks complete
Phase 2: ✅ All implementation tasks complete  
Phase 3: ⚠️  1 of 2 tasks fully complete

**Success Criteria**
✅ Performance: Updates in 45ms (target: <100ms)
✅ Scalability: Tested with 1200 connections
❌ Monitoring: Not yet configured
✅ Reliability: Zero message loss confirmed

## Summary Report

**Blocking Issues (1):**
1. Redis pub/sub must be configured for production

**Non-blocking Issues (4):**
1. Add exponential backoff to retry logic
2. Refactor complex WebSocketManager method
3. Add missing TypeScript types
4. Configure monitoring for uptime tracking

**Recommendation**: Address blocking issue before PR. Implementation matches plan with 92% completion.
```

## Notes

- Uses multiple specialized agents for thorough review
- Focuses on practical issues that matter
- Provides actionable feedback with clear priorities
- Integrates automated linting and testing
- Generic enough to work with any codebase
- Verifies completion against tasks.md execution plan
- Ensures all acceptance criteria are satisfied
- Validates technical decisions were followed