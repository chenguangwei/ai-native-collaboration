# ⚡ Commands 命令集合

> 轻量级任务触发器 — 输入 `/命令名` 即可执行

## Commands vs Skills vs Agents

| 特性 | Commands | Skills | Agents |
|------|----------|--------|--------|
| 复杂度 | 简单，单文件 | 复杂，多文件工作流 | 独立子任务 |
| 结构 | 单个 `.md` 文件 | `SKILL.md` + 关联文件 | `.md` + YAML frontmatter |
| 运行方式 | 主对话内执行 | 主对话内执行 | **后台独立运行** |
| 适用场景 | 快速触发单一任务 | 需要详细指导的工作流 | 大规模分析、审查 |

---

## 可用命令

| 命令 | 文件 | 用途 |
|------|------|------|
| `/plan-ceo` | `plan-ceo.md` | 唤醒产品思维，输出高优 PRD |
| `/plan-architect` | `plan-architect.md` | 唤醒架构师思维，CTO 级技术推演 |
| `/review` | `review.md` | 代码审查 |
| `/qa` | `qa.md` | 触发自动化测试 |
| `/ship` | `ship.md` | 发版前检查清单 |
| `/debug` | `debug.md` | 启动结构化排障 |
| `/retro` | `retro.md` | 生成迭代复盘报告 |
| `/switch-role` | `switch-role.md` | 切换工作角色（fullstack/frontend/backend/pm/qa/devops/architect）|

---

## 快速使用

```bash
# 产品规划
/plan-ceo        # 输出高优 PRD

# 技术架构
/plan-architect  # CTO 级推演

# 开发质量
/review          # 代码审查
/qa              # 自动化测试

# 发布流程
/ship            # 发版检查

# 排障
/debug           # 结构化排障

# 复盘
/retro           # 迭代复盘

# 角色切换
/switch-role     # 切换开发角色
```

---

## 创建新命令

在此目录下创建 `.md` 文件，文件名即为命令名：

```markdown
# /my-command — 命令描述

> 简短说明

## 执行步骤

1. 第一步...
2. 第二步...
3. 输出结果...
```

`my-command.md` → 输入 `/my-command` 即可触发。

---

## 与 Skills 的区别

Commands 适合**快速单次触发**，Skills 适合**复杂多步骤工作流**：

```
Commands (此目录):
  /debug → 快速启动排障模式

Skills (.claude/skills/ 或 .agents/skills/):
  /systematic-debugging → 详细的 5 步排障方法论 + 工具调用规范
```

更多技能参见 [Skills 速查索引](../../docs/06_skills/SKILLS_INDEX.md)。
