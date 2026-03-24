# 🎭 Agents 智能助手

> 让 Claude 在"后台"干活，保持主对话干净

## 什么是 Agent？

有些任务太复杂了，你想让 Claude 请个专家来帮忙。

举个例子：你让 Claude "帮我全面审查这 500 行代码"。

- **不用 Agent**：Claude 在主对话里干这件事，它会把每个文件的检查过程、发现的每个小问题、每一步分析都显示出来。你的聊天记录会被刷屏，塞满几百条中间信息，根本没法看。

- **用 Agent**：Claude 在"后台"启动一个 Agent。Agent 会默默检查完所有代码，然后只把最终结果（比如"发现 3 个安全问题、5 个性能问题"）告诉你。你的聊天记录保持干净，只看到有用的结论。

## Agent vs Commands vs Skills

| 特性 | Agents | Commands | Skills |
|------|--------|----------|--------|
| 执行方式 | 后台运行 | 主对话 | 主对话 |
| 输出 | 简洁报告 | 详细过程 | 详细过程 |
| 复杂度 | 高 | 低 | 高 |
| 适用场景 | 全面审查、大规模分析 | 简单快速任务 | 复杂工作流 |

### Commands - 轻量快捷

**Commands 就是一个文件**，里面写了要干什么。适合简单任务。

```
commands/
├── review.md    # 触发代码审查
└── debug.md    # 触发调试模式
```

### Skills - 复杂工作流

**Skills 可以带一堆相关文件**，SKILL.md 可以引用 DETAILED_GUIDE.md 等关联文件。适合需要详细指导的工作流。

### Agents - 后台专家

**Agents 是让 Claude 启动一个"小助手"在后台干活**，只把结果告诉你。适合大规模分析、审查等会产生大量中间过程的任务。

## Agent 文件结构

```yaml
---
name: code-reviewer
description: 审查代码质量、风格和最佳实践
tools: [Read, Grep, Glob]
model: sonnet
---

# 角色设定

你是一个代码审查专家...
```

### 字段说明

| 字段 | 说明 | 示例 |
|------|------|------|
| `name` | Agent 名称 | `code-reviewer` |
| `description` | Agent 描述，会显示在技能列表中 | `审查代码质量...` |
| `tools` | 允许使用的工具数组 | `[Read, Grep, Glob]` |
| `model` | 使用的模型 | `sonnet` / `opus` / `haiku` |

### tools 字段

限制 Agent 能用哪些工具。根据任务需求最小化权限：

```yaml
# 代码审查只需要读
tools: [Read, Grep, Glob]

# 性能分析可能需要运行命令
tools: [Read, Grep, Glob, Bash]

# 安全审计可能需要写权限
tools: [Read, Grep, Glob, Edit, Write]
```

### model 字段

决定用哪个 AI 模型，省钱又高效：

| 模型 | 特点 | 适用场景 |
|------|------|----------|
| `haiku` | 便宜、快 | 简单任务 |
| `sonnet` | 平衡 | 大多数任务 |
| `opus` | 贵、聪明 | 复杂推理 |

```yaml
# 简单审查用 Haiku
model: haiku

# 复杂分析用 Sonnet
model: sonnet

# 深度推理用 Opus
model: opus
```

## 现有 Agents

### 代码审查 (按语言)

| Agent | 描述 | 工具 | 模型 |
|-------|------|------|------|
| `frontend-reviewer` | 前端审查员 - TypeScript/React | Read, Grep, Glob, Bash | sonnet |
| `java-reviewer` | Java 审查员 - SpringBoot/Java | Read, Grep, Glob, Bash | sonnet |
| `python-reviewer` | Python 审查员 - FastAPI/Django | Read, Grep, Glob, Bash | sonnet |

### 专项审查

| Agent | 描述 | 工具 | 模型 |
|-------|------|------|------|
| `security-auditor` | 安全审计员 - OWASP 漏洞扫描 | Read, Grep, Glob | sonnet |
| `performance-analyzer` | 性能分析师 - 全链路性能瓶颈分析 | Read, Grep, Glob, Bash | sonnet |

## 使用方式

### 手动激活

```
角色: pr-reviewer
审查内容: [粘贴代码或文件列表]
```

### 自动触发

在 `/review` 命令中自动调用 pr-reviewer。

#### 触发机制

```
用户输入 /review
    ↓
.claude/commands/review.md (定义执行清单)
    ↓
.claude/skills/requesting-code-review/SKILL.md
    ↓
使用 Agent tool 启动 subagent (后台运行)
    ↓
pr-reviewer / code-reviewer 干完活
    ↓
输出简洁报告 (不刷屏)
```

#### 如何连接 Commands、Skills 和 Agents

1. **Commands** 定义"做什么"（清单）
2. **Skills** 定义"怎么做"（工作流），可以 dispatch subagent
3. **Agents** 是实际在后台干活的"小助手"

```
commands/review.md:
  # 告诉 Claude 要做哪些审查步骤

skills/requesting-code-review/SKILL.md:
  # 告诉 Claude 如何调度 agent
  # "Dispatch superpowers:code-reviewer subagent"

agents/pr-reviewer.md:
  # agent 实际在后台审查代码
  # 只输出最终报告
```

## 全局 vs 项目级 Agents

### 项目级 Agents

放在当前项目的 `.claude/agents/` 目录，只在当前项目可用：

```
.claude/agents/
├── pr-reviewer.md
├── security-auditor.md
└── performance-analyzer.md
```

### 全局 Agents

放在 `~/.claude/agents/` 目录，在所有项目里可用：

```
~/.claude/agents/
├── code-reviewer.md
├── security-auditor.md
└── ...
```

## 创建新 Agent

1. 在 `.claude/agents/` 创建 `.md` 文件
2. 添加 YAML frontmatter（name, description, tools, model）
3. 编写 Agent 角色和任务说明

```yaml
---
name: my-agent
description: 我的自定义 Agent
tools: [Read, Grep]
model: sonnet
---

# 角色设定

你是一个...
```
