# Pytest Patterns

## File Structure
- Test files: test_{module}.py or tests/test_{module}.py
- Conftest: conftest.py for shared fixtures
- Match source: app/services/stats.py → tests/services/test_stats.py

## Fixtures
```python
@pytest.fixture
def tmp_db(tmp_path):
    """Generic database fixture — adapt to your ORM/driver."""
    db_path = tmp_path / "test.db"
    # Replace with your project's DB setup
    yield db_path

@pytest.fixture
def client(tmp_db):
    """HTTP client fixture — adapt to your framework (Flask, FastAPI, Django)."""
    # Flask:   app.test_client()
    # FastAPI: TestClient(app)
    # Django:  django.test.Client()
    from app import create_app
    app = create_app(testing=True)
    with app.test_client() as c:
        yield c
```

## Test Patterns
```python
def test_create_user_success(client):
    response = client.post("/api/users", json={"name": "Test", "email": "test@example.com"})
    assert response.status_code == 201
    assert response.json()["name"] == "Test"

def test_create_user_duplicate_email(client):
    client.post("/api/users", json={"name": "A", "email": "dup@example.com"})
    response = client.post("/api/users", json={"name": "B", "email": "dup@example.com"})
    assert response.status_code == 400

def test_get_user_not_found(client):
    response = client.get("/api/users/99999")
    assert response.status_code == 404
```

## Running
```bash
pytest tests/ -v                           # All tests verbose
pytest tests/test_users.py -v              # Single file
pytest tests/test_users.py::test_create -v # Single test
pytest --cov=app tests/                    # With coverage
```
