#!/usr/bin/env bash
# sync-agents-skills.sh
# 将 gstack 生成的 Codex 适配版 skills 同步到项目根 .agents/skills/
# 每次 gstack 升级后运行此脚本

set -e

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
GSTACK_AGENTS="$ROOT/.claude/skills/gstack/.agents/skills"
TARGET="$ROOT/.agents/skills"

if [ ! -d "$GSTACK_AGENTS" ]; then
  echo "ERROR: gstack .agents/skills 不存在: $GSTACK_AGENTS"
  echo "请先运行: cd .claude/skills/gstack && ./setup"
  exit 1
fi

mkdir -p "$TARGET"

SYNCED=0
for skill_dir in "$GSTACK_AGENTS"/*/; do
  skill_name=$(basename "$skill_dir")
  dest="$TARGET/$skill_name"

  rm -rf "$dest"
  cp -Rf "$skill_dir" "$dest"
  SYNCED=$((SYNCED + 1))
done

echo "✓ 同步 $SYNCED 个 gstack skills 到 .agents/skills/"
echo "  来源: $GSTACK_AGENTS"
echo "  目标: $TARGET"
echo ""
echo "已同步 skills:"
ls "$GSTACK_AGENTS" | sed 's/^/  - /'
