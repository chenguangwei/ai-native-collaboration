# Claude Code 使用技巧：从入门到精通

> 综合 40+ 实战技巧，按学习曲线分级编排。
> 建议第一次阅读时顺序过一遍；之后当作工具手册按需查阅。

## 快速速查表

| macOS | Windows |
|-------|---------|
| ![Claude Code 速查表 Mac](images/Claude%20code速查表-mac-26.3.jpg) | ![Claude Code 速查表 Win](images/Claude%20code速查表-win-26.3.jpg) |

---

## 目录

- [第一章 入门上手](#第一章-入门上手)
- [第二章 日常提效](#第二章-日常提效)
- [第三章 上下文与 Prompt](#第三章-上下文与-prompt)
- [第四章 CLAUDE.md 与规则系统](#第四章-claudemd-与规则系统)
- [第五章 工具、MCP 与自动化](#第五章-工具mcp-与自动化)
- [第六章 进阶：Agent 与并行](#第六章-进阶agent-与并行)
- [第七章 专家心法](#第七章-专家心法)

---

## 第一章 入门上手

> 目标：第一天就能顺畅使用，不踩低级坑。

### 1.1 设置别名，省去每次确认

每次启动都要审批权限很烦。把常用启动方式存成别名：

```bash
# ~/.zshrc 或 ~/.bashrc
alias c='claude'
alias cc='claude --dangerously-skip-permissions'  # 跳过所有确认，完全信任自己
alias ch='claude --chrome'                         # 带浏览器模式启动
```

执行 `source ~/.zshrc` 生效。`cc` 适合熟悉环境后日常用，第一周建议先用 `c`，养成审批习惯。

### 1.2 必会的基础命令

一开始不需要记全部命令，这几个够用：

| 命令 | 作用 |
|------|------|
| `/clear` | 清空对话，开始新话题 |
| `/compact` | 压缩上下文，释放 token 空间 |
| `/model` | 切换模型 |
| `/usage` | 查看 API 用量和速率限制 |
| `/help` | 查看所有可用命令 |
| `Esc` | 立即中止当前操作 |
| `Esc + Esc` | 撤销，恢复到操作前的状态 |

### 1.3 启用状态栏，随时掌握 token 消耗

Claude Code 支持在终端底部显示实时状态：

```
/statusline
```

它会生成一段 shell 脚本，显示：当前目录、git 分支、token 用量、对话轮数。一眼知道上下文还剩多少，避免在快撑满时才发现。有 10 种颜色主题可选。

### 1.4 让 Claude 管理你的 Git

不用再手动 `git add / commit / push`。直接告诉 Claude：

```
提交这些改动，commit message 用中文，格式是 feat: xxx
```

或者让它完整接管：

```
创建一个 draft PR，标题描述这次改动，等我确认后再标记为 ready
```

draft PR 是低风险的好习惯——改动可见但不会触发 review 请求，你确认没问题再推进。

在 `settings.json` 里可以自定义提交署名：

```json
{
  "gitAttribution": {
    "coAuthoredBy": true
  }
}
```

### 1.5 掌握 Markdown，输出更清晰

Claude 的输出是 Markdown 渲染的。你的输入也用 Markdown 会更清晰：

```markdown
帮我做以下三件事：
1. 重构 `src/auth/login.ts`
2. 给每个函数加 JSDoc
3. 跑一遍测试确认没有回归
```

比一段散文描述清晰得多，Claude 不容易遗漏步骤。

---

## 第二章 日常提效

> 目标：把常见操作速度提升 2-3 倍。

### 2.1 `!` 前缀：终端输出直接进上下文

不需要复制粘贴错误日志，直接在 Claude 对话框输入：

```
!npm test
!git status
!cat error.log
```

命令输出会自动落入 Claude 的上下文，调试循环大幅提速。

### 2.2 `@文件名` 直接引用文件

避免让 Claude 搜遍整个仓库才找到你已经知道的文件：

```
帮我重构 @src/auth/middleware.ts，参考 @src/auth/types.ts 里的类型定义
```

精准引用节省 token，响应也更准确。

### 2.3 搜索历史对话

Claude 的对话记录存在本地：

```bash
~/.claude/projects/
```

忘了上次怎么解决某个问题？直接问 Claude：

```
帮我搜索我们之前讨论过 JWT 过期的对话
```

或者用 grep 自己找：

```bash
grep -r "JWT" ~/.claude/projects/ --include="*.json" -l
```

### 2.4 多标签页并行工作

Claude Code 支持在不同终端标签页同时跑多个实例。常见用法：

- 标签 1：主功能开发
- 标签 2：跑测试 / 看日志
- 标签 3：文档或 PR 相关

每个实例独立，互不干扰。

### 2.5 语音输入，效果比打字好

开口说话时你会自然地加入更多背景、约束和细节，比键盘打出来的简短指令效果明显更好。

推荐工具：
- **SuperWhisper / MacWhisper**（Mac）：本地转写，隐私友好
- Claude 内置语音模式：`/voice`

复杂需求用语音描述，精确指令用键盘，两种方式结合效果最好。

### 2.6 `Ctrl+G`：在 AI 动手前改它的计划

Claude 给出计划后，不要直接让它执行。按 `Ctrl+G` 在编辑器中打开计划，调整步骤顺序、修正错误方向，再放行。

20 分钟后发现方向跑偏的问题，90% 可以靠这一步消灭。

### 2.7 `Ctrl+B`：后台运行，不阻塞对话

Claude 在跑耗时任务（构建、测试、部署）时，按 `Ctrl+B` 将它推到后台。你继续规划下一步，它在后台干活，有结果时自动汇报。

### 2.8 用 `realpath` 消除路径歧义

当你需要告诉 Claude 操作某个文件，用绝对路径最稳：

```bash
realpath src/components/Button.tsx
# 输出：/Users/xxx/project/src/components/Button.tsx
```

把输出粘给 Claude，避免相对路径引发的目录混淆。

---

## 第三章 上下文与 Prompt

> 目标：让 Claude 始终在正确的轨道上工作。

### 3.1 上下文像牛奶，越新鲜越好

> "AI context is like milk; it's best served fresh and condensed."

不同任务之间执行 `/clear`。一个混乱的 3 小时会话，质量会随时间缓慢下滑，原因是早期无关的上下文在稀释你的最新指令。

规律：每换一个独立任务，开新会话。

### 3.2 纠正两次还没改好？重开会话

如果你已经纠正了两次，Claude 还是偏，不要第三次尝试修正——

1. `/clear`
2. 把刚才学到的教训融入新的 prompt
3. 重新开始

延续一个破损的对话只会叠加混乱。问题往往在 prompt 本身，不在 Claude。

### 3.3 不要描述 Bug，直接粘原始数据

```bash
# 不要这样：
"我的 API 返回 500 错误，好像是数据库连接问题"

# 要这样：
cat error.log | claude "分析这个错误，给出修复方案"
```

或者直接把 CI 日志、Stack Trace 粘进去，加一句「修掉它」。抽象描述会丢失细节，原始数据给出精准结果。

### 3.4 Plan Mode：架构级改动前必用

`Shift+Tab` 进入 Plan Mode。

多文件变更、结构性重构、跨模块改动——在这些场景先进 Plan Mode，让 Claude 输出完整方案，你审核后再执行。能防止 Claude 自信地解决了一个错误的问题。

### 3.6 压缩时给出保留指引

```
/compact 重点保留用户认证模块的改动记录和当前 TODO 列表
```

没有指引的 `/compact` 会随机丢失重要上下文；有指引的压缩能精准提炼，后续响应质量明显更好。

### 3.7 创建交接文档，跨会话接力

长任务跨多个会话时，在每次结束前让 Claude 生成交接文档：

```
帮我生成一份会话交接文档，包括：
- 已完成的工作
- 当前状态
- 下一步计划
- 需要注意的坑
保存到 memory/handoff.md
```

下次开新会话，第一条消息就是：`读取 @memory/handoff.md，继续上次的工作`。

### 3.8 `ultrathink` 解锁深度推理

在 prompt 末尾加 `ultrathink`（Opus 4.6 有效）：

```
重构这个支付模块的错误处理逻辑，ultrathink
```

Claude 会动态分配更多推理预算。真正复杂的问题（架构设计、难以定位的 bug），质量提升肉眼可见。简单任务不需要加，会浪费预算。

---

## 第四章 CLAUDE.md 与规则系统

> 目标：让 Claude 自动遵守你的项目规范，不用每次重复说。

### 4.1 用 `/init` 生成初始文件，然后删掉一半

```
/init
```

生成 `CLAUDE.md` 后，无情地删掉你说不出理由保留的内容。每一行多余的指令都是 token 消耗，会悄悄降低其他指令的执行质量。

**黄金测试**：对每一行问自己——「没有这条，Claude 会犯错吗？」答案是否就删掉。

你大约有 150-200 行的有效预算，超过后合规率开始下降。

### 4.2 CLAUDE.md 的内容分层

```markdown
# CLAUDE.md 推荐结构

## 项目上下文（必须）
- 这是什么项目，用什么技术栈
- 关键目录结构

## 不可违反的规则（必须）
- 禁止直接 push main
- 提交前必须跑测试

## 风格约定（按需）
- 中文注释
- 函数命名用动词开头

## 工作流提示（轻量）
- 优先查看 docs/ 下的设计文档
```

不要把所有规范都塞进去。「风格约定」和「工作流提示」只放真正影响 Claude 决策的内容。

### 4.3 用 `@imports` 保持主文件轻量

不要把长文档内容直接粘进 CLAUDE.md，改用引用：

```markdown
# CLAUDE.md

项目规范详见：
@docs/api-conventions.md
@docs/git-workflow.md
```

Claude 按需读取，主文件保持精简，上下文不被撑爆。

### 4.4 每次 Claude 出错后更新规则

Claude 犯了某类错误，不只是纠正它，更要固化这个知识：

```
把这个问题的正确处理方式写入 CLAUDE.md，确保以后不再发生
```

你的 CLAUDE.md 会变成一个随每次会话持续进化的活系统。

### 4.5 用 `.claude/rules/` 实现条件化规则

某些规范只对特定目录有效，用路径声明限制作用域：

```yaml
# .claude/rules/api-rules.md
---
paths:
  - "src/api/**"
  - "src/handlers/**"
---

# API 响应必须遵循统一格式
所有端点返回：{ code, data, message }
```

这样 API 规范只在编辑 `src/api/` 时加载，不干扰其他模块的上下文。

### 4.6 CLAUDE.md 管建议，Hooks 管强制要求

Claude 遵循 CLAUDE.md 的概率约 80%，不是 100%。对于不可妥协的要求（格式、安全、提交规范），用 Hooks——它每次都执行，没有例外。

**PostToolUse Hook：每次编辑后自动格式化**

```json
// .claude/settings.json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Edit|Write",
      "hooks": [{
        "type": "command",
        "command": "npx prettier --write \"$CLAUDE_FILE_PATH\" 2>/dev/null || true"
      }]
    }]
  }
}
```

**PreToolUse Hook：拦截危险命令**

```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Bash",
      "hooks": [{
        "type": "command",
        "command": "echo \"$CLAUDE_TOOL_INPUT\" | grep -qE '(rm -rf|DROP TABLE|force push)' && echo 'BLOCKED' && exit 1 || exit 0"
      }]
    }]
  }
}
```

### 4.7 Skills：按需加载的扩展知识

`.claude/skills/` 里的技能文件只在调用时加载，不调用时不占上下文：

```
# 调用时
使用 systematic-debugging 技能分析这个问题
```

把它理解成库文件——用时挂载，不用时隐形。适合把较长的工作流规范封装进来。

### 4.8 定期审计已授权的命令

Claude Code 会记录你批准过的 shell 命令。定期检查：

```
/permissions
```

看看哪些命令是你已经无脑批准的，撤销不再需要的权限。特别是在项目性质发生变化之后。

---

## 第五章 工具、MCP 与自动化

> 目标：让 Claude 拿到它需要的工具，但不浪费上下文。

### 5.1 让 Claude 自检结果，形成闭环

在 prompt 里直接包含验证步骤：

```
重构 auth 模块，跑 npm test，修掉所有失败用例，最后告诉我完成了
```

这一条指令能带来 2-3 倍的质量提升。Claude 会在返回结果前自己确认工作有效，而不是猜测。

### 5.2 优先用 CLI 工具，少用 MCP Server

CLI 工具比 MCP Server 消耗的上下文更少：

```bash
# 用 gh CLI 管 PR（推荐）
gh pr create --title "feat: add auth" --body "..."
gh pr list --state open

# 用 sentry-cli 查生产错误
sentry-cli releases list
```

教 Claude 用这些 CLI，节省的上下文在长会话中持续积累。

### 5.3 优先安装这四个 MCP Server

信噪比最高、实用价值最大的四个：

| MCP Server | 用途 |
|-----------|------|
| **Playwright** | UI 自动化测试，比内置浏览器更稳定 |
| **PostgreSQL / MySQL** | 查询 Schema，辅助数据库相关开发 |
| **Slack** | 直接读取 Bug 讨论串，减少切换 |
| **Figma** | 设计稿转代码 |

先把这四个用熟，再根据实际需求扩展。

### 5.4 Playwright MCP 优于内置浏览器

当需要操作网页时，优先选择 Playwright MCP 而非 Claude 内置的浏览器集成。Playwright 更稳定、可调试、支持截图验证，在大多数场景下是更好的选择。

### 5.5 容器化高风险操作

需要跑破坏性实验（批量重命名文件、修改配置、清理数据）时，在 Docker 容器里执行：

```bash
docker run --rm -v $(pwd):/workspace -w /workspace node:20 bash
# 然后在容器内指挥 Claude 操作
```

容器崩了不影响本机，实验完 review diff 再决定要不要合并。

### 5.6 `/loop` 定期后台检查

```
/loop 5m 检查部署是否成功，如果失败告诉我
```

设置后台循环检查，你继续其他工作，Claude 有情况时主动汇报。适合等待 CI 通过、监控部署状态等场景。

### 5.7 安装 dx 插件，扩展实用命令

```bash
# 安装 dx 插件
claude plugin install dx
```

安装后获得一组实用命令：
- `/dx:handoff` — 生成会话交接文档
- `/dx:gha` — 分析 GitHub Actions 日志
- `/dx:clone` — 分叉当前对话，在新分支上实验

---

## 第六章 进阶：Agent 与并行

> 目标：突破单线程限制，用并行工作流倍增吞吐量。

### 6.1 Git Worktrees：多功能并行开发

```bash
# 为不同功能创建独立工作目录
git worktree add ../project-feature-auth feature/auth
git worktree add ../project-feature-payment feature/payment

# 在不同目录各开一个 Claude Code 实例
cd ../project-feature-auth && claude
```

三个功能同时开发，互不干扰，没有分支切换的开销。合并时按正常 PR 流程走。

### 6.2 用子 Agent 保持主上下文干净

主会话上下文很宝贵。探索性工作派给子 Agent：

```
用子 Agent 梳理一下支付模块的完整调用链，整理成文档告诉我
```

子 Agent 独立读取文件、分析代码，返回摘要结果。主上下文只接收结论，不被过程污染。

### 6.3 创建专属子 Agent

在 `.claude/agents/` 里定义预配置的 Agent：

```yaml
# .claude/agents/code-reviewer.md
---
name: code-reviewer
description: TypeScript 代码审查，关注类型安全和性能
model: sonnet
tools: [Read, Grep, Glob]
---

审查以下方面：
1. 类型定义是否完整
2. 是否有潜在的 null/undefined 风险
3. 是否有明显的性能问题
```

调用时：

```
用 code-reviewer agent 审查 src/api/ 目录的改动
```

### 6.4 并行 Agent：多模块同时分析

独立任务不要串行执行：

```
同时启动三个 Agent：
- Agent 1：分析 auth 模块的安全隐患
- Agent 2：检查 cache 系统的性能瓶颈
- Agent 3：验证 API 的错误处理覆盖率
汇总结果告诉我
```

并行执行节省的时间随任务数量线性增长。

### 6.5 Agent Teams（实验性）

```bash
CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude
```

一个主导 Agent 将任务分解并分发给 3-5 个并行子 Agent。大规模代码调研、多模块重构时，这是另一个维度的速度提升。

### 6.6 `/sandbox`：无监督实验的安全沙盒

```
/sandbox
```

通过 OS 级隔离（macOS Seatbelt / Linux bubblewrap），让 Claude 在沙盒里放开跑实验性重构，对真实系统零风险。结束后 review diff，只合并满意的部分。

---

## 第七章 专家心法

> 目标：建立可持续进化的 AI 工作流，而不是一次性的使用技巧。

### 7.1 把软件工程能力带进来，不是甩给 AI

Claude Code 放大你的能力，不替代你的判断。

规划先于编码——在让 Claude 动手之前，先想清楚要做什么。把计划写出来（哪怕是一段话），Claude 的输出质量会显著提升。

### 7.2 TDD：先写测试，再写实现

```
帮我为这个功能先写测试用例，用例通过后再写实现
```

测试先行有两个好处：
1. 强迫你在写代码前想清楚接口和行为
2. 给 Claude 提供了自动验证机制，它能自己判断实现是否正确

### 7.3 用好「问烂问题」的特权

```
这个文件你觉得有什么问题？
这个设计你有什么疑问？
```

模糊提问让 Claude 发现你没想到要问的问题。摸底陌生代码库时，这是最快的方式。

### 7.4 自动化你的自动化

不只是用 Claude 自动化业务逻辑，也用它自动化你的 AI 工作流本身：

```
分析我最近 10 次 /clear 前的对话，总结哪类任务容易让 Claude 跑偏，
帮我写一条 CLAUDE.md 规则来预防它
```

让系统自我改进，是真正的复利。

### 7.5 个人工作流投资值得认真对待

花在优化 CLAUDE.md、自定义 skills、调整 Hooks 上的时间，是长期回报最高的投入。

一次好的配置，可能在接下来几百次会话里持续生效。

### 7.6 定期清理系统提示，保持精简

CLAUDE.md 会随时间膨胀。每个月做一次审计：

```
读取我的 CLAUDE.md，找出可能已经过时或重复的规则，给出精简建议
```

系统提示越精简，Claude 在你真正关心的规则上的注意力就越集中。

### 7.7 Claude Code 不只是写代码的工具

它是一个通用的工程师助手：

- **写作**：文档、PRD、技术方案、邮件草稿
- **调研**：竞品分析、技术选型、API 文档梳理
- **DevOps**：部署脚本、Dockerfile 调优、告警规则配置
- **数据**：SQL 查询调试、数据格式转换、报表生成

遇到觉得「这个好像 AI 能帮」的场景，直接试。边界比你想象的宽得多。

---

## 快速参考

### 快捷键速查

| 快捷键 | 功能 |
|--------|------|
| `Esc` | 中止当前操作 |
| `Esc + Esc` | 撤销，回到操作前状态 |
| `Ctrl+G` | 在执行前编辑 Claude 的计划 |
| `Ctrl+B` | 推入后台，继续对话 |
| `Ctrl+S` | 暂存当前草稿 |
| `Shift+Tab` | 进入 Plan Mode |

### 常用命令速查

| 命令 | 功能 |
|------|------|
| `/clear` | 清空会话 |
| `/compact [指引]` | 压缩上下文 |
| `/model` | 切换模型 |
| `/init` | 生成 CLAUDE.md |
| `/permissions` | 查看已授权命令 |
| `/voice` | 语音输入模式 |
| `/sandbox` | 启用沙盒隔离 |
| `/loop [间隔] [任务]` | 后台循环检查 |

### 按场景选择技巧

| 场景 | 推荐技巧 |
|------|---------|
| 第一次用 | §1.1 别名 → §1.2 基础命令 → §1.3 状态栏 |
| 调 Bug | §3.3 粘原始数据 + §5.1 自检闭环 |
| 大型重构 | §3.5 Plan Mode + §6.1 Worktrees |
| 项目规范落地 | §4.1-4.6 CLAUDE.md 体系 |
| 提升 AI 质量 | §3.8 ultrathink + §4.4 规则进化 |
| 并行提速 | §6.2 子 Agent + §6.4 并行 Agent |

---

> "大多数工程师优化的是代码。最快的那批人优化的是 AI 工作流。这是两种完全不同的复利优势。"

**从每章挑 1-2 条本周开始用。30 天后，你的工作流会有根本性的变化。**
