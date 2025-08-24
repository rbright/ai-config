---
allowed-tools: Bash, Grep, LS, Read
description: Run appropriate test suites based on modified file types
---

# user-test

Run the appropriate test suite based on the types of files that have been modified.

## Implementation

1. **Check which types of files have been modified**:
   - Run `git diff --name-only` to see unstaged changes
   - Run `git diff --cached --name-only` to see staged changes
   - Analyze file paths to determine affected code and tests
   - Map source files to their test files

2. **Determine which test suites to run**:
   - Python files (`*.py`) → `pytest`
   - Go files (`*.go`) → `go test`
   - TypeScript/JavaScript files (`*.ts`, `*.tsx`, `*.js`, `*.jsx`) → `vitest`
   - If test files modified, run tests for that specific area
   - If source files modified, run related test suites
   - Consider test dependencies and integration points

3. **Optimize test execution**:
   - Run focused tests when possible for speed
   - Run integration tests if service boundaries crossed
   - Default to running all tests if scope unclear
   - Use parallel execution where supported

4. **Report test results**:
   - Show test execution progress
   - Display failed tests with error details
   - Provide coverage information if available
   - Highlight flaky tests if detected
   - Show performance metrics for slow tests

## Example Usage

```text
User: /user-test
Assistant: I'll check which files were modified and run the appropriate tests.

Analyzing modified files...

Found modified files:
- src/services/user_service.py
- src/models/user.py
- tests/test_user_service.py

Detected Python changes. Determining test strategy...

Changes affect user service and model. Running focused tests...

Executing: pytest tests/test_user_service.py tests/test_models.py -v --cov=src

============================= test session starts ==============================
collected 15 items

tests/test_user_service.py::test_create_user PASSED                     [ 6%]
tests/test_user_service.py::test_update_user PASSED                     [13%]
tests/test_user_service.py::test_delete_user PASSED                     [20%]
tests/test_user_service.py::test_find_user PASSED                       [26%]
tests/test_user_service.py::test_authentication PASSED                  [33%]
tests/test_models.py::test_user_validation PASSED                       [40%]
tests/test_models.py::test_user_serialization PASSED                    [46%]
... 8 more tests ...

======================== 15 passed in 2.34s ========================

Coverage Report:
- src/services/user_service.py: 95%
- src/models/user.py: 100%
- Overall: 96%

✅ All tests passed with excellent coverage!
```

## Notes

## Boundaries & Scope
- Run tests only; do not modify code or test data
- Avoid flaky-test auto-retries unless configured
- Report failures with minimal, actionable context

## Repo Conventions
- Follow `CLAUDE.md` for language-appropriate test tooling (vitest, pytest, go test)
- Respect project-specific test scripts in package/config files

## Task List References
- Use `TodoWrite` to create tasks for failing tests or missing coverage
- Record a summary status in `tasks.md` under the current initiative

## Templates/Reports
```markdown
### Test Report
- Suites run:
- Pass/Fail:
- Failures:
- Coverage (if available):
- Next steps:
```

---

- Intelligently determines test scope based on modified files
- Runs focused tests when possible for faster feedback
- Supports Python (pytest), Go (go test), and TypeScript (vitest)
- No configuration files assumed - uses defaults
- Provides helpful context when tests fail
- Shows coverage metrics to track test completeness
- Uses consistent status indicators (✅, ❌, ⚠️)
- Can detect and run integration tests when needed
