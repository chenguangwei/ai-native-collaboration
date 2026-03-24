# 后端服务 (Python 3.11+ + FastAPI)

## 技术栈
- Python 3.11+
- FastAPI
- SQLAlchemy 2.0 (async)
- Pydantic v2
- Alembic（数据库迁移）
- Poetry（依赖管理）

## 目录结构

```
backend/
├── app/
│   ├── api/             # 路由层（APIRouter）
│   │   └── v1/
│   │       ├── auth.py
│   │       └── users.py
│   ├── services/        # 业务逻辑（无 DB 直接调用）
│   ├── repositories/    # 数据访问层（SQLAlchemy）
│   ├── models/          # SQLAlchemy ORM 模型
│   ├── schemas/         # Pydantic 请求/响应模型
│   ├── core/
│   │   ├── config.py    # 配置（从环境变量读取）
│   │   ├── security.py  # JWT / 密码哈希
│   │   └── deps.py      # FastAPI 依赖注入
│   └── main.py          # FastAPI 应用入口
├── tests/
│   ├── conftest.py
│   ├── unit/
│   └── integration/
├── alembic/             # 数据库迁移
├── pyproject.toml
└── Dockerfile
```

## 开发

```bash
poetry install
poetry run uvicorn app.main:app --reload
```

## 规范

- 路由层只做参数验证，不写业务逻辑
- 数据库操作统一在 repositories 层，使用 async session
- Pydantic Schema 与 ORM Model 严格分离
- 配置从环境变量读取，禁止硬编码密钥
- 测试使用 pytest + httpx（异步）
