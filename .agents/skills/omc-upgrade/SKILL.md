---
name: omc-upgrade
version: 2.1.0
description: |
  升级内置的 oh-my-claudecode (OMC) 到最新版本，并同步 skills 与文档。
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
| `/plan` | 战略规划（可选访谈） |
| `/team` | Claude 原生 Team 多智能体编排 |
| `/omc-teams` | tmux CLI worker 编排（claude/codex/gemini） |
| `/ccg` | Claude+Codex+Gemini 三模型协作 |
| `/ralph` | PRD 驱动的持续执行，不完成不停止 |
| `/ultrawork` | 并行执行引擎（Haiku/Sonnet/Opus 分层） |
| `/autopilot` | idea → 规格 → 实现 → QA 全自动 |
| `/debug` | 诊断 OMC 会话与仓库状态 |
| `/trace` | 证据驱动追踪 |
| `/verify` | 声称完成前验证变更有效性 |
| `/ai-slop-cleaner` | 行为安全优先的 AI 代码味清理 |
| `/learner` | 提取项目级调试知识为可复用 skill |
| `/remember` | 管理项目长期记忆 |
| `/skill` `/skillify` | 管理并固化本地技能 |
| `/wiki` | 持久化 markdown 知识库 |
| `/ultraqa` | QA 循环直到全部测试通过 |
| `/ralplan` | Planner→Architect→Critic 共识规划 |

---

## 执行步骤

### Step 1: 定位内置 OMC 目录

```bash
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
OMC_PATH="$ROOT/.claude/skills/omc"
AGENT_OMC_PATH="$ROOT/.agents/skills/omc"

if [ ! -d "$OMC_PATH" ]; then
  echo "ERROR: 内置 OMC 不存在: $OMC_PATH"
  echo "请确认脚手架已正确接入（.claude/skills/omc/ 应存在）"
  exit 1
fi

echo "OMC_PATH=$OMC_PATH"
echo "AGENT_OMC_PATH=$AGENT_OMC_PATH"
echo "CURRENT_VERSION=$(jq -r '.version' \"$OMC_PATH/package.json\")"
```

### Step 2: 拉取上游最新版本到临时目录

```bash
TMP_DIR="$(mktemp -d)"
git clone --depth 1 https://github.com/Yeachan-Heo/oh-my-claudecode.git "$TMP_DIR"
UPSTREAM_SHA="$(git -C "$TMP_DIR" rev-parse --short HEAD)"
UPSTREAM_VERSION="$(jq -r '.version' "$TMP_DIR/package.json")"
echo "UPSTREAM_SHA=$UPSTREAM_SHA"
echo "UPSTREAM_VERSION=$UPSTREAM_VERSION"
```

### Step 3: 覆盖同步 vendored OMC（.claude + .agents）

```bash
rsync -a --delete --exclude='.git' "$TMP_DIR"/ "$OMC_PATH"/
rsync -a --delete --exclude='.git' "$TMP_DIR"/ "$AGENT_OMC_PATH"/
echo "SYNCED_VERSION=$(jq -r '.version' \"$OMC_PATH/package.json\")"
```

### Step 4: 同步 skills 入口（Codex + Claude Code）

```bash
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
if [ -f "$ROOT/scripts/sync-omc-skills.sh" ]; then
  bash "$ROOT/scripts/sync-omc-skills.sh"
else
  echo "SKIP: sync-omc-skills.sh 不存在，跳过 skills 同步"
fi
```

> `sync-omc-skills.sh` 会同时做两件事：
> 1. 同步 `.claude/skills/omc/skills/*` → `.agents/skills/*`（Codex）
> 2. 维护 `.claude/skills/<skill> -> omc/skills/<skill>` 链接（Claude Code）

### Step 5: 同步文档与验证

报告结果：
```
✅ OMC 已升级

版本：{UPSTREAM_VERSION} ({UPSTREAM_SHA})
同步路径：
  - .claude/skills/omc/
  - .agents/skills/omc/
  - .agents/skills/*（通过 scripts/sync-omc-skills.sh）
  - .claude/skills/*（OMC skills 链接入口）

已同步文档：
  - .claude/skills/omc/README*.md
  - .agents/skills/omc/README*.md

新增/更新 OMC skills（示例）：
  /debug /verify /remember /skillify /wiki /team /omc-teams

OMC 为内置组件，无需全局安装 plugin。
```
