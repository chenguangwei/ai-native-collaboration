# 📖 故障排查手册

> 供 AI 在报错时自动检索

---

## 1. 常见错误

### 1.1 数据库连接

**错误**: `ECONNREFUSED`

**排查**:
```bash
# 检查数据库服务
pg_isready -h localhost -p 5432

# 检查连接配置
cat .env | grep DATABASE
```

**解决**:
- 启动数据库服务
- 检查连接字符串

---

### 1.2 认证错误

**错误**: `401 Unauthorized`

**排查**:
```bash
# 检查 Token
echo $JWT_SECRET

# 检查过期时间
```

**解决**:
- 刷新 Token
- 重新登录

---

### 1.3 构建错误

**错误**: `Build failed`

**排查**:
```bash
# 检查依赖
npm install

# 检查 TypeScript
npx tsc --noEmit
```

**解决**:
- 重新安装依赖
- 修复类型错误

---

## 2. 性能问题

### 2.1 内存泄漏

**症状**: 服务内存持续增长

**排查**:
```bash
# 查看内存使用
node --inspect server.js
# 使用 Chrome DevTools
```

---

### 2.2 慢查询

**症状**: API 响应慢

**排查**:
```sql
-- 查看慢查询日志
SELECT query, calls, mean_time
FROM pg_stat_statements
ORDER BY mean_time DESC
LIMIT 10;
```

---

## 3. 部署问题

### 3.1 容器启动失败

**排查**:
```bash
# 查看容器日志
docker-compose logs -f

# 检查端口占用
lsof -i :3000
```

---

## 4. 恢复流程

### 4.1 数据库恢复

```bash
# 停止服务
docker-compose stop api

# 恢复数据
docker-compose exec db psql -U user -d db < backup.sql

# 启动服务
docker-compose start api
```

---

## 5. 紧急联系人

| 角色 | 联系方式 |
|------|----------|
| 开发者 | - |
| 运维 | - |
