# Scaffold v2.0 Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 将 AI Native 脚手架从 v1.0 升级到 v2.0，修复结构性问题，支持 Java/Python 后端多技术栈，建立 git subtree 分发机制。

**Architecture:** 原地改造（方式 A）。按顺序处理：目录清理 → Memory 修正 → 脚本补全 → 模板创建 → 文档补全 → 版本文件。每个任务独立提交，保持历史可追溯。

**Tech Stack:** Bash, Markdown, JSON。无需 Node.js 依赖（脚本用纯 bash）。

**Design Doc:** `docs/plans/2026-03-24-scaffold-v2-design.md`

---

### Task 1: 清理孤立的 memory 根文件 + 迁移 custom-skills

**Files:**
- Delete: `memory/today.md`
- Delete: `memory/active-tasks.json`
- Delete: `memory/conductor-tasks.json`
- Delete: `custom-skills/` 目录（整体）
- Move: `custom-skills/ai-native-scaffold-init/` → `.claude/skills/ai-native-scaffold-init/`
- Move: `custom-skills/context-handoff/` → `.claude/skills/context-handoff/`
- Move: `custom-skills/team-collaboration/` → `.claude/skills/team-collaboration/`
- Modify: `.gitignore`

**Step 1: 迁移 custom-skills 到 .claude/skills**

```bash
cp -r custom-skills/ai-native-scaffold-init .claude/skills/
cp -r custom-skills/context-handoff .claude/skills/
cp -r custom-skills/team-collaboration .claude/skills/
```

**Step 2: 验证迁移成功**

```bash
ls .claude/skills/ai-native-scaffold-init/
ls .claude/skills/context-handoff/
ls .claude/skills/team-collaboration/
```

Expected: 每个目录下有 `SKILL.md`

**Step 3: 删除 custom-skills 目录和孤立 memory 文件**

```bash
rm -rf custom-skills/
rm -f memory/today.md memory/active-tasks.json memory/conductor-tasks.json
```

**Step 4: 更新 .gitignore，增加 CLAUDE.local.md**

在 `.gitignore` 末尾追加：
```
# 本地 AI 配置覆盖（不提交）
CLAUDE.local.md
```

**Step 5: 验证**

```bash
ls custom-skills 2>/dev/null && echo "❌ 目录还在" || echo "✅ 已删除"
ls memory/today.md 2>/dev/null && echo "❌ 文件还在" || echo "✅ 已删除"
```

**Step 6: Commit**

```bash
git add -A
git commit -m "refactor: 迁移 custom-skills 到 .claude/skills，清理孤立 memory 文件"
```

---

### Task 2: 修正 context-handoff 技能的读取路径

**Files:**
- Modify: `.claude/skills/context-handoff/SKILL.md`

**Step 1: 读取当前文件确认现有路径**

读取 `.claude/skills/context-handoff/SKILL.md`，定位读取 `memory/today.md` 的代码块。

**Step 2: 替换为正确路径**

将"读取记忆文件"步骤改为：

```markdown
### 1. 读取配置，确认当前角色

```bash
ROLE=$(cat .claude/project-config.json | python3 -c "import sys,json; print(json.load(sys.stdin)['currentRole'])")
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
```

**Step 3: Commit**

```bash
git add .claude/skills/context-handoff/SKILL.md
git commit -m "fix: 修正 context-handoff 技能的 memory 读取路径"
```

---

### Task 3: 创建 scripts/lock.sh（任务锁工具）

**Files:**
- Create: `scripts/lock.sh`

**Step 1: 创建 scripts 目录**

```bash
mkdir -p scripts
```

**Step 2: 创建 lock.sh**

```bash
#!/bin/bash
# AI 任务锁工具
# 用法：
#   ./scripts/lock.sh acquire <task-id> <role>   加锁
#   ./scripts/lock.sh release <task-id>           释放
#   ./scripts/lock.sh status                      查看所有锁
#   ./scripts/lock.sh clean                       清理过期锁（>30分钟）

set -e

LOCK_DIR="memory/lock"
EXPIRE_SECONDS=1800  # 30 分钟

mkdir -p "$LOCK_DIR"

cmd="${1:-status}"
task_id="$2"
role="$3"

acquire() {
  local lock_file="$LOCK_DIR/$task_id.lock"
  if [ -f "$lock_file" ]; then
    local holder role_held ts now age
    IFS=: read -r role_held _ ts < "$lock_file"
    now=$(date -u +%s)
    age=$((now - ts))
    if [ $age -lt $EXPIRE_SECONDS ]; then
      echo "❌ 任务 [$task_id] 已被 [$role_held] 持有（${age}s 前加锁）"
      exit 1
    else
      echo "⚠️  发现过期锁，自动清理..."
      rm -f "$lock_file"
    fi
  fi
  echo "$role:$$:$(date -u +%s)" > "$lock_file"
  echo "✅ [$role] 已锁定任务 [$task_id]"
}

release() {
  local lock_file="$LOCK_DIR/$task_id.lock"
  if [ ! -f "$lock_file" ]; then
    echo "⚠️  任务 [$task_id] 没有锁"
    exit 0
  fi
  rm -f "$lock_file"
  echo "🔓 任务 [$task_id] 已释放"
}

status() {
  local locks
  locks=$(ls "$LOCK_DIR"/*.lock 2>/dev/null)
  if [ -z "$locks" ]; then
    echo "✅ 当前无任务锁"
    return
  fi
  echo "📋 当前任务锁："
  for f in $locks; do
    local task role pid ts now age
    task=$(basename "$f" .lock)
    IFS=: read -r role pid ts < "$f"
    now=$(date -u +%s)
    age=$((now - ts))
    echo "  [$task] 持有者: $role，已持续: ${age}s"
  done
}

clean() {
  local cleaned=0
  for f in "$LOCK_DIR"/*.lock 2>/dev/null; do
    [ -f "$f" ] || continue
    local ts now age
    IFS=: read -r _ _ ts < "$f"
    now=$(date -u +%s)
    age=$((now - ts))
    if [ $age -ge $EXPIRE_SECONDS ]; then
      echo "🗑️  清理过期锁: $(basename $f .lock)（${age}s）"
      rm -f "$f"
      cleaned=$((cleaned + 1))
    fi
  done
  echo "清理完成，共清理 $cleaned 个过期锁"
}

case "$cmd" in
  acquire) acquire ;;
  release) release ;;
  status)  status  ;;
  clean)   clean   ;;
  *) echo "用法: lock.sh <acquire|release|status|clean> [task-id] [role]"; exit 1 ;;
esac
```

**Step 3: 赋予执行权限**

```bash
chmod +x scripts/lock.sh
```

**Step 4: 验证基本功能**

```bash
./scripts/lock.sh status
./scripts/lock.sh acquire test-task-001 backend
./scripts/lock.sh status
./scripts/lock.sh release test-task-001
./scripts/lock.sh status
```

Expected:
```
✅ 当前无任务锁
✅ [backend] 已锁定任务 [test-task-001]
📋 当前任务锁：[test-task-001] 持有者: backend，已持续: 0s
🔓 任务 [test-task-001] 已释放
✅ 当前无任务锁
```

**Step 5: Commit**

```bash
git add scripts/lock.sh
git commit -m "feat: 添加任务锁工具 scripts/lock.sh，支持过期自动清理"
```

---

### Task 4: 创建 scripts/replace-placeholders.sh（项目初始化脚本）

**Files:**
- Create: `scripts/replace-placeholders.sh`

**Step 1: 创建脚本**

```bash
#!/bin/bash
# 项目初始化脚本 - 替换脚手架占位符，复制技术栈模板
# 用法：./scripts/replace-placeholders.sh <项目名> <frontend:react|vue|next> <backend:java|python>
#
# 示例：
#   ./scripts/replace-placeholders.sh "med-ai-platform" "next" "java"
#   ./scripts/replace-placeholders.sh "data-service" "react" "python"

set -e

PROJECT_NAME="${1:?用法: $0 <项目名> <frontend:react|vue|next> <backend:java|python>}"
FRONTEND="${2:-react}"
BACKEND="${3:-java}"

# 验证参数
case "$FRONTEND" in react|vue|next) ;; *)
  echo "❌ frontend 参数必须是: react | vue | next"
  exit 1
esac

case "$BACKEND" in java|python) ;; *)
  echo "❌ backend 参数必须是: java | python"
  exit 1
esac

echo "🚀 初始化项目: $PROJECT_NAME (frontend: $FRONTEND, backend: $BACKEND)"
echo ""

# Step 1: 替换文档中的占位符
echo "📝 替换占位符..."
find . \( -name "*.md" -o -name "*.json" -o -name "*.yml" \) \
  -not -path "./.git/*" \
  -not -path "./node_modules/*" \
  -not -path "./.scaffold/*" \
  -exec sed -i.bak "s/\[项目名称\]/$PROJECT_NAME/g" {} \;
find . -name "*.bak" -delete
echo "   ✅ 占位符替换完成"

# Step 2: 复制前端技术栈模板
FRONTEND_TEMPLATE="templates/frontend/$FRONTEND"
if [ -d "$FRONTEND_TEMPLATE" ]; then
  echo "📦 复制前端模板 ($FRONTEND)..."
  cp -r "$FRONTEND_TEMPLATE/." src/frontend/
  echo "   ✅ 前端模板复制完成"
else
  echo "   ⚠️  前端模板 $FRONTEND_TEMPLATE 不存在，跳过"
fi

# Step 3: 复制后端技术栈模板
BACKEND_TEMPLATE="templates/backend/$BACKEND"
if [ -d "$BACKEND_TEMPLATE" ]; then
  echo "📦 复制后端模板 ($BACKEND)..."
  cp -r "$BACKEND_TEMPLATE/." src/backend/
  echo "   ✅ 后端模板复制完成"
else
  echo "   ⚠️  后端模板 $BACKEND_TEMPLATE 不存在，跳过"
fi

# Step 4: 更新 project-config.json
echo "⚙️  更新项目配置..."
if command -v python3 &>/dev/null; then
  python3 - <<EOF
import json, sys

with open('.claude/project-config.json', 'r') as f:
    cfg = json.load(f)

cfg['project'] = '$PROJECT_NAME'
cfg['version'] = '1.0.0'

with open('.claude/project-config.json', 'w') as f:
    json.dump(cfg, f, indent=2, ensure_ascii=False)
    f.write('\n')

print('   ✅ project-config.json 已更新')
EOF
else
  echo "   ⚠️  未找到 python3，请手动更新 .claude/project-config.json"
fi

# Step 5: 初始化 memory 日志（基于当前角色）
ROLE=$(python3 -c "import json; print(json.load(open('.claude/project-config.json'))['currentRole'])" 2>/dev/null || echo "fullstack")
TODAY=$(date +%Y-%m-%d)
ROLE_LOG="memory/roles/$ROLE/today.md"

mkdir -p "memory/roles/$ROLE"
if [ ! -f "$ROLE_LOG" ]; then
  cat > "$ROLE_LOG" <<LOGEOF
# 📅 $TODAY $ROLE 工作日志

## 今日目标
- [ ] 项目初始化完成

## 今日完成
（会话结束时更新）

## 明日待办
（会话结束时更新）
LOGEOF
  echo "   ✅ 初始化角色日志: $ROLE_LOG"
fi

echo ""
echo "✅ 项目初始化完成！"
echo ""
echo "项目名称: $PROJECT_NAME"
echo "前端技术栈: $FRONTEND"
echo "后端技术栈: $BACKEND"
echo ""
echo "下一步："
echo "  1. git init && git add -A && git commit -m 'feat: 初始化项目 $PROJECT_NAME'"
echo "  2. 编辑 .claude/project-config.json 配置团队角色和 gitUser"
echo "  3. 启动 Claude Code，运行 /plan-ceo 开始规划"
```

**Step 2: 赋予执行权限**

```bash
chmod +x scripts/replace-placeholders.sh
```

**Step 3: 验证（dry run 模式检查语法）**

```bash
bash -n scripts/replace-placeholders.sh && echo "✅ 语法检查通过"
```

**Step 4: Commit**

```bash
git add scripts/replace-placeholders.sh
git commit -m "feat: 添加项目初始化脚本 scripts/replace-placeholders.sh"
```

---

### Task 5: 创建前端技术栈模板（React / Vue / Next.js）

**Files:**
- Create: `templates/frontend/react/README.md`
- Create: `templates/frontend/vue/README.md`
- Create: `templates/frontend/next/README.md`

**Step 1: 创建模板目录结构**

```bash
mkdir -p templates/frontend/react
mkdir -p templates/frontend/vue
mkdir -p templates/frontend/next
```

**Step 2: 创建 React 模板 README**

`templates/frontend/react/README.md`：

```markdown
# 前端应用 (React + Vite + TypeScript)

## 技术栈
- React 18+
- TypeScript 5+
- Vite
- Tailwind CSS

## 目录结构

```
frontend/
├── public/              # 静态资源
├── src/
│   ├── components/      # 共享组件（无业务逻辑）
│   ├── features/        # 功能模块（含组件+hooks+api）
│   │   └── auth/
│   │       ├── components/
│   │       ├── hooks/
│   │       └── api.ts
│   ├── hooks/           # 全局 hooks
│   ├── lib/             # 工具函数（纯函数，可测试）
│   ├── pages/           # 页面路由入口
│   ├── App.tsx
│   └── main.tsx
├── index.html
├── vite.config.ts
├── tsconfig.json
└── package.json
```

## 开发

```bash
npm install
npm run dev
```

## 规范

- 组件使用具名导出
- Props 使用 TypeScript interface 定义
- 禁止在组件内直接调用 API（通过 hooks 封装）
- 遵循 `.claude/rules/anti-slop.md` 设计规范
```

**Step 3: 创建 Vue 模板 README**

`templates/frontend/vue/README.md`：

```markdown
# 前端应用 (Vue 3 + Vite + TypeScript)

## 技术栈
- Vue 3 (Composition API)
- TypeScript 5+
- Vite
- Tailwind CSS

## 目录结构

```
frontend/
├── public/
├── src/
│   ├── components/      # 共享组件
│   ├── composables/     # 可复用逻辑（对应 React hooks）
│   ├── features/        # 功能模块
│   ├── views/           # 页面组件（路由对应）
│   ├── stores/          # Pinia 状态管理
│   ├── lib/             # 工具函数
│   ├── App.vue
│   └── main.ts
├── vite.config.ts
└── package.json
```

## 开发

```bash
npm install
npm run dev
```

## 规范

- 使用 `<script setup>` 语法
- 使用 Pinia 管理全局状态（不用 Vuex）
- Composable 命名以 `use` 开头
```

**Step 4: 创建 Next.js 模板 README**

`templates/frontend/next/README.md`：

```markdown
# 前端应用 (Next.js 14+ App Router)

## 技术栈
- Next.js 14+ (App Router)
- TypeScript 5+
- Tailwind CSS

## 目录结构

```
frontend/
├── app/                 # App Router 页面
│   ├── (auth)/          # 路由分组
│   ├── api/             # Route Handlers
│   ├── layout.tsx
│   └── page.tsx
├── components/          # 共享组件（Server/Client 组件）
├── features/            # 功能模块
├── lib/                 # 工具函数
├── hooks/               # Client 端 hooks
├── public/
├── next.config.js
└── package.json
```

## 开发

```bash
npm install
npm run dev
```

## 规范

- 优先使用 Server Components（无 `'use client'` 标注）
- Client Components 文件顶部加 `'use client'`
- 数据获取在 Server Components 中直接 async/await
- API 路由放在 `app/api/` 下
```

**Step 5: Commit**

```bash
git add templates/
git commit -m "feat: 添加前端技术栈模板 (react/vue/next)"
```

---

### Task 6: 创建后端技术栈模板（Java / Python）

**Files:**
- Create: `templates/backend/java/README.md`
- Create: `templates/backend/python/README.md`

**Step 1: 创建目录**

```bash
mkdir -p templates/backend/java
mkdir -p templates/backend/python
```

**Step 2: 创建 Java/Spring Boot 模板 README**

`templates/backend/java/README.md`：

```markdown
# 后端服务 (Java 17 + Spring Boot 3)

## 技术栈
- Java 17+
- Spring Boot 3+
- Spring Security + JWT
- Spring Data JPA + Hibernate
- PostgreSQL / MySQL
- Maven

## 目录结构

```
backend/
├── src/
│   ├── main/
│   │   ├── java/com/{company}/{project}/
│   │   │   ├── controller/      # REST 控制器（薄层，只做入参校验）
│   │   │   ├── service/         # 业务逻辑
│   │   │   │   └── impl/
│   │   │   ├── repository/      # JPA Repository 接口
│   │   │   ├── model/
│   │   │   │   ├── entity/      # JPA 实体
│   │   │   │   └── dto/         # 请求/响应 DTO
│   │   │   ├── config/          # Spring 配置类
│   │   │   ├── security/        # 认证/授权
│   │   │   └── exception/       # 全局异常处理
│   │   └── resources/
│   │       ├── application.yml
│   │       └── application-{env}.yml
│   └── test/
│       └── java/...             # 单元测试 + 集成测试
├── pom.xml
└── Dockerfile
```

## 开发

```bash
mvn spring-boot:run
```

## 规范

- Controller 不写业务逻辑，只做参数校验和调用 Service
- Service 方法加 `@Transactional`（写操作）
- 数据库查询使用参数化（禁止字符串拼接）
- DTO 与 Entity 严格分离，用 MapStruct 转换
- 单元测试覆盖所有 Service 方法
```

**Step 3: 创建 Python/FastAPI 模板 README**

`templates/backend/python/README.md`：

```markdown
# 后端服务 (Python 3.11+ + FastAPI)

## 技术栈
- Python 3.11+
- FastAPI
- SQLAlchemy 2.0 (async)
- Pydantic v2
- Alembic（数据库迁移）
- Poetry（依赖管理）

## 目录结构

```
backend/
├── app/
│   ├── api/             # 路由层（APIRouter）
│   │   └── v1/
│   │       ├── auth.py
│   │       └── users.py
│   ├── services/        # 业务逻辑（无 DB 直接调用）
│   ├── repositories/    # 数据访问层（SQLAlchemy）
│   ├── models/          # SQLAlchemy ORM 模型
│   ├── schemas/         # Pydantic 请求/响应模型
│   ├── core/
│   │   ├── config.py    # 配置（从环境变量读取）
│   │   ├── security.py  # JWT / 密码哈希
│   │   └── deps.py      # FastAPI 依赖注入
│   └── main.py          # FastAPI 应用入口
├── tests/
│   ├── conftest.py
│   ├── unit/
│   └── integration/
├── alembic/             # 数据库迁移
├── pyproject.toml
└── Dockerfile
```

## 开发

```bash
poetry install
poetry run uvicorn app.main:app --reload
```

## 规范

- 路由层只做参数验证，不写业务逻辑
- 数据库操作统一在 repositories 层，使用 async session
- Pydantic Schema 与 ORM Model 严格分离
- 配置从环境变量读取，禁止硬编码密钥
- 测试使用 pytest + httpx（异步）
```

**Step 4: Commit**

```bash
git add templates/backend/
git commit -m "feat: 添加后端技术栈模板 (java/python)"
```

---

### Task 7: 更新 src/ README 文件 + 创建 shared 目录

**Files:**
- Modify: `src/frontend/README.md`
- Modify: `src/backend/README.md`
- Create: `src/shared/README.md`
- Create: `src/shared/types/.gitkeep`
- Create: `src/shared/constants/.gitkeep`

**Step 1: 重写 src/frontend/README.md**

```markdown
# 前端应用

选择技术栈后，此目录结构由 `scripts/replace-placeholders.sh` 自动生成。

## 支持的技术栈

| 技术栈 | 初始化命令 | 文档 |
|--------|------------|------|
| React + Vite | `./scripts/replace-placeholders.sh <名称> react <后端>` | `templates/frontend/react/README.md` |
| Vue 3 + Vite | `./scripts/replace-placeholders.sh <名称> vue <后端>` | `templates/frontend/vue/README.md` |
| Next.js 14 | `./scripts/replace-placeholders.sh <名称> next <后端>` | `templates/frontend/next/README.md` |

## 开发规范（所有技术栈通用）

- 组件/函数命名语义化（见 `.claude/rules/anti-slop.md`）
- 状态管理按需引入，不提前设计
- API 类型定义放 `../shared/types/`，前后端共享
- 遵循 TDD：先写测试，再写实现
```

**Step 2: 重写 src/backend/README.md**

```markdown
# 后端服务

选择技术栈后，此目录结构由 `scripts/replace-placeholders.sh` 自动生成。

## 支持的技术栈

| 技术栈 | 初始化命令 | 文档 |
|--------|------------|------|
| Java 17 + Spring Boot 3 | `./scripts/replace-placeholders.sh <名称> <前端> java` | `templates/backend/java/README.md` |
| Python 3.11 + FastAPI | `./scripts/replace-placeholders.sh <名称> <前端> python` | `templates/backend/python/README.md` |

## 开发规范（所有技术栈通用）

- 禁止字符串拼接 SQL，使用参数化查询
- API 响应 Schema 放 `../shared/types/`，前后端共享
- 配置项从环境变量读取（禁止硬编码密钥）
- 单元测试覆盖所有业务逻辑层（Service / Use Case）
```

**Step 3: 创建 src/shared/README.md**

```markdown
# 共享层 (Shared)

> 前后端共用的类型定义、枚举常量，保持单一来源。

## 使用场景

- API 请求/响应的 TypeScript 类型
- 前后端共享的枚举值（如状态码、角色类型）
- 通用常量（如分页默认值）

## 目录结构

```
shared/
├── types/           # TypeScript 接口/类型定义
│   ├── api.ts       # API 响应通用结构
│   └── user.ts      # 用户相关类型
└── constants/       # 共享常量
    └── index.ts
```

## 示例

```typescript
// shared/types/api.ts
export interface ApiResponse<T> {
  code: number;
  data: T;
  message: string;
}

// shared/constants/index.ts
export const PAGE_SIZE = 20;
export const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
```

## 注意

- 只放纯类型定义和常量，不引入业务逻辑
- Java 后端对应的 DTO 类从这里的类型定义同步
- Python 后端对应的 Pydantic Schema 从这里的类型定义同步
```

**Step 4: 创建占位文件**

```bash
mkdir -p src/shared/types src/shared/constants
touch src/shared/types/.gitkeep src/shared/constants/.gitkeep
```

**Step 5: Commit**

```bash
git add src/
git commit -m "feat: 更新 src/ 支持多技术栈，新增 shared 共享层"
```

---

### Task 8: 创建版本文件 + 更新 project-config.json

**Files:**
- Create: `SCAFFOLD_VERSION`
- Create: `CHANGELOG.md`
- Create: `CLAUDE.local.md.template`
- Modify: `.claude/project-config.json`

**Step 1: 创建 SCAFFOLD_VERSION**

内容：`2.0.0`

**Step 2: 创建 CHANGELOG.md**

```markdown
# Changelog

所有版本变更记录遵循 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)。

---

## [2.0.0] - 2026-03-24

### Breaking Changes
- `memory/today.md`、`memory/active-tasks.json`、`memory/conductor-tasks.json` 已删除，统一到 `memory/roles/{role}/today.md` 和 `memory/.index/`
- `custom-skills/` 目录已迁移到 `.claude/skills/`

### Added
- 多技术栈支持：前端 React/Vue/Next.js，后端 Java(SpringBoot)/Python(FastAPI)
- `scripts/replace-placeholders.sh`：一键初始化新项目
- `scripts/lock.sh`：AI 并发任务锁工具（支持过期自动清理）
- `templates/`：前后端技术栈结构模板
- `src/shared/`：前后端共享类型/常量层
- `SCAFFOLD_VERSION`：脚手架版本追踪
- `CLAUDE.local.md.template`：本地配置覆盖模板
- `.claude/commands/switch-role.md`：角色切换命令
- `docs/00_ai_system/subtree-guide.md`：git subtree 接入手册

### Fixed
- `context-handoff` 技能读取路径修正（原读 `memory/today.md`，现读 `memory/roles/{role}/today.md`）
- `ai-native-scaffold-init` 技能补全初始化脚本引用
- `README.md` 目录结构图与实际路径对齐
- `src/backend/README.md` 移除 Node.js 特定结构，改为 Java/Python 双模板

### Changed
- `src/frontend/README.md`：改为多技术栈说明
- `src/backend/README.md`：改为 Java/Python 双模板

---

## [1.0.0] - 2026-03-23

### Added
- 初始版本发布
- CLAUDE.md AI 灵魂中枢
- 7 角色系统（fullstack/frontend/backend/pm/qa/devops/architect）
- 路径过滤规则（YAML frontmatter）
- 语言专属 Reviewer Agent（frontend/java/python）
- OWASP 安全审计员 Agent
- gstack 技能套件集成
- TDD + 人类确认双门禁规则
```

**Step 3: 创建 CLAUDE.local.md.template**

```markdown
<!--
  本文件用于本地/个人配置覆盖，不提交到 Git。
  复制此文件并重命名为 CLAUDE.local.md 使用。
  cp CLAUDE.local.md.template CLAUDE.local.md
-->

# 本地配置覆盖

> 此文件覆盖 CLAUDE.md 中的全局配置，仅本机生效。

## 个人角色覆盖

如果你的角色与 project-config.json 中的 currentRole 不同：

```json
// 临时覆盖当前角色（不影响团队共享配置）
// currentRole: "frontend"
```

## 本地工具配置

```bash
# 本地数据库连接（不提交）
# DB_URL=postgresql://localhost:5432/mydb_dev
```

## 个人习惯覆盖

```
// 例如：关闭某个 skill 的自动触发
// 例如：调整响应语言偏好
```
```

**Step 4: 更新 project-config.json，增加 scaffoldVersion 字段**

在 `project-config.json` 中，`"version"` 字段后增加：
```json
"scaffoldVersion": "2.0.0",
```

**Step 5: Commit**

```bash
git add SCAFFOLD_VERSION CHANGELOG.md CLAUDE.local.md.template .claude/project-config.json
git commit -m "feat: 添加脚手架版本管理文件和本地配置模板"
```

---

### Task 9: 新增 switch-role 命令

**Files:**
- Create: `.claude/commands/switch-role.md`

**Step 1: 创建命令文件**

```markdown
# Switch Role（切换角色）

切换当前 AI 工作角色，加载对应角色的记忆和工作焦点。

## 使用方法

```
/switch-role <role>
```

支持的角色：`fullstack` | `frontend` | `backend` | `pm` | `qa` | `devops` | `architect`

## 执行流程

1. **保存当前角色状态**

   将当前未完成任务追加到 `memory/roles/{current-role}/today.md`。

2. **更新 project-config.json**

   ```bash
   python3 -c "
   import json
   with open('.claude/project-config.json', 'r+') as f:
       cfg = json.load(f)
       cfg['currentRole'] = '$ARGS'
       f.seek(0); json.dump(cfg, f, indent=2, ensure_ascii=False); f.truncate()
   print('角色已切换为: $ARGS')
   "
   ```

3. **加载新角色上下文**

   - 读取 `memory/roles/{new-role}/today.md`（新角色今日日志）
   - 读取 `.claude/project-config.json` 中新角色的 `focus` 目录
   - 输出切换确认：

   ```
   🎭 角色切换完成

   当前角色: {new-role}
   工作焦点: {focus directories}
   今日日志: {summary from today.md or "暂无记录"}

   准备开始 {new-role} 视角的工作。
   ```

## 注意

- 切换角色不会清除其他角色的记忆，只改变当前 AI 的工作视角
- 多 AI 并发时，每个窗口应保持固定角色，避免频繁切换
```

**Step 2: Commit**

```bash
git add .claude/commands/switch-role.md
git commit -m "feat: 添加 /switch-role 角色切换命令"
```

---

### Task 10: 创建 git subtree 接入手册

**Files:**
- Create: `docs/00_ai_system/subtree-guide.md`

**Step 1: 创建文件**

```markdown
# Git Subtree 接入手册

> 消费项目如何接入脚手架，以及如何拉取上游更新。

---

## 为什么用 Subtree 而不是 Submodule

| 对比 | Subtree | Submodule |
|------|---------|-----------|
| clone 后可用 | ✅ 直接可用 | ❌ 需要 `git submodule update --init` |
| 团队门槛 | 低 | 较高 |
| 更新方式 | `git subtree pull` | `git submodule update --remote` |
| 文件可见性 | 完全展开在目录中 | 指针引用 |
| 适合场景 | 内部标准分发 | 独立组件引用 |

---

## 初次接入

### 前提条件

- 已有项目 Git 仓库（或新建一个）
- 有脚手架仓库的读权限

### 步骤

```bash
# 1. 进入项目目录
cd your-project

# 2. 添加脚手架为远端
git remote add scaffold git@your-internal-git/ai-native-scaffold.git

# 3. 引入脚手架到 .scaffold/ 目录（首次，squash 合并保持历史干净）
git subtree add --prefix=.scaffold scaffold main --squash

# 4. 运行初始化脚本
bash .scaffold/scripts/replace-placeholders.sh "your-project-name" "next" "java"
#   参数: <项目名> <frontend:react|vue|next> <backend:java|python>

# 5. 初始提交
git add -A
git commit -m "feat: 初始化项目 your-project-name（基于 AI Native Scaffold v$(cat .scaffold/SCAFFOLD_VERSION)）"
```

---

## 拉取脚手架更新

当脚手架发布新版本时：

```bash
# 1. 查看当前使用的脚手架版本
cat .scaffold/SCAFFOLD_VERSION

# 2. 查看脚手架更新内容（可选，需要网络访问）
# git fetch scaffold && git log scaffold/main --oneline -10

# 3. 拉取更新
git subtree pull --prefix=.scaffold scaffold main --squash

# 4. 解决冲突（如果有）
# 见下方"冲突解决"章节

# 5. 提交
git commit -m "chore: 升级脚手架到 v$(cat .scaffold/SCAFFOLD_VERSION)"
```

---

## 可自定义的范围

以下目录**不会被 subtree pull 覆盖**，可以安全修改：

| 目录/文件 | 说明 |
|-----------|------|
| `.claude/rules/` | 可新增项目专属规则（不改核心规则文件） |
| `.claude/agents/` | 可新增项目专属 Agent |
| `.claude/commands/` | 可新增项目专属命令 |
| `.claude/project-config.json` | 项目配置，完全自有 |
| `docs/` | 完全自有 |
| `memory/` | 完全自有 |
| `src/` | 完全自有 |
| `tests/` | 完全自有 |
| `ops/` | 完全自有 |

**禁止直接修改 `.scaffold/` 目录内的文件**，否则下次 `subtree pull` 会产生冲突。

---

## 冲突解决

如果 `subtree pull` 后有冲突：

```bash
# 查看冲突文件
git status

# 打开冲突文件，选择保留哪个版本：
# - <<<<<<< HEAD 是你的项目版本
# - >>>>>>> scaffold/main 是脚手架新版本

# 冲突解决原则：
# - .scaffold/ 目录内的冲突：接受脚手架新版本（除非你有特殊原因）
# - 项目目录的冲突：保留项目版本

# 解决后提交
git add .
git commit -m "chore: 合并脚手架更新，解决冲突"
```

---

## 版本兼容

查看 `.scaffold/CHANGELOG.md` 了解每个版本的 Breaking Changes。

升级前重点关注：
- Memory 路径变更（会影响跨会话上下文恢复）
- 命令重命名（会影响日常 AI 交互习惯）
- Agent 结构变更（会影响代码审查流程）

---

## 常见问题

**Q: 能不能把脚手架更新推送回去？**
A: 可以，但需要写权限。`git subtree push --prefix=.scaffold scaffold main`。通常只有脚手架维护者做这件事。

**Q: `.scaffold/` 目录很大，影响仓库体积吗？**
A: 脚手架内容大部分是 Markdown，不影响实际开发体积。如果介意，可以在 `.gitattributes` 中排除 `.scaffold/` 的 linguist 统计。

**Q: 多个项目能同时追踪同一个脚手架版本吗？**
A: 是的，每个项目独立维护自己的 `.scaffold/` 副本，互不影响。
```

**Step 2: Commit**

```bash
git add docs/00_ai_system/subtree-guide.md
git commit -m "docs: 添加 git subtree 接入手册"
```

---

### Task 11: 补全 docs/06_skills/roles/ROLE_SETUP.md

**Files:**
- Modify: `docs/06_skills/roles/ROLE_SETUP.md`

**Step 1: 重写文件**

```markdown
# 角色技能配置说明

> 各角色启动时需要了解的技能和工作模式。

---

## 快速配置

编辑 `.claude/project-config.json`，设置 `currentRole`：

```json
{
  "currentRole": "backend",   // 修改此字段
  "gitUser": "your@email.com"
}
```

或使用命令切换：`/switch-role backend`

---

## 各角色说明

### fullstack（全栈工程师）

**工作焦点：** `src/frontend/`、`src/backend/`、`src/shared/`

**常用命令：**
- `/plan-architect` — 技术方案设计
- `/review` — 代码审查（前后端均覆盖）
- `/qa` — 全栈测试

**推荐 Agent：**
- `frontend-reviewer`（前端代码审查）
- `java-reviewer` 或 `python-reviewer`（后端代码审查）
- `security-auditor`（安全扫描）

---

### frontend（前端工程师）

**工作焦点：** `src/frontend/`、`src/shared/types/`

**常用命令：**
- `/review` — 前端代码审查
- `/qa` — 前端测试

**推荐 Agent：**
- `frontend-reviewer`
- `performance-analyzer`（性能分析）

**专属规则：** `.claude/rules/component-rules.md`（组件规范）

---

### backend（后端工程师）

**工作焦点：** `src/backend/`、`src/shared/types/`

**常用命令：**
- `/review` — 后端代码审查
- `/qa` — API 集成测试

**推荐 Agent：**
- `java-reviewer` 或 `python-reviewer`
- `security-auditor`

**专属规则：** `.claude/rules/api-rules.md`（API 规范）

---

### pm（产品经理）

**工作焦点：** `docs/01_product/`、`memory/roles/pm/`

**常用命令：**
- `/plan-ceo` — 产品规划
- `/retro` — 迭代复盘

**日常文件：**
- `docs/01_product/prd_v1.0.md` — PRD
- `docs/01_product/business_rules.md` — 业务规则

---

### qa（测试工程师）

**工作焦点：** `tests/`、`docs/04_qa/`

**常用命令：**
- `/qa` — 执行测试计划
- `/review` — 测试代码审查

**目录说明：**
- `tests/unit/` — 单元测试
- `tests/api_integration/` — API 集成测试
- `tests/e2e_browser/` — 端到端测试

---

### devops（运维工程师）

**工作焦点：** `ops/`、`docs/05_ops/`

**常用命令：**
- `/ship` — 发布检查
- `/debug` — 生产问题排查

**常用文件：**
- `ops/docker-compose.yml`
- `ops/k8s/`
- `docs/05_ops/runbook.md`

---

### architect（架构师）

**工作焦点：** `docs/03_architecture/`

**常用命令：**
- `/plan-architect` — 架构设计
- `/retro` — 架构复盘

**核心文档：**
- `docs/03_architecture/system_flow.md`
- `docs/03_architecture/api_specs.md`
- `docs/03_architecture/db_schema.md`

---

## 多 AI 并发配置

多人/多窗口并发工作时：

```bash
# 窗口1（后端 AI）
# .claude/project-config.json: currentRole = "backend"

# 窗口2（前端 AI）
# .claude/project-config.json: currentRole = "frontend"
# （使用 git worktree 隔离工作目录）

# 创建独立工作目录
git worktree add ../workspace-frontend feature/login-ui
cd ../workspace-frontend
# 修改此目录的 project-config.json 为 frontend 角色
```

任务协调使用 `scripts/lock.sh`：
```bash
./scripts/lock.sh acquire login-ui-task frontend
# ... 完成工作 ...
./scripts/lock.sh release login-ui-task
```
```

**Step 2: Commit**

```bash
git add docs/06_skills/roles/ROLE_SETUP.md
git commit -m "docs: 补全角色技能配置说明"
```

---

### Task 12: 修正 README.md 目录结构图

**Files:**
- Modify: `README.md`

**Step 1: 定位并替换 README.md 中的错误目录结构**

找到如下错误结构：
```
├── /rules                 # 📜 核心准则 (Layer 0)
├── /commands              # ⚡ Slash Commands (Layer 0)
├── /agents                # 🎭 虚拟角色 (Layer 0)
├── /custom-skills                # 🛠️ 技能工具箱 (Layer 0)
```

替换为：
```
├── .claude/
│   ├── rules/             # 📜 核心准则 (Layer 0)
│   ├── commands/          # ⚡ Slash Commands (Layer 0)
│   ├── agents/            # 🎭 专属 Agent (Layer 0)
│   └── skills/            # 🛠️ 技能工具箱 (Layer 0，含 gstack + 自定义)
│
├── scripts/               # 🔧 工具脚本（初始化、任务锁）
├── templates/             # 📋 技术栈模板（frontend/backend）
├── SCAFFOLD_VERSION       # 脚手架版本号
```

**Step 2: Commit**

```bash
git add README.md
git commit -m "docs: 修正 README.md 目录结构图与实际路径对齐"
```

---

### Task 13: 最终验证 + 打标签

**Step 1: 验证关键文件存在**

```bash
echo "=== 验证核心文件 ===" && \
ls .claude/skills/ai-native-scaffold-init/SKILL.md && \
ls .claude/skills/context-handoff/SKILL.md && \
ls .claude/skills/team-collaboration/SKILL.md && \
ls scripts/lock.sh && \
ls scripts/replace-placeholders.sh && \
ls templates/frontend/react/README.md && \
ls templates/frontend/vue/README.md && \
ls templates/frontend/next/README.md && \
ls templates/backend/java/README.md && \
ls templates/backend/python/README.md && \
ls src/shared/README.md && \
ls SCAFFOLD_VERSION && \
ls CHANGELOG.md && \
ls CLAUDE.local.md.template && \
ls .claude/commands/switch-role.md && \
ls docs/00_ai_system/subtree-guide.md && \
echo "✅ 所有文件验证通过"
```

**Step 2: 验证孤立文件已删除**

```bash
ls memory/today.md 2>/dev/null && echo "❌ 还存在" || echo "✅ today.md 已删除"
ls memory/active-tasks.json 2>/dev/null && echo "❌ 还存在" || echo "✅ active-tasks.json 已删除"
ls custom-skills 2>/dev/null && echo "❌ custom-skills 还存在" || echo "✅ custom-skills 已删除"
```

**Step 3: 验证脚本语法**

```bash
bash -n scripts/lock.sh && echo "✅ lock.sh 语法正确"
bash -n scripts/replace-placeholders.sh && echo "✅ replace-placeholders.sh 语法正确"
```

**Step 4: 打 Git 标签**

```bash
git tag -a v2.0.0 -m "Scaffold v2.0.0: 多技术栈支持 + git subtree 分发机制"
echo "✅ 已打标签 v2.0.0"
```

**Step 5: 最终提交确认**

```bash
git log --oneline -15
```

Expected: 看到 13 个有序提交，从 Task 1 到 Task 12。

---

*计划生成时间：2026-03-24*
*设计文档：`docs/plans/2026-03-24-scaffold-v2-design.md`*
