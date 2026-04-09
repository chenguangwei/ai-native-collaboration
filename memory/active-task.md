# 🎯 当前主线任务 (Active Tasks)

## OMC 对齐升级（已完成）
- [x] 对齐上游 `oh-my-claudecode` 最新版本（`4.11.2`）
- [x] 同步 `.claude/skills/omc/` 与 `.agents/skills/omc/` vendored 内容
- [x] 执行 `scripts/sync-omc-skills.sh` 刷新 `.agents/skills/` 顶层 OMC skills
- [x] 同步 OMC 相关文档（`README.md`、`docs/06_handbooks/ai-native/SKILLS_INDEX.md`、`.agents/skills/omc-upgrade/SKILL.md`）

## OMC 在 Claude Code 侧不生效（已修复）
- [x] 复现并确认根因：`.claude/skills/` 缺少 OMC skills 顶层入口链接
- [x] 修复 `scripts/sync-omc-skills.sh`：同步 `.agents/skills` + 维护 `.claude/skills/<skill> -> omc/skills/<skill>`
- [x] 回归验证：37 个 OMC skill 链接已建立，`deep-interview`/`verify`/`wiki` 等入口可解析
- [x] 更新 `.agents/skills/omc-upgrade/SKILL.md`，避免后续升级回归
- [ ] 视需要提交 commit（等待人类确认）

## OMC Agents 在 Claude/Codex 不生效（已修复）
- [x] 复现并确认根因：缺少 `.claude/agents` 与 `.agents/agents` 入口目录
- [x] 扩展 `scripts/sync-omc-skills.sh`：同步 19 个 OMC agents 到双入口并创建安全别名
- [x] 回归验证：`omc-architect`/`architect`、`omc-debugger`/`debugger` 在双目录均可解析
- [x] 更新 `.agents/skills/omc-upgrade/SKILL.md`，将 agents 同步纳入标准流程
- [ ] 视需要提交 commit（等待人类确认）
