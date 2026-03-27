---
name: omc-upgrade
version: 1.1.0
description: |
  安装或升级 oh-my-claudecode (OMC) 到最新版本，并链接 skills 到全局。
  触发词：升级 omc、update omc、omc upgrade、安装 omc
allowed-tools:
  - Bash
  - AskUserQuestion
---

# /omc-upgrade

安装或升级 oh-my-claudecode，让 `/deep-interview`、`/ralph` 等技能全局可用。

## OMC Skills 列表

安装后可直接使用（无需前缀）：

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

### Step 1: 检测 OMC 本地路径

```bash
# 按优先级查找 OMC
OMC_PATH=""
# 1. 全局 git clone 路径（推荐）
[ -d "$HOME/.claude/omc" ] && OMC_PATH="$HOME/.claude/omc"
# 2. 项目工作区（如有本地 repo）
[ -z "$OMC_PATH" ] && [ -d "$HOME/Documents/workspace/oh-my-claudecode" ] && OMC_PATH="$HOME/Documents/workspace/oh-my-claudecode"
# 3. 已通过 plugin 安装
[ -z "$OMC_PATH" ] && OMC_PATH=$(ls -d ~/.claude/plugins/cache/*/oh-my-claudecode/* 2>/dev/null | head -1)

echo "OMC_PATH=$OMC_PATH"
```

**如果 `OMC_PATH` 为空**（未安装），执行安装：

```bash
git clone --depth 1 https://github.com/Yeachan-Heo/oh-my-claudecode.git ~/.claude/omc
OMC_PATH="$HOME/.claude/omc"
echo "Installed to $OMC_PATH"
```

### Step 2: 如果已安装，拉取最新版本

```bash
if [ -d "$OMC_PATH/.git" ]; then
  cd "$OMC_PATH"
  OLD_SHA=$(git rev-parse --short HEAD)
  git pull --ff-only origin main 2>&1
  NEW_SHA=$(git rev-parse --short HEAD)
  echo "OLD=$OLD_SHA NEW=$NEW_SHA"
  [ "$OLD_SHA" = "$NEW_SHA" ] && echo "ALREADY_LATEST" || echo "UPDATED"
fi
```

### Step 3: 链接 skills 到 ~/.claude/skills/

```bash
OMC_SKILLS="$OMC_PATH/skills"
SKILLS="deep-interview learner ai-slop-cleaner ralph ultrawork autopilot ultraqa ralplan"

for skill in $SKILLS; do
  ln -sf "$OMC_SKILLS/$skill" ~/.claude/skills/$skill
  echo "linked: $skill → $OMC_SKILLS/$skill"
done
```

### Step 4: 链接 agents 到 ~/.claude/agents/（如存在）

```bash
if [ -d "$OMC_PATH/agents" ]; then
  for agent in executor architect critic analyst explore code-reviewer; do
    [ -f "$OMC_PATH/agents/$agent.md" ] && \
      cp "$OMC_PATH/agents/$agent.md" ~/.claude/agents/omc-$agent.md && \
      echo "agent: omc-$agent"
  done
fi
```

### Step 5: 确认完成

报告结果：
```
✅ OMC 已就绪

版本：{NEW_SHA 或 already latest}
Skills 已链接到 ~/.claude/skills/：
  /deep-interview  /ralph  /ultrawork  /autopilot
  /ai-slop-cleaner  /learner  /ultraqa  /ralplan

现在可以直接使用，例如：/deep-interview "我想做一个..."
```
