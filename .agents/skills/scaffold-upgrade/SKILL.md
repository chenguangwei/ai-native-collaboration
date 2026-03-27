---
name: scaffold-upgrade
version: 1.0.0
description: |
  升级 AI Native 脚手架到最新版本。检测 git subtree 集成的脚手架版本，
  拉取更新，智能同步配置文件（保护项目自定义内容），展示变更内容。
  当用户说"升级脚手架"、"更新脚手架"、"scaffold upgrade"时触发。
allowed-tools:
  - Bash
  - Read
  - Edit
  - Write
  - AskUserQuestion
---

# /scaffold-upgrade

升级 AI Native 脚手架到最新版本，展示变更内容。

---

## 升级流程

### Step 1: 检测当前状态

```bash
# 检测脚手架集成状态
if [ ! -d ".scaffold" ]; then
  echo "ERROR: .scaffold 目录不存在，当前项目未通过 git subtree 集成脚手架"
  exit 1
fi

# 读取当前版本
CURRENT_VER=$(cat .scaffold/SCAFFOLD_VERSION 2>/dev/null || echo "unknown")
CONFIG_VER=$(cat .claude/project-config.json 2>/dev/null | grep '"scaffoldVersion"' | grep -o '"[0-9.]*"' | tr -d '"' || echo "")
echo "CURRENT_VER=$CURRENT_VER"
echo "CONFIG_VER=$CONFIG_VER"

# 检查 scaffold remote 是否已配置
REMOTE_URL=$(git remote get-url scaffold 2>/dev/null || echo "")
echo "REMOTE_URL=$REMOTE_URL"
```

**如果 `REMOTE_URL` 为空**，则告知用户并中止：
> "未找到 `scaffold` remote。请先添加脚手架仓库：
> ```bash
> git remote add scaffold <脚手架仓库地址>
> ```
> 参考：`docs/00_ai_system/scaffold-integration-manual.md`"

### Step 2: 获取远端最新版本

```bash
# fetch 远端（不修改本地文件）
git fetch scaffold 2>&1
if [ $? -ne 0 ]; then
  echo "ERROR: fetch scaffold 失败，请检查网络和仓库权限"
  exit 1
fi

# 读取远端最新版本
REMOTE_VER=$(git show scaffold/main:SCAFFOLD_VERSION 2>/dev/null || echo "unknown")
echo "REMOTE_VER=$REMOTE_VER"
```

**版本比较逻辑**：
- 如果 `REMOTE_VER == CURRENT_VER`：告知用户 "已是最新版本 (v{CURRENT_VER})"，退出
- 如果 `REMOTE_VER == unknown`：告知用户无法读取远端版本，询问是否仍继续
- 如果 `REMOTE_VER > CURRENT_VER`（字符串比较）：继续 Step 3

### Step 3: 询问用户（或自动升级）

首先检查 auto-upgrade 配置：
```bash
AUTO=$(cat .claude/project-config.json 2>/dev/null | grep '"scaffoldAutoUpgrade"' | grep -o 'true\|false' || echo "false")
echo "AUTO_UPGRADE=$AUTO"
```

**如果 `AUTO_UPGRADE=true`**：跳过询问，直接执行 Step 4，日志输出 "Auto-upgrading scaffold v{old} → v{new}..."

**否则**，使用 AskUserQuestion：
- 问题：`脚手架 **v{REMOTE_VER}** 已发布（当前 v{CURRENT_VER}），现在升级吗？`
- 选项：`["是，立即升级", "总是自动升级", "暂不升级", "不再提醒"]`

**如果选择"总是自动升级"**：
使用 Edit 工具在 `.claude/project-config.json` 中添加 `"scaffoldAutoUpgrade": true`，然后继续 Step 4。

**如果选择"暂不升级"**：告知用户可随时运行 `/scaffold-upgrade` 手动升级，退出。

**如果选择"不再提醒"**：告知用户可通过删除 `project-config.json` 中的 `scaffoldAutoUpgrade` 字段重新启用提醒，退出。

### Step 4: 执行 git subtree pull

```bash
# 备份当前版本号（用于后续展示变更）
OLD_VER="$CURRENT_VER"

# 执行 subtree pull
git subtree pull --prefix=.scaffold scaffold main --squash -m "chore: 升级脚手架 v${OLD_VER} → v${REMOTE_VER}"
if [ $? -ne 0 ]; then
  echo "ERROR: git subtree pull 失败"
  exit 1
fi

# 确认新版本
NEW_VER=$(cat .scaffold/SCAFFOLD_VERSION 2>/dev/null || echo "unknown")
echo "NEW_VER=$NEW_VER"
```

**如果失败**，告知用户：
> "git subtree pull 失败。可能原因：
> 1. 有未提交的本地改动（`git stash` 后重试）
> 2. 网络问题或权限不足
> 3. 合并冲突（需手动解决后 `git subtree pull` 重试）"

### Step 5: 智能同步文件

从 `.scaffold/` 同步到项目根目录。**保护项目自定义内容**：

**永远不覆盖（项目专属）**：
```
.claude/project-config.json     # 项目配置（角色、成员等）
.claude/settings.json           # Claude Code 本地设置
.claude/settings.local.json     # 本地覆盖设置
memory/                         # AI 跨会话记忆
src/                            # 业务代码
ops/                            # 基础设施配置
tests/                          # 测试用例
CLAUDE.local.md                 # 本地覆盖的 CLAUDE.md
```

**直接覆盖（脚手架拥有）**：
```bash
# 同步规则文件
cp -r .scaffold/.claude/rules/ .claude/rules/

# 同步 Agent 定义
cp -r .scaffold/.claude/agents/ .claude/agents/

# 同步命令（保护项目自定义命令）
rsync -av --exclude='*.local.md' .scaffold/.claude/commands/ .claude/commands/

# 同步 Skills（跳过 gstack，它有独立升级流程）
rsync -av --exclude='gstack' .scaffold/.agents/skills/ .agents/skills/
rsync -av --exclude='gstack' .scaffold/.claude/skills/ .claude/skills/

# 同步脚本
cp -r .scaffold/scripts/ ./scripts/

# 同步模板（如存在）
[ -d ".scaffold/templates" ] && cp -r .scaffold/templates/ ./templates/
```

**特殊处理 CLAUDE.md**：
```bash
# 检查项目的 CLAUDE.md 是否与脚手架默认版本不同
SCAFFOLD_DEFAULT_HASH=$(git show HEAD~1:.scaffold/CLAUDE.md 2>/dev/null | md5sum | cut -d' ' -f1 || echo "")
PROJECT_HASH=$(md5sum CLAUDE.md 2>/dev/null | cut -d' ' -f1 || echo "")
SCAFFOLD_NEW_HASH=$(md5sum .scaffold/CLAUDE.md 2>/dev/null | cut -d' ' -f1 || echo "")
echo "PROJECT_HASH=$PROJECT_HASH"
echo "SCAFFOLD_DEFAULT_HASH=$SCAFFOLD_DEFAULT_HASH"
echo "SCAFFOLD_NEW_HASH=$SCAFFOLD_NEW_HASH"
```

- 如果 `PROJECT_HASH == SCAFFOLD_DEFAULT_HASH`（用户未修改过）：直接覆盖 `cp .scaffold/CLAUDE.md ./CLAUDE.md`
- 如果 `PROJECT_HASH != SCAFFOLD_DEFAULT_HASH` 且 `SCAFFOLD_NEW_HASH != SCAFFOLD_DEFAULT_HASH`（用户改过，脚手架也有更新）：
  告知用户：
  > "`CLAUDE.md` 已被项目自定义，脚手架也更新了此文件。新版本已放在 `.scaffold/CLAUDE.md`，请手动 diff 后决定是否合并：
  > ```bash
  > diff CLAUDE.md .scaffold/CLAUDE.md
  > ```"

### Step 6: 更新 project-config.json 版本号

使用 Edit 工具，将 `project-config.json` 中的 `"scaffoldVersion"` 更新为新版本号：

将 `"scaffoldVersion": "{OLD_VER}"` 替换为 `"scaffoldVersion": "{NEW_VER}"`

### Step 7: 展示变更内容

读取 `.scaffold/CHANGELOG.md`，找到 `v{OLD_VER}` 和 `v{NEW_VER}` 之间的所有版本条目，输出摘要：

格式：
```
脚手架 v{NEW_VER} — 从 v{OLD_VER} 升级成功！

更新内容：
- [bullet 1]
- [bullet 2]
- ...

建议操作：
- 运行 `git status` 查看同步的文件变化
- 如有 CLAUDE.md 冲突，请手动 diff 合并
- 提交升级变更：git add -A && git commit -m "chore: 升级脚手架 v{OLD_VER} → v{NEW_VER}"
```

---

## 单独调用（Standalone）

当直接调用 `/scaffold-upgrade` 时：

1. 执行 Step 1 检测当前状态
2. 执行 Step 2 获取远端版本
3. 如有新版本：走完整升级流程（Step 3-7）
4. 如已是最新：告知用户当前版本，无需操作

---

## 同步规则详解

| 路径 | 策略 | 原因 |
|------|------|------|
| `.claude/rules/` | 覆盖 | 脚手架拥有，项目不应直接修改 |
| `.claude/agents/` | 覆盖 | 脚手架拥有 |
| `.claude/commands/` | 合并（跳过 *.local.md） | 允许项目添加自定义命令 |
| `.agents/skills/` | 覆盖（跳过 gstack） | gstack 有独立升级流程 |
| `.claude/skills/` | 覆盖（跳过 gstack） | 同上 |
| `scripts/` | 覆盖 | 脚手架工具脚本 |
| `CLAUDE.md` | 智能检测 | 可能被项目自定义 |
| `.claude/project-config.json` | 永不覆盖 | 项目专属配置 |
| `memory/` | 永不覆盖 | AI 运行时状态 |
| `src/` | 永不覆盖 | 业务代码 |
