# AI Native Scaffold v2.0 设计文档

**日期**: 2026-03-24
**状态**: 已审批，待实施
**范围**: 内部标准脚手架完整强化（方式 A：原地改造）

---

## 背景与目标

当前脚手架（v1.0）存在结构性问题，影响多团队（D 用途）落地：

- Memory 文件三层重复，路径冲突
- 初始化脚本缺失
- 技术栈写死（Node.js），不支持 Java/Python 后端
- 无版本管理，无 Subtree 同步机制
- 任务锁机制依赖 JSON 文件，存在竞态风险

目标：升级为 v2.0，支持中型团队（5-20人）多角色并发协作，可作为内部标准通过 git subtree 分发。

---

## 设计总览

### 段 1：目录结构统一

**改动：**

1. `custom-skills/` 迁移到 `.claude/skills/`，删除 `custom-skills/` 目录
2. `memory/` 根目录孤立文件删除（`today.md`、`active-tasks.json`、`conductor-tasks.json`）
3. 新增文件：
   - `SCAFFOLD_VERSION` — 脚手架版本号（如 `2.0.0`）
   - `CHANGELOG.md` — 版本变更记录
   - `CLAUDE.local.md.template` — 本地覆盖模板（实际文件加入 `.gitignore`）
4. `.claude/commands/` 补充 `switch-role.md`
5. `scripts/` 目录新增 `replace-placeholders.sh` 和 `lock.sh`

**最终结构：**

```
.
├── CLAUDE.md
├── CLAUDE.local.md.template     # 本地覆盖模板
├── SCAFFOLD_VERSION             # 2.0.0
├── CHANGELOG.md
├── README.md
│
├── .claude/
│   ├── agents/                  # 不变
│   ├── commands/
│   │   ├── switch-role.md       # 新增
│   │   └── ...（现有）
│   ├── rules/                   # 不变
│   ├── skills/
│   │   ├── gstack/
│   │   ├── ai-native-scaffold-init/   # 从 custom-skills/ 迁入
│   │   ├── context-handoff/           # 从 custom-skills/ 迁入
│   │   ├── team-collaboration/        # 从 custom-skills/ 迁入
│   │   └── ...（现有 gstack 技能）
│   └── project-config.json      # 增加 scaffoldVersion 字段
│
├── scripts/
│   ├── replace-placeholders.sh  # 补全
│   └── lock.sh                  # 新增
│
├── templates/                   # 新增，技术栈模板
│   ├── frontend/
│   │   ├── react/
│   │   ├── vue/
│   │   └── next/
│   └── backend/
│       ├── java/
│       └── python/
│
├── memory/                      # 见段 2
├── docs/                        # 见段 6
├── src/                         # 见段 1b
├── tests/
└── ops/
```

### 段 1b：src/ 结构

前端支持 React / Vue / Next.js，后端主力 Java(Spring Boot) / Python(FastAPI)：

```
src/
├── frontend/     # 技术栈选定后替换，README 提供三套结构模板
├── backend/      # 技术栈选定后替换，README 提供 Java/Python 两套模板
└── shared/       # 前后端共享：API 类型定义、枚举、常量
    ├── types/
    └── constants/
```

`src/backend/README.md` 提供两套模板：

**Java/Spring Boot：**
```
backend/
├── src/main/java/com/{company}/{project}/
│   ├── controller/
│   ├── service/
│   ├── repository/
│   ├── model/
│   │   ├── entity/
│   │   └── dto/
│   └── config/
└── src/main/resources/
    └── application.yml
```

**Python/FastAPI：**
```
backend/
├── app/
│   ├── api/          # 路由层
│   ├── services/     # 业务逻辑
│   ├── models/       # ORM 模型
│   ├── schemas/      # Pydantic 模型
│   └── core/         # 配置、依赖注入
├── tests/
└── pyproject.toml
```

---

### 段 2：Memory 系统

**删除孤立根文件：**
- `memory/today.md`
- `memory/active-tasks.json`
- `memory/conductor-tasks.json`

**统一结构：**

```
memory/
├── .index/
│   ├── today-overview.md        # 团队日志聚合（context-handoff 生成）
│   ├── active-tasks.json        # 跨角色任务注册表（唯一权威来源）
│   └── roles/
│       ├── frontend.json
│       ├── backend.json
│       └── qa.json
│
├── roles/
│   ├── {role}/
│   │   ├── today.md             # 角色今日日志（AI 会话结束写入）
│   │   └── YYYY-MM-DD.md        # 历史归档
│
├── persons/
│   └── {git-user-email}/
│       └── today.md
│
├── lock/
│   └── conductor-tasks.json     # 协调记录（降级为人工可读，锁由 .lock 文件控制）
│
└── shared/
    ├── projects.md
    ├── goals.md
    └── retrospectives/
```

**写入规则：**

| 写入者 | 路径 | 时机 |
|--------|------|------|
| 角色 AI | `roles/{role}/today.md` | 会话结束 |
| 角色 AI | `persons/{git-user}/today.md` | 会话结束 |
| 角色 AI | `.index/roles/{role}.json` | 会话结束（快照） |
| context-handoff | `.index/today-overview.md` | 聚合生成 |
| lock.sh | `lock/*.lock` | 加锁/释放 |

**context-handoff 技能读取路径修正：**
```
1. 读 .claude/project-config.json → 获取 currentRole
2. 读 memory/roles/{role}/today.md → 角色日志
3. 读 memory/.index/active-tasks.json → 任务状态
4. 读 memory/lock/conductor-tasks.json → 锁状态
```

---

### 段 3：版本管理 + Subtree 同步

**版本文件：**
- `SCAFFOLD_VERSION`：内容为 `2.0.0`
- `CHANGELOG.md`：记录 breaking changes 和新特性
- `project-config.json` 增加 `"scaffoldVersion": "2.0.0"` 字段

**Subtree 方案（不用 submodule）：**

消费项目结构：
```
消费项目/
├── .scaffold/     # git subtree 追踪目录，禁止手动修改
├── .claude/       # 从 .scaffold/ 初始化后复制，可自定义
├── memory/
├── docs/
└── src/
```

操作命令：
```bash
# 初次接入
git remote add scaffold git@your-git/ai-native-scaffold.git
git subtree add --prefix=.scaffold scaffold main --squash
bash .scaffold/scripts/replace-placeholders.sh "项目名" "next" "java"

# 拉取更新
git subtree pull --prefix=.scaffold scaffold main --squash
```

可自定义范围（不受 subtree pull 影响）：
- `.claude/rules/`（可增加项目规则）
- `.claude/agents/`（可增加项目 Agent）
- `docs/`、`memory/`、`src/`（完全自有）

---

### 段 4：任务锁重设计

**锁文件方案**（替代纯 JSON）：

```bash
# scripts/lock.sh acquire <task-id> <role>
# scripts/lock.sh release <task-id>
# scripts/lock.sh status

LOCK_DIR="memory/lock"

acquire() {
  LOCK_FILE="$LOCK_DIR/$1.lock"
  if [ -f "$LOCK_FILE" ]; then
    HOLDER=$(cat "$LOCK_FILE" | cut -d: -f1)
    echo "❌ 任务 $1 已被 $HOLDER 持有"
    exit 1
  fi
  echo "$2:$$:$(date -u +%s)" > "$LOCK_FILE"
  echo "✅ $2 已锁定任务 $1"
}

release() {
  rm -f "$LOCK_DIR/$1.lock"
  echo "🔓 任务 $1 已释放"
}
```

规则：
- `.lock` 文件格式：`{role}:{PID}:{timestamp}`
- 30 分钟无续期自动过期（由 `lock.sh status` 检查清理）
- `conductor-tasks.json` 保留为协调记录（人工可读），不作锁源

---

### 段 5：初始化脚本

**`scripts/replace-placeholders.sh`：**

```bash
#!/bin/bash
# 用法：./scripts/replace-placeholders.sh <项目名> <frontend:react|vue|next> <backend:java|python>
PROJECT_NAME=$1
FRONTEND=${2:-react}
BACKEND=${3:-java}

# 替换文档占位符
find . \( -name "*.md" -o -name "*.json" \) \
  -not -path "./.git/*" -not -path "./node_modules/*" \
  -exec sed -i.bak "s/\[项目名称\]/$PROJECT_NAME/g" {} \;
find . -name "*.bak" -delete

# 复制技术栈模板
[ -d "templates/frontend/$FRONTEND" ] && \
  cp -r templates/frontend/$FRONTEND/* src/frontend/
[ -d "templates/backend/$BACKEND" ] && \
  cp -r templates/backend/$BACKEND/* src/backend/

# 更新 project-config.json
node -e "
  const fs = require('fs');
  const cfg = JSON.parse(fs.readFileSync('.claude/project-config.json', 'utf8'));
  cfg.project = '$PROJECT_NAME';
  cfg.version = '1.0.0';
  fs.writeFileSync('.claude/project-config.json', JSON.stringify(cfg, null, 2));
"

echo "✅ 初始化完成：$PROJECT_NAME (frontend:$FRONTEND + backend:$BACKEND)"
echo ""
echo "下一步："
echo "  1. 编辑 .claude/project-config.json 配置团队角色"
echo "  2. 启动 AI 助手，运行 /plan-ceo 开始规划"
```

---

### 段 6：文档补全清单

| 文件 | 动作 | 内容 |
|------|------|------|
| `docs/00_ai_system/subtree-guide.md` | 新建 | 接入、更新、冲突解决完整手册 |
| `docs/06_skills/roles/ROLE_SETUP.md` | 补充 | 各角色技能配置说明 |
| `src/frontend/README.md` | 改写 | React/Vue/Next 三套结构模板 |
| `src/backend/README.md` | 改写 | Java/Python 两套结构模板 |
| `CLAUDE.local.md.template` | 新建 | 本地覆盖示例 |
| `.claude/commands/switch-role.md` | 新建 | 角色切换命令 |
| `CHANGELOG.md` | 新建 | v2.0.0 变更记录 |
| `.gitignore` | 更新 | 增加 `CLAUDE.local.md` |

---

## 实施顺序

1. 目录结构整理（删孤立文件、迁移 custom-skills）
2. Memory 系统修正（删根文件、修 context-handoff）
3. `scripts/` 补全（replace-placeholders.sh、lock.sh）
4. `templates/` 创建（frontend 3套 + backend 2套）
5. 文档补全（subtree-guide、README 改写等）
6. 版本文件（SCAFFOLD_VERSION、CHANGELOG）
7. `project-config.json` 更新
8. README.md 修正结构图
9. 提交 v2.0.0

---

*设计者：Claude Code + chenguangwei，2026-03-24*
