# 💾 Memory 目录说明

> 多角色协作的记忆管理系统

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
│       ├── qa.json
│       ├── devops.json
│       └── architect.json
│
├── roles/                     # 按角色存储
│   ├── backend/              # 后端工程师
│   ├── frontend/             # 前端工程师
│   ├── pm/                   # 产品经理
│   ├── qa/                   # QA 测试
│   ├── devops/               # 运维工程师
│   └── architect/             # 架构师
│
├── persons/                   # 按人员存储（基于 git user）
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

## 快速开始

### 1. 配置角色

在 `.claude/settings.json` 中添加：

```json
{
  "role": "backend",
  "git-user": "your@email.com",
  "team": "feature-team"
}
```

### 2. 查看今日工作

```bash
# 查看团队概览
cat memory/.index/today-overview.md

# 查看自己角色的工作
cat memory/roles/backend/today.md

# 按人员查看
PERSON=$(git config user.email | tr '@' '_')
cat memory/persons/$PERSON/today.md
```

### 3. 任务锁

修改共享文件前检查锁：

```bash
cat memory/lock/conductor-tasks.json | jq '.locks[] | select(.status=="active")'
```

## 角色 Memory 模板

每个角色在 `memory/roles/{role}/` 下有：

- `today.md` - 今日工作日志
- `YYYY-MM-DD.md` - 历史记录
- `tasks/locked/` - 被锁定的任务

## 协作规则

1. **读取优先** - 修改前先读取最新状态
2. **加锁执行** - 修改共享文件前加锁
3. **及时释放** - 操作完成后立即释放锁
4. **同步写入** - 同时更新 roles/ 和 persons/ 目录

## 详见

- [记忆保存机制](../rules/memory-flush.md)
