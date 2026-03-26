# 手动接入脚手架（git subtree）

> 以下以 `app_insurance_cloud`（Java Spring Boot 项目）为实际案例演示。

## 前提条件

- 项目已有 Git 仓库
- 本地有脚手架读权限（通过 GitLab 账号）
- `.claude/` 和 `.agents/` 已推送到脚手架 `main` 分支

> **注意**：如果脚手架 `main` 分支尚未包含 `.claude/` 和 `.agents/`（本地有但未 push），需先将脚手架推送到 GitLab，否则步骤 3 拿到的文件不完整，需手动补充（见步骤 3 注意事项）。

---

## 步骤

### 步骤 1：添加脚手架为 git remote

```bash
cd your-project

git remote add scaffold http://gitlab-iot.yunzhisheng.cn/med-ai/med-ai-native-collaboration.git

# 验证
git remote -v
# scaffold  http://gitlab-iot.yunzhisheng.cn/med-ai/med-ai-native-collaboration.git (fetch)
# scaffold  http://gitlab-iot.yunzhisheng.cn/med-ai/med-ai-native-collaboration.git (push)
```

### 步骤 2：通过 git subtree 拉取脚手架到 `.scaffold/` 目录

`--squash` 把脚手架历史压成一个提交，保持项目 git 历史干净。

```bash
git subtree add --prefix=.scaffold scaffold main --squash
```

执行成功后项目根目录会出现 `.scaffold/` 目录，包含脚手架所有文件。

### 步骤 3：把 AI 配置文件复制到项目根目录

Claude Code 需要在项目根目录找到这些文件才能正常工作：

```bash
# CLAUDE.md — AI 行为规范入口
cp .scaffold/CLAUDE.md ./CLAUDE.md
cp .scaffold/CLAUDE.local.md.template ./CLAUDE.local.md.template

# docs/ — 知识库框架（产品/架构/测试/运维文档目录）
cp -r .scaffold/docs ./docs

# memory/ — 跨会话 AI 记忆（角色日志、任务注册表）
cp -r .scaffold/memory ./memory

# .claude/ — 命令、规则、Agent、Skills
cp -r .scaffold/.claude ./.claude

# .agents/ — 统一 Skills 目录（Claude Code + Codex 共用）
cp -r .scaffold/.agents ./.agents
```

> **app_insurance_cloud 实际情况**：GitLab `main` 分支当时尚未包含 `.claude/` 和 `.agents/`，
> 所以这两个目录是从本地脚手架目录直接复制的：
> ```bash
> cp -r /path/to/med-ai-native-collaboration/.claude ./.claude
> cp -r /path/to/med-ai-native-collaboration/.agents ./.agents
> ```
> 后续脚手架推送到 GitLab 后，通过 `git subtree pull` 即可自动同步，无需再手动复制。

### 步骤 4：配置当前项目信息

编辑 `.claude/project-config.json`，设置项目名称、当前角色和 git 用户：

```json
{
  "project": "app_insurance_cloud",
  "currentRole": "backend",
  "gitUser": "your@email.com",
  "team": "development",
  "scaffoldVersion": "2.0.0"
}
```

支持角色：`fullstack` | `frontend` | `backend` | `pm` | `qa` | `devops` | `architect`

`app_insurance_cloud` 为纯 Java 后端项目，选择 `backend`。

### 步骤 5：初始化角色记忆日志

```bash
mkdir -p memory/roles/backend
cat > memory/roles/backend/today.md << 'EOF'
# 📅 $(date +%Y-%m-%d) backend 工作日志

## 今日目标
- [x] 接入 AI Native 脚手架 v2.0.0

## 今日完成
（会话结束时更新）

## 明日待办
（会话结束时更新）
EOF
```

### 步骤 6：提交

```bash
git add CLAUDE.md CLAUDE.local.md.template docs/ memory/ .claude/ .agents/ .scaffold/
git commit -m "feat: 接入 AI Native 脚手架 v$(cat .scaffold/SCAFFOLD_VERSION)"
```

---

## 操作后的项目结构变化

接入前：
```
your-project/
├── src/          # 已有业务代码（不动）
├── pom.xml
└── README.md
```

接入后：
```
your-project/
├── .scaffold/    # 脚手架原始文件（git subtree 追踪，禁止手动修改）
├── .claude/      # AI 命令 / 规则 / Agent / Skills
├── .agents/      # 统一 Skills 目录
├── CLAUDE.md     # AI 行为规范（可按项目定制）
├── docs/         # 知识库（按需填充）
├── memory/       # AI 跨会话记忆
├── src/          # 已有业务代码（完全不变）
├── pom.xml
└── README.md
```

---

## 后续更新脚手架

当脚手架发布新版本时：

```bash
git subtree pull --prefix=.scaffold scaffold main --squash
# 然后按需手动同步 .claude/ .agents/ 中有更新的文件
```

详见 [git subtree 接入手册](subtree-guide.md)
