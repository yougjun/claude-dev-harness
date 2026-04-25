# General Implementation Patterns

## REST API Design
- HTTP methods: GET (read), POST (create), PUT (full update), PATCH (partial), DELETE
- Consistent response format: { data, error, message }
- Meaningful status codes: 200, 201, 400, 401, 403, 404, 500
- Pagination: ?page=1&limit=20 or cursor-based

## SQL / Database
- Parameterized queries always
- Indexes on frequently queried columns
- Foreign keys for referential integrity
- Transactions for multi-step operations

## Error Handling
- Catch specific exceptions
- Log errors with context
- Return meaningful error messages
- Don't swallow errors silently

## Git Conventions
- Small, focused commits
- Descriptive messages: type: description
- Don't commit secrets or large binaries

## Security Basics
- Validate all user inputs at the boundary
- Parameterize database queries
- Escape HTML output
- Use HTTPS for external API calls
- Don't log sensitive data
