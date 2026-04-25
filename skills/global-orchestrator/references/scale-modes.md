# Scale Mode Selection Criteria

## Single Mode
**Agents:** implementer only
**Execution:** Direct subagent call

Select when ALL true:
- Change affects 1 file (or 2-3 trivially related files)
- No architectural decisions needed
- Straightforward: typo fix, config change, simple bug fix, string update
- No tests needed (or existing tests cover the change)

Examples: "Fix the typo in the header", "Change port from 3000 to 3001", "Update copyright year", "Add a missing import"

## Reduced Mode
**Agents:** analyst → implementer → tester (sequential subagents)

Select when ANY true:
- Bug fix that needs analysis to locate the cause
- Small feature affecting 2-5 files
- Refactoring within a single module
- Adding tests for existing functionality

Examples: "Fix the login error when session expires", "Add input validation to the form", "Refactor the database queries in stats.py", "Add tests for the user service"

## Full Mode
**Agents:** All 7 (hybrid execution)

Select when ANY true:
- New feature requiring new files, routes, or components
- Change touching 5+ files across different layers
- Architectural decision needed
- Explicit user request for full review
- Changes to authentication, authorization, or data handling

Examples: "Add user authentication system", "Build a new dashboard page with API endpoint", "Migrate from REST to GraphQL"

## Override
User can always override:
- "Just fix it, no harness" → Single mode
- "Full review please" → Full mode
- "Skip security review" → Full minus Phase 4 security
