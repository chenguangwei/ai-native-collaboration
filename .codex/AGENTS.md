# AI-Native Scaffold — Codex CLI 指令

> 本文件为 Codex CLI 专属指令。Skills 从 `.agents/skills/` 自动加载。

## 项目技术栈

| 层级 | 技术 |
|------|------|
| 前端 | React / Vue 3 / Next.js 14+ |
| 后端 | Java 17 + Spring Boot 3 / Python 3.11 + FastAPI |
| 测试 | JUnit 5 / pytest / Vitest / Playwright |

## 核心开发原则

1. **TDD 先行** — 先写测试，再写实现；覆盖率 ≥80%
2. **不可变性** — 永远创建新对象，禁止原地修改
3. **原子提交** — 每次提交只做一件事
4. **人类确认** — 严禁未经确认直接 push

## Skill 发现机制

Skills 从 `.agents/skills/` 自动加载。每个 skill 包含：
- `SKILL.md` — 详细指令和工作流（Claude Code 和 Codex 共享）
- `agents/openai.yaml` — Codex 接口元数据

## 可用 Skills

### 开发工作流
| Skill | 触发时机 |
|-------|---------|
| `brainstorming` | 任何创意工作前 |
| `test-driven-development` | 实现功能/修复 bug 前 |
| `systematic-debugging` | 遇到 bug 或测试失败 |
| `verification-before-completion` | 声称工作完成前 |
| `writing-plans` | 多步骤任务规划 |
| `executing-plans` | 执行已有计划 |
| `subagent-driven-development` | 独立任务并行执行 |
| `dispatching-parallel-agents` | 并行启动多 agent |

### 代码质量
| Skill | 触发时机 |
|-------|---------|
| `receiving-code-review` | 收到代码审查反馈 |
| `requesting-code-review` | 提交 PR 前 |
| `finishing-a-development-branch` | 开发分支收尾 |
| `using-git-worktrees` | 需要隔离开发环境 |
| `coding-standards` | TypeScript/JS/React 编码规范 |
| `tdd-workflow` | TDD 具体代码模式与 mock 示例 |

### 后端开发
| Skill | 触发时机 |
|-------|---------|
| `springboot-patterns` | Spring Boot 架构与 API 设计 |
| `java-coding-standards` | Java 17+ 编码规范 |
| `backend-patterns` | Node.js 后端架构模式 |
| `api-design` | REST API 设计规范 |
| `agent-harness-construction` | AI Agent 工具设计与优化 |
| `browser-qa` | 前端部署后自动化 QA |

### 前端开发
| Skill | 触发时机 |
|-------|---------|
| `react-best-practices` | React/Next.js 代码优化 |
| `frontend-design` | 构建前端界面 |
| `baseline-ui` | UI 基础验证 |
| `fixing-accessibility` | 无障碍问题修复 |
| `fixing-metadata` | HTML metadata 修复 |
| `fixing-motion-performance` | 动画性能优化 |

### UI/UX 设计
| Skill | 说明 |
|-------|------|
| `ui-ux-pro-max` | 高级 UX 设计 |
| `adapt` | 响应式适配 |
| `animate` | 微动效添加 |
| `arrange` | 布局优化 |
| `typeset` | 字体排版 |
| `colorize` | 色彩添加 |
| `audit` | UI 质量审计 |
| `harden` | 错误处理增强 |
| `normalize` | 设计系统对齐 |
| `polish` | 发布前质量打磨 |
| `distill` | 简化设计 |
| `bolder` | 视觉增强 |
| `quieter` | 视觉降噪 |
| `overdrive` | 激进设计突破 |
| `optimize` | 性能优化 |
| `extract` | 组件提取 |
| `critique` | UX 效果评估 |
| `delight` | 用户愉悦感 |
| `onboard` | 引导流程 |
| `clarify` | 文案优化 |
| `teach-impeccable` | 设计上下文建立 |

### gstack 浏览器自动化
| Skill | 说明 |
|-------|------|
| `gstack` | 浏览器操作框架 |
| `gstack-browse` | 网页浏览 |
| `gstack-review` | 代码审查 |
| `gstack-ship` | 发布检查 |
| `gstack-qa` | 自动化测试 |
| `gstack-qa-only` | 只报告 QA |
| `gstack-retro` | 迭代复盘 |
| `gstack-cso` | 安全审计 |
| `gstack-canary` | 部署监控 |
| `gstack-investigate` | 问题调查 |
| `gstack-autoplan` | 自动规划 |
| `gstack-land-and-deploy` | 合并部署 |
| `gstack-office-hours` | YC 式答辩 |
| `gstack-plan-*` | 计划审查系列 |
| `gstack-benchmark` | 性能基线 |
| `gstack-document-release` | 发版文档 |

### 工具管理
| Skill | 说明 |
|-------|------|
| `context-handoff` | 上下文交接 |
| `find-skills` | 技能发现 |
| `writing-skills` | 技能编写 |
| `using-superpowers` | 超能力启动 |
| `team-collaboration` | 团队协作 |
| `ai-native-scaffold-init` | 脚手架初始化 |

## Agent 角色分工

| Agent | 职责 | 何时使用 |
|-------|------|---------|
| `explorer` | 只读代码探索 | 理解代码结构前 |
| `reviewer` | 代码审查（正确性/安全） | 提交/PR 前 |
| `docs_researcher` | 文档核实 | 库升级/API 确认 |

## 并行 Agent 原则

对独立任务，始终并行启动：
- ✅ Agent1: 安全分析 + Agent2: 性能检查 + Agent3: 类型检查（并行）
- ❌ 没有依赖时仍然串行

## 代码质量检查清单

提交前确认：
- [ ] 函数 <50 行，嵌套 ≤4 层
- [ ] 文件 <800 行，按特性/领域组织
- [ ] 每层都有错误处理，禁止吞掉错误
- [ ] 系统边界处验证所有输入
- [ ] 使用不可变模式（永远创建新对象）
- [ ] 无硬编码值

## 安全规范（无 Hooks 时）

1. 所有用户输入在系统边界处验证
2. 禁止硬编码 secrets — 使用环境变量
3. 提交前运行 `npm audit` / `pip audit`
4. 推送前检查 `git diff`

## MCP 服务器

默认启用：`github`、`context7`、`sequential-thinking`

按需启用（解注释 `.codex/config.toml`）：`playwright`、`exa`、`memory`
