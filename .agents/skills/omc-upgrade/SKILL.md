---
name: omc-upgrade
version: 1.0.0
description: |
  升级 oh-my-claudecode (OMC) 到最新版本。
  触发词：升级 omc、update omc、omc upgrade
allowed-tools:
  - Bash
  - AskUserQuestion
---

# /omc-upgrade

升级 oh-my-claudecode 插件到最新版本。

## 执行步骤

### Step 1: 检查当前状态

```bash
# 检查 OMC 是否已安装
ls ~/.claude/plugins/cache/ | grep -i "oh-my-claudecode\|omc" 2>/dev/null || echo "NOT_INSTALLED"
```

**如果 `NOT_INSTALLED`**：提示用户先安装：
```
/plugin marketplace add https://github.com/Yeachan-Heo/oh-my-claudecode
/plugin install oh-my-claudecode
```
然后退出。

### Step 2: 执行升级

```bash
/plugin marketplace update oh-my-claudecode
```

执行完毕后运行 OMC 自身的 setup：
```
/oh-my-claudecode:omc-setup
```

### Step 3: 确认完成

告知用户升级完成，可用的 OMC 技能：
- `/oh-my-claudecode:deep-interview` — 需求澄清
- `/oh-my-claudecode:ralph` — 持续执行直到完成
- `/oh-my-claudecode:ultrawork` — 并行执行引擎
- `/oh-my-claudecode:autopilot` — 全自动 idea → 代码
- `/oh-my-claudecode:ai-slop-cleaner` — 清除 AI 代码味
- `/oh-my-claudecode:learner` — 提取项目级调试知识
- `/oh-my-claudecode:ultraqa` — QA 循环直到通过
