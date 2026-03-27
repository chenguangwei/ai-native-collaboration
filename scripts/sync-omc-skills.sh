#!/usr/bin/env bash
# sync-omc-skills.sh
# 将 OMC vendored 版 skills 同步到项目根 .agents/skills/
# 每次 OMC 升级后运行此脚本

set -e

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
OMC_SKILLS="$ROOT/.claude/skills/omc/skills"
TARGET="$ROOT/.agents/skills"

if [ ! -d "$OMC_SKILLS" ]; then
  echo "ERROR: OMC skills 不存在: $OMC_SKILLS"
  echo "请确认 .claude/skills/omc/ 目录完整"
  exit 1
fi

mkdir -p "$TARGET"

SYNCED=0
for skill_dir in "$OMC_SKILLS"/*/; do
  skill_name=$(basename "$skill_dir")
  # 只同步含有 SKILL.md 的目录
  [ -f "$skill_dir/SKILL.md" ] || continue
  dest="$TARGET/$skill_name"

  rm -rf "$dest"
  cp -Rf "$skill_dir" "$dest"
  SYNCED=$((SYNCED + 1))
done

echo "✓ 同步 $SYNCED 个 OMC skills 到 .agents/skills/"
echo "  来源: $OMC_SKILLS"
echo "  目标: $TARGET"
echo ""
echo "已同步 skills:"
for skill_dir in "$OMC_SKILLS"/*/; do
  skill_name=$(basename "$skill_dir")
  [ -f "$skill_dir/SKILL.md" ] && echo "  - $skill_name"
done
