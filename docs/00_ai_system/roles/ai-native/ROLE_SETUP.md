# AI-Native 岗位配置说明

> AI-Native 时代不再按技术栈划分岗位。你解决**什么问题**决定你的角色，AI 负责技术细节。

---

## 快速配置

编辑 `.claude/project-config.json`，设置 `currentRole`：

```json
{
  "currentRole": "delivery-engineer",
  "gitUser": "your@email.com"
}
```

或使用命令切换：`/switch-role delivery-engineer`

**支持的角色值**：`delivery-engineer` | `ai-engineer` | `quality-engineer` | `product-owner`

---

## 岗位对照表（新旧映射）

| AI-Native 岗位 | 替代了 | 核心转变 |
|--------------|--------|---------|
| 交付工程师 | frontend + backend + fullstack + DevOps | 不再区分语言栈，端到端交付特性（含部署上线）|
| AI 工程师 | architect + 新增 | Agent 编排、LLM 集成成为独立专业 |
| 质量工程师 | QA | 从"写测试"扩展到安全+可靠性+可观测性 |
| 产品负责人 | PM | 用 AI 工具放大产品洞察能力 |

---

## 各岗位详情

### 交付工程师 (delivery-engineer)

**核心使命**：端到端交付用户可用的产品特性。从需求到上线（含部署运维），不依赖其他角色。

**工作范围**：`src/`（前端+后端均覆盖）、`tests/`、`ops/`、`docs/05_ops/`

**日常工作流**：
```
/deep-interview（需求澄清）→ /brainstorming → /writing-plans
→ /test-driven-development → 编写代码（前端/后端均可）
→ /ai-slop-cleaner → /review → /ship → /land-and-deploy
```

**核心技能**：

| 技能 | 场景 |
|------|------|
| `/deep-interview` | 需求不清时 Socratic 澄清 |
| `/test-driven-development` + `/tdd-workflow` | 所有功能开发 |
| `/coding-standards` | 编码规范（语言无关）|
| `/api-design` | API 设计 |
| `/frontend-design` | UI 界面构建 |
| `/review` | 代码审查 |
| `/ai-slop-cleaner` | 清理 AI 生成代码味道 |
| `/ultraqa` | QA 循环至通过 |
| `/ship` | 发布前检查 |
| `/land-and-deploy` | 合并 + 自动部署 |
| `/canary` | 金丝雀发布监控 |
| `/setup-deploy` | 部署环境配置 |
| `/guard` + `/careful` | 安全操作保护 |
| `/systematic-debugging` | 生产故障排查 |
| `/investigate` | 根因调查 |
| `/retro` | 故障/迭代复盘 |
| `/learner` | 提取调试/运维经验 |
| `/ralph` | 复杂特性/运维任务持续执行 |

**推荐 Agents**：
- `omc-code-reviewer` — 代码质量
- `omc-critic` — 技术方案批判
- `security-auditor`（内置）— 安全扫描

---

### AI 工程师 (ai-engineer)

**核心使命**：设计和构建 AI 系统。包括 Agent 编排、LLM 集成、RAG 流水线、Prompt 工程优化。

**工作范围**：`src/ai/`、`.claude/agents/`、`.agents/skills/`、AI 相关基础设施

**日常工作流**：
```
/ralplan（多视角架构规划）→ /writing-plans
→ 设计 Agent 工具/观察格式/错误恢复
→ /executing-plans → 验证 AI 系统行为
→ /learner（记录 AI 系统调试经验）
```

**核心技能**：

| 技能 | 场景 |
|------|------|
| `agent-harness-construction` | Agent 系统设计 |
| `/dispatching-parallel-agents` | 并行 Agent 编排 |
| `/subagent-driven-development` | 子代理驱动开发 |
| `/claude-api` | Claude API / Anthropic SDK |
| `/ultrawork` | 并行执行引擎 |
| `/autopilot` | 全自动 AI 流水线 |
| `/ralplan` | 三视角架构共识 |
| `/deep-interview` | 复杂 AI 需求澄清 |
| `/plan-eng-review` | 工程架构评审 |

**推荐 Agents**：
- `omc-architect` — 架构决策
- `omc-critic` — 方案批判
- `omc-planner` — 实施规划
- `analyst`（内置）— 需求结构化分析

---

### 质量工程师 (quality-engineer)

**核心使命**：保障产品可靠性、安全性和可观测性。不只是测试——包括安全审计、性能监控、混沌工程。

**工作范围**：`tests/`、`docs/04_qa/`、安全配置

**日常工作流**：
```
制定测试策略 → /tdd-workflow（测试代码模式）
→ /qa（自动化执行）→ /ultraqa（循环至通过）
→ /cso（安全审计）→ /benchmark（性能基线）
→ /learner（提取 Bug 模式）
```

**核心技能**：

| 技能 | 场景 |
|------|------|
| `/qa` + `/qa-only` | 自动化测试执行 |
| `/ultraqa` | QA 循环直到全部通过 |
| `browser-qa` | 视觉/交互/无障碍 QA |
| `/tdd-workflow` | 测试代码模式 |
| `/cso` | 安全审计 |
| `/benchmark` | 性能基线 |
| `/audit` | UI 质量审计 |
| `/learner` | 提取 Bug 模式为可复用知识 |

**测试目录**：
- `tests/unit/` — 单元测试
- `tests/api_integration/` — API 集成测试
- `tests/e2e_browser/` — 端到端测试

**推荐 Agents**：
- `omc-qa-tester` — QA 测试执行
- `omc-verifier` — 验证完成标准
- `omc-security-reviewer` — 安全审查
- `security-auditor`（内置）— 漏洞扫描

---

### 产品负责人 (product-owner)

**核心使命**：定义"做什么"和"为什么做"。从用户需求出发，提供清晰的验收标准，让工程团队方向正确。

**工作范围**：`docs/01_product/`、`memory/roles/product-owner/`

**日常工作流**：
```
/deep-interview（挖掘用户真实需求）
→ /office-hours（强迫症提问，逼出核心假设）
→ /ralplan（多视角共识规划）
→ /plan-ceo-review（CEO 视角评审）
→ /document-release（发布后更新文档）
→ /retro（迭代复盘）
```

**核心技能**：

| 技能 | 场景 |
|------|------|
| `/deep-interview` | 用户需求深度 Socratic 挖掘 |
| `/office-hours` | YC 式强迫症提问 |
| `/plan-ceo-review` | CEO 视角产品方向评审 |
| `/plan-design-review` | 设计可行性评审 |
| `/plan-eng-review` | 工程方案评审 |
| `/ralplan` | 多视角功能规划 |
| `/design-consultation` | 设计方向咨询 |
| `/document-release` | 发布后文档更新 |
| `/retro` | 迭代复盘 |
| `/autopilot` | 快速原型验证假设 |

**核心文档**：
- `docs/01_product/prd_v1.0.md` — PRD
- `docs/01_product/business_rules.md` — 业务规则

**推荐 Agents**：
- `analyst`（内置）— 需求结构化分析
- `omc-analyst` — OMC 需求分析
- `omc-critic` — 挑战产品假设

---

## 多 AI 并发配置

多人/多窗口并发工作时，用 git worktree 隔离：

```bash
# 交付工程师 A 在独立 worktree 工作
git worktree add ../workspace-feature-login feature/login
cd ../workspace-feature-login
# 修改 .claude/project-config.json → currentRole = "delivery-engineer"
```

任务协调使用 `scripts/lock.sh`：

```bash
./scripts/lock.sh acquire login-feature delivery-engineer
# ... 完成工作 ...
./scripts/lock.sh release login-feature
./scripts/lock.sh status   # 查看所有锁状态
```

---

## 岗位选择决策树

```
你今天主要做什么？
│
├── 构建功能 / 部署上线 / 维护基础设施
│   └── → delivery-engineer
│
├── 设计 AI Agent / LLM 集成 / 提示工程
│   └── → ai-engineer
│
├── 保障代码质量 / 测试 / 安全审计
│   └── → quality-engineer
│
└── 定义需求 / 写 PRD / 评审方案
    └── → product-owner
```
