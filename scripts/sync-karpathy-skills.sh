#!/usr/bin/env bash
# sync-karpathy-skills.sh
# 同步 vendored Karpathy skills 到:
# 1) .agents/skills/ (Codex 技能发现)
# 2) .codex/skills/  (项目内 Codex 技能发现)
# 3) .claude/skills/<name> -> karpathy/skills/<name> (Claude Code 技能发现入口)

set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
KARPATHY_SKILLS="$ROOT/.claude/skills/karpathy/skills"
CLAUDE_SKILLS_ROOT="$ROOT/.claude/skills"
AGENTS_TARGET="$ROOT/.agents/skills"
CODEX_TARGET="$ROOT/.codex/skills"

if [ ! -d "$KARPATHY_SKILLS" ]; then
  echo "ERROR: Karpathy skills 不存在: $KARPATHY_SKILLS"
  echo "请先放置上游技能到 .claude/skills/karpathy/skills/"
  exit 1
fi

mkdir -p "$AGENTS_TARGET" "$CODEX_TARGET" "$CLAUDE_SKILLS_ROOT"

SYNCED=0
LINKED=0
SKIPPED=0
for skill_dir in "$KARPATHY_SKILLS"/*/; do
  [ -d "$skill_dir" ] || continue
  [ -f "$skill_dir/SKILL.md" ] || continue

  skill_name="$(basename "$skill_dir")"
  expected_link_target="karpathy/skills/$skill_name"
  claude_link="$CLAUDE_SKILLS_ROOT/$skill_name"

  rm -rf "$AGENTS_TARGET/$skill_name"
  cp -Rf "$skill_dir" "$AGENTS_TARGET/$skill_name"

  rm -rf "$CODEX_TARGET/$skill_name"
  cp -Rf "$skill_dir" "$CODEX_TARGET/$skill_name"

  SYNCED=$((SYNCED + 1))

  if [ -e "$claude_link" ] || [ -L "$claude_link" ]; then
    if [ -L "$claude_link" ] && [ "$(readlink "$claude_link" || true)" = "$expected_link_target" ]; then
      ln -sfn "$expected_link_target" "$claude_link"
      LINKED=$((LINKED + 1))
    else
      echo "SKIP link (occupied): .claude/skills/$skill_name"
      SKIPPED=$((SKIPPED + 1))
    fi
  else
    ln -s "$expected_link_target" "$claude_link"
    LINKED=$((LINKED + 1))
  fi
done

echo "✓ 同步 $SYNCED 个 Karpathy skills 到 .agents/skills 与 .codex/skills"
echo "  来源: $KARPATHY_SKILLS"
echo "  目标: $AGENTS_TARGET"
echo "  目标: $CODEX_TARGET"
echo "✓ 维护 .claude/skills 链接: linked=$LINKED skipped=$SKIPPED"
echo ""
echo "已同步 skills:"
for skill_dir in "$KARPATHY_SKILLS"/*/; do
  [ -f "$skill_dir/SKILL.md" ] && echo "  - $(basename "$skill_dir")"
done
