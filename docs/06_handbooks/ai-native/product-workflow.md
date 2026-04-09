# 🚀 产品全流程工作手册

> 覆盖产品 → 研发 → 测试 → 运维全链路的 AI 原生协作指南

---

## 概览：产品交付流程

```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│   产品阶段    │ → │   研发阶段    │ → │   测试阶段    │ → │   运维阶段    │
│   PM         │    │   Dev        │    │   QA         │    │   DevOps     │
│              │    │              │    │              │    │              │
│ 需求分析      │    │ 架构设计      │    │ 测试计划      │    │ 部署上线      │
│ PRD 输出      │    │ 功能实现      │    │ 执行测试      │    │ 监控运营      │
│ 验收标准      │    │ 代码审查      │    │ 缺陷追踪      │    │ 应急响应      │
└──────────────┘    └──────────────┘    └──────────────┘    └──────────────┘
```

**每个阶段的核心产出物：**

| 阶段 | 输入 | 输出 | 交付给 |
|------|------|------|--------|
| 产品 | 用户反馈/业务目标 | PRD + 验收标准 | 研发、测试 |
| 研发 | PRD + 架构设计 | 可运行代码 + 测试覆盖 | 测试 |
| 测试 | 功能代码 + 验收标准 | 测试报告 + 质量结论 | 运维 |
| 运维 | 通过测试的版本 | 上线服务 + 监控配置 | 全团队 |

---

## 第一阶段：产品（PM）

### 1.1 角色配置

```json
// .claude/project-config.json
{
  "currentRole": "product-owner",
  "gitUser": "pm@company.com",
  "team": "product"
}
```

### 1.2 需求收集与分析

**启动产品思维：**

```
/office-hours
```

执行 5-Why 分析 → 竞品调研 → 用户价值验证 → 输出高优 PRD。

**办公时间审视（YC 视角）：**

```
/office-hours
```

用创业者视角审视需求合理性，避免过度设计。

**AI 辅助分析流程：**

```
1. 描述业务背景和用户痛点
2. 触发 /office-hours → 获取结构化分析
3. 补充竞品数据和用户访谈
4. /plan-ceo-review → CEO 视角审查 PRD 草稿
```

### 1.3 PRD 编写规范

**文件位置：** `docs/01_product/prd_{feature}.md`

**必须包含：**

```markdown
## 功能背景
- 解决什么问题
- 目标用户群体
- 预期业务价值

## 功能描述
- 核心用例（用户故事格式）
- 交互流程图
- 边界条件说明

## 验收标准（AC）
- AC-01: Given ... When ... Then ...
- AC-02: ...

## 技术约束
- 性能要求（P99 响应时间）
- 兼容性要求
- 安全合规要求

## 优先级与排期
- RICE 评分：Reach / Impact / Confidence / Effort
```

> 验收标准（AC）是测试用例的直接来源，必须可量化、可验证。

### 1.4 设计协作

```
/design-consultation    # 与设计师确认交互方案
/plan-design-review     # 设计评审
```

**产出：** `docs/02_design/` 下的设计稿链接和设计规范。

### 1.5 与研发交接

**研发启动会议准备清单：**

- [ ] PRD 已定稿并提交至 `docs/01_product/`
- [ ] 验收标准（AC）已明确
- [ ] 设计稿已确认
- [ ] 技术约束已沟通
- [ ] 优先级已对齐

**通知研发：**

```bash
# 更新任务注册表
# 编辑 memory/.index/active-tasks.json，添加新需求
{
  "id": "feat-xxx",
  "title": "功能名称",
  "status": "ready_for_dev",
  "owner": "",
  "prd": "docs/01_product/prd_xxx.md"
}
```

### 1.6 产品阶段记忆管理

**每日开始：**
```bash
cat memory/active-task.md (宏观进度) / memory/handoff.md (微观交接单)
cat memory/.index/today-overview.md
```

**每日结束，更新 `memory/active-task.md (宏观进度) / memory/handoff.md (微观交接单)`：**
```markdown
## 今日完成
- [x] 完成用户认证功能 PRD 初稿

## 待确认
- [ ] 与安全团队确认加密方案

## 研发/测试阻塞项
- 无
```

---

## 第二阶段：研发（Dev）

### 2.1 角色配置

```json
// 前端工程师
{ "currentRole": "delivery-engineer", "gitUser": "fe@company.com" }

// 后端工程师
{ "currentRole": "delivery-engineer", "gitUser": "be@company.com" }

// 全栈工程师
{ "currentRole": "delivery-engineer", "gitUser": "fs@company.com" }
```

### 2.2 接收需求

**启动前必读：**

```bash
# 读取 PRD
cat docs/01_product/prd_{feature}.md

# 读取架构约束
cat docs/03_architecture/

# 查看 API 规范（如有）
cat docs/03_architecture/api_spec.md
```

### 2.3 架构设计

**技术方案评审：**

```
/plan-eng-review
```

CTO 级推演：方案对比 → 架构设计 → 数据流设计 → 风险评估 → 输出 ADR。

**产出位置：** `docs/03_architecture/adr_{feature}.md`

**架构文档必须包含：**
- 技术选型理由（为什么不选其他方案）
- 数据模型变更
- API 接口定义
- 性能预估

### 2.4 功能开发：TDD 流程

**Step 1：头脑风暴（新功能必须）**

```
brainstorming 技能自动触发
```

**Step 2：编写计划**

```
writing-plans 技能
```

将 PRD 拆分为可执行的开发任务，产出 `docs/03_architecture/plan_{feature}.md`。

**Step 3：TDD 开发循环**

```
tdd-workflow 技能 / tdd-guide Agent
```

```
红灯（写失败测试）
    ↓
绿灯（最简实现）
    ↓
重构（保持测试通过）
    ↓
重复
```

**Step 4：代码审查**

```
# 代码改动后，自动触发
code-reviewer Agent（后台运行）

# 安全敏感逻辑（认证、支付、权限）
security-reviewer Agent（后台运行）
```

**Step 5：完成验证**

```
verification-before-completion 技能
```

声明完成前必须验证，不可跳过。

### 2.5 前端开发专项

**UI 实现流程：**

```
1. 读取设计稿：cat docs/02_design/
2. frontend-design 技能  → 生成高质量界面
3. react-best-practices 技能 → 性能优化检查
4. baseline-ui 技能 → 动画/排版基线验证
5. /qa → 触发 UI 测试
```

**前端常用指令：**

| 场景 | 命令/技能 |
|------|----------|
| 设计实现 | `frontend-design` |
| React 优化 | `react-best-practices` |
| 可访问性检查 | `fixing-accessibility` |
| 动画性能修复 | `fixing-motion-performance` |
| 响应式适配 | `adapt` |
| 视觉质感提升 | `polish` |

### 2.6 后端开发专项

**API 开发流程：**

```
1. 读取 API 规范：cat docs/03_architecture/api_spec.md
2. api-design 技能 → REST 接口设计审查
3. TDD：先写集成测试，再写实现
4. springboot-patterns / backend-patterns → 架构模式合规
5. security-reviewer Agent → 安全扫描
6. analyst Agent → 性能瓶颈检查
```

**后端常用指令：**

| 场景 | 命令/技能 |
|------|----------|
| Spring Boot 架构 | `springboot-patterns` |
| Java 规范 | `java-coding-standards` |
| API 设计审查 | `api-design` |
| 安全扫描 | `security-reviewer` Agent |
| 性能分析 | `analyst` Agent |
| 构建报错修复 | `debugger` Agent |

### 2.7 Git 提交规范

```bash
# 提交格式
feat: 用户登录 API 实现

# 类型: feat / fix / refactor / docs / test / chore
# 每次提交只做一件事（原子性）
# 禁止 push 前未经人类确认
```

**发 PR 前执行：**

```
/review          # 代码审查
requesting-code-review 技能   # 准备 PR 描述
```

### 2.8 研发阶段记忆管理

**每日结束，更新 `memory/roles/{role}/today.md`：**

```markdown
## 今日完成
- [x] 用户登录接口实现（含测试）

## 进行中
- [ ] JWT 刷新逻辑（预计明日完成）

## 阻塞项
- 等待 PM 确认错误码设计

## 涉及文件
- src/backend/auth/login.ts
- tests/unit/auth/login.test.ts
```

---

## 第三阶段：测试（QA）

### 3.1 角色配置

```json
{
  "currentRole": "quality-engineer",
  "gitUser": "qa@company.com",
  "team": "quality"
}
```

### 3.2 测试计划制定

**读取需求和验收标准：**

```bash
cat docs/01_product/prd_{feature}.md   # 读取 AC
cat docs/03_architecture/api_spec.md   # 读取接口约定
cat docs/04_qa/                        # 查看已有测试用例
```

**测试用例输出位置：** `docs/04_qa/test_cases_{feature}.md`

**测试用例格式（基于 AC）：**

```markdown
## TC-001 正常登录

**前置条件：** 用户已注册，账号未锁定
**输入：** 正确的邮箱和密码
**步骤：**
1. POST /api/auth/login
2. 传入 { email, password }
**预期结果：** 返回 200，包含 JWT token
**对应 AC：** AC-01
```

### 3.3 测试执行

**自动化测试触发：**

```
/qa
```

执行单元测试 → 集成测试 → E2E 测试 → 汇总结果。

**专项测试工具：**

| 测试类型 | 命令/技能 |
|---------|----------|
| 全量自动化 | `/qa` |
| 仅报告模式 | `/qa-only` |
| 浏览器 UI 测试 | `browser-qa` 技能 |
| 视觉回归测试 | `browser-qa` 技能 |
| 可访问性审计 | `audit` 技能 |
| 设计稿还原度 | `/design-review` |
| 安全测试 | `security-reviewer` Agent |
| 性能基准 | `/benchmark` |

**浏览器自动化测试（gstack）：**

```
/browse     # 手动浏览验证
/qa         # 触发完整 UI 测试套件
```

### 3.4 缺陷管理

**缺陷记录格式：** `docs/04_qa/bugs/bug_{id}.md`

```markdown
## BUG-001 登录失败无错误提示

**严重级别：** P1 - 主流程阻塞
**环境：** 测试环境 / Chrome 120
**复现步骤：**
1. 输入错误密码
2. 点击登录
**实际结果：** 页面无响应，无错误提示
**预期结果：** 显示"密码错误"提示
**截图：** [附图]
**指派给：** 前端工程师
```

**通知研发修复：**

```bash
# 更新任务注册表
# memory/.index/active-tasks.json 中将对应任务状态改为 "bug_found"
```

### 3.5 回归测试

研发修复后，执行定向回归：

```
1. /qa → 确认修复有效
2. 检查关联功能无回退
3. 更新 docs/04_qa/audit_log.md
```

### 3.6 质量门禁（上线准入）

**测试报告结论，必须全部通过才能交付运维：**

- [ ] 所有 AC 验收通过
- [ ] P0/P1 缺陷清零
- [ ] 自动化覆盖率 ≥ 80%
- [ ] 安全扫描无高危漏洞
- [ ] 性能基准达标（P99 < 阈值）

**输出测试报告：** `docs/04_qa/test_report_{version}.md`

### 3.7 测试阶段记忆管理

**每日结束，更新 `memory/active-task.md (宏观进度) / memory/handoff.md (微观交接单)`：**

```markdown
## 今日测试结论
- [x] 登录功能：PASS（3 个 AC 全部通过）
- [x] 注册功能：FAIL（BUG-001 已提交）

## 待测试
- [ ] 密码重置功能（等研发完成）

## 阻塞项
- BUG-001 未修复，阻塞注册功能上线
```

---

## 第四阶段：运维（DevOps）

### 4.1 角色配置

```json
{
  "currentRole": "delivery-engineer",
  "gitUser": "ops@company.com",
  "team": "platform"
}
```

### 4.2 发布准入检查

**接收测试报告，执行发布前检查：**

```
/ship
```

执行完整发布检查清单：代码状态 → 测试验证 → 构建验证 → 安全扫描 → 最终确认。

**检查项：**

```bash
# 查看测试报告
cat docs/04_qa/test_report_{version}.md

# 确认质量门禁全部通过
# 检查 CHANGELOG 已更新
cat CHANGELOG.md

# 核实版本号
cat SCAFFOLD_VERSION
```

### 4.3 部署流程

**标准部署序列：**

```
1. 构建验证
      ↓
2. 部署到测试环境
      ↓
3. 冒烟测试
      ↓
4. /canary → 金丝雀发布（灰度 5%）
      ↓
5. 监控观察（15 分钟）
      ↓
6. /land-and-deploy → 全量发布
      ↓
7. 验证监控指标
```

**部署命令：**

| 场景 | 命令 |
|------|------|
| 发布前检查 | `/ship` |
| 金丝雀发布 | `/canary` |
| 全量发布 | `/land-and-deploy` |
| 部署后验证 | `/canary`（观察指标） |
| 紧急回滚 | `ops/runbook/rollback.md` |

### 4.4 监控与告警

**部署后必查指标：**

```bash
# 查看运维 Runbook
cat docs/05_ops/runbook.md

# 核查监控配置
cat ops/monitoring/
```

**关键指标：**
- 错误率（Error Rate < 0.1%）
- P99 响应时间（< SLA 阈值）
- 资源使用率（CPU/Memory < 80%）
- 业务指标（登录成功率、下单成功率等）

### 4.5 应急响应

**线上故障响应流程：**

```
1. 告警触发
      ↓
2. /investigate → 根因调查
      ↓
3. /systematic-debugging → 结构化排障
      ↓
4. 评估：修复 or 回滚？
      ↓
5. 执行操作，通知相关方
      ↓
6. /retro → 事后复盘
```

**故障排查工具：**

| 场景 | 命令/技能 |
|------|----------|
| 根因调查 | `/investigate` |
| 结构化排障 | `systematic-debugging` 技能 |
| 性能瓶颈 | `analyst` Agent |
| 安全事件 | `security-reviewer` Agent |
| 复盘报告 | `/retro` |

### 4.6 发布后复盘

**每次发布后执行：**

```
/retro
```

收集数据 → 分析问题 → 提炼经验 → 生成复盘报告。

**复盘报告位置：** `memory/shared/retrospectives/retro_{date}.md`

### 4.7 运维阶段记忆管理

**每次发布后，更新 `memory/active-task.md (宏观进度) / memory/handoff.md (微观交接单)`：**

```markdown
## 今日发布
- [x] v1.2.0 用户认证功能上线（18:30）
  - 金丝雀：15 分钟无异常
  - 全量：19:00 完成

## 监控状态
- 错误率：0.02% ✅
- P99：120ms ✅

## 待处理
- [ ] 优化日志告警阈值（非紧急）
```

---

## 跨阶段协作规范

### 阶段交接检查清单

**产品 → 研发：**
- [ ] PRD 已在 `docs/01_product/` 中定稿
- [ ] 验收标准（AC）已明确且可量化
- [ ] 设计稿已确认并链接至文档
- [ ] `memory/.index/active-tasks.json` 已更新

**研发 → 测试：**
- [ ] 功能分支已合并至 `develop`
- [ ] 单元测试覆盖率 ≥ 80%
- [ ] API 文档已更新（`docs/03_architecture/api_spec.md`）
- [ ] `memory/.index/active-tasks.json` 状态改为 `ready_for_qa`

**测试 → 运维：**
- [ ] 测试报告已输出（`docs/04_qa/test_report_{version}.md`）
- [ ] P0/P1 缺陷清零
- [ ] 质量门禁全部通过
- [ ] `memory/.index/active-tasks.json` 状态改为 `ready_for_deploy`

### 跨岗位任务状态流转

```
需求创建 (pm)
    ↓ ready_for_dev
开发中 (dev)
    ↓ ready_for_qa
测试中 (qa)
    ↓ ready_for_deploy
部署中 (devops)
    ↓ done
已上线
```

**任务状态文件：** `memory/.index/active-tasks.json`

### 团队概览同步

每日站会前，查看团队整体进度：

```bash
cat memory/.index/today-overview.md
```

**PM 负责维护 `today-overview.md`，每日更新各阶段状态：**

```markdown
## 2026-03-26 团队进度

### 用户认证功能 (feat-auth)
- 产品：✅ PRD 已定稿
- 前端：🔄 登录页面开发中（80%）
- 后端：✅ 登录 API 完成
- 测试：⏳ 等待前端完成
- 运维：⏳ 等待测试通过

### 跨角色依赖
- 前端登录页面 → 依赖 后端登录 API ✅
- 测试执行 → 依赖 前端开发完成
```

---

## 并行工作模式

当多个功能同时开发时，使用 Git Worktree 隔离：

```
using-git-worktrees 技能
```

```bash
# 不同功能在独立 worktree 中并行开发
git worktree add ../feat-auth feature/user-auth
git worktree add ../feat-payment feature/payment

# 互不干扰，独立测试，独立合并
```

**适用场景：**
- PM 同时推进多个需求
- 前后端功能并行开发
- 修复 bug 同时开发新功能

---

## 快速参考

### 各阶段核心命令

| 阶段 | 核心命令 | 用途 |
|------|---------|------|
| 产品 | `/plan-ceo-review` | CEO 视角审查 |
| 产品 | `/office-hours` | YC 视角审视 |
| 研发 | `/plan-eng-review` | 工程方案 / 架构设计审查 |
| 研发 | `/review` | 代码审查 |
| 研发 | `/debug` | 结构化排障 |
| 测试 | `/qa` | 自动化测试 |
| 测试 | `/design-review` | 设计还原度检查 |
| 运维 | `/ship` | 发布前检查 |
| 运维 | `/canary` | 金丝雀发布 |
| 运维 | `/retro` | 发布复盘 |
| 全员 | `/switch-role` | 切换工作角色 |

### 各阶段关键产出物

| 阶段 | 文件位置 | 产出物 |
|------|---------|--------|
| 产品 | `docs/01_product/prd_{feature}.md` | PRD + AC |
| 产品 | `docs/02_design/` | 设计稿 + 规范 |
| 研发 | `docs/03_architecture/adr_{feature}.md` | 架构决策记录 |
| 研发 | `src/` + `tests/` | 代码 + 测试 |
| 测试 | `docs/04_qa/test_cases_{feature}.md` | 测试用例 |
| 测试 | `docs/04_qa/test_report_{version}.md` | 测试报告 |
| 运维 | `docs/05_ops/runbook.md` | 运维 Runbook |
| 全员 | `memory/.index/active-tasks.json` | 任务状态 |

### Agent 使用场景速查

| 场景 | Agent | 谁用 |
|------|-------|------|
| 复杂功能拆分 | `planner` | 研发/PM |
| TDD 指导 | `tdd-guide` | 研发 |
| 构建报错 | `debugger` | 研发 |
| 代码审查 | `code-reviewer` | 研发/QA |
| 安全漏洞扫描 | `security-reviewer` | 研发/QA/运维 |
| 性能瓶颈分析 | `analyst` | 研发/运维 |

---

## 相关文档

| 文档 | 说明 |
|------|------|
| [handbook-pm.md](handbook-pm.md) | 产品经理详细操作手册 |
| [handbook-frontend.md](handbook-frontend.md) | 前端工程师详细操作手册 |
| [handbook-backend.md](handbook-backend.md) | 后端工程师详细操作手册 |
| [handbook-qa.md](handbook-qa.md) | 测试工程师详细操作手册 |
| [handbook-devops.md](handbook-devops.md) | 运维工程师详细操作手册 |
| [SKILLS_INDEX.md](../00_ai_system/roles/SKILLS_INDEX.md) | 80 个技能完整索引 |
| [Claude Code 使用技巧](../00_ai_system/claude-code-40-best-practices.md) | 从入门到精通 40+ 技巧 |

---

*基于 AI 原生开发方法论 v1.1 | 最后更新：2026-03-26*
