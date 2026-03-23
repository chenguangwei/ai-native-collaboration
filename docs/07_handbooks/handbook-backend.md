# ⚙️ 后端工程师操作手册

> 适用于后端开发角色，基于 AI 原生开发方法论

---

## 角色配置

### 1. 配置当前角色

编辑 `.claude/project-config.json`:

```json
{
  "currentRole": "backend",
  "gitUser": "your@email.com",
  "team": "backend-team"
}
```

### 2. 验证配置

```bash
cat .claude/project-config.json | grep currentRole
```

---

## 日常开发流程

### 1. 启动工作

```bash
# 查看今日任务
cat memory/roles/backend/today.md

# 查看 API 文档
cat docs/03_architecture/api_specs.md

# 查看数据库结构
cat docs/03_architecture/db_schema.md
```

### 2. 开始新任务

**使用架构技能:**

```
/plan-architect        # 架构评审
/writing-plans         # 编写计划
```

### 3. 开发流程

```
/brainstorming → /writing-plans → /test-driven-development → 开发 → /verification
```

---

## 常用命令

### 代码开发

| 命令 | 用途 |
|------|------|
| `/test-driven-development` | TDD 开发 |
| `/verification-before-completion` | 完成验证 |
| `/executing-plans` | 执行计划 |

### 代码质量

| 命令 | 用途 |
|------|------|
| `/review` | 代码审查 |
| `/simplify` | 代码简化 |
| `/codex` | 代码风格 |

### 测试发布

| 命令 | 用途 |
|------|------|
| `/qa` | 自动化测试 |
| `/ship` | 发布检查 |

### 调试问题

| 命令 | 用途 |
|------|------|
| `/systematic-debugging` | 结构化调试 |
| `/investigate` | 根因调查 |

---

## Memory 操作

### 每日开始

```bash
cat memory/roles/backend/today.md
cat docs/03_architecture/api_specs.md
```

### 每日结束

```markdown
# 更新 memory/roles/backend/today.md
- 记录今日完成
- 记录待办
- 记录问题
```

---

## 项目结构

```
src/backend/
├── controllers/    # 控制器
├── services/       # 业务逻辑
├── models/         # 数据模型
├── middleware/     # 中间件
├── utils/          # 工具函数
└── config/         # 配置

tests/
├── unit/           # 单元测试
└── api_integration/ # 接口测试
```

---

## 常用开发命令

```bash
# 安装依赖
npm install

# 开发服务器
npm run dev

# 构建
npm run build

# 测试
npm run test

# 数据库迁移
npm run migrate
```

---

## API 开发流程

### 1. 定义 API

```markdown
# 在 docs/03_architecture/api_specs.md 中定义
- 端点
- 请求方法
- 请求参数
- 响应格式
```

### 2. 实现接口

```typescript
// 创建控制器
// 创建服务
// 创建模型
// 编写测试
```

### 3. 文档同步

```markdown
# 更新 API 文档
# 确保与前端对齐
```

---

## 与其他角色协作

### 与前端协作

1. 提供 API 文档
2. 确认返回格式
3. 处理接口变更

### 与产品协作

1. 确认需求可行性
2. 提供技术方案
3. 评估工作量

### 与 QA 协作

1. 提供测试数据
2. 确认接口文档
3. 协助调试

---

## 技能触发规则

### 新功能开发

```
/brainstorming → /plan-architect → /writing-plans → /test-driven-development → /verification → /review
```

### Bug 修复

```
/systematic-debugging → 定位 → 修复 → /verification → /review
```

### 发布

```
/ship → /qa → /verification → 合并
```

---

## 安全检查

### 常用命令

```bash
# 依赖安全审计
npm audit

# 敏感信息检查
git secrets scan
```

### 检查项

- [ ] 输入验证
- [ ] SQL 注入防护
- [ ] 认证授权
- [ ] 敏感信息保护
- [ ] 错误处理

---

*基于 AI 原生开发方法论 v1.1*
