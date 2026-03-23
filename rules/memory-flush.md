# 💾 记忆保存机制（多岗位版）

> 不依赖人工的自动工作记录与数据保存，支持多角色协作

## 目录结构

```
memory/
├── .index/                    # 索引目录（跨角色共享）
│   ├── today-overview.md      # 今日全局概览
│   ├── active-tasks.json      # 跨角色任务注册表
│   └── roles/                 # 角色状态索引
│       ├── backend.json
│       ├── frontend.json
│       ├── pm.json
│       └── qa.json
│
├── roles/                     # 按角色存储
│   ├── backend/
│   │   ├── today.md          # 今日工作
│   │   ├── 2024-01-01.md    # 历史记录
│   │   └── tasks/locked/    # 被锁定的任务
│   ├── frontend/
│   ├── pm/
│   ├── qa/
│   ├── devops/
│   └── architect/
│
├── persons/                   # 按人员存储（基于 git user）
│   └── {git-user}@email.com/
│       ├── today.md
│       └── 2024-01-01.md
│
├── shared/                    # 共享文档
│   ├── projects.md
│   ├── goals.md
│   ├── retrospectives/
│   └── audit-logs/
│
└── lock/                      # 任务锁
    └── conductor-tasks.json
```

---

## 角色识别

### 配置文件

在 `.claude/project-config.json` 中配置：

```json
{
  "currentRole": "fullstack",
  "gitUser": "alice@company.com",
  "team": "api-feature"
}
```

### 识别优先级

| 优先级 | 方式 | 配置位置 | 说明 |
|--------|------|----------|------|
| 1 | 配置文件 | `.claude/project-config.json` | `currentRole` 字段 |
| 2 | Worktree 路径 | git worktree | 从路径推断角色 |
| 3 | CLAUDE.md | 分析角色定义 | 自动推断 |

### 启动参数

```bash
claude --role=frontend
claude --role=backend --git-user=bob@company.com
```

---

## 触发时机

### 自动触发
- 每个会话结束时
- 完成重要里程碑后
- 长时间空闲后

### 手动触发
- 使用 `/session-end` 命令
- 用户要求保存时

---

## 保存流程

```
1. 识别角色
      ↓
2. 检测任务锁
      ↓
3. 收集状态
      ↓
4. 同步写入
   ├── roles/{role}/today.md
   ├── persons/{git-user}/today.md
   └── .index/today-overview.md
      ↓
5. 更新任务状态
      ↓
6. 释放任务锁
      ↓
7. 自动 commit（可选）
```

---

## 保存内容

### 1. 角色今日工作 (roles/{role}/today.md)

```markdown
# 📅 2024-01-01 后端工作日志

## 角色
- **角色**: backend
- **人员**: alice@company.com
- **团队**: api-feature

## 今日完成
- [x] 用户登录 API 实现
- [x] JWT 认证中间件

## 今日待办
- [ ] 用户注册 API
- [ ] 密码重置功能

## 问题与解决方案
- Q: JWT 过期时间配置
- A: 使用环境变量 JWT_EXPIRES_IN 控制

## 明日计划
- 完善用户资料模块
- 添加头像上传功能

## 涉及文件
- src/backend/auth/login.ts
- src/backend/auth/jwt.ts
```

### 2. 人员今日工作 (persons/{git-user}/today.md)

```markdown
# 📅 2024-01-01 alice@company.com 工作日志

## 角色: backend
## 团队: api-feature

## 工作内容
- [x] 用户登录 API
- [x] JWT 认证中间件

## 协作记录
- @frontend: 确认 API 返回格式
- @qa: 提供测试用例
```

### 3. 跨角色概览 (.index/today-overview.md)

```markdown
# 📅 2024-01-01 团队工作概览

## 后端 (backend)
- ✅ 用户登录 API
- 🔄 用户注册 API

## 前端 (frontend)
- ✅ 登录页面 UI
- 🔄 注册页面 UI

## 产品 (pm)
- 📋 审核 PRD v2.0

## QA
- 🔍 准备测试计划

## 跨角色依赖
- backend.login_api → frontend.login_page
- backend.login_api → qa.test_cases
```

### 4. 任务注册表 (.index/active-tasks.json)

```json
{
  "tasks": [
    {
      "id": "task-001",
      "title": "用户认证系统",
      "status": "in_progress",
      "role": "backend",
      "owner": "alice@company.com",
      "created": "2024-01-01T09:00:00Z",
      "updated": "2024-01-01T15:30:00Z",
      "locked": true,
      "locked_by": "claude-backend-session-123",
      "dependencies": []
    }
  ]
}
```

---

## 任务锁机制

### 加锁规则

修改共享文件前必须加锁：

```bash
# 1. 检查锁状态
cat memory/lock/conductor-tasks.json | jq '.locks[] | select(.file=="src/backend/auth.ts")'

# 2. 尝试加锁
# 在 conductor-tasks.json 中添加：
{
  "locks": [{
    "file": "src/backend/auth.ts",
    "owner": "alice@company.com",
    "role": "backend",
    "status": "active",
    "locked_at": "2024-01-01T10:00:00Z"
  }]
}

# 3. 执行操作...

# 4. 释放锁
```

### 锁超时

- 默认锁超时：30 分钟
- 超时后自动释放
- 可手动续期

---

## 自动保存规则

### 最小保存间隔
- 每次会话结束必须保存
- 重大改动后立即保存

### 保存优先级

| 优先级 | 文件 | 说明 |
|--------|------|------|
| P0 | roles/{role}/today.md | 角色工作日志 |
| P0 | persons/{git-user}/today.md | 人员工作日志 |
| P1 | .index/active-tasks.json | 任务状态 |
| P1 | .index/today-overview.md | 全局概览 |
| P2 | shared/projects.md | 项目状态 |

---

## 跨会话恢复

### 启动时检查

```bash
# 1. 识别角色
cat .claude/settings.json | jq '.role'

# 2. 读取今日工作
cat memory/roles/backend/today.md

# 3. 读取人员日志
GIT_USER=$(git config user.email)
cat memory/persons/$GIT_USER/today.md

# 4. 读取全局概览
cat memory/.index/today-overview.md

# 5. 检查任务锁
cat memory/lock/conductor-tasks.json
```

### 状态同步

- 本地文件优先
- Git 远程备份
- 冲突时保留两版

---

## Git 集成

### 自动 Commit

```bash
# 提交记忆文件
git add memory/
git commit -m "chore(memory): 更新 $(date +%Y-%m-%d) 工作记忆 [role:backend]"

# 按角色提交
git add memory/roles/backend/
git commit -m "chore(memory): 后端工作日志 $(date +%Y-%m-%d)"
```

### 分支策略

- 使用 `memory/` 目录独立分支
- 定期与主分支合并

---

## 清理规则

### 归档
- 超过 7 天的 today.md 移至角色目录下的历史文件夹
- 超过 30 天的任务标记为已完成/已取消

### 保留
- projects.md - 永久保留
- goals.md - 永久保留
- retrospectives/ - 永久保留

---

## 协作命令

```bash
# 查看自己的今日工作
cat memory/roles/backend/today.md

# 查看团队今日概览
cat memory/.index/today-overview.md

# 查看任务锁状态
cat memory/lock/conductor-tasks.json

# 按人员查看
GIT_USER=$(git config user.email)
cat memory/persons/$GIT_USER/today.md
```
