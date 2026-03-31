# AI 工程师操作手册

> 设计和构建 AI 系统。包括 Agent 编排、LLM 集成、RAG 流水线、Prompt 工程。
> 这是 AI-Native 时代最具差异化的新角色。

---

## 角色配置

```json
{
  "currentRole": "ai-engineer",
  "gitUser": "your@email.com"
}
```

---

## 核心工作流

### Agent 系统设计

```
/ralplan            → Planner→Architect→Critic 三角规划
/writing-plans      → 拆分系统实施计划
agent-harness-construction → 工具设计、观察格式化、错误恢复、context 预算
/executing-plans    → 执行架构变更
```

### 并行执行

```
/dispatching-parallel-agents  → 并行启动多个 Agent
/ultrawork                    → Haiku/Sonnet/Opus 分层路由
/autopilot                    → 全自动 idea→QA 流水线
```

### Claude API 开发

```
/claude-api         → Anthropic SDK 使用指南
```

### Codex 二次验证

AI 工程师构建 AI 系统时，最容易产生"自我验证"的盲区——用 Claude 写的代码让 Claude 来审。Codex 提供独立的第二视角：

```
/codex:setup                               → 首次使用：检查安装状态，登录账号
/codex:review --wait                       → PR 前同步代码审查（小 diff 用这个）
/codex:review --background                 → 大 diff 后台审查，不阻塞开发
/codex:adversarial-review                  → 挑战式：质疑 Agent 设计决策和架构假设
/codex:rescue 描述问题                     → 卡住时把任务交给 Codex 独立处理
/codex:rescue --resume 继续修复            → 续接上次 Codex 线程
/codex:status                              → 查看所有后台任务进度
/codex:result <job-id>                     → 获取完整审查结果
```

**何时用 Codex vs Claude：**

| 场景 | 推荐 |
|------|------|
| 快速修改、简单 bug | Claude（当前会话直接处理）|
| 大型重构、多文件变更 | Codex（`/codex:rescue --background`）|
| PR 代码审查 | Codex（`/codex:review`，独立视角）|
| 架构设计是否合理 | Codex（`/codex:adversarial-review`）|
| Claude 反复失败、卡住 | Codex（`/codex:rescue`，第二视角）|

---

## 常用技能速查

| 场景 | 命令 |
|------|------|
| 复杂需求澄清 | `/deep-interview` |
| 架构规划 | `/ralplan` |
| Agent 设计 | `agent-harness-construction` |
| 并行任务 | `/ultrawork` |
| 全自动流水线 | `/autopilot` |
| 工程评审 | `/plan-eng-review` |
| 根因调查 | `/investigate` |
| 代码审查（独立视角） | `/codex:review` |
| 架构决策验证 | `/codex:adversarial-review` |
| 任务委托 Codex | `/codex:rescue` |
| 经验沉淀 | `/learner` |

---

## Agent 设计核查清单

- [ ] 工具定义清晰（输入/输出/副作用）
- [ ] 观察结果有结构化格式
- [ ] 错误恢复策略明确（重试/降级/中止）
- [ ] Context 预算合理（不超出窗口上限）
- [ ] 并行 vs 串行任务划分正确
- [ ] 已用 `/codex:adversarial-review` 做独立架构验证

---

## 推荐 Agents

| Agent | 用途 |
|-------|------|
| `omc-architect` | 架构设计决策 |
| `omc-critic` | 方案批判与风险识别 |
| `omc-planner` | 实施规划 |
| `analyst`（内置）| 需求结构化分析 |
| `codex-rescue`（内置）| Codex 任务委托 subagent |

---

## 相关文档

- [Agent 编排规范](../../00_ai_system/claude-code-40-best-practices.md)
- [skills 架构说明](../../00_ai_system/roles/ai-native/SKILLS_INDEX.md#ai-工程师)
