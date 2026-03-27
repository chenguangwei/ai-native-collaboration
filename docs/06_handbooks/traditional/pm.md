# 产品经理操作手册

> 过渡期版。参考 [README.md](README.md) 了解完整团队协作流程。

---

## 角色配置

```json
{
  "currentRole": "product-owner",
  "gitUser": "pm@company.com"
}
```

---

## 核心工作流

### 1. 需求挖掘

```
/deep-interview "用户反馈：..."
```
Socratic 提问，歧义降到 20% 以下再动笔写 PRD。

### 2. 产品方向审视

```
/plan-ceo-review   → CEO 视角，拷问用户价值
/office-hours      → YC 式压力测试，找假设弱点
```

### 3. 复杂功能规划

```
/ralplan
```
Planner → Architect → Critic 三角评审，输出带风险评估的规划。

### 4. 迭代复盘

```
/retro
```

---

## PRD 必含要素

```markdown
## 用户故事
As a [用户]，I want [功能]，So that [价值]

## 验收标准（AC）
- AC-01: Given ... When ... Then ...

## 技术约束
- 性能 / 安全 / 兼容要求

## 优先级
- RICE 评分
```

**AC 即测试用例来源，必须可量化。**

---

## 与研发交接检查清单

- [ ] PRD 写入 `docs/01_product/prd_{feature}.md`
- [ ] 所有 AC 明确且可量化
- [ ] 设计稿链接写入 PRD
- [ ] `memory/.index/active-tasks.json` 已更新状态

---

## 推荐 Agents

| Agent | 用途 |
|-------|------|
| `analyst`（内置）| 需求结构化分析 |
| `omc-analyst` | 复杂需求拆解 |
| `omc-critic` | 挑战产品假设 |
