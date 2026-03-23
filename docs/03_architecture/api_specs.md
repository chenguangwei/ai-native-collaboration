# 📡 API 契约文档

> 前后端 AI 并发结对编程的【唯一对齐基准】

---

## 1. API 设计原则

### RESTful 规范

- 资源命名: 小写、复数、kebab-case
- HTTP 方法: GET/POST/PUT/DELETE
- 状态码: 符合 HTTP 语义

### 版本管理

```
API 前缀: /api/v1/
升级策略: 向后兼容
废弃通知: 提前 3 个月
```

---

## 2. 认证接口

### 登录

```
POST /api/v1/auth/login

Request:
{
  "email": "user@example.com",
  "password": "password123"
}

Response (200):
{
  "token": "jwt-token",
  "refreshToken": "refresh-token",
  "expiresIn": 86400
}

Response (401):
{
  "error": "invalid_credentials",
  "message": "邮箱或密码错误"
}
```

### 登出

```
POST /api/v1/auth/logout
Headers: Authorization: Bearer <token>

Response (204): No Content
```

---

## 3. 用户接口

### 获取当前用户

```
GET /api/v1/users/me
Headers: Authorization: Bearer <token>

Response (200):
{
  "id": "user-123",
  "email": "user@example.com",
  "name": "张三",
  "createdAt": "2024-01-01T00:00:00Z"
}
```

### 更新用户

```
PATCH /api/v1/users/me
Headers: Authorization: Bearer <token>

Request:
{
  "name": "新名字"
}

Response (200):
{
  "id": "user-123",
  "email": "user@example.com",
  "name": "新名字"
}
```

---

## 4. 通用响应格式

### 成功响应

```json
{
  "data": { },
  "meta": {
    "page": 1,
    "total": 100
  }
}
```

### 错误响应

```json
{
  "error": "error_code",
  "message": "错误描述",
  "details": { }
}
```

---

## 5. HTTP 状态码

| 状态码 | 含义 |
|--------|------|
| 200 | 成功 |
| 201 | 创建成功 |
| 204 | 无内容 |
| 400 | 请求错误 |
| 401 | 未认证 |
| 403 | 无权限 |
| 404 | 资源不存在 |
| 500 | 服务器错误 |
