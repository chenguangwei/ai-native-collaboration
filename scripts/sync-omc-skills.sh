#!/usr/bin/env bash
# sync-omc-skills.sh
# 同步 OMC vendored 版 skills 到:
# 1) .agents/skills/ (Codex 技能发现)
# 2) .claude/skills/<name> -> omc/skills/<name> (Claude Code 技能发现)
# 同步 OMC vendored 版 agents 到:
# 3) .agents/agents/omc-*.md (Codex Agent 发现)
# 4) .claude/agents/omc-*.md + 可用时创建 <name>.md 别名 (Claude Code Agent 发现)
# 每次 OMC 升级后运行此脚本

set -e

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
OMC_SKILLS="$ROOT/.claude/skills/omc/skills"
OMC_AGENTS="$ROOT/.claude/skills/omc/agents"
AGENTS_TARGET="$ROOT/.agents/skills"
CLAUDE_SKILLS_ROOT="$ROOT/.claude/skills"
AGENTS_AGENT_ROOT="$ROOT/.agents/agents"
CLAUDE_AGENT_ROOT="$ROOT/.claude/agents"

if [ ! -d "$OMC_SKILLS" ]; then
  echo "ERROR: OMC skills 不存在: $OMC_SKILLS"
  echo "请确认 .claude/skills/omc/ 目录完整"
  exit 1
fi

if [ ! -d "$OMC_AGENTS" ]; then
  echo "ERROR: OMC agents 不存在: $OMC_AGENTS"
  echo "请确认 .claude/skills/omc/ 目录完整"
  exit 1
fi

mkdir -p "$AGENTS_TARGET" "$CLAUDE_SKILLS_ROOT" "$AGENTS_AGENT_ROOT" "$CLAUDE_AGENT_ROOT"

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

AGENT_SYNCED=0
AGENT_ALIAS_LINKED=0
AGENT_ALIAS_SKIPPED=0
for agent_file in "$OMC_AGENTS"/*.md; do
  [ -f "$agent_file" ] || continue

  filename=$(basename "$agent_file")          # e.g. architect.md
  agent_name="${filename%.md}"                # e.g. architect
  prefixed_name="omc-$filename"               # e.g. omc-architect.md

  # 1) 同步到 .agents/agents/omc-*.md（复制文件，兼容性更稳）
  cp -f "$agent_file" "$AGENTS_AGENT_ROOT/$prefixed_name"

  # 2) 同步到 .claude/agents/omc-*.md（复制文件）
  cp -f "$agent_file" "$CLAUDE_AGENT_ROOT/$prefixed_name"
  AGENT_SYNCED=$((AGENT_SYNCED + 1))

  # 3) 为无冲突场景创建别名：architect.md -> omc-architect.md
  #    如果已有同名自定义文件/链接，则跳过，避免覆盖用户资产。
  claude_alias="$CLAUDE_AGENT_ROOT/$filename"
  agents_alias="$AGENTS_AGENT_ROOT/$filename"

  if [ -e "$claude_alias" ] || [ -L "$claude_alias" ]; then
    if [ -L "$claude_alias" ] && [ "$(readlink "$claude_alias" || true)" = "$prefixed_name" ]; then
      ln -sfn "$prefixed_name" "$claude_alias"
      AGENT_ALIAS_LINKED=$((AGENT_ALIAS_LINKED + 1))
    else
      echo "SKIP agent alias (occupied): .claude/agents/$filename"
      AGENT_ALIAS_SKIPPED=$((AGENT_ALIAS_SKIPPED + 1))
    fi
  else
    ln -s "$prefixed_name" "$claude_alias"
    AGENT_ALIAS_LINKED=$((AGENT_ALIAS_LINKED + 1))
  fi

  if [ -e "$agents_alias" ] || [ -L "$agents_alias" ]; then
    if [ -L "$agents_alias" ] && [ "$(readlink "$agents_alias" || true)" = "$prefixed_name" ]; then
      ln -sfn "$prefixed_name" "$agents_alias"
      AGENT_ALIAS_LINKED=$((AGENT_ALIAS_LINKED + 1))
    else
      echo "SKIP agent alias (occupied): .agents/agents/$filename"
      AGENT_ALIAS_SKIPPED=$((AGENT_ALIAS_SKIPPED + 1))
    fi
  else
    ln -s "$prefixed_name" "$agents_alias"
    AGENT_ALIAS_LINKED=$((AGENT_ALIAS_LINKED + 1))
  fi
done

echo "✓ 同步 $AGENT_SYNCED 个 OMC agents 到 .claude/agents 与 .agents/agents"
echo "  来源: $OMC_AGENTS"
echo "  目标: $CLAUDE_AGENT_ROOT (omc-*.md + alias)"
echo "  目标: $AGENTS_AGENT_ROOT (omc-*.md + alias)"
echo "✓ 维护 agent 别名: linked=$AGENT_ALIAS_LINKED skipped=$AGENT_ALIAS_SKIPPED"
echo ""
echo "已同步 skills:"
for skill_dir in "$OMC_SKILLS"/*/; do
  skill_name=$(basename "$skill_dir")
  [ -f "$skill_dir/SKILL.md" ] && echo "  - $skill_name"
done

echo ""
echo "已同步 agents:"
for agent_file in "$OMC_AGENTS"/*.md; do
  [ -f "$agent_file" ] || continue
  echo "  - $(basename "$agent_file")"
done
