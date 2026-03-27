# AI-Native 操作手册

> 岗位不再按语言栈划分，而是按"你解决什么问题"来定义。

---

## 5 个岗位手册

| 岗位 | 手册 | 核心职责 | currentRole |
|------|------|---------|-------------|
| 产品工程师 | [product-engineer.md](product-engineer.md) | 端到端交付产品特性，不区分前后端语言栈 | `product-engineer` |
| AI 工程师 | [ai-engineer.md](ai-engineer.md) | Agent 编排、LLM 集成、AI 流水线 | `ai-engineer` |
| 质量工程师 | [quality-engineer.md](quality-engineer.md) | 全栈测试 + 安全 + 可靠性 | `quality-engineer` |
| 平台工程师 | [platform-engineer.md](platform-engineer.md) | 基础设施、CI/CD、开发者体验 | `platform-engineer` |
| 产品负责人 | [product-owner.md](product-owner.md) | 需求策略、PRD、用户研究 | `product-owner` |

---

## 选哪个岗位？

```
今天主要做什么？
├── 构建用户可见的功能（页面 / API / 数据）
│   └── product-engineer
├── 设计 AI Agent / LLM 集成 / Prompt 工程
│   └── ai-engineer
├── 测试 / 安全审计 / 可靠性保障
│   └── quality-engineer
├── CI/CD / 基础设施 / 部署监控
│   └── platform-engineer
└── 写 PRD / 需求分析 / 方向评审
    └── product-owner
```

---

## 通用工作流

```
需求不清楚  → /deep-interview
开始新功能  → /brainstorming
遇到 Bug   → /systematic-debugging
完成前      → /verification-before-completion
提 PR 前   → /review → /ai-slop-cleaner
发布前      → /ship
```

---

## 与传统体系的对应关系

| AI-Native 岗位 | 替代了 |
|--------------|--------|
| 产品工程师 | 前端 + 后端 + 全栈 |
| AI 工程师 | 架构师 + 新增 |
| 质量工程师 | 测试工程师 |
| 平台工程师 | 运维/DevOps |
| 产品负责人 | 产品经理 |

过渡期协作指南 → [../traditional/](../traditional/README.md)
