# Skills 速查索引

> AI-Native 岗位技能速查手册 — 共 126 个技能

**AI-Native 核心理念**：岗位不再按技术栈划分（不再有"Java 工程师"vs"前端工程师"），而是按**你解决什么问题**来划分。AI 负责处理语言/框架的技术细节，人负责产品判断、系统设计和质量保障。

**技能来源**：
- 🔧 **核心技能** — 项目内置
- 🌐 **gstack** — 浏览器自动化套件（`scripts/sync-agents-skills.sh` 同步）
- 📦 **ECC** — 来自 [everything-claude-code](https://github.com/swirlai/everything-claude-code) 最佳实践
- ⭐ **OMC** — 来自 [oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode)，通过 `/omc-upgrade` 安装/升级
- 🤖 **Codex** — OpenAI Codex CLI 集成，项目内置（需全局安装 `npm install -g @openai/codex`）

---

## 目录

1. [通用技能](#通用技能) — 所有岗位必备
2. [OMC 高阶技能](#omc-高阶技能) — 超越岗位边界的 AI 增强套件
3. [Codex 代码审查与修复](#codex-代码审查与修复) — OpenAI Codex CLI 集成
4. [交付工程师](#交付工程师) — 端到端交付产品特性（含部署上线）
5. [AI 工程师](#ai-工程师) — Agent 编排、LLM 集成、AI 流水线
6. [质量工程师](#质量工程师) — 全栈测试 + 安全 + 可靠性 + 可观测性
7. [产品负责人](#产品负责人) — 需求策略、PRD、用户研究
8. [gstack 浏览器自动化](#gstack-浏览器自动化)

---

## 通用技能

所有岗位适用的核心工作流技能。

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `graphify` | `/graphify` | 🔧 | **代码/文档 → 知识图谱**，揭示隐藏依赖与社区结构 |
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

> **oh-my-claudecode** 以 vendored 方式内置在仓库中（当前 `4.11.2`），跨岗位通用。
>
> **安装/升级**：`/omc-upgrade` | **验证**：`find .agents/skills -maxdepth 1 -type d | grep -E "deep-interview|ralph|verify|wiki"`

### 核心执行与编排

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `deep-interview` | `/deep-interview` | ⭐ OMC | Socratic 需求澄清，歧义门控后执行 |
| `plan` | `/plan` | ⭐ OMC | 战略规划（可选访谈） |
| `ralplan` | `/ralplan` | ⭐ OMC | 共识规划入口，先澄清再执行 |
| `team` | `/team` | ⭐ OMC | Claude 原生 Team 多智能体编排 |
| `omc-teams` | `/omc-teams` | ⭐ OMC | tmux CLI worker（claude/codex/gemini） |
| `autopilot` | `/autopilot` | ⭐ OMC | idea → 可运行代码的全自动执行 |
| `ralph` | `/ralph` | ⭐ OMC | 持续执行直到任务完成 |
| `ultrawork` | `/ultrawork` | ⭐ OMC | 高吞吐并行执行引擎 |
| `ccg` | `/ccg` | ⭐ OMC | Claude + Codex + Gemini 三模型协作 |

### 调试与验证

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `debug` | `/debug` | ⭐ OMC | 诊断当前 OMC 会话/仓库状态 |
| `trace` | `/trace` | ⭐ OMC | 证据驱动链路追踪 |
| `verify` | `/verify` | ⭐ OMC | 声称完成前做变更有效性验证 |
| `ultraqa` | `/ultraqa` | ⭐ OMC | 测试-修复-复测循环直到通过 |
| `visual-verdict` | `/visual-verdict` | ⭐ OMC | 截图对比的结构化视觉判定 |

### 技能沉淀与知识管理

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `ai-slop-cleaner` | `/ai-slop-cleaner` | ⭐ OMC | 回归安全优先的 AI 代码味清理 |
| `learner` | `/learner` | ⭐ OMC | 从会话提取可复用技能 |
| `remember` | `/remember` | ⭐ OMC | 维护项目级可复用记忆 |
| `skill` | `/skill` | ⭐ OMC | 本地 skills 的 list/add/remove/edit/search |
| `skillify` | `/skillify` | ⭐ OMC | 将一次性流程固化为新技能草稿 |
| `wiki` | `/wiki` | ⭐ OMC | 持久化 markdown 知识库沉淀 |

### 平台与集成

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `ask` | `/ask` | ⭐ OMC | Provider Advisor（Claude/Codex/Gemini）|
| `external-context` | `/external-context` | ⭐ OMC | 并行外部文档/网页调研 |
| `deep-dive` | `/deep-dive` | ⭐ OMC | trace + deep-interview 二阶段深潜 |
| `deepinit` | `/deepinit` | ⭐ OMC | 代码库 AGENTS 分层初始化 |
| `setup` | `/setup` | ⭐ OMC | 安装/诊断/MCP 路由入口 |
| `omc-setup` | `/omc-setup` | ⭐ OMC | OMC 安装或刷新配置 |
| `omc-doctor` | `/omc-doctor` | ⭐ OMC | OMC 安装与冲突诊断 |
| `mcp-setup` | `/mcp-setup` | ⭐ OMC | 常用 MCP 服务配置 |
| `configure-notifications` | `/configure-notifications` | ⭐ OMC | Telegram/Discord/Slack 通知配置 |
| `hud` | `/hud` | ⭐ OMC | HUD 显示元素与布局配置 |
| `cancel` | `/cancel` | ⭐ OMC | 终止当前 OMC 模式运行 |

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

## Codex 代码审查与修复

> **定位**：OpenAI Codex CLI 深度集成，提供独立于 Claude 的第二视角代码审查、问题诊断与自主修复能力。所有 Codex 命令跨岗位通用。
>
> **前置条件**：`npm install -g @openai/codex` + `codex login`（首次使用运行 `/codex:setup` 检查）

### 初始化

| 命令 | 触发 | 用途 |
|------|------|------|
| — | `/codex:setup` | 检查 Codex CLI 安装状态，引导登录；可选开启 stop-time review gate |

### 代码审查

| 命令 | 触发 | 用途 |
|------|------|------|
| — | `/codex:review` | 基于当前 git diff 进行代码审查（前台或后台执行）|
| — | `/codex:adversarial-review` | **挑战式审查**：质疑设计决策、接口假设和架构取舍，不只找实现缺陷 |

审查参数：

```
/codex:review --wait                      # 前台等待结果
/codex:review --background                # 后台运行，用 /codex:status 查进度
/codex:review --base main                 # 与 main 分支对比
/codex:adversarial-review 关注 auth 模块   # 聚焦特定模块的对抗审查
```

### 任务委托（Rescue）

将复杂调试、根因分析或实现任务完全交给 Codex 执行：

| 命令 | 触发 | 用途 |
|------|------|------|
| — | `/codex:rescue <任务描述>` | 把任务转发给 `codex-rescue` subagent 执行，返回结果原文 |

任务参数：

```
/codex:rescue 找出内存泄漏根因并修复
/codex:rescue --background 重构 auth 模块   # 后台运行
/codex:rescue --resume 继续上次任务          # 续接上一次 Codex 线程
/codex:rescue --effort high 优化数据库查询  # 指定推理力度
/codex:rescue --model spark 快速原型        # 使用 spark 轻量模型
```

### 任务管理

| 命令 | 触发 | 用途 |
|------|------|------|
| — | `/codex:status` | 查看当前会话所有 Codex 任务状态（表格视图）|
| — | `/codex:status <job-id>` | 查看指定任务详情 |
| — | `/codex:result <job-id>` | 获取已完成任务的完整输出 |
| — | `/codex:cancel <job-id>` | 取消正在运行的后台任务 |

### 内部 Skills（不可直接调用，供 Agent 使用）

| Skill | 文件位置 | 用途 |
|-------|----------|------|
| `codex-cli-runtime` | `.agents/skills/codex-cli-runtime/` | Codex companion 脚本调用契约 |
| `codex-result-handling` | `.agents/skills/codex-result-handling/` | 审查结果展示规则（禁止自动修复）|
| `gpt-5-4-prompting` | `.agents/skills/gpt-5-4-prompting/` | GPT-5.4 提示词组装指南（含 recipes、anti-patterns）|

### Agent

| Agent | 文件位置 | 用途 |
|-------|----------|------|
| `codex-rescue` | `.claude/agents/codex-rescue.md` | 薄封装转发层，把任务原文转发给 Codex，不做额外处理 |

### 典型工作流

```
PR 合并前    → /codex:review --background（后台审查，不阻塞开发）
架构评审     → /codex:adversarial-review --base main（质疑整体设计）
卡住了       → /codex:rescue 描述问题（第二视角诊断）
后台任务跟进 → /codex:status → /codex:result <id>
```

---

## 交付工程师

> **角色定位**：端到端交付产品特性（含部署上线）。不区分前端/后端/语言栈——AI 处理技术细节，你负责产品判断和用户价值交付。配置 `currentRole: "delivery-engineer"`。

### 构建产品

| 技能 | 触发 | 来源 | 用途 |
|------|------|------|------|
| `tdd-workflow` | `/tdd-workflow` | 📦 ECC | TDD 方法论与工作流模式 |
| `springboot-tdd` | `/springboot-tdd` | 📦 ECC | Spring Boot 单元/集成测试 TDD |
| `coding-standards` | `/coding-standards` | 📦 ECC | 通用编码规范（TS/JS/Python）|
| `java-coding-standards` | `/java-coding-standards` | 📦 ECC | Java 17+ 编码规范 |
| `api-design` | `/api-design` | 📦 ECC | REST API 设计规范 |
| `backend-patterns` | `/backend-patterns` | 📦 ECC | 仓库层/缓存/N+1/JWT/RBAC 模式 |
| `springboot-patterns` | `/springboot-patterns` | 📦 ECC | Spring Boot 架构模式 |
| `react-best-practices` | `/react-best-practices` | 🔧 | 前端性能优化 |
| `frontend-patterns` | `/frontend-patterns` | 📦 ECC | React/Next.js 前端架构最佳实践 |
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
| `e2e-testing` | `/e2e-testing` | 📦 ECC | Playwright E2E 测试模式与配置 |
| `springboot-verification` | `/springboot-verification` | 📦 ECC | Spring Boot 项目级验证流程 |

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
| `security-reviewer`（内置）| 安全漏洞扫描 |

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
TDD 开发   → /tdd-workflow
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

*最后更新: 2026-04-08 by Claude Code — 共 126 个技能 | AI-Native 岗位体系 v2.0 + Codex 集成 + Graphify 知识图谱*
