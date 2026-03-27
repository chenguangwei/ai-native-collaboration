# 🏗️ 脚手架开发者指南

> 此文件仅适用于**脚手架仓库本身的开发与维护**，不会分发到接入脚手架的业务项目中。

## 脚手架仓库结构

```
├── .agents/
│   └── skills/           # 统一 Skill 源（Claude Code + Codex 共用）
│       ├── brainstorming/
│       │   ├── SKILL.md
│       │   └── agents/openai.yaml
│       ├── systematic-debugging/
│       ├── test-driven-development/
│       ├── gstack*/      # 由 scripts/sync-agents-skills.sh 同步
│       └── ...（80+ 个 skills）
│
├── .claude/
│   ├── rules/            # AI 的肌肉记忆（全局始终加载）
│   ├── commands/         # 驾驭者的操纵杆（单个 .md，简单任务）
│   ├── agents/           # 后台专家（后台运行，只输出报告）
│   └── skills/
│       ├── gstack/       # gstack vendored（Claude Code 原生）
│       ├── omc/          # oh-my-claudecode vendored
│       ├── brainstorming → ../../.agents/skills/brainstorming
│       └── ...（符号链接 → .agents/skills/）
│
├── .codex/               # Codex CLI 配置
│   ├── AGENTS.md         # Codex 专属指令
│   ├── config.toml       # 运行时配置（MCP、多 agent）
│   └── agents/           # Codex 多 agent 角色定义
│
├── scripts/
│   ├── sync-agents-skills.sh   # gstack 升级后同步到 .agents/skills/
│   ├── sync-omc-skills.sh      # OMC 升级后同步到 .agents/skills/
│   └── replace-placeholders.sh # 新项目初始化占位符替换
│
├── memory/               # 跨会话状态同步中心
├── docs/                 # 全景知识库
├── CLAUDE.md             # ← 分发到业务项目的通用 AI 行为规范
├── CLAUDE.scaffold.md    # ← 本文件（脚手架开发专用，不分发）
└── README.md             # 脚手架导航文档
```

## 分发规则

当业务项目通过 `git subtree` 或初始化脚本接入脚手架时：

| 文件 | 分发行为 |
|------|---------|
| `CLAUDE.md` | ✅ 复制到业务项目根目录（通用 AI 行为规范） |
| `CLAUDE.scaffold.md` | ❌ 不复制（脚手架仓库专用） |
| `CLAUDE.local.md.template` | ✅ 复制（供开发者创建本地覆盖） |
| `.claude/project-config.json` | ✅ 首次复制，后续永不覆盖 |
| `.claude/rules/` | ✅ 覆盖同步 |
| `.claude/agents/` | ✅ 覆盖同步 |
| `.claude/skills/` | ✅ 覆盖同步（跳过 gstack/omc 独立升级） |
| `memory/` | ✅ 首次复制目录结构，后续永不覆盖 |

## Codex 配置

使用 `/codex` 调用 Codex CLI（需先安装 `npm i -g @openai/codex`）。

**三种模式：**
- `/codex review` - 独立 diff 审查，pass/fail gate
- `/codex challenge` - 对抗模式，尝试破坏你的代码
- `ask codex <问题>` - 咨询模式，支持追问

**多 Agent 配置位于** `.codex/` 目录（`config.toml` + `AGENTS.md` + `agents/`）。

> 如果 codex 未安装：`npm install -g @openai/codex`

## 脚手架开发注意事项

1. **修改 CLAUDE.md 后**：确保内容对任意业务项目都通用，不要加入脚手架特有的路径描述
2. **新增 Skill**：在 `.agents/skills/` 下创建目录，然后在 `.claude/skills/` 建立符号链接
3. **新增 Rule**：在 `.claude/rules/` 下添加 `.md` 文件，注意使用 YAML frontmatter 声明 paths 作用域
4. **版本发布**：更新 `SCAFFOLD_VERSION` 和 `CHANGELOG.md`

---

*此文件仅供脚手架仓库的开发维护参考，不随 scaffold-upgrade 分发到业务项目。*
