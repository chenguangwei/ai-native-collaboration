# 🚀 交付工程师操作手册

> AI-Native 时代不再区分"前端工程师"或"Java 工程师"。交付工程师端到端交付特性——AI 处理语言栈技术细节，你负责产品判断和用户价值交付。
>
> 旧角色（frontend / backend / fullstack）统一升级为 **交付工程师**。

---

## 角色流转 (Role Switch)

在会话输入栏中敲击 ，或者直接编辑  认领待办以隐式切换。

---

## 日常开发流程

### 1. 启动工作

```bash
# 1. 查看今日任务
cat memory/active-task.md (宏观进度) / memory/handoff.md (微观交接单)

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

**使用 tdd-workflow:**

```
/tdd-workflow
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
| `/tdd-workflow` | TDD 开发流程 |
| `/verification-before-completion` | 完成前验证 |

### 代码质量

| 命令 | 用途 |
|------|------|
| `/review` | 代码审查 |
| `/simplify` | 代码简化优化 |
| `/codex` | 代码风格检查 |
| `/ai-slop-cleaner` | 清理 AI 生成代码味道（OMC）|

### 测试发布

| 命令 | 用途 |
|------|------|
| `/qa` | 自动化测试 |
| `/ultraqa` | QA 循环直到全部通过（OMC）|
| `/ship` | 发布检查 |

### 调试问题

| 命令 | 用途 |
|------|------|
| `/systematic-debugging` | 结构化调试 |
| `/investigate` | 根因调查 |
| `/learner` | 提取调试经验为可复用知识（OMC）|

---

## 技能触发规则

### 功能开发

```
需求不清楚 → /deep-interview（OMC Socratic 澄清）
         ↓
/brainstorming → /writing-plans → /tdd-workflow → 编写代码
         ↓
/verification-before-completion → /review → /ai-slop-cleaner（可选）
```

### Bug 修复

```
/systematic-debugging → 定位问题 → 编写修复 → /verification-before-completion → /review
复杂 Bug → /learner（提取经验，避免重蹈覆辙）
```

### 发布流程

```
/ship → /ultraqa（循环至通过）→ /verification-before-completion → 合并发布
```

### 复杂多步任务

```
/ralplan（多视角规划）→ /ralph（持续执行，不完成不停止）
```

### 快速原型

```
/autopilot（idea → 规格 → 实现 → QA 全自动）
```

---

## Memory 操作

### 每日开始

```bash
# 查看今日工作
cat memory/active-task.md (宏观进度) / memory/handoff.md (微观交接单)

# 查看团队进度
cat memory/.index/today-overview.md

# 查看是否有待处理任务
cat memory/.index/active-tasks.json
```

### 每日结束

```bash
# 更新今日工作
# 编辑 memory/active-task.md (宏观进度) / memory/handoff.md (微观交接单)

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
- `/deep-interview` - 需求 Socratic 澄清（OMC）
- `/plan-ceo-review` - 产品方向审视
- `/plan-eng-review` - 架构评审
- `/ralplan` - 多视角共识规划（OMC）
- `/design-consultation` - 设计咨询

### 开发阶段
- `/tdd-workflow` - TDD
- `/springboot-tdd` - Spring Boot 测试验证循环
- `/springboot-patterns` - Spring Boot 架构设计模式
- `/java-coding-standards` - Java 编码级强制规范
- `/frontend-patterns` - 前端架构模式及实现
- `/api-design` - API 接口规范与防腐边界设计
- `/e2e-testing` - 端到端测试
- `/verification-before-completion` - 完成验证
- `/systematic-debugging` - 调试排障
- `/learner` - 提取调试经验（OMC）
- `/simplify` - 代码简化
- `/ai-slop-cleaner` - AI 代码味清理（OMC）

### 质量保证
- `/review` - 代码审查
- `/qa` - 自动化测试
- `/ultraqa` - QA 循环至通过（OMC）
- `/ship` - 发布检查

### OMC 高阶工作流
- `/ralph` - 持续执行，不完成不停止
- `/ultrawork` - 并行执行引擎（分层路由）
- `/autopilot` - idea → QA 全自动流水线

### OMC 管理
- `/omc-upgrade` - 安装或升级 oh-my-claudecode

---

*基于 AI 原生开发方法论 v1.1 | OMC v27527267*
