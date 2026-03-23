# Context Handoff

跨会话上下文交接，确保 AI 在新会话中快速恢复工作状态。

## 使用场景

- 用户开始新的会话
- 从断点继续工作
- 多 AI 窗口协同

## 工作流程

### 1. 读取记忆文件

```bash
# 读取今日任务
cat memory/today.md

# 读取活跃任务
cat memory/active-tasks.json

# 读取 conductor 锁
cat memory/conductor-tasks.json
```

### 2. 分析上下文状态

检查以下文件获取当前进度：

| 文件 | 内容 | 优先级 |
|------|------|--------|
| `memory/today.md` | 今日工作日志 | 高 |
| `memory/active-tasks.json` | 跨会话任务 | 高 |
| `.claude/tasks/` | 当前任务列表 | 中 |

### 3. 恢复上下文

在对话开始时输出：

```
📋 上下文恢复

上次工作: [任务描述]
中断位置: [文件:行号或步骤]
待完成任务:
- [ ] 任务 1
- [ ] 任务 2

继续中...
```

### 4. 同步锁状态

如果是多窗口协作，检查 conductor 锁：

```bash
# 检查是否有被锁定的任务
cat memory/conductor-tasks.json | jq '.locks[] | select(.status=="active")'
```

### 5. 确认人类意图

```
我看到上次我们在做 [任务]。
是否继续这个任务，还是开始新工作？
```

## 关键文件

```
memory/
├── today.md              # 今日日志
├── active-tasks.json     # 活跃任务
├── conductor-tasks.json  # 任务锁
└── projects.md          # 项目大盘
```

## 注意事项

- 每次会话开始时自动触发
- 优先读取 `memory/today.md`
- 确保不重复已完成的工作
- 检查任务锁避免冲突
