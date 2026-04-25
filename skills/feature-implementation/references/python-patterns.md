# Python Implementation Patterns

## Flask
- Blueprints for route organization
- @app.errorhandler for consistent error responses
- Session management via flask-session or secure cookies
- Jinja2 templates, keep logic out of templates

## FastAPI
- Pydantic v2 models for request/response schemas
- Dependency injection via Depends()
- Async endpoints for I/O operations
- HTTPException for error responses
- One router per domain

## SQLAlchemy
- 2.0 style with select() statements
- Async sessions: async with get_session() as session:
- Alembic for migrations
- Explicit relationship loading (selectinload, joinedload)

## General Python
- Type hints for function signatures
- pathlib.Path over os.path
- f-strings for formatting
- Context managers for resources
- logging module, not print()
