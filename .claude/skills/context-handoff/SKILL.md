# Context Handoff

跨会话上下文交接，确保 AI 在新会话中快速恢复工作状态。

## 使用场景

- 用户开始新的会话
- 从断点继续工作
- 多 AI 窗口协同

## 工作流程

### 1. 读取配置，确认当前角色

```bash
ROLE=$(python3 -c "import json; print(json.load(open('.claude/project-config.json'))['currentRole'])")
GIT_USER=$(git config user.email)
echo "当前角色: $ROLE，操作者: $GIT_USER"
```

### 2. 读取角色日志和任务状态

```bash
# 角色今日工作
cat memory/roles/$ROLE/today.md 2>/dev/null || echo "（今日暂无日志）"

# 跨角色任务注册表
cat memory/.index/active-tasks.json 2>/dev/null || echo "（暂无活跃任务）"

# 任务锁状态
ls memory/lock/*.lock 2>/dev/null && cat memory/lock/*.lock || echo "（无任务锁）"
```

### 3. 输出上下文恢复摘要

在对话开始时输出：

```
📋 上下文恢复 [角色: {ROLE}]

上次工作: [从 today.md 提取]
活跃任务: [从 active-tasks.json 提取]
锁状态: [从 lock/*.lock 提取]

是否继续上次工作，还是开始新任务？
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
├── roles/{role}/today.md         # 角色今日日志（规范路径）
├── .index/active-tasks.json      # 跨角色任务注册表
└── lock/conductor-tasks.json     # 任务协调记录
```

## 注意事项

- 每次会话开始时自动触发
- 优先读取 `memory/today.md`
- 确保不重复已完成的工作
- 检查任务锁避免冲突
