#!/usr/bin/env bash
# sync-omc-skills.sh
# 同步 OMC vendored 版 skills 到:
# 1) .agents/skills/ (Codex 技能发现)
# 2) .claude/skills/<name> -> omc/skills/<name> (Claude Code 技能发现)
# 每次 OMC 升级后运行此脚本

set -e

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
OMC_SKILLS="$ROOT/.claude/skills/omc/skills"
AGENTS_TARGET="$ROOT/.agents/skills"
CLAUDE_SKILLS_ROOT="$ROOT/.claude/skills"

if [ ! -d "$OMC_SKILLS" ]; then
  echo "ERROR: OMC skills 不存在: $OMC_SKILLS"
  echo "请确认 .claude/skills/omc/ 目录完整"
  exit 1
fi

mkdir -p "$AGENTS_TARGET" "$CLAUDE_SKILLS_ROOT"

SYNCED=0
LINKED=0
SKIPPED=0
for skill_dir in "$OMC_SKILLS"/*/; do
  skill_name=$(basename "$skill_dir")
  # 只同步含有 SKILL.md 的目录
  [ -f "$skill_dir/SKILL.md" ] || continue
  agent_dest="$AGENTS_TARGET/$skill_name"
  claude_link="$CLAUDE_SKILLS_ROOT/$skill_name"
  expected_link_target="omc/skills/$skill_name"

  rm -rf "$agent_dest"
  cp -Rf "$skill_dir" "$agent_dest"
  SYNCED=$((SYNCED + 1))

  # 同步 Claude Code 顶层技能入口:
  # - 不覆盖非 OMC 入口（避免踩掉已有 gstack 或项目自定义技能）
  # - 若不存在，或已是指向 omc/skills/<name> 的符号链接，则更新为最新链接
  if [ -e "$claude_link" ] || [ -L "$claude_link" ]; then
    if [ -L "$claude_link" ]; then
      current_target="$(readlink "$claude_link" || true)"
      if [ "$current_target" = "$expected_link_target" ]; then
        ln -sfn "$expected_link_target" "$claude_link"
        LINKED=$((LINKED + 1))
      else
        echo "SKIP link (occupied): .claude/skills/$skill_name -> $current_target"
        SKIPPED=$((SKIPPED + 1))
      fi
    else
      echo "SKIP link (occupied): .claude/skills/$skill_name (not a symlink)"
      SKIPPED=$((SKIPPED + 1))
    fi
  else
    ln -s "$expected_link_target" "$claude_link"
    LINKED=$((LINKED + 1))
  fi
done

echo "✓ 同步 $SYNCED 个 OMC skills 到 .agents/skills/"
echo "  来源: $OMC_SKILLS"
echo "  目标: $AGENTS_TARGET"
echo "✓ 维护 .claude/skills OMC 链接: linked=$LINKED skipped=$SKIPPED"
echo ""
echo "已同步 skills:"
for skill_dir in "$OMC_SKILLS"/*/; do
  skill_name=$(basename "$skill_dir")
  [ -f "$skill_dir/SKILL.md" ] && echo "  - $skill_name"
done
