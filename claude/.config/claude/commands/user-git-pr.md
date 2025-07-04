---
allowed-tools: Bash, Read, WebFetch, Grep
description: Create a GitHub pull request with Conventional Commits format
---

# user-git-pr

Create a GitHub pull request following the Conventional Commits standard with automated analysis of changes.

## Implementation

1. **Analyze the current branch and changes**:
   - Run `git branch --show-current` to get current branch name
   - Run `git log origin/main..HEAD --oneline` to see commits
   - Run `git diff origin/main --name-only` to see all changed files
   - Run `git diff origin/main --stat` to see change statistics
   - Determine the scope and type of changes

2. **Determine the change type based on modifications**:
   - **feat**: New features or functionality
   - **fix**: Bug fixes or corrections
   - **docs**: Documentation only changes
   - **style**: Code style changes (formatting, missing semicolons, etc.)
   - **refactor**: Code changes that neither fix bugs nor add features
   - **test**: Adding or updating tests
   - **chore**: Maintenance tasks, dependency updates, configuration
   - **perf**: Performance improvements
   - **ci**: CI/CD configuration changes

3. **Analyze commit patterns**:
   - Review commit messages for consistency
   - Check if commits follow conventional format
   - Identify the primary change type across commits
   - Determine appropriate scope from file paths

4. **Generate PR title using Conventional Commits format**:
   - Format: `type(scope): description`
   - Scope is optional and represents the affected area
   - Description should be clear and concise
   - Use imperative mood (e.g., "add" not "adds")

5. **Create comprehensive PR body**:
   - **Summary**: What changes were made and why
   - **Test Plan**: How the changes were tested
   - **Related Issues**: Link to issue tracker if applicable
   - **Breaking Changes**: Note if applicable
   - Include Claude Code attribution

6. **Execute GitHub CLI to create the PR**:
   - Use `gh pr create` with generated title and body
   - Set appropriate labels based on change type
   - Add reviewers if configured
   - Set draft status if changes are incomplete

## Example Usage

```sh
User: /user-git-pr
Assistant: I'll analyze your changes and create a pull request following Conventional Commits standards.

Analyzing current branch and changes...

Current branch: feature/user-authentication

Commits on this branch:
- Add JWT authentication middleware
- Create user login endpoint
- Add authentication tests

Files changed (3 files, +245, -12):
- src/middleware/auth.ts
- src/api/auth/login.ts
- tests/auth.test.ts

This appears to be a new feature adding authentication functionality.

Creating pull request...

Title: feat(auth): add JWT authentication system

Body:
## Summary
Implements JWT-based authentication for the application:
- Added authentication middleware for protected routes
- Created login endpoint with credential validation
- Comprehensive test coverage for auth flow

## Test Plan
- [x] Unit tests for JWT token generation
- [x] Integration tests for login endpoint
- [x] Middleware tests for protected routes
- [x] Manual testing with various credentials

## Related Issues
Closes #123

---
🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>

✅ Pull request created: https://github.com/org/repo/pull/456
```

## Notes

- Automatically determines the appropriate conventional commit type
- Generates descriptive PR titles following standards
- Creates comprehensive PR bodies with all required sections
- Handles various scenarios: features, fixes, breaking changes
- Works with GitHub CLI (`gh`) which must be authenticated
- Focuses on GitHub only - not GitLab or Bitbucket
- Can detect if branch name suggests issue number
- Provides consistent formatting for better PR reviews