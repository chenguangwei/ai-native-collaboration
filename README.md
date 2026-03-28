# 🧑‍💻 AI Native 脚手架导航

> 基于 AI-原生开发方法论的内部标准脚手架，支持 git subtree 分发到多个项目。

## 项目概览

| 属性 | 值 |
|------|-----|
| 脚手架版本 | v2.0.0 |
| 更新时间 | 2026-03-27 |

## 目录结构

```
.
├── CLAUDE.md              # 🤖 AI 行为总入口
├── SCAFFOLD_VERSION       # 脚手架版本号
├── CHANGELOG.md           # 版本变更记录
├── CLAUDE.local.md.template  # 本地配置覆盖模板（实际文件不提交）
│
├── .agents/               # 🤖 Agent 技能扩展（gstack / OMC 等）
│   └── skills/
│
├── .claude/               # 🧠 AI 行为层 (Layer 0)
│   ├── rules/             # 📜 核心准则（全局加载）
│   ├── commands/          # ⚡ Slash Commands
│   ├── agents/            # 🎭 专属 Agent（后台运行）
│   ├── skills/            # 🛠️ 技能工具箱（gstack + OMC + 自定义）
│   └── project-config.json # ⚙️ 角色配置（currentRole、gitUser）
│
├── scripts/               # 🔧 脚手架工具脚本
│   ├── replace-placeholders.sh   # 新项目初始化
│   ├── sync-agents-skills.sh     # gstack 升级同步
│   └── sync-omc-skills.sh        # OMC 升级同步
│
├── memory/                # 🧠 跨会话记忆体 (RAM/动态上下文)
│   ├── active-task.md     # 当前进行中的核心大纲与拆解任务树
│   ├── handoff.md         # 跨会话交接信、进度阻碍与状态留存
│   └── project-facts.md   # 本项目隐藏的踩坑经验与反省铁律
│
└── docs/                  # 📖 固化知识库 (ROM/长时记忆)
    ├── 00_AI_NATIVE_SOP.md# 👑 核心操作大纲 (SOP 必读教程)
    ├── 00_ai_system/      # AI 系统与命令设计规范
    ├── 01_product/        # 产品文档（PRD、业务规则）
    ├── 02_design/         # 设计规范（设计系统、UI 资产）
    ├── 03_architecture/   # 架构设计（API、数据库、流程）
    ├── 04_qa/             # 测试用例 + 审计日志
    ├── 05_ops/            # 运维手册（部署、Runbook）
    └── 06_handbooks/      # 各角色操作手册与技能查询索引
```

---

## Commands vs Skills vs Agents

三者都是 AI 的"扩展能力"，但定位不同：

| 特性 | Commands | Skills | Agents |
|------|----------|--------|--------|
| 复杂度 | 简单，一个文件 | 复杂，多文件工作流 | 独立子任务 |
| 结构 | 单个 `.md` 文件 | `SKILL.md` + 关联文件 | `.md` + YAML frontmatter |
| 运行方式 | 主对话内执行 | 主对话内执行 | **后台独立运行** |
| 输出 | 内联输出 | 内联输出 | **只返回最终报告** |
| 适用场景 | 快速触发单一任务 | 需要详细指导的工作流 | 大规模分析、审查 |
| 示例 | `/review` 触发审查 | `/browse` 浏览器自动化 | `security-auditor` 扫描全库 |

### Commands — 轻量快捷

一个 `.md` 文件就是一个命令。输入 `/review` 时，Claude 读取 `.claude/commands/review.md` 并按步骤执行。

```
.claude/commands/
├── plan-ceo.md        # 产品规划
├── plan-architect.md  # 架构设计
├── review.md          # 代码审查
├── qa.md              # 自动化测试
├── ship.md            # 发布检查
├── debug.md           # 结构化排障
├── retro.md           # 迭代复盘
└── switch-role.md     # 角色切换
```

### Skills — 复杂工作流

`SKILL.md` 可以引用旁边的文件，适合多步骤、需要详细规则的工作流：

```markdown
# SKILL.md
@DETAILED_GUIDE.md     # 引用详细规则
@../utils/helper.ts    # 引用工具函数
```

```
.claude/skills/
├── gstack/                   # 虚拟工程团队工具（vendored）
├── omc/                      # oh-my-claudecode 多智能体编排（vendored）
├── context-handoff/          # 跨会话上下文恢复
├── team-collaboration/       # 多 AI 并发协调
└── ai-native-scaffold-init/  # 新项目初始化
```

### Agents — 后台专家

Agent 在后台启动独立子任务，只把最终报告返回到主对话，不刷屏中间过程。适合大规模分析类任务。

```
.claude/agents/
├── frontend-reviewer.md    # 前端代码审查 (TypeScript/React/Vue)
├── java-reviewer.md        # Java 后端审查 (Spring Boot)
├── python-reviewer.md      # Python 后端审查 (FastAPI)
├── security-auditor.md     # OWASP 安全扫描
└── performance-analyzer.md # 全链路性能分析
```

Agent 文件通过 YAML frontmatter 声明可用工具和模型，限制权限：

```yaml
---
name: security-auditor
description: 安全审计员，OWASP 漏洞扫描时调用
tools: [Read, Grep, Glob]
model: sonnet
---
```

---

## 快速开始

### 方式一（推荐）：让 Claude Code 自动完成接入

打开你的项目，启动 Claude Code，把下面这段话发给它，CC 会自动执行所有步骤：

**后端项目接入示例：**
```
我需要把 AI Native 脚手架接入当前项目。

脚手架 GitLab 地址：http://gitlab-iot.yunzhisheng.cn/med-ai/med-ai-native-collaboration.git
当前项目是 Java Spring Boot 后端项目，我的角色是 delivery-engineer，gitUser 是 xxx@email.com

请帮我：
1. 把脚手架以 git subtree 方式引入到 .scaffold/ 目录（remote 名称用 scaffold）
2. 把 CLAUDE.md、.claude/、.agents/、docs/、memory/ 复制到项目根目录
3. 更新 .claude/project-config.json，初始化基本项目环境参数
4. 告诉我后续如何更新脚手架

注意：不要改动现有 src/ 代码和 pom.xml。
```

**全栈项目接入示例：**
```
我需要把 AI Native 脚手架接入当前项目。

脚手架 GitLab 地址：http://gitlab-iot.yunzhisheng.cn/med-ai/med-ai-native-collaboration.git
当前项目是前后端分离的全栈项目：
- 前端：React 18 + TypeScript + Next.js 14（src/frontend/）
- 后端：Python 3.11 + FastAPI（src/backend/）
- 数据库：PostgreSQL + Redis
我的角色是 delivery-engineer，gitUser 是 xxx@email.com

请帮我：
1. 把脚手架以 git subtree 方式引入到 .scaffold/ 目录（remote 名称用 scaffold）
2. 把 CLAUDE.md、.claude/、.agents/、docs/、memory/ 复制到项目根目录
3. 更新 .claude/project-config.json，初始化基本项目环境参数
4. 告诉我后续如何更新脚手架

注意：不要改动现有 src/ 代码、pom.xml、requirements.txt。
```

CC 会逐步执行并在每个关键操作前说明做什么，你确认后它继续。全程大约 2 分钟。

> **如果脚手架 `main` 分支尚未包含 `.claude/` 和 `.agents/`**（本地有但未推送），可在对话中补充：
> ```
> 注意：脚手架 GitLab 上还没有 .claude/ 和 .agents/，
> 这两个目录在本地路径 /path/to/med-ai-native-collaboration，
> 请从本地复制。
> ```

---

### 方式二（手动,不推荐）：已有项目接入脚手架（git subtree）

详见 [手动接入操作手册](docs/00_ai_system/scaffold-integration-manual.md)（以 `app_insurance_cloud` Java 项目为实际案例，包含 6 个步骤、结构变化说明和后续更新方式）。

---

## 脚手架更新

当脚手架发布新版本时，在业务项目中直接运行：

```
/scaffold-upgrade
```

skill 会自动完成完整升级流程：

| 步骤 | 内容 |
|------|------|
| 1 | 检测本地版本（`.scaffold/SCAFFOLD_VERSION`）与远端最新版本 |
| 2 | 询问是否升级（支持"总是自动升级"选项） |
| 3 | `git subtree pull` 拉取最新脚手架代码 |
| 4 | 智能同步文件（覆盖 rules/agents/skills，**保护** project-config.json/memory/src） |
| 5 | 展示 CHANGELOG.md 变更摘要 |

**文件保护规则**：

| 策略 | 路径 |
|------|------|
| 覆盖（脚手架拥有） | `.claude/rules/`、`.claude/agents/`、`.agents/skills/`、`scripts/` |
| 智能检测 | `CLAUDE.md`（如被项目修改过，冲突时提示 diff） |
| 永不覆盖（项目专属） | `.claude/project-config.json`、`memory/` |

> **前提**：项目已通过 git subtree 接入脚手架（存在 `.scaffold/` 目录和 `scaffold` remote）。
> 如未接入，参考[手动接入操作手册](docs/00_ai_system/scaffold-integration-manual.md)。

---

### AI 交互命令

**脚手架内置命令：**
```bash
/plan-ceo          # 唤醒产品思维，输出高优 PRD
/plan-architect    # 唤醒架构师思维，进行技术设计
/review            # 代码审查
/qa                # 触发自动化测试
/ship              # 执行发版检查
/debug             # 启动结构化排障
/retro             # 生成复盘报告
/switch-role       # 切换工作角色
/scaffold-upgrade  # 升级 AI Native 脚手架到最新版本
/omc-upgrade       # 升级 oh-my-claudecode 插件
```

**OMC 内置命令**（[oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode) 已内置，无需单独安装）：
```bash
/deep-interview   # Socratic 需求澄清，歧义 <20% 才执行
/ralph            # PRD 驱动的持续执行，不完成不停止
/ultrawork        # 并行执行引擎（Haiku/Sonnet/Opus 分层路由）
/autopilot        # idea → 规格 → 实现 → QA 全自动流水线
/ai-slop-cleaner  # 行为安全优先的 AI 代码味清理（deslop）
/learner          # 提取项目级调试知识为可复用 skill
/ultraqa          # QA 循环直到全部测试通过
/ralplan          # Planner→Architect→Critic 共识规划
```

**Autoresearch**（[autoresearch](https://github.com/uditgoenka/autoresearch) 自主目标驱动迭代引擎，已内置）：
```bash
/autoresearch          # 通用自主优化循环：修改→验证→保留/丢弃→重复
/autoresearch:plan     # 将自然语言目标转化为可执行配置
/autoresearch:debug    # 科学方法驱动的 Bug 猎杀循环
/autoresearch:fix      # 自动修复错误，直到测试/构建/类型全部通过
/autoresearch:security # STRIDE + OWASP Top 10 自主安全审计
/autoresearch:ship     # 通用交付工作流（代码/内容/部署/营销）
/autoresearch:scenario # 场景驱动用例生成，探索边界与失效模式
/autoresearch:predict  # 多专家视角群体预测（架构/安全/性能）
/autoresearch:learn    # 自主学习代码库，生成/更新文档
```

### 多元角色融合与切换

摒弃死板的 JSON 文件角色锁，系统采用高自由度的动态机甲加载方案：你可以直接通过撰写 `memory/active-task.md` 来让 AI **隐式流转角色**；或者在对话中显式执行 `/switch-role [角色名]` 进行强制状态锚定。

#### AI-Native 体系 🚀（推荐）

> 按「解决什么问题」划分岗位，AI 处理语言栈技术细节

| 角色 | currentRole 值 | 说明 |
|------|---------------|------|
| 产品负责人 | `product-owner` | 需求策略、PRD、用户研究 |
| 交付工程师 | `delivery-engineer` | 端到端交付产品特性（含部署上线，替代前端/后端/全栈/运维）|
| AI 工程师 | `ai-engineer` | Agent 编排、LLM 集成、AI 流水线 |
| 质量工程师 | `quality-engineer` | 全栈测试 + 安全 + 可靠性 + 可观测性 |

详见 👉 [全局操作总纲 SOP](docs/00_AI_NATIVE_SOP.md) (基建协同铁律)

#### 传统体系 👥（过渡期）

> 保留原有岗位名称，映射到 AI-Native 角色值

| 你的岗位 | currentRole 值 | 说明 |
|---------|---------------|------|
| 产品经理 | `product-owner` | 需求策略、PRD |
| 前端工程师 | `delivery-engineer` | UI、交互、前端逻辑 |
| 后端工程师 | `delivery-engineer` | API、服务、数据层 |
| 测试工程师 | `quality-engineer` | 测试、安全、质量保障 |
| 运维工程师 | `delivery-engineer` | 基础设施、部署、监控 |
详见 [传统体系操作大全](docs/06_handbooks/traditional/README.md) | [全局操作总纲 SOP](docs/00_AI_NATIVE_SOP.md)

---

## Git Sparse Checkout

> 不同岗位只拉取自己关注的目录，不影响 push/merge

### AI-Native 体系

```bash
# 交付工程师（前端+后端+运维全覆盖）
git sparse-checkout set src ops docs memory

# AI 工程师
git sparse-checkout set src .claude .agents docs/03_architecture memory

# 质量工程师
git sparse-checkout set tests docs/04_qa docs/03_architecture memory

# 产品负责人
git sparse-checkout set docs/01_product docs/02_design memory
```

### 传统体系

```bash
# 前端工程师
git sparse-checkout set src/frontend src/shared docs/02_design docs/04_qa memory

# 后端工程师
git sparse-checkout set src/backend src/shared docs/03_architecture docs/05_ops memory

# 产品经理
git sparse-checkout set docs/01_product docs/02_design memory

# 测试工程师
git sparse-checkout set tests docs/04_qa docs/03_architecture memory

# 运维工程师
git sparse-checkout set ops docs/05_ops memory
```

---

## 文档索引

### AI 系统

| 文档 | 说明 |
|------|------|
| [全局操作总纲 SOP(必读)](docs/00_AI_NATIVE_SOP.md) | 最核心的协作规范：ROM/RAM 分区及过渡期剧本指引 |
| [Skills 速查索引](docs/06_handbooks/ai-native/SKILLS_INDEX.md) | 88 个强悍技能按 4 大职业分类，含触发方式 |
| [Commands 命令集](.claude/commands/README.md) | 轻量且高频的核心执行命令 |
| [Agents 说明](.claude/agents/README.md) | 后台分析师/测试员/监控卫士列表 |
| [AI 系统文档](docs/00_ai_system/) | 路由矩阵、subtree 接入手册 |
| [Claude Code 使用技巧：从入门到精通](docs/00_ai_system/claude-code-40-best-practices.md) | 从配置到多 Agent，40+ 个提升工作流效率的技巧 |
| [Autoresearch 使用手册](docs/00_ai_system/autoresearch-guide.md) | 自主目标驱动迭代引擎：9 个子命令完整使用指南 |

### 操作手册

| 文档 | 说明 |
|------|------|
| [AI-Native 操作手册](docs/06_handbooks/ai-native/README.md) | 4 个 AI-Native 岗位操作指南 |
| [传统体系操作手册](docs/06_handbooks/traditional/README.md) | 产品/前端/后端/QA/运维完整协作规范 |

### 产品与研发

| 文档 | 说明 |
|------|------|
| [产品文档](docs/01_product/) | PRD、业务规则 |
| [设计规范](docs/02_design/) | 设计系统、UI 资产 |
| [架构设计](docs/03_architecture/) | API 规范、数据库设计、系统流程 |
| [测试用例](docs/04_qa/) | 测试计划、审计日志 |
| [运维手册](docs/05_ops/) | 部署环境、Runbook |

> 引用 [oh-my-claudecode Claude Code 的多智能体编排系统](https://github.com/Yeachan-Heo/oh-my-claudecode)
> 引用 [gstack 将 Claude Code 转化为虚拟工程团队](https://github.com/garrytan/gstack)
> 引用 [autoresearch 自主目标驱动迭代引擎，Karpathy autoresearch 理念的 Claude Code 实现](https://github.com/uditgoenka/autoresearch)
---

*最后更新: 2026-03-28 by Claude Code*

