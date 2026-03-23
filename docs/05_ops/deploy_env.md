# 🌍 多环境配置

> 开发、测试、生产环境配置

---

## 1. 环境列表

| 环境 | 域名 | 用途 |
|------|------|------|
| 开发 | dev.example.com | 本地开发 |
| 测试 | staging.example.com | 预发布测试 |
| 生产 | example.com | 正式环境 |

---

## 2. 环境变量

### 开发环境 (.env.development)

```bash
# 数据库
DATABASE_URL=postgresql://user:pass@localhost:5432/dev_db

# API
API_URL=http://localhost:3000
NODE_ENV=development

# 认证
JWT_SECRET=dev-secret-key
JWT_EXPIRES_IN=7d
```

### 测试环境 (.env.staging)

```bash
DATABASE_URL=postgresql://user:pass@staging-db:5432/staging_db
API_URL=https://staging.example.com
NODE_ENV=staging
JWT_SECRET=${STAGING_JWT_SECRET}
```

### 生产环境 (.env.production)

```bash
DATABASE_URL=postgresql://user:pass@prod-db:5432/prod_db
API_URL=https://api.example.com
NODE_ENV=production
JWT_SECRET=${PROD_JWT_SECRET}
```

---

## 3. 数据库配置

| 环境 | 主机 | 端口 | 名称 |
|------|------|------|------|
| 开发 | localhost | 5432 | dev_db |
| 测试 | staging-db | 5432 | staging_db |
| 生产 | prod-db | 5432 | prod_db |

---

## 4. 服务配置

### 4.1 API 服务

```yaml
# docker-compose.yml
services:
  api:
    image: api:${VERSION}
    environment:
      - NODE_ENV=${NODE_ENV}
      - DATABASE_URL=${DATABASE_URL}
    ports:
      - "3000:3000"
```

### 4.2 前端服务

```yaml
  web:
    image: web:${VERSION}
    environment:
      - API_URL=${API_URL}
    ports:
      - "80:80"
```

---

## 5. 部署检查清单

- [ ] 环境变量已配置
- [ ] 数据库已迁移
- [ ] SSL 证书有效
- [ ] 监控已就绪
- [ ] 回滚方案已准备
