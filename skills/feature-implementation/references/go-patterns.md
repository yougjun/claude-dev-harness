# Go Implementation Patterns

## Project Structure
- `cmd/` for entry points, `internal/` for private packages, `pkg/` for public
- One package per directory, package name matches directory name
- `go.mod` at project root

## Error Handling
- Return errors as last value: `func Foo() (Result, error)`
- Wrap errors with context: `fmt.Errorf("fetch user %d: %w", id, err)`
- Check errors immediately — no deferred error checks
- Use `errors.Is()` and `errors.As()` for comparison

## Interfaces
- Define interfaces where they are consumed, not where implemented
- Small interfaces (1-3 methods) — io.Reader, io.Writer as models
- Accept interfaces, return structs

## Concurrency
- Share memory by communicating (channels), not by communicating through shared memory
- Use `sync.WaitGroup` for fan-out/fan-in
- Always handle goroutine cleanup (context cancellation, done channels)

## HTTP
- `net/http` for simple APIs, chi/gin/echo for routing
- Middleware pattern: `func(next http.Handler) http.Handler`
- Use `context.Context` for request-scoped values and cancellation

## Database
- `database/sql` + driver (pgx, go-sqlite3)
- Use `sqlx` for struct scanning if the project does
- Always use parameterized queries (`$1`, `?`)
