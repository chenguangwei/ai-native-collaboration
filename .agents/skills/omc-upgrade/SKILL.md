---
name: omc-upgrade
version: 2.0.0
description: |
  升级内置的 oh-my-claudecode (OMC) 到最新版本，并同步 skills。
  触发词：升级 omc、update omc、omc upgrade、omc-upgrade
allowed-tools:
  - Bash
  - AskUserQuestion
---

# /omc-upgrade

升级脚手架内置的 oh-my-claudecode 到最新版本。OMC 已作为 vendored 依赖内置于 `.claude/skills/omc/`，无需全局安装。

## OMC 内置 Skills

安装脚手架后即可直接使用（无需前缀）：

| 技能 | 用途 |
|------|------|
| `/deep-interview` | Socratic 需求澄清，歧义 <20% 才执行 |
| `/ralph` | PRD 驱动的持续执行，不完成不停止 |
| `/ultrawork` | 并行执行引擎（Haiku/Sonnet/Opus 分层） |
| `/autopilot` | idea → 规格 → 实现 → QA 全自动 |
| `/ai-slop-cleaner` | 行为安全优先的 AI 代码味清理 |
| `/learner` | 提取项目级调试知识为可复用 skill |
| `/ultraqa` | QA 循环直到全部测试通过 |
| `/ralplan` | Planner→Architect→Critic 共识规划 |

---

## 执行步骤

### Step 1: 定位内置 OMC 目录

```bash
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
OMC_PATH="$ROOT/.claude/skills/omc"

if [ ! -d "$OMC_PATH" ]; then
  echo "ERROR: 内置 OMC 不存在: $OMC_PATH"
  echo "请确认脚手架已正确接入（.claude/skills/omc/ 应存在）"
  exit 1
fi

echo "OMC_PATH=$OMC_PATH"
```

### Step 2: 拉取最新版本

```bash
if [ -d "$OMC_PATH/.git" ]; then
  cd "$OMC_PATH"
  OLD_SHA=$(git rev-parse --short HEAD)
  git pull --ff-only origin main 2>&1
  NEW_SHA=$(git rev-parse --short HEAD)
  echo "OLD=$OLD_SHA NEW=$NEW_SHA"
  [ "$OLD_SHA" = "$NEW_SHA" ] && echo "ALREADY_LATEST" || echo "UPDATED"
else
  echo "WARN: OMC 目录非 git 仓库，执行重新克隆..."
  TEMP_DIR=$(mktemp -d)
  git clone --depth 1 https://github.com/Yeachan-Heo/oh-my-claudecode.git "$TEMP_DIR"
  rm -rf "$OMC_PATH"
  mv "$TEMP_DIR" "$OMC_PATH"
  NEW_SHA=$(cd "$OMC_PATH" && git rev-parse --short HEAD)
  echo "REINSTALLED: $NEW_SHA"
fi
```

### Step 3: 重建 .claude/skills/ 下的符号链接

```bash
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
OMC_SKILLS="$ROOT/.claude/skills/omc/skills"
SKILLS="deep-interview learner ai-slop-cleaner ralph ultrawork autopilot ultraqa ralplan"

for skill in $SKILLS; do
  if [ -d "$OMC_SKILLS/$skill" ]; then
    ln -sfn "omc/skills/$skill" "$ROOT/.claude/skills/$skill"
    echo "linked: $skill → omc/skills/$skill"
  fi
done
```

### Step 4: 同步到 .agents/skills/（Codex 兼容）

```bash
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
if [ -f "$ROOT/scripts/sync-omc-skills.sh" ]; then
  bash "$ROOT/scripts/sync-omc-skills.sh"
else
  echo "SKIP: sync-omc-skills.sh 不存在，跳过 .agents/ 同步"
fi
```

### Step 5: 确认完成

报告结果：
```
✅ OMC 已升级

版本：{NEW_SHA}
内置路径：.claude/skills/omc/
Skills 已链接：
  /deep-interview  /ralph  /ultrawork  /autopilot
  /ai-slop-cleaner  /learner  /ultraqa  /ralplan

OMC 为内置组件，无需全局安装 plugin。
```
