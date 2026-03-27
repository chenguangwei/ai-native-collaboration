---
name: python-backend-patterns
description: Python backend architecture and coding standards focusing on FastAPI, Pydantic, async programming, and database best practices. Use this when writing, reviewing, or refactoring Python code.
---

# Python Backend Patterns

## Core Principles
1. **PEP 8 Compliance**: Follow standard Python conventions (snake_case for functions/variables, PascalCase for classes). No `print()` for debugging (use `logger`).
2. **Type Hints**: Always use exact type hints (e.g., `dict[str, Any]` instead of generic `Any`).
3. **Async Programming**: Never mix sync blocking IO calls inside async functions.

## 1. Type Hints
**Avoid:** Missing types or `Any`.
```python
def get_user(id):
    return db.query(id)

data: Any = get_data()
```
**Preferred:** Explicit type signatures.
```python
def get_user(user_id: int) -> User:
    return db.query(user_id)

data: dict[str, Any] = get_data()
# or
data: UserSchema = get_data()
```

## 2. API Design (FastAPI)
**Avoid:** Missing response models or parameter validation.
```python
@app.get("/user/{user_id}")
def get_user(user_id: int):
    return user_service.get(user_id)

@app.post("/user")
def create_user(name: str, email: str):
    # Missing explicit validation
    pass
```
**Preferred:** Use Pydantic schemas and standard response models.
```python
class CreateUserRequest(BaseModel):
    name: str
    email: EmailStr

    @validator("name")
    def name_not_empty(cls, v):
        if not v.strip():
            raise ValueError("name cannot be empty")
        return v

@app.post("/user", response_model=UserResponse)
def create_user(request: CreateUserRequest):
    return user_service.create(request)
```

## 3. Database Operations
**Avoid:** N+1 queries or string concatenation syntax.
```python
# String concatenation (SQL Injection risk)
sql = f"SELECT * FROM users WHERE id = {user_id}"

# N+1 Query Problem
users = session.query(User).all()
for user in users:
    print(session.query(Order).filter_by(user_id=user.id).all())
```
**Preferred:** Parameterized queries and explicit `joinedload` for eager loading.
```python
# Parameterized query
sql = "SELECT * FROM users WHERE id = %s"
cursor.execute(sql, (user_id,))

# Eager loading via joinedload
users = session.query(User).options(joinedload(User.orders)).all()
```

## 4. Exception Handling
**Avoid:** Naked `except:` or swallowing errors without logging.
```python
try:
    do_something()
except:
    pass

try:
    do_something()
except Exception:
    return None
```
**Preferred:** Catch precise exceptions, log accordingly, and raise appropriate business errors.
```python
try:
    do_something()
except ValueError as e:
    logger.warning(f"Business error: {e}")
    raise BusinessError("Invalid input parameters")
except Exception as e:
    logger.exception("Unexpected system error")
    raise
```

## 5. Async Operations
**Avoid:** Blocking operations inside `async def` or mixing patterns improperly.
```python
@app.get("/users")
async def get_users():
    users = [] 
    for u in User.all():  # Blocking DB call!
        users.append(u)
    return users
```
**Preferred:** Embrace purely explicit async libraries (like `aiohttp` and `asyncpg` / `SQLAlchemy[asyncio]`).
```python
@app.get("/users")
async def get_users():
    users = await User.all() # Proper async call
    return users

async def fetch_data():
    async with aiohttp.ClientSession() as session:
        async with session.get(url) as response:
            return await response.json()
```

## 6. Security & Best Practices
- **No hardcoded secrets**: Use environment variables for API keys and toggles.
- **Password Hashing**: Use `passlib` or `bcrypt` for securely hashing passwords before storing.
- **Input Validation**: Never trust user data. Validate all endpoints inputs using `pydantic`.
- **SQL Injection**: Strictly use ORM or parametrized queries.
