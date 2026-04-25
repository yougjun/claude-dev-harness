# Go Test Patterns

## File Structure
- Test file: `foo_test.go` in same package as `foo.go`
- Test function: `func TestFoo(t *testing.T)`
- Table-driven tests are the standard pattern

## Table-Driven Tests
```go
func TestAdd(t *testing.T) {
    tests := []struct {
        name     string
        a, b     int
        expected int
    }{
        {"positive", 1, 2, 3},
        {"zero", 0, 0, 0},
        {"negative", -1, -2, -3},
    }
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            got := Add(tt.a, tt.b)
            if got != tt.expected {
                t.Errorf("Add(%d, %d) = %d, want %d", tt.a, tt.b, got, tt.expected)
            }
        })
    }
}
```

## HTTP Handler Tests
```go
func TestGetUser(t *testing.T) {
    req := httptest.NewRequest("GET", "/users/1", nil)
    w := httptest.NewRecorder()
    handler.ServeHTTP(w, req)
    if w.Code != http.StatusOK {
        t.Errorf("status = %d, want %d", w.Code, http.StatusOK)
    }
}
```

## Running
```bash
go test ./...              # All tests
go test ./pkg/... -v       # Verbose, specific package
go test -cover ./...       # With coverage
go test -run TestFoo ./... # Single test
```
