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

# 2. 拉取更新
git subtree pull --prefix=.scaffold scaffold main --squash

# 3. 解决冲突（如果有）——见下方章节

# 4. 提交
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

# 冲突解决原则：
# - .scaffold/ 目录内的冲突：接受脚手架新版本
# - 项目目录的冲突：保留项目版本

# 解决后提交
git add .
git commit -m "chore: 合并脚手架更新，解决冲突"
```

---

## 版本兼容

升级前查看 `.scaffold/CHANGELOG.md` 了解 Breaking Changes。

重点关注：
- Memory 路径变更（影响跨会话上下文恢复）
- 命令重命名（影响日常 AI 交互习惯）
- Agent 结构变更（影响代码审查流程）

---

## 常见问题

**Q: 能不能把改动推送回脚手架仓库？**
A: 可以，但需要写权限：`git subtree push --prefix=.scaffold scaffold main`。通常只有脚手架维护者操作。

**Q: `.scaffold/` 目录影响仓库体积吗？**
A: 脚手架内容大部分是 Markdown，体积极小。

**Q: 多个项目能同时追踪同一个脚手架版本吗？**
A: 是的，每个项目独立维护自己的 `.scaffold/` 副本，互不影响。
