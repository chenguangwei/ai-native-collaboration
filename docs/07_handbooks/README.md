# 📚 AI-Native 开发操作手册

> AI-Native 时代：岗位不再按技术栈划分，而是按**你解决什么问题**来定义。

---

## 岗位手册

### 全流程视角（推荐先读）

| 手册 | 描述 |
|------|------|
| [handbook-team-collab.md](handbook-team-collab.md) | **过渡期协作手册**：产品/前端/后端/测试/运维 各岗位 AI 使用指南 |
| [handbook-product-workflow.md](handbook-product-workflow.md) | 产品全流程（阶段视角）：需求→构建→测试→运维完整交付链路 |

### AI-Native 岗位手册

| 岗位 | 手册 | 核心职责 |
|------|------|---------|
| 产品工程师 | [handbook-fullstack.md](handbook-fullstack.md) | 端到端交付特性，不区分前后端语言栈 |
| 产品负责人 | [handbook-pm.md](handbook-pm.md) | 需求策略、PRD、用户研究 |
| 质量工程师 | [handbook-qa.md](handbook-qa.md) | 全栈测试 + 安全 + 可靠性 |
| 平台工程师 | [handbook-devops.md](handbook-devops.md) | 基础设施、CI/CD、开发者体验 |

> **旧手册参考**：`handbook-frontend.md`、`handbook-backend.md` 内容已合并到产品工程师手册。AI 工程师手册见 `docs/00_ai_system/`。

---

## AI-Native 岗位体系

```
传统体系（已过时）        AI-Native 体系
─────────────────         ──────────────────────
前端工程师          →
后端工程师（Java）   →     产品工程师
后端工程师（Node）   →       端到端交付，不分语言栈
全栈工程师          →
─────────────────         ──────────────────────
架构师              →     AI 工程师
（无对应角色）       →       Agent 编排 + LLM 集成
─────────────────         ──────────────────────
QA 测试工程师       →     质量工程师
                           全栈测试 + 安全 + 可靠性
─────────────────         ──────────────────────
DevOps              →     平台工程师
                           基础设施 + 开发者体验
─────────────────         ──────────────────────
产品经理            →     产品负责人
                           需求策略 + 验收标准
```

---

## 快速开始

### 1. 配置岗位

编辑 `.claude/project-config.json`:

```json
{
  "currentRole": "product-engineer",
  "gitUser": "your@email.com",
  "team": "your-team"
}
```

**支持的角色值**：
- `product-engineer` — 产品工程师
- `ai-engineer` — AI 工程师
- `quality-engineer` — 质量工程师
- `platform-engineer` — 平台工程师
- `product-owner` — 产品负责人

### 2. 不确定选哪个？

```
今天主要做什么？
├── 构建用户可见功能（页面/API）→ product-engineer
├── 设计 Agent / LLM 集成      → ai-engineer
├── 测试 / 安全审计             → quality-engineer
├── CI/CD / 基础设施            → platform-engineer
└── 写 PRD / 需求分析           → product-owner
```

---

## 通用命令速查

### 任何岗位都适用

| 场景 | 命令 |
|------|------|
| 需求不清楚 | `/deep-interview` |
| 开始新功能 | `/brainstorming` |
| 制定计划 | `/writing-plans` |
| TDD 开发 | `/test-driven-development` |
| 完成前验证 | `/verification-before-completion` |
| 代码审查 | `/review` |
| 清理 AI 代码味 | `/ai-slop-cleaner` |
| 发现 Bug | `/systematic-debugging` |
| 发布检查 | `/ship` |

### OMC 高阶工具

| 场景 | 命令 |
|------|------|
| 复杂任务持续执行 | `/ralph` |
| 并行多任务 | `/ultrawork` |
| idea→QA 全自动 | `/autopilot` |
| 架构多视角共识 | `/ralplan` |
| QA 循环至通过 | `/ultraqa` |
| 提取经验知识 | `/learner` |
| 安装/升级 OMC | `/omc-upgrade` |

---

## 岗位技能矩阵

| 岗位 | 核心工作流 |
|------|-----------|
| 产品工程师 | `/deep-interview` → `/brainstorming` → TDD → `/review` → `/ship` |
| AI 工程师 | `/ralplan` → `agent-harness-construction` → `/ultrawork` → `/learner` |
| 质量工程师 | `/tdd-workflow` → `/qa` → `/ultraqa` → `/cso` → `/benchmark` |
| 平台工程师 | `/ship` → `/land-and-deploy` → `/canary` → `/investigate` |
| 产品负责人 | `/deep-interview` → `/office-hours` → `/plan-ceo-review` → `/ralplan` |

---

## Memory 工作流

### 每日开始
```bash
cat memory/roles/{role}/today.md
cat memory/.index/today-overview.md
cat memory/lock/conductor-tasks.json
```

### 每日结束
```bash
# 更新以下文件：
1. memory/roles/{role}/today.md
2. memory/persons/{git-user}/today.md
3. memory/.index/today-overview.md
4. memory/.index/active-tasks.json
```

---

## 相关文档

- [岗位配置指南](../06_skills/roles/ROLE_SETUP.md)
- [Skills 索引](../06_skills/SKILLS_INDEX.md)
- [AI 系统文档](../00_ai_system/)
- [记忆保存机制](../../.claude/rules/memory-flush.md)

---

*基于 AI-Native 开发方法论 v2.0*
