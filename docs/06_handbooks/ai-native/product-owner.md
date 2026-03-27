# 📋 产品负责人操作手册

> 适用于产品负责人角色，基于 AI 原生开发方法论

---

## 角色配置

### 1. 配置当前角色

编辑 `.claude/project-config.json`:

```json
{
  "currentRole": "product-owner",
  "gitUser": "your@email.com",
  "team": "product-team"
}
```

### 2. 验证配置

```bash
cat .claude/project-config.json | grep currentRole
```

---

## 日常操作流程

### 1. 启动工作

```bash
# 查看今日任务
cat memory/roles/product-owner/today.md

# 查看产品文档
cat docs/01_product/prd_v1.0.md
cat docs/01_product/business_rules.md
```

### 2. 规划新功能

**使用产品思维:**

```
/plan-ceo-review        # CEO 视角审视
/design-consultation    # 设计咨询
/office-hours          # YC 办公时间
```

---

## 常用命令

### 产品规划

| 命令 | 用途 |
|------|------|
| `/plan-ceo-review` | 产品方向审视 |
| `/plan-design-review` | 设计可行性审视 |
| `/plan-eng-review` | 技术实现审视 |
| `/office-hours` | YC 办公时间 |

### 文档管理

| 命令 | 用途 |
|------|------|
| `/document-release` | 发布后文档更新 |

### 设计协作

| 命令 | 用途 |
|------|------|
| `/design-consultation` | 设计方向咨询 |
| `/design-review` | 设计质量审查 |

---

## Memory 操作

### 每日开始

```bash
cat memory/roles/product-owner/today.md
cat docs/01_product/prd_v1.0.md
```

### 每日结束

```markdown
# 更新 memory/roles/product-owner/today.md
- 记录今日完成的需求评审
- 记录待处理的需求
- 记录需求变更
```

---

## 项目文档

```
docs/01_product/
├── prd_v1.0.md         # 产品需求文档
├── business_rules.md    # 业务规则
└── roadmap.md          # 产品路线图
```

---

## 产品工作流程

### 1. 需求收集

```
1. 与利益相关者沟通
2. 记录需求
3. 优先级排序
```

### 2. 需求评审

```
/plan-ceo-review → 审视产品价值
/plan-design-review → 审视设计可行性
/plan-eng-review → 审视技术实现
```

### 3. 需求文档

```markdown
# 更新 docs/01_product/prd_v1.0.md
- 功能描述
- 用户故事
- 验收标准
- 优先级
```

### 4. 进度跟踪

```markdown
# 更新 memory/roles/pm/today.md
# 更新 memory/.index/today-overview.md
```

---

## 与开发协作

### 与前端协作

1. 提供设计稿
2. 确认交互细节
3. 验收 UI

### 与后端协作

1. 提供 API 需求
2. 确认数据格式
3. 验收功能

### 与 QA 协作

1. 提供验收标准
2. 确认测试用例
3. 验收测试结果

---

## 技能触发规则

### 新功能规划

```
/brainstorming → /plan-ceo-review → /writing-plans → /design-consultation → 编写 PRD
```

### 设计评审

```
/design-consultation → /design-review → 反馈
```

### 发布

```
/document-release → 更新文档
```

---

*基于 AI 原生开发方法论 v1.1*
