# 🐞 QA 测试工程师操作手册

> 适用于 QA 测试角色，基于 AI 原生开发方法论

---

## 角色流转 (Role Switch)

在会话输入栏中敲击 ，或者直接编辑  认领待办以隐式切换。

---

## 日常操作流程

### 1. 启动工作

```bash
# 查看今日任务
cat memory/active-task.md (宏观进度) / memory/handoff.md (微观交接单)

# 查看测试用例
cat docs/04_qa/test_cases.md

# 查看团队进度
cat memory/.index/today-overview.md
```

### 2. 执行测试

**使用 QA 技能:**

```
/qa                    # 自动化测试 + 修复
/qa-only               # 仅报告测试结果
```

---

## 常用命令

### 测试执行

| 命令 | 用途 |
|------|------|
| `/qa` | 自动化测试 + 修复 |
| `/qa-only` | 仅报告测试结果 |
| `/browse` | 浏览器自动化 |

### 测试设计

| 命令 | 用途 |
|------|------|
| `/baseline-ui` | UI 质量基线检查 |
| `/fixing-accessibility` | 无障碍测试 |
| `/fixing-metadata` | SEO 测试 |

### 质量审查

| 命令 | 用途 |
|------|------|
| `/design-review` | 设计质量审查 |
| `/audit` | 全面质量审计 |

---

## 测试类型

### 1. 单元测试

```bash
npm run test:unit
# 或
jest
```

### 2. 集成测试

```bash
npm run test:api
# 或
npm run test:integration
```

### 3. E2E 测试

```bash
npm run test:e2e
# 或
npx playwright test
```

---

## Memory 操作

### 每日开始

```bash
cat memory/active-task.md (宏观进度) / memory/handoff.md (微观交接单)
cat docs/04_qa/test_cases.md
```

### 每日结束

```markdown
# 更新 memory/active-task.md (宏观进度) / memory/handoff.md (微观交接单)
- 记录测试用例执行结果
- 记录发现的 bug
- 记录待验证的修复
```

---

## 项目结构

```
tests/
├── unit/                  # 单元测试
├── api_integration/       # 接口测试
└── e2e_browser/          # E2E 测试

docs/04_qa/
├── test_cases.md         # 测试用例
└── audit_logs/           # Bug 报告
```

---

## 测试用例格式

### BDD 格式

```markdown
## 用户登录功能

### 场景: 正常登录

**Given** 用户已注册
**When** 输入正确的用户名和密码
**Then** 登录成功，跳转到首页

### 场景: 密码错误

**Given** 用户已注册
**When** 输入错误的密码
**Then** 显示错误提示
```

---

## Bug 报告格式

```markdown
## Bug 报告

### 基本信息
- ID: BUG-001
- 优先级: 高
- 模块: 用户登录

### 描述
描述问题...

### 复现步骤
1. 打开登录页
2. 输入用户名
3. 输入错误密码
4. 点击登录

### 预期结果
显示密码错误提示

### 实际结果
页面无响应

### 环境
- 浏览器: Chrome 120
- 系统: macOS
```

---

## 与其他角色协作

### 与开发协作

1. 提供测试用例
2. 报告 Bug
3. 验证修复

### 与产品协作

1. 确认验收标准
2. 评审需求文档

### 与设计协作

1. 验收 UI 实现
2. 检查无障碍

---

## 技能触发规则

### 测试执行

```
/qa → 报告问题 → 开发修复 → /qa → 验证
```

### UI 审查

```
/design-review → /baseline-ui → /fixing-accessibility
```

### 发布验证

```
/ship → /qa → 验证通过 → 合并
```

---

## 常用测试命令

```bash
# 运行所有测试
npm test

# 运行单元测试
npm run test:unit

# 运行 E2E 测试
npm run test:e2e

# 生成覆盖率报告
npm run test:coverage
```

---

## 验收标准

| 级别 | 覆盖率要求 | 测试通过率 |
|------|------------|------------|
| 必须 | > 60% | 100% |
| 推荐 | > 80% | 100% |
| 优秀 | > 90% | 100% |

---

*基于 AI 原生开发方法论 v1.1*
