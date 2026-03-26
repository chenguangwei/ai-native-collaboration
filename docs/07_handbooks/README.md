# 📚 AI 原生开发操作手册

> 基于 AI 原生开发方法论的角色操作指南

---

## 手册目录

### 全流程视角（推荐先读）

| 手册 | 描述 |
|------|------|
| [handbook-product-workflow.md](handbook-product-workflow.md) | 产品全流程手册：产品→研发→测试→运维完整交付链路 |

### 角色专项手册

| 角色 | 手册 | 描述 |
|------|------|------|
| 产品 | [handbook-pm.md](handbook-pm.md) | 产品经理工作指南 |
| 前端 | [handbook-frontend.md](handbook-frontend.md) | 前端工程师开发指南 |
| 后端 | [handbook-backend.md](handbook-backend.md) | 后端工程师开发指南 |
| 全栈 | [handbook-fullstack.md](handbook-fullstack.md) | 全栈工程师完整工作流程 |
| QA | [handbook-qa.md](handbook-qa.md) | 测试工程师工作指南 |
| 运维 | [handbook-devops.md](handbook-devops.md) | 运维工程师部署指南 |

---

## 快速开始

### 1. 配置角色

编辑 `.claude/project-config.json`:

```json
{
  "currentRole": "your-role",  // fullstack/frontend/backend/pm/qa/devops
  "gitUser": "your@email.com",
  "team": "your-team"
}
```

### 2. 启动工作

```bash
# 查看今日任务
cat memory/roles/{role}/today.md

# 查看团队概览
cat memory/.index/today-overview.md
```

### 3. 开始工作

```
# 使用 brainstorming 技能
/brainstorming
```

---

## 常用命令速查

### 开发流程

| 阶段 | 命令 |
|------|------|
| 头脑风暴 | `/brainstorming` |
| 编写计划 | `/writing-plans` |
| 执行计划 | `/executing-plans` |
| TDD 开发 | `/test-driven-development` |
| 完成验证 | `/verification-before-completion` |

### 质量保证

| 命令 | 用途 |
|------|------|
| `/review` | 代码审查 |
| `/qa` | 自动化测试 |
| `/ship` | 发布检查 |

### 调试

| 命令 | 用途 |
|------|------|
| `/systematic-debugging` | 结构化调试 |
| `/investigate` | 根因调查 |

---

## 角色技能矩阵

| 角色 | 核心技能 |
|------|----------|
| 全栈 | brainstorming → TDD → review → ship |
| 前端 | frontend-design → react-best-practices → qa |
| 后端 | test-driven-development → review → ship |
| 产品 | plan-ceo-review → design-consultation → document-release |
| QA | qa → design-review → audit |
| 运维 | ship → qa → systematic-debugging |

---

## Memory 工作流

### 每日开始

```bash
cat memory/roles/{role}/today.md
cat memory/.index/today-overview.md
cat memory/lock/conductor-tasks.json
```

### 每日结束

```markdown
# 更新以下文件:
1. memory/roles/{role}/today.md
2. memory/persons/{git-user}/today.md
3. memory/.index/today-overview.md
4. memory/.index/active-tasks.json
```

---

## 相关文档

- [角色配置指南](06_skills/roles/ROLE_SETUP.md)
- [Skills 索引](../06_skills/SKILLS_INDEX.md)
- [记忆保存机制](../rules/memory-flush.md)
- [项目配置](../.claude/project-config.json)

---

*基于 AI 原生开发方法论 v1.1*
