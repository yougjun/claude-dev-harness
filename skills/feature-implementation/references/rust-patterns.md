# Rust Implementation Patterns

## Project Structure
- `src/main.rs` (binary) or `src/lib.rs` (library)
- Modules: `mod.rs` or `module_name.rs` + `module_name/` directory
- Workspace: `Cargo.toml` with `[workspace]` for multi-crate projects

## Error Handling
- Use `Result<T, E>` — never panic in library code
- `thiserror` for defining error types, `anyhow` for application errors
- `?` operator for propagation
- Map errors with `.map_err(|e| ...)`

## Ownership & Borrowing
- Prefer borrowing (`&T`, `&mut T`) over cloning
- Use `String` for owned data, `&str` for borrowed
- `Vec<T>` owned, `&[T]` borrowed slice
- Implement `Clone` only when ownership transfer is genuinely needed

## Traits
- Implement standard traits: `Display`, `Debug`, `From`, `Default`
- Use trait objects (`dyn Trait`) sparingly — prefer generics
- Derive macros: `#[derive(Debug, Clone, Serialize, Deserialize)]`

## Async
- `tokio` runtime (or `async-std` if the project uses it)
- `async fn` + `.await` for IO-bound operations
- Use `tokio::spawn` for concurrent tasks
- Always handle `JoinHandle` results

## Web
- `axum` or `actix-web` — match the project's framework
- Extractors for request parsing
- Tower middleware for cross-cutting concerns
