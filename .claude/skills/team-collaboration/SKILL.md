# Team Collaboration

多 AI 并发协作与任务协调。

## 使用场景

- 启动多个 AI 窗口并行工作
- 协调前端/后端 AI 并发开发
- 避免任务冲突

## 工作流程

### 1. 创建团队

```bash
# 创建团队
TeamCreate --team_name "feature-xxx" --description "功能开发团队"

# 或使用 worktree
git worktree add ../workspace-feature-x feature/x
```

### 2. 分配任务

使用 Task 工具创建任务：

```bash
# 创建任务
TaskCreate --content "实现用户认证 API" --owner "backend-ai"

TaskCreate --content "实现登录页面 UI" --owner "frontend-ai"

TaskCreate --content "编写集成测试" --owner "qa-ai"
```

### 3. 任务锁机制

在 `memory/conductor-tasks.json` 中记录锁：

```json
{
  "locks": [
    {
      "task_id": "xxx",
      "owner": "backend-ai",
      "file": "src/backend/auth/",
      "status": "active",
      "started_at": "2024-01-01T10:00:00Z"
    }
  ]
}
```

### 4. 协调规则

| 规则 | 说明 |
|------|------|
| 单一职责 | 每个 AI 只负责一个模块 |
| 文件锁 | 同一文件同一时间只能被一个 AI 编辑 |
| 提交原子性 | 每次提交只包含一个功能 |
| 定期同步 | 每 30 分钟同步一次进度 |

### 5. 冲突解决

如果发现冲突：

```
⚠️ 任务冲突检测

冲突文件: src/backend/user.ts
当前持有: backend-ai
请求者: frontend-ai

解决方案:
1. frontend-ai 等待 backend-ai 完成
2. 或者拆分文件，frontend 负责 UI 部分
```

## 团队配置示例

### 前端 + 后端团队

```
Team: api-feature
├── backend-ai  → src/backend/api/
├── frontend-ai → src/frontend/
└── reviewer-ai → 审查所有变更
```

### 多功能并行团队

```
Team: sprint-xxx
├── auth-team   → 认证模块
├── payment-team → 支付模块
└── ui-team    → UI 组件
```

## 完成后

- 更新 `memory/today.md`
- 同步任务状态到 `memory/active-tasks.json`
- 清理无用的 worktree
