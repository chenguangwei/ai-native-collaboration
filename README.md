# 🧑‍💻 AI Native 脚手架导航

> 基于 AI-原生开发方法论的内部标准脚手架，支持 git subtree 分发到多个项目。

## 项目概览

| 属性 | 值 |
|------|-----|
| 脚手架版本 | v2.0.0 |
| 前端技术栈 | React / Vue 3 / Next.js 14+ |
| 后端技术栈 | Java 17 + Spring Boot 3 / Python 3.11 + FastAPI |
| AI 框架版本 | v2.0 |
| 更新时间 | 2026-03-24 |

## 目录结构

```
.
├── CLAUDE.md              # 🤖 AI 灵魂中枢（AI 行为规范入口）
├── SCAFFOLD_VERSION       # 脚手架版本号
├── CHANGELOG.md           # 版本变更记录
├── CLAUDE.local.md.template  # 本地配置覆盖模板（实际文件不提交）
│
├── .claude/
│   ├── rules/             # 📜 核心准则 (Layer 0，全局加载)
│   ├── commands/          # ⚡ Slash Commands (Layer 0)
│   ├── agents/            # 🎭 专属 Agent (Layer 0，后台运行)
│   └── skills/            # 🛠️ 技能工具箱 (Layer 0，含 gstack + 自定义)
│
├── scripts/               # 🔧 工具脚本（初始化、任务锁）
│   ├── replace-placeholders.sh   # 新项目初始化
│   └── lock.sh                   # 多 AI 并发任务锁
│
├── templates/             # 📋 技术栈结构模板
│   ├── frontend/          # react / vue / next
│   └── backend/           # java / python
│
├── memory/                # 💾 跨会话记忆体 (Layer 1)
│   ├── .index/            # 团队概览 + 任务注册表
│   ├── roles/             # 按角色存储的工作日志
│   ├── persons/           # 按人员存储的工作日志
│   └── lock/              # 任务锁文件
│
├── docs/                  # 📖 知识库 (Layer 2)
│   ├── 00_ai_system/      # AI 系统文档（路由矩阵、subtree 手册）
│   ├── 01_product/        # 产品文档
│   ├── 02_design/         # 设计规范
│   ├── 03_architecture/   # 架构设计
│   ├── 04_qa/             # 测试用例
│   ├── 05_ops/            # 运维手册
│   ├── 06_skills/         # 角色技能配置
│   └── 07_handbooks/      # 各角色操作手册
│
├── src/                   # ⌨️ 代码开发区 (Layer 3)
│   ├── frontend/          # 前端应用（选定技术栈后初始化）
│   ├── backend/           # 后端服务（选定技术栈后初始化）
│   └── shared/            # 前后端共享类型/常量
│
├── tests/                 # 🕵️ 自动化测试 (Layer 3)
│   ├── unit/              # 单元测试
│   ├── api_integration/   # API 集成测试
│   └── e2e_browser/       # 端到端测试
│
└── ops/                   # ☁️ 基础设施 (Layer 3)
    ├── docker-compose.yml
    └── k8s/
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
├── gstack/                   # 浏览器自动化套件
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

```
我需要把 AI Native 脚手架接入当前项目。

脚手架 GitHub 地址：https://github.com/chenguangwei/ai-native-collaboration.git
当前项目是 Java Spring Boot 后端项目，我的角色是 backend，gitUser 是 xxx@email.com

请帮我：
1. 把脚手架以 git subtree 方式引入到 .scaffold/ 目录（remote 名称用 scaffold）
2. 把 CLAUDE.md、.claude/、.agents/、docs/、memory/ 复制到项目根目录
3. 更新 .claude/project-config.json，设置 project、currentRole、gitUser
4. 初始化 memory/roles/backend/today.md 工作日志
5. 告诉我后续如何更新脚手架

注意：不要改动现有 src/ 代码和 pom.xml。
```

CC 会逐步执行并在每个关键操作前说明做什么，你确认后它继续。全程大约 2 分钟。

> **如果脚手架 `main` 分支尚未包含 `.claude/` 和 `.agents/`**（本地有但未推送），可在对话中补充：
> ```
> 注意：脚手架 GitLab 上还没有 .claude/ 和 .agents/，
> 这两个目录在本地路径 /path/to/med-ai-native-project-demo，
> 请从本地复制。
> ```

---

### 方式二（手动）：已有项目接入脚手架（git subtree）

详见 [手动接入操作手册](docs/00_ai_system/scaffold-integration-manual.md)（以 `app_insurance_cloud` Java 项目为实际案例，包含 6 个步骤、结构变化说明和后续更新方式）。

---

### AI 交互命令

```bash
/plan-ceo        # 唤醒产品思维，输出高优 PRD
/plan-architect  # 唤醒架构师思维，进行技术设计
/review          # 代码审查
/qa              # 触发自动化测试
/ship            # 执行发版检查
/debug           # 启动结构化排障
/retro           # 生成复盘报告
/switch-role     # 切换工作角色
```

### 多角色配置

编辑 `.claude/project-config.json` 设置当前角色：

```json
{
  "currentRole": "backend",
  "gitUser": "your@email.com"
}
```

支持角色：`fullstack` | `frontend` | `backend` | `pm` | `qa` | `devops` | `architect`

详见 [角色技能配置说明](docs/06_skills/roles/ROLE_SETUP.md)

---

## Git Sparse Checkout

> 不同岗位只拉取自己关注的目录，不影响 push/merge

```bash
# 全栈工程师
git sparse-checkout set src docs memory

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

# 架构师
git sparse-checkout set docs/03_architecture docs/01_product src memory
```

---

## 文档索引

### AI 系统

| 文档 | 说明 |
|------|------|
| [Skills 速查索引](docs/06_skills/SKILLS_INDEX.md) | 80 个技能按岗位分类，含触发方式与来源 |
| [Commands 命令集](.claude/commands/README.md) | 8 个轻量命令列表与用法 |
| [Agents 说明](.claude/agents/README.md) | Agent 列表与使用方式 |
| [角色技能配置](docs/06_skills/roles/ROLE_SETUP.md) | 各角色工具与工作焦点 |
| [AI 系统文档](docs/00_ai_system/) | 路由矩阵、subtree 接入手册 |

### 产品与研发

| 文档 | 说明 |
|------|------|
| [产品文档](docs/01_product/) | PRD、业务规则 |
| [设计规范](docs/02_design/) | 设计系统、UI 资产 |
| [架构设计](docs/03_architecture/) | API 规范、数据库设计、系统流程 |
| [测试用例](docs/04_qa/) | 测试计划、审计日志 |
| [运维手册](docs/05_ops/) | 部署环境、Runbook |
| [操作手册](docs/07_handbooks/) | 各角色详细操作指南 |

---

*最后更新: 2026-03-24 by Claude Code*
