
# user-lint

Run the appropriate linters and type checkers based on the types of files that have been modified.

## Implementation

1. Check which types of files have been modified:
   - Run `git diff --name-only` to see unstaged changes
   - Run `git diff --cached --name-only` to see staged changes
   - Combine both lists to get all modified files

2. Analyze file extensions to determine which linters to run:
   - Python files (`*.py`) → `ruff check` and `pyright`
   - Go files (`*.go`) → `go fmt`, `golangci-lint`, and `go vet`
   - TypeScript files (`*.ts`, `*.tsx`) → `eslint` and `tsc`
   - JavaScript files (`*.js`, `*.jsx`) → `eslint`
   - SQL files (`*.sql`) → `sqlfluff lint`
   - Terraform files (`*.tf`, `*.tfvars`) → `terraform validate`

3. Execute the appropriate linters and type checkers:
   - Run only the tools for modified file types
   - Run type checkers after linters
   - If multiple file types modified, run all applicable tools
   - If no files detected, run all available tools

4. Report results:
   - Show which linters and type checkers were run
   - Display any errors found
   - Provide clear pass/fail status

## Linter and Type Checker Details

### Python
- **ruff**: Fast Python linter for style and errors
- **pyright**: Static type checker for Python

### Go
- **go fmt**: Standard Go code formatter
- **golangci-lint**: Comprehensive Go linter aggregator
- **go vet**: Go static analysis tool for suspicious constructs

### TypeScript/JavaScript
- **eslint**: JavaScript/TypeScript linting with configured rules
- **tsc**: TypeScript compiler for type checking (TS files only)

### SQL
- **sqlfluff**: SQL linter and formatter for query validation

### Terraform
- **terraform validate**: Validates terraform configuration syntax

## Example Usage

### Python Example
```text
User: /user-lint
Assistant: I'll check which files were modified and run the appropriate linters and type checkers.

Checking for modified files...

Found modified files:
- src/services/user_service.py
- src/models/user.py

Detected Python files. Running Python linters and type checker...

Running ruff...
✅ ruff: No style issues found

Running pyright...
❌ pyright found type errors:
src/services/user_service.py:45:16 - error: Argument of type "str | None" cannot be assigned to parameter of type "str"
src/models/user.py:23:12 - error: "datetime" is not a known member of module "datetime"

Please fix the type errors before committing.
```

### TypeScript Example
```text
User: /user-lint
Assistant: I'll check which files were modified and run the appropriate linters and type checkers.

Checking for modified files...

Found modified files:
- src/components/UserList.tsx
- src/hooks/useAuth.ts
- src/utils/helpers.js

Detected TypeScript and JavaScript files. Running linters and type checker...

Running eslint...
⚠️  eslint found issues:
src/components/UserList.tsx:15:3 - warning: React Hook useEffect has missing dependencies
src/utils/helpers.js:8:10 - error: 'data' is defined but never used

Running tsc (TypeScript files only)...
❌ tsc found type errors:
src/components/UserList.tsx:32:5 - error TS2322: Type 'string' is not assignable to type 'number'
src/hooks/useAuth.ts:18:22 - error TS2339: Property 'email' does not exist on type 'User'

Please fix the linting and type errors before committing.
```

### Go Example
```text
User: /user-lint
Assistant: I'll check which files were modified and run the appropriate linters and type checkers.

Checking for modified files...

Found modified files:
- pkg/api/handlers.go
- internal/service/auth.go

Detected Go files. Running Go linters and static analysis...

Running go fmt...
✅ All files properly formatted

Running go vet...
⚠️  go vet found issues:
internal/service/auth.go:34: unreachable code

Running golangci-lint...
❌ golangci-lint found issues:
pkg/api/handlers.go:23:2: ineffectual assignment to err (ineffassign)
internal/service/auth.go:45: Error return value is not checked (errcheck)

Please fix the issues before committing.
```

## Notes

- Always checks both staged and unstaged files
- Runs both linters and type checkers where applicable
- Type checking provides additional safety beyond linting
- Provides specific error messages and locations
- No configuration files are assumed - uses default settings

## Boundaries & Scope
- Linting and type checks only; do not modify files
- Do not attempt auto-fix unless explicitly requested
- Report results and recommended next steps

## Repo Conventions
- Follow `CLAUDE.md` for language tool standards (ruff/pyright, eslint/tsc, sqlfluff)
- Respect project-specific config files when present

## Task List References
- If issues found, create remediation tasks via `TodoWrite` in the appropriate engineer task lists
- Record a summary status in `tasks.md` under the relevant audit or initiative

## Templates/Reports
```markdown
### Lint Report
- Files checked:
- Tools run:
- Errors:
- Warnings:
- Next steps:
```

---
