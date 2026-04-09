# 🤝 会话交接记录 (Handoff)

> **前情提要**: 这不是流水账，这是给下一个会话（或者是给接手的人类）留的接力棒。旧的记录请随时清空。

## 最新交接点 
**[交付工程师 - 2026-04-09 11:47]**

- **刚刚干了什么**:
  - 已定位并修复 “OMC 在 Codex 可用但在 Claude Code 无效” 问题。
  - 根因：`.claude/skills/omc/skills/` 虽然完整（37 个），但 `.claude/skills/` 顶层缺少对应入口链接，Claude Code 不会自动暴露。
  - 已修改 `scripts/sync-omc-skills.sh`：除了同步 `.agents/skills/`，新增维护 `.claude/skills/<skill> -> omc/skills/<skill>`。
  - 已回归验证：脚本执行后 `linked=37 skipped=0`，`deep-interview/autopilot/verify/wiki/omc-teams` 等入口均可解析到 `SKILL.md`。
  - 已更新 `.agents/skills/omc-upgrade/SKILL.md`，将该链接维护纳入标准升级流程，避免回归。
- **剩下的坑 / Blocker**:
  - 无功能阻塞。
  - 当前有 2 个脚本/文档改动 + 37 个新符号链接（`.claude/skills/*`），未提交。
- **下一步要做什么 (Next Steps)**:
  - 人类确认是否将 37 个 `.claude/skills/*` 符号链接纳入版本控制。
  - 确认后提交并推送本次修复。
