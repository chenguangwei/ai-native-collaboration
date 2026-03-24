# ⚡ Commands 命令集合

> 快速触发的轻量级任务

## Commands vs Skills

| 特性 | Commands | Skills |
|------|----------|--------|
| 复杂度 | 简单，一个文件 | 复杂，多个相关文件 |
| 结构 | 单个 `.md` 文件 | `SKILL.md` + 关联文件 |
| 适用场景 | 快速触发单一任务 | 需要详细指导的工作流 |
| 示例 | `/review` 审查代码 | `/browse` 浏览器自动化 |

### Commands - 轻量快捷

**Commands 就是一个文件**，里面写了要干什么。

```
commands/
├── review.md    # 触发代码审查
├── debug.md    # 触发调试模式
└── qa.md       # 触发测试
```

当你输入 `/review` 时，Claude 读取 `commands/review.md`，按照文件里的步骤执行。

### Skills - 复杂工作流

**Skills 可以带一堆相关文件**。SKILL.md 文件里可以引用其他文件：

```markdown
# SKILL.md

@DETAILED_GUIDE.md     <!-- 去读旁边的详细规则 -->
@../utils/helper.ts    <!-- 引用工具函数 -->

## 执行步骤
1. 读取 DETAILED_GUIDE.md
2. 按照规则执行...
```

这样 skill 就能用那个详细文件里的内容，适合复杂的工作流。

## 快速开始

```bash
# 触发命令
/review     # 代码审查
/debug      # 调试模式
/qa         # 自动化测试
/ship       # 发布检查
/retro      # 复盘报告
```

## 创建新命令

在 `commands/` 目录下创建 `.md` 文件：

```markdown
# /my-command - 命令名称

> 简短描述

## 执行步骤

1. 第一步做什么
2. 第二步做什么
3. 输出什么结果
```

文件名即为命令名：`my-command.md` → `/my-command`
