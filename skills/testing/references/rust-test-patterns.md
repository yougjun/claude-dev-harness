# Rust Test Patterns

## File Structure
- Unit tests: `#[cfg(test)] mod tests` at bottom of source file
- Integration tests: `tests/` directory at crate root
- Test function: `#[test] fn test_foo()`

## Unit Tests
```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_add_positive() {
        assert_eq!(add(1, 2), 3);
    }

    #[test]
    fn test_add_zero() {
        assert_eq!(add(0, 0), 0);
    }

    #[test]
    #[should_panic(expected = "overflow")]
    fn test_add_overflow() {
        add(i32::MAX, 1);
    }
}
```

## Async Tests (tokio)
```rust
#[tokio::test]
async fn test_fetch_user() {
    let user = fetch_user(1).await.unwrap();
    assert_eq!(user.name, "Alice");
}
```

## Integration Tests
```rust
// tests/api_test.rs
use my_crate::create_app;

#[tokio::test]
async fn test_health_endpoint() {
    let app = create_app().await;
    let response = app.get("/health").await;
    assert_eq!(response.status(), 200);
}
```

## Running
```bash
cargo test                 # All tests
cargo test test_add        # Matching name
cargo test -- --nocapture  # Show println output
cargo test --doc           # Doc tests only
```
