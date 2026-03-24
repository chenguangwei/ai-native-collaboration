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
- `context-handoff` 技能读取路径修正
- `src/backend/README.md` 移除 Node.js 特定结构，改为 Java/Python 双模板
- `README.md` 目录结构图与实际路径对齐

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
