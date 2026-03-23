# 🚀 全栈工程师操作手册

> 适用于全栈开发角色，基于 AI 原生开发方法论

---

## 角色配置

### 1. 配置当前角色

编辑 `.claude/project-config.json`:

```json
{
  "currentRole": "fullstack",
  "gitUser": "your@email.com",
  "team": "development"
}
```

### 2. 验证配置

```bash
# 确认角色
cat .claude/project-config.json | grep currentRole

# 确认 git 用户
git config user.email
```

---

## 日常开发流程

### 1. 启动工作

```bash
# 1. 查看今日任务
cat memory/roles/fullstack/today.md

# 2. 查看团队概览
cat memory/.index/today-overview.md

# 3. 检查任务锁
cat memory/lock/conductor-tasks.json
```

### 2. 开始新任务

**使用 brainstorming 技能:**

```
# 唤醒头脑风暴
/brainstorming
```

按流程:
1. 探索项目上下文
2. 确认需求
3. 编写设计文档
4. 制定实施计划

### 3. 实施开发

**使用 test-driven-development:**

```
/test-driven-development
```

流程:
1. 先写测试
2. 运行测试（应该失败）
3. 写实现代码
4. 运行测试（应该通过）
5. 重构

---

## 常用命令

### 代码开发

| 命令 | 用途 |
|------|------|
| `/brainstorming` | 开始新功能前头脑风暴 |
| `/writing-plans` | 编写实施计划 |
| `/test-driven-development` | TDD 开发流程 |
| `/verification-before-completion` | 完成前验证 |

### 代码质量

| 命令 | 用途 |
|------|------|
| `/review` | 代码审查 |
| `/simplify` | 代码简化优化 |
| `/codex` | 代码风格检查 |

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

## 技能触发规则

### 功能开发

```
/brainstorming → /writing-plans → /test-driven-development → 编写代码 → /verification-before-completion → /review
```

### Bug 修复

```
/systematic-debugging → 定位问题 → 编写修复 → /verification-before-completion → /review
```

### 发布流程

```
/ship → /qa → 修复问题 → /verification-before-completion → 合并发布
```

---

## Memory 操作

### 每日开始

```bash
# 查看今日工作
cat memory/roles/fullstack/today.md

# 查看团队进度
cat memory/.index/today-overview.md

# 查看是否有待处理任务
cat memory/.index/active-tasks.json
```

### 每日结束

```bash
# 更新今日工作
# 编辑 memory/roles/fullstack/today.md

# 同步到人员目录
PERSON=$(git config user.email | tr '@' '_')
# 编辑 memory/persons/$PERSON/today.md

# 更新团队概览
# 编辑 memory/.index/today-overview.md

# 更新任务状态
# 编辑 memory/.index/active-tasks.json
```

---

## 项目结构参考

```
src/
├── frontend/          # 前端代码
│   ├── components/
│   ├── pages/
│   └── hooks/
└── backend/          # 后端代码
    ├── controllers/
    ├── services/
    └── models/

tests/
├── unit/            # 单元测试
├── api_integration/ # 接口测试
└── e2e_browser/    # E2E 测试
```

---

## Git 工作流

### 1. 创建功能分支

```bash
git checkout -b feature/xxx
```

### 2. 提交变更

```bash
# 查看变更
git status
git diff

# 提交
git add .
git commit -m "feat: 添加用户登录功能"
```

### 3. 提交前检查

```bash
# 运行测试
npm test

# 代码审查
/review
```

### 4. 合并前

```bash
# Ship 检查
/ship
```

---

## 协作指南

### 与前端协作

```markdown
# 确认 API 格式
1. 查看 docs/03_architecture/api_specs.md
2. 与前端对齐字段
3. 更新文档
```

### 与后端协作

```markdown
# 确认接口可用
1. 调用后端 API
2. 测试边界情况
3. 更新前端对接代码
```

### 与 QA 协作

```markdown
# 提交测试
1. 确保单元测试通过
2. 提供测试数据
3. 更新 test_cases.md
```

---

## 常用技能速查

### 设计阶段
- `/brainstorming` - 头脑风暴
- `/plan-ceo-review` - 产品方向审视
- `/plan-architect` - 架构评审
- `/design-consultation` - 设计咨询

### 开发阶段
- `/test-driven-development` - TDD
- `/verification-before-completion` - 完成验证
- `/systematic-debugging` - 调试
- `/simplify` - 代码简化

### 质量保证
- `/review` - 代码审查
- `/qa` - 自动化测试
- `/ship` - 发布检查

---

*基于 AI 原生开发方法论 v1.1*
