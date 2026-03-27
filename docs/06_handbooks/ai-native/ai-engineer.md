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
| 经验沉淀 | `/learner` |

---

## Agent 设计核查清单

- [ ] 工具定义清晰（输入/输出/副作用）
- [ ] 观察结果有结构化格式
- [ ] 错误恢复策略明确（重试/降级/中止）
- [ ] Context 预算合理（不超出窗口上限）
- [ ] 并行 vs 串行任务划分正确

---

## 推荐 Agents

| Agent | 用途 |
|-------|------|
| `omc-architect` | 架构设计决策 |
| `omc-critic` | 方案批判与风险识别 |
| `omc-planner` | 实施规划 |
| `analyst`（内置）| 需求结构化分析 |

---

## 相关文档

- [Agent 编排规范](../../00_ai_system/claude-code-40-best-practices.md)
- [skills 架构说明](../../00_ai_system/roles/ai-native/SKILLS_INDEX.md#ai-工程师)
