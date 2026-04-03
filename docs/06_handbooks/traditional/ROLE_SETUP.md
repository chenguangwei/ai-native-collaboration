# 岗位体系迁移指南（传统 → AI-Native）

> 本文档描述传统研发团队如何逐步迁移到 AI-Native 岗位体系。

---

## 传统岗位 → AI-Native 岗位映射

| 传统岗位 | 迁移路径 | 目标 AI-Native 岗位 |
|---------|---------|-------------------|
| 产品经理 (PM) | 掌握 AI 需求分析、PRD 生成技能 | 产品负责人 (Product Owner) |
| 前端工程师 | 扩展到全栈 + AI 工具链交付 | 交付工程师 (Delivery Engineer) |
| 后端工程师 | 扩展到全栈 + LLM/Agent 集成 | 交付工程师 / AI 工程师 |
| 测试工程师 (QA) | 扩展到安全、可靠性、可观测性 | 质量工程师 (Quality Engineer) |
| 运维工程师 (DevOps) | 融入交付闭环，负责部署上线 | 交付工程师 (Delivery Engineer) |

---

## 迁移阶段

### 阶段一：AI 工具赋能（0-2 个月）

每个传统岗位保持原有职责，引入 AI 工具提升效率。

- 参考各岗位手册：[pm.md](pm.md) / [frontend.md](frontend.md) / [backend.md](backend.md) / [qa.md](qa.md) / [devops.md](devops.md)
- 优先掌握：`/brainstorming`、`/review`、`/qa`、`/ship` 等核心 Slash Commands

### 阶段二：跨职能协作（2-4 个月）

打破传统岗位边界，开始跨职能协作。

- 前端工程师开始承接简单后端任务（API 调用、数据处理）
- 后端工程师开始承接 LLM 集成（Prompt 工程、Agent 编排）
- QA 工程师开始承接安全审计和可观测性建设

### 阶段三：AI-Native 岗位重组（4-6 个月）

正式按 AI-Native 4 岗位体系重组团队。

- 参考 AI-Native 手册：[../ai-native/README.md](../ai-native/README.md)
- 各岗位详细职责：
  - [交付工程师](../ai-native/delivery-engineer.md)
  - [AI 工程师](../ai-native/ai-engineer.md)
  - [质量工程师](../ai-native/quality-engineer.md)
  - [产品负责人](../ai-native/product-owner.md)

---

## 技能习得优先级

### 全员必备

1. Claude Code 熟练使用（参见 [使用指南](../../00_ai_system/claude-code-40-best-practices.md)）
2. Prompt 工程基础（清晰表达意图、上下文给足）
3. AI 生成代码的 Review 能力（不盲目接受输出）
4. TDD 流程：先写测试，再写实现

### 按岗位习得

参见 [SKILLS_INDEX.md](SKILLS_INDEX.md)（传统岗位技能速查）和 [../ai-native/SKILLS_INDEX.md](../ai-native/SKILLS_INDEX.md)（AI-Native 技能速查）。

---

*迁移目标：6 个月内完成 AI-Native 岗位体系建立 | v1.0 | 2026-03-27*
