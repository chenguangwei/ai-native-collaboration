# Skills 速查索引

> AI-Native 岗位技能速查手册 — 共 88 个技能

**AI-Native 核心理念**：岗位不再按技术栈划分（不再有"Java 工程师"vs"前端工程师"），而是按**你解决什么问题**来划分。AI 负责处理语言/框架的技术细节，人负责产品判断、系统设计和质量保障。

**技能来源**：
- 🔧 **核心技能** — 项目内置
- 🌐 **gstack** — 浏览器自动化套件（`scripts/sync-agents-skills.sh` 同步）
- 📦 **ECC** — 来自 [everything-claude-code](https://github.com/swirlai/everything-claude-code) 最佳实践
- ⭐ **OMC** — 来自 [oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode)，通过 `/omc-upgrade` 安装/升级

---

## 目录

1. [通用技能](#通用技能) — 所有岗位必备
2. [OMC 高阶技能](#omc-高阶技能) — 超越岗位边界的 AI 增强套件
3. [交付工程师](#交付工程师) — 端到端交付产品特性（含部署上线）
4. [AI 工程师](#ai-工程师) — Agent 编排、LLM 集成、AI 流水线
5. [质量工程师](#质量工程师) — 全栈测试 + 安全 + 可靠性 + 可观测性
6. [产品负责人](#产品负责人) — 需求策略、PRD、用户研究
7. [gstack 浏览器自动化](#gstack-浏览器自动化)

---

## 通用技能

所有岗位适用的核心工作流技能。

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `brainstorming` | `/brainstorming` | 🔧 | **创意工作前必须触发** |
| `systematic-debugging` | `/systematic-debugging` | 🔧 | Bug/错误时系统化排障 |
| `verification-before-completion` | `/verification-before-completion` | 🔧 | 声称完成前强制验证 |
| `writing-plans` | `/writing-plans` | 🔧 | 多步骤任务规划 |
| `executing-plans` | `/executing-plans` | 🔧 | 执行已规划的计划 |
| `context-handoff` | `context-handoff` | 🔧 | 跨会话上下文恢复 |
| `team-collaboration` | `team-collaboration` | 🔧 | 多 AI 并发协调 |
| `find-skills` | `/find-skills` | 🔧 | 查找合适的技能 |
| `using-superpowers` | `/using-superpowers` | 🌐 | 如何使用技能系统 |
| `dispatching-parallel-agents` | `/dispatching-parallel-agents` | 🔧 | 并行启动多个 agent |
| `subagent-driven-development` | `/subagent-driven-development` | 🔧 | 子代理驱动开发 |
| `receiving-code-review` | `/receiving-code-review` | 🔧 | 收到审查反馈时 |
| `requesting-code-review` | `/requesting-code-review` | 🔧 | 提交 PR 前请求审查 |
| `finishing-a-development-branch` | `/finishing-a-development-branch` | 🔧 | 开发分支收尾 |
| `using-git-worktrees` | `/using-git-worktrees` | 🔧 | 隔离开发环境 |
| `writing-skills` | `/writing-skills` | 🔧 | 创建自定义技能 |
| `ai-native-scaffold-init` | `ai-native-scaffold-init` | 🔧 | 新项目初始化 |

---

## OMC 高阶技能

> **oh-my-claudecode** 全局安装，所有项目可用，超越岗位边界。
>
> **安装/升级**：`/omc-upgrade` | **验证**：`ls ~/.claude/skills/ | grep deep-interview`

### 需求与执行

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `deep-interview` | `/deep-interview` | ⭐ OMC | Socratic 需求澄清，歧义 <20% 才开始执行 |
| `ralph` | `/ralph` | ⭐ OMC | PRD 驱动持续执行循环，不完成不停止 |
| `ultrawork` | `/ultrawork` | ⭐ OMC | 并行执行引擎（Haiku/Sonnet/Opus 分层路由）|
| `autopilot` | `/autopilot` | ⭐ OMC | idea → 规格 → 实现 → QA 全自动流水线 |
| `ralplan` | `/ralplan` | ⭐ OMC | Planner→Architect→Critic 多视角共识规划 |

### 代码质量与学习

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `ai-slop-cleaner` | `/ai-slop-cleaner` | ⭐ OMC | 行为安全优先的 AI 代码味清理 |
| `learner` | `/learner` | ⭐ OMC | 从调试会话提取项目级可复用知识 |
| `ultraqa` | `/ultraqa` | ⭐ OMC | QA 循环直到全部测试通过 |

### OMC Agents（`~/.claude/agents/` 已安装，19 个）

| Agent | 用途 |
|-------|------|
| `omc-planner` | 任务规划与分解 |
| `omc-architect` | 架构设计决策 |
| `omc-critic` | 批判性方案挑战 |
| `omc-analyst` | 需求分析 |
| `omc-executor` | 任务执行 |
| `omc-code-reviewer` | 代码审查 |
| `omc-security-reviewer` | 安全审查 |
| `omc-qa-tester` | QA 测试 |
| `omc-debugger` | 调试分析 |
| `omc-verifier` | 完成验证 |

---

## 交付工程师

> **角色定位**：端到端交付产品特性（含部署上线）。不区分前端/后端/语言栈——AI 处理技术细节，你负责产品判断和用户价值交付。配置 `currentRole: "delivery-engineer"`。

### 构建产品

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `test-driven-development` | `/test-driven-development` | 🔧 | TDD 方法论与工作流 |
| `tdd-workflow` | `/tdd-workflow` | 📦 ECC | TDD 具体代码模式（含 mock 示例）|
| `coding-standards` | `/coding-standards` | 📦 ECC | 通用编码规范（TS/JS/Python）|
| `api-design` | `/api-design` | 📦 ECC | REST API 设计规范 |
| `backend-patterns` | `/backend-patterns` | 📦 ECC | 仓库层/缓存/N+1/JWT/RBAC 模式 |
| `react-best-practices` | `/react-best-practices` | 🔧 | 前端性能优化 |
| `frontend-design` | `/frontend-design` | 🔧 | 创建高质量界面 |

### UI 质量

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `ui-ux-pro-max` | `/ui-ux-pro-max` | 🔧 | 专业 UI/UX 设计（50 种风格）|
| `baseline-ui` | `/baseline-ui` | 🔧 | UI 质量基线检查 |
| `fixing-accessibility` | `/fixing-accessibility` | 🔧 | WCAG 无障碍修复 |
| `adapt` | `/adapt` | 🔧 | 响应式多屏适配 |
| `animate` | `/animate` | 🔧 | 添加微动效 |
| `polish` | `/polish` | 🔧 | 发布前最终打磨 |
| `clarify` | `/clarify` | 🔧 | 文案优化 |

### 代码质量

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `gstack-review` | `/review` | 🌐 | PR 级代码审查 |
| `verification-before-completion` | `/verification-before-completion` | 🔧 | 完成前强制验证 |
| `ai-slop-cleaner` | `/ai-slop-cleaner` | ⭐ OMC | 清理 AI 生成代码味道 |
| `deep-interview` | `/deep-interview` | ⭐ OMC | 需求不清时 Socratic 澄清 |

### 发布与运维

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `gstack-ship` | `/ship` | 🌐 | 发布前检查清单 |
| `gstack-land-and-deploy` | `/land-and-deploy` | 🌐 | 合并 + 部署 |
| `gstack-canary` | `/canary` | 🌐 | 金丝雀发布监控 |
| `gstack-setup-deploy` | `/setup-deploy` | 🌐 | 部署环境配置 |
| `gstack-guard` | `/guard` | 🌐 | 全安全防护模式 |
| `gstack-careful` | `/careful` | 🌐 | 安全操作保护 |
| `finishing-a-development-branch` | `/finishing-a-development-branch` | 🔧 | 分支收尾 |
| `systematic-debugging` | `/systematic-debugging` | 🔧 | 生产故障排查 |
| `gstack-investigate` | `/investigate` | 🌐 | 问题根因调查 |
| `gstack-retro` | `/retro` | 🌐 | 故障/迭代复盘 |
| `learner` | `/learner` | ⭐ OMC | 提取运维经验 |
| `ralph` | `/ralph` | ⭐ OMC | 复杂运维任务持续执行 |

---

## AI 工程师

> **角色定位**：设计和构建 AI 系统。包括 Agent 编排、LLM 集成、RAG 流水线、Prompt 工程。这是 AI-Native 时代最具差异化的新角色。

### Agent 系统设计

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `agent-harness-construction` | `agent-harness-construction` | 📦 ECC | Agent 工具设计、观察格式化、错误恢复、context 预算 |
| `dispatching-parallel-agents` | `/dispatching-parallel-agents` | 🔧 | 并行 Agent 编排 |
| `subagent-driven-development` | `/subagent-driven-development` | 🔧 | 子代理驱动开发 |
| `claude-api` | `/claude-api` | 🔧 | Claude API / Anthropic SDK 使用 |
| `ultrawork` | `/ultrawork` | ⭐ OMC | 并行执行引擎（Haiku/Sonnet/Opus 分层）|
| `autopilot` | `/autopilot` | ⭐ OMC | 全自动 idea→QA 流水线 |

### 架构规划

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `writing-plans` | `/writing-plans` | 🔧 | 编写系统实施计划 |
| `executing-plans` | `/executing-plans` | 🔧 | 执行架构变更 |
| `ralplan` | `/ralplan` | ⭐ OMC | Planner→Architect→Critic 多视角共识规划 |
| `deep-interview` | `/deep-interview` | ⭐ OMC | 复杂 AI 需求 Socratic 澄清 |
| `gstack-plan-eng-review` | `/plan-eng-review` | 🌐 | 技术架构评审 |
| `gstack-autoplan` | `/autoplan` | 🌐 | 自动规划与任务分解 |

### 推荐 Agents

| Agent | 用途 |
|-------|------|
| `omc-architect` | 架构设计决策 |
| `omc-critic` | 方案批判与风险识别 |
| `omc-planner` | 实施规划 |
| `analyst`（内置）| 需求分析 |

---

## 质量工程师

> **角色定位**：保障整个产品的可靠性、安全性和可观测性。不限于"写测试用例"——包括安全审计、性能基线、混沌工程。

### 测试执行

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `gstack-qa` | `/qa` | 🌐 | 自动化测试 + 修复 |
| `gstack-qa-only` | `/qa-only` | 🌐 | 只报告测试结果 |
| `ultraqa` | `/ultraqa` | ⭐ OMC | QA 循环直到全部通过 |
| `browser-qa` | `browser-qa` | 📦 ECC | 视觉/交互/无障碍自动化 QA |
| `gstack-browse` | `/browse` | 🌐 | 浏览器自动化 |
| `tdd-workflow` | `/tdd-workflow` | 📦 ECC | TDD 测试代码模式 |

### 安全与合规

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `gstack-cso` | `/cso` | 🌐 | 安全审计 |
| `fixing-accessibility` | `/fixing-accessibility` | 🔧 | WCAG 无障碍修复 |
| `fixing-metadata` | `/fixing-metadata` | 🔧 | SEO 元数据审计 |
| `fixing-motion-performance` | `/fixing-motion-performance` | 🔧 | 动画性能审计 |

### 质量审查

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `gstack-review` | `/review` | 🌐 | 代码质量审查 |
| `gstack-design-review` | `/design-review` | 🌐 | 设计质量审查 |
| `audit` | `/audit` | 🔧 | 全面 UI 质量审计 |
| `gstack-benchmark` | `/benchmark` | 🌐 | 性能基线测量 |
| `learner` | `/learner` | ⭐ OMC | 提取 Bug 模式为可复用知识 |

### 推荐 Agents

| Agent | 用途 |
|-------|------|
| `omc-qa-tester` | QA 测试执行 |
| `omc-verifier` | 验证完成标准 |
| `omc-security-reviewer` | 安全审查 |
| `security-auditor`（内置）| 安全漏洞扫描 |

---

## 产品负责人

> **角色定位**：从用户需求出发，定义"做什么"和"为什么做"。不写代码，但决定产品方向和验收标准。

### 需求分析

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `deep-interview` | `/deep-interview` | ⭐ OMC | 用户需求深度 Socratic 挖掘 |
| `ralplan` | `/ralplan` | ⭐ OMC | 复杂功能多视角共识规划 |
| `gstack-office-hours` | `/office-hours` | 🌐 | YC 式强迫症提问，逼出核心假设 |
| `gstack-plan-ceo-review` | `/plan-ceo-review` | 🌐 | CEO 视角产品方向评审 |

### 规划与设计

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `gstack-plan-design-review` | `/plan-design-review` | 🌐 | 设计可行性评审 |
| `gstack-plan-eng-review` | `/plan-eng-review` | 🌐 | 工程技术方案评审 |
| `gstack-design-consultation` | `/design-consultation` | 🌐 | 设计方向咨询 |
| `autopilot` | `/autopilot` | ⭐ OMC | 快速原型全自动流水线 |

### 文档与复盘

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `gstack-document-release` | `/document-release` | 🌐 | 发布后自动更新文档 |
| `gstack-retro` | `/retro` | 🌐 | 迭代复盘报告 |
| `gstack-autoplan` | `/autoplan` | 🌐 | 自动规划任务 |

### 推荐 Agents

| Agent | 用途 |
|-------|------|
| `analyst`（内置）| 需求分析与结构化 |
| `omc-analyst` | OMC 需求分析 |
| `omc-critic` | 方案批判，挑战产品假设 |

---

## gstack 浏览器自动化

> 所有 gstack 技能通过 `scripts/sync-agents-skills.sh` 同步，永远使用 gstack 进行网页操作。

| 技能 | 触发 | 用途 |
|------|------|------|
| `gstack` | `/gstack` | 浏览器操作基础框架 |
| `gstack-browse` | `/browse` | 网页浏览 |
| `gstack-review` | `/review` | 代码审查 |
| `gstack-ship` | `/ship` | 发布前检查 |
| `gstack-qa` | `/qa` | 自动化 QA 测试 + 修复 |
| `gstack-qa-only` | `/qa-only` | 只报告，不修复 |
| `gstack-retro` | `/retro` | 迭代复盘 |
| `gstack-cso` | `/cso` | 安全审计 |
| `gstack-canary` | `/canary` | 金丝雀部署监控 |
| `gstack-investigate` | `/investigate` | 问题调查 |
| `gstack-autoplan` | `/autoplan` | 自动规划 |
| `gstack-land-and-deploy` | `/land-and-deploy` | 合并 + 部署 |
| `gstack-office-hours` | `/office-hours` | YC 式答辩 |
| `gstack-plan-ceo-review` | `/plan-ceo-review` | CEO 计划审查 |
| `gstack-plan-eng-review` | `/plan-eng-review` | 工程计划审查 |
| `gstack-plan-design-review` | `/plan-design-review` | 设计计划审查 |
| `gstack-design-consultation` | `/design-consultation` | 设计咨询 |
| `gstack-design-review` | `/design-review` | 设计审查 |
| `gstack-benchmark` | `/benchmark` | 性能基线测量 |
| `gstack-document-release` | `/document-release` | 发版文档 |
| `gstack-setup-browser-cookies` | `/setup-browser-cookies` | 浏览器 Cookie 配置 |
| `gstack-setup-deploy` | `/setup-deploy` | 部署环境配置 |
| `gstack-freeze` | `/freeze` | 限制文件编辑 |
| `gstack-unfreeze` | `/unfreeze` | 解除编辑限制 |
| `gstack-guard` | `/guard` | 全安全防护 |
| `gstack-careful` | `/careful` | 安全操作保护 |
| `gstack-upgrade` | `/gstack-upgrade` | gstack 版本升级 |

---

## 技能触发速查

### 通用工作流（任何岗位）

```
需求不清楚  → /deep-interview（Socratic 澄清，歧义 <20%）
开始新功能  → /brainstorming
制定计划    → /writing-plans | /ralplan（复杂架构）
TDD 开发   → /test-driven-development + /tdd-workflow
代码审查    → /review → /receiving-code-review
代码清理    → /ai-slop-cleaner
完成验证    → /verification-before-completion
发布流程    → /ship → /land-and-deploy
```

### 质量保障

```
发现 Bug    → /systematic-debugging
根因调查    → /investigate
QA 测试     → /qa | /qa-only | /ultraqa（循环至通过）
安全审计    → /cso
性能基线    → /benchmark
```

### AI-Native 加速器

```
需求澄清    → /deep-interview
持续执行    → /ralph（不完成不停止）
并行执行    → /ultrawork（分层路由）
全自动      → /autopilot（idea → QA）
架构共识    → /ralplan（三角评审）
经验沉淀    → /learner（提取可复用知识）
升级 OMC   → /omc-upgrade
```

---

*最后更新: 2026-03-27 by Claude Code — 共 88 个技能 | AI-Native 岗位体系 v2.0*
