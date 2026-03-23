# Custom Skills

项目自定义技能库，基于 AI Native 方法论构建。

## 目录结构

```
custom-skills/
├── README.md                    # 本文件
├── ai-native-scaffold-init/     # 项目初始化
├── context-handoff/            # 上下文交接
├── team-collaboration/          # 团队协作
└── [your-skill]/               # 添加你的技能
```

## 已有技能

| 技能 | 用途 |
|------|------|
| `ai-native-scaffold-init` | 基于脚手架初始化新项目 |
| `context-handoff` | 跨会话上下文恢复 |
| `team-collaboration` | 多 AI 并发协作 |

## 添加新技能

### 1. 创建技能目录

```bash
mkdir -p custom-skills/your-skill-name
```

### 2. 创建 SKILL.md

每个技能至少包含：

```markdown
# Skill Name

简短描述。

## 使用场景
何时触发这个技能。

## 工作流程
步骤列表。

## 示例
使用示例。
```

### 3. 注册到项目

编辑 `.claude/settings.json`：

```json
{
  "skills": [
    "custom-skills/your-skill-name"
  ]
}
```

## 技能规范

### 命名

- 使用 `kebab-case`
- 简洁明了
- 避免与其他技能重名

### 结构

```
your-skill/
├── SKILL.md          # 必需：技能定义
├── metadata.json     # 可选：元数据
└── [辅助文件]        # 可选：脚本、模板等
```

### SKILL.md 结构

```markdown
# 技能名称

## 使用场景
## 前置条件
## 工作流程
## 检查清单
## 示例
## 注意事项
```

## 最佳实践

1. **单一职责** - 每个技能只做一件事
2. **明确触发** - 清楚说明何时使用
3. **步骤清晰** - 列出具体操作步骤
4. **包含示例** - 提供使用示例
5. **版本标注** - 记录创建/更新时间

---

*创建自定义技能，让 AI 更懂你的工作方式。*
