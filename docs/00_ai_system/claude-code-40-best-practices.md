# 我用错了 Claude Code 好几个月——这 40 个技巧彻底改变了我的工作流

大多数人把 Claude Code 当成自动补全工具在用。
顶尖的 1% 用它像操作系统一样驾驭整个开发流程。

> "普通用户和高手之间的差距，不在于技术水平，在于配置。这个差距，每周值 4～6 小时。"

下面是 40 个真正改变工作流的 Claude Code 最佳实践。

---

## 一、基础配置

### 01 — 设置 `cc` 别名，省去每次确认

在 `~/.zshrc` 或 `~/.bashrc` 中加入：

```bash
alias cc='claude --dangerously-skip-permissions'
```

然后执行 `source ~/.zshrc`。此后输入 `cc` 就能跳过每次操作的权限确认提示。**前提是你明白自己在授权什么**——速度快，因为它信任你。

### 02 — 启用状态栏，获得实时 HUD

在 Claude Code 中运行：

```
/statusline
```

它会生成一段 shell 脚本，在每次 AI 响应后于终端底部实时显示：当前目录、分支名、上下文用量。相当于一个会话级别的 HUD。

### 03 — 将上下文窗口扩展到 100 万 token

Sonnet 4.6 和 Opus 4.6 支持 100 万 token 上下文。在会话中途切换：

```
/model opus[1m]
```

建议从 50 万开始，逐步调高，找到压缩前的最佳平衡点。

### 04 — 一次性配置输出风格，永久生效

运行 `/config` 选择风格：**Explanatory（详细）**、**Concise（简洁）** 或 **Technical（技术向）**。
也可以在 `~/.claude/output-styles/` 中创建完全自定义的风格文件。配置好之后，不需要每次手动纠正 AI 的语气。

### 05 — 用手机远程控制 Claude Code

```bash
claude remote-control
```

然后从 claude.ai 或移动端 App 接入。在 PC 上发起一次大型重构，手机上随时查看进度。

---

## 二、工作流提速技巧

### 06 — `!` 前缀：让 bash 输出直接进入上下文

输入 `!git status` 或 `!npm test`，输出会直接落入 Claude 的上下文，无需复制粘贴，调试循环效率大幅提升。

### 07 — `Esc` 暂停，`Esc+Esc` 回退

- `Esc`：立即中止 Claude 当前操作
- `Esc+Esc`（或 `/rewind`）：打开菜单，可恢复代码、对话或两者

这是你的「撤销」按钮，对那些只有 40% 把握的想法，大胆用。

### 08 — `Ctrl+S`：暂存当前草稿

写到一半需要临时问个问题？`Ctrl+S` 暂存草稿，问完之后草稿自动恢复。复杂多步任务的救命键。

### 09 — `Ctrl+B`：后台运行耗时任务

Claude 在跑测试或构建时，按 `Ctrl+B`，它继续在后台工作，你可以继续对话规划下一步。真正的并行生产力。

### 10 — `/btw`：侧边提问，不污染主对话

`/btw` 弹出一个悬浮层，可以快速问「为什么用这个方法？」之类的问题，主对话历史保持干净，好奇心照样得到满足。

### 11 — `Ctrl+G`：在 AI 动手前编辑它的计划

Claude 给出计划后，`Ctrl+G` 在编辑器中打开计划内容，调整步骤、修正方向，再让它执行。避免 20 分钟后才发现方向跑偏。

### 12 — 语音输入比打字给出更好的 Prompt

```
/voice
```

开启按键说话模式。开口说 prompt 时，你会自然地补充更多背景、约束和细节，效果明显优于键盘敲出的简短指令。

---

## 三、上下文与 Prompt 管理

### 13 — 不同任务之间执行 `/clear`

干净的会话永远优于混乱的 3 小时会话。累积的上下文会悄悄稀释你的指令。`/clear` 是防止输出质量在一天中缓慢下滑的关键。

### 14 — 纠正两次还没好？直接开新会话

如果你已经纠正过两次，Claude 还是偏了，不要第三次修正——`/clear` 后重写 prompt，把刚才学到的教训融进去。延续一个破损的对话只会叠加混乱。

### 15 — 不要描述 Bug，直接粘贴原始数据

不要解释 bug，直接粘错误日志、CI 输出或 Slack 截图，然后说「修掉它」：

```bash
cat error.log | claude "解释这个错误并给出修复方案"
```

抽象描述会丢失细节，原始数据才能得到精准结果。

### 16 — 架构级改动用 Plan Mode

`Shift+Tab` 进入 Plan Mode。多文件变更或结构性调整时必用，前期规划的开销，能防止 Claude 花 20 分钟自信地解决了错误的问题。

### 17 — 直接指定文件，节省 token

用 `@src/auth/middleware.ts` 直接引用文件，Claude 自动解析，避免它搜遍整个代码库才找到你早已知道的上下文。

### 18 — 用模糊提问探索陌生代码

「这个文件你会怎么改进？」能让 Claude 发现你没想到要问的不一致之处。在摸底陌生领域时，模糊是一种特性。

### 19 — 压缩时给出保留指引

使用 `/compact` 时，告诉 Claude 要保留什么：「重点保留 API 的改动」。没有指引的压缩会丢失上下文主线；有指引的压缩能精准提炼。

### 20 — `ultrathink` 解锁自适应推理

在任意 prompt 末尾加上 `ultrathink`（仅 Opus 4.6）：

```
重构这个支付模块，ultrathink
```

Claude 会根据问题实际复杂度动态分配推理预算。遇到真正难的问题，质量提升肉眼可见。

---

## 四、自动化、工具与 MCP

### 21 — 让 Claude 自检结果

在 prompt 中包含测试命令：

```
重构 auth 模块，跑测试套件，修掉失败的用例再告诉我完成了
```

这一条指令能带来 2～3 倍的质量提升，因为它形成了反馈闭环。

### 22 — 安装 LSP 插件，自动获取诊断信息

```
/plugin install typescript-lsp@claude-plugins-official
```

LSP 插件让 Claude 在每次编辑后自动获取诊断结果，在你发现之前就修掉类型错误。

### 23 — 优先用 CLI 工具，少用 MCP Server

CLI 工具比 MCP Server 更节省上下文。教 Claude 用 `gh` 管 PR，用 `sentry-cli --help` 调试生产问题，节省的上下文在长会话中会持续积累。

### 24 — 优先安装这四个 MCP Server

信噪比最高的四个：
- **Playwright** — UI 验证
- **PostgreSQL/MySQL** — Schema 查询
- **Slack** — 直接读取 Bug 讨论串
- **Figma** — 设计稿转代码

先把这四个用熟，再考虑扩展。

### 25 — `/loop` 定期后台检查

```
/loop 5m check if deploy succeeded
```

设置后台循环检查，会话保持打开，你继续工作，Claude 有消息时主动汇报。

### 26 — 用 `/permissions` 白名单免确认

别每次都手动批准 `npm run lint`。把信任的命令加入白名单，消除频繁确认带来的隐性效率损耗。

---

## 五、掌握 CLAUDE.md 与规则系统

### 27 — `/init` 生成后砍掉一半

`/init` 生成初始 `CLAUDE.md`，然后无情删掉你说不出理由保留的内容。每一行多余的指令都是 token 消耗，悄悄降低其他地方的注意力质量。

### 28 — CLAUDE.md 的黄金测试

对每一行问自己：「没有这条，Claude 会犯错吗？」
答案是否 → 删掉。
你大约有 150～200 条指令的预算，超过后合规率开始下降，用好这个预算。

### 29 — 每次犯错后自动更新规则

Claude 出错时说：

```
更新 CLAUDE.md，确保这个问题不再发生
```

你的规则文件就会变成一个随每次会话持续进化的活系统。

### 30 — 用 `.claude/rules/` 实现条件化规则

在规则文件顶部添加路径声明：

```yaml
---
paths:
  - "src/api/**"
---
```

TypeScript 规则只在 `.ts` 文件生效，数据库规则只在 `/db` 目录生效。上下文精准，不浪费。

### 31 — 用 `@imports` 保持 CLAUDE.md 轻量

引用 `@docs/git-instructions.md` 而不是把内容直接粘进去。Claude 按需读取，基础上下文保持轻量。

### 32 — Skills：按需加载的扩展知识

`.claude/skills/` 中的 Skill 文件在调用时加载，不调用时不占上下文。把它理解成库文件——用时挂载，不用时隐形。

### 33 — CLAUDE.md 管建议，Hooks 管强制要求

Claude 遵循 CLAUDE.md 的概率约 80%。对于格式、安全、代码规范这类不可妥协的要求，使用 Hooks——它每次都会执行，没有例外。

### 34 — PostToolUse Hook：每次编辑后自动格式化

在 `.claude/settings.json` 中加入：

```json
"hooks": {
  "PostToolUse": [{
    "matcher": "Edit|Write",
    "hooks": [{
      "type": "command",
      "command": "npx prettier --write \"$CLAUDE_FILE_PATH\" 2>/dev/null || true"
    }]
  }]
}
```

每次编辑后自动运行 Prettier，彻底告别手动格式化。

### 35 — PreToolUse Hook：拦截危险命令

在 Bash 工具执行前拦截，阻止 `rm -rf` 或 `DROP TABLE` 等危险操作。PreToolUse Hook 是让你敢于给 Claude 更多自主权的安全网。

---

## 六、进阶：Worktree、Agent 与隔离执行

### 36 — `--worktree` 实现并行分支开发

```bash
claude --worktree feature-auth
```

创建独立的工作副本，同时开启 3 个会话分别处理不同功能，互不干扰，直接倍增吞吐量。

### 37 — 用子 Agent 保持主上下文窗口干净

```
用子 Agent 搞清楚支付流程
```

这会派生一个独立实例读取相关文件，返回摘要——主上下文始终保持精简专注。

### 38 — 为常用任务创建自定义子 Agent

```
/agents
```

在 `.claude/agents/` 中保存预配置的 Agent：基于 Haiku 的快速搜索 Agent、严格 TypeScript 审查 Agent、文档撰写 Agent。你的 AI 专属团队，随叫随到。

### 39 — Agent Teams：大规模并行作业

启用实验性功能：

```bash
CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude
```

一个主导 Agent 将任务分发给 3～5 个并行子 Agent。大规模调研或多模块重构时，这是另一个维度的速度。

### 40 — `/sandbox`：无监督实验的安全沙盒

```
/sandbox
```

通过 Seatbelt 或 bubblewrap 实现 OS 级隔离，让 Claude 在实验性重构上放开跑，对真实系统零风险。跑完 review diff，合并你满意的部分。

---

## 总结

> "大多数工程师优化的是代码。最快的那批人优化的是 AI 工作流。这是两种完全不同的复利优势。"

这 40 条技巧，不需要新的订阅，不需要你是 10x 工程师。它们全都藏在你已经在用的工具里，等着被发现。

**从这个列表里挑 5 条，本周实现它们。30 天后回来，工作流不会没有根本性的变化。**
