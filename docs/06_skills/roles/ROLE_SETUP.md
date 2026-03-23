# 角色配置指南

## 配置角色

### 方式一：配置文件（推荐）

在 `.claude/settings.json` 中添加：

```json
{
  "role": "backend",
  "git-user": "alice@company.com",
  "team": "api-feature"
}
```

### 方式二：环境变量

```bash
export CLAUDE_ROLE=backend
export CLAUDE_GIT_USER=alice@company.com
export CLAUDE_TEAM=api-feature
```

### 方式三：启动参数

```bash
claude --role=backend --git-user=alice@company.com
```

---

## 各角色配置

### 后端工程师

```json
{
  "role": "backend",
  "git-user": "your@email.com",
  "team": "backend-team"
}
```

**关注目录：**
- `src/backend/` - 后端代码
- `docs/03_architecture/` - 架构文档
- `memory/roles/backend/` - 后端工作日志

---

### 前端工程师

```json
{
  "role": "frontend",
  "git-user": "your@email.com",
  "team": "frontend-team"
}
```

**关注目录：**
- `src/frontend/` - 前端代码
- `docs/02_design/` - 设计文档
- `memory/roles/frontend/` - 前端工作日志

---

### 产品经理

```json
{
  "role": "pm",
  "git-user": "your@email.com",
  "team": "product-team"
}
```

**关注目录：**
- `docs/01_product/` - 产品文档
- `memory/roles/pm/` - 产品工作日志

---

### QA 测试

```json
{
  "role": "qa",
  "git-user": "your@email.com",
  "team": "qa-team"
}
```

**关注目录：**
- `tests/` - 测试代码
- `docs/04_qa/` - QA 文档
- `memory/roles/qa/` - QA 工作日志

---

### 运维工程师

```json
{
  "role": "devops",
  "git-user": "your@email.com",
  "team": "ops-team"
}
```

**关注目录：**
- `ops/` - 运维脚本
- `docs/05_ops/` - 运维文档
- `memory/roles/devops/` - 运维工作日志

---

### 架构师

```json
{
  "role": "architect",
  "git-user": "your@email.com",
  "team": "architecture-team"
}
```

**关注目录：**
- `docs/03_architecture/` - 架构文档
- `memory/roles/architect/` - 架构工作日志

---

## 验证配置

```bash
# 检查当前配置
cat .claude/settings.json | jq '.role, .git-user, .team'

# 验证角色索引
cat memory/.index/roles/backend.json

# 查看团队概览
cat memory/.index/today-overview.md
```

## 切换角色

如果需要在不同角色间切换：

1. 修改 `.claude/settings.json` 中的 `role` 字段
2. 重启 Claude Code 会话
3. AI 将自动读取新角色的 memory

## Git 用户目录映射

| Git Email | Memory 目录 |
|-----------|------------|
| alice@company.com | `memory/persons/alice_company.com/` |
| bob@github.com | `memory/persons/bob_github.com/` |

> 注：@ 符号被替换为下划线
