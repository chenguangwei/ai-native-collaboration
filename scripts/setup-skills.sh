#!/usr/bin/env bash
# setup-skills.sh — 跨平台 skill 链接脚本
# macOS/Linux: 创建 symlinks
# Windows (Git Bash): 创建 directory junctions
#
# Usage:
#   bash scripts/setup-skills.sh          # 首次设置
#   bash scripts/setup-skills.sh --force  # 强制重建所有链接

set -euo pipefail

ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
GSTACK_SRC="$ROOT/.claude/skills/gstack"
CLAUDE_SKILLS="$ROOT/.claude/skills"
AGENTS_SKILLS="$ROOT/.agents/skills"

# ---------- platform detection ----------
is_windows() {
  [[ "$(uname -s)" == MINGW* ]] || [[ "$(uname -s)" == MSYS* ]] || [[ "$(uname -s)" == CYGWIN* ]]
}

FORCE=false
[[ "${1:-}" == "--force" ]] && FORCE=true

# ---------- link helper ----------
# Creates a symlink (macOS/Linux) or junction (Windows)
make_link() {
  local target="$1"  # what to point to
  local link="$2"    # where to create the link

  if [[ -L "$link" ]]; then
    if [[ "$FORCE" == "true" ]]; then
      rm -f "$link"
    else
      return 0  # already a symlink, skip
    fi
  elif [[ -d "$link" ]]; then
    if [[ "$FORCE" == "true" ]]; then
      rm -rf "$link"
    else
      echo "  ⚠️  $link exists as directory, use --force to replace"
      return 0
    fi
  elif [[ -f "$link" ]]; then
    # Windows git clone turns symlinks into text files
    rm -f "$link"
  fi

  if is_windows; then
    # Convert to Windows paths for mklink
    local win_target
    local win_link
    win_target=$(cygpath -w "$target" 2>/dev/null || echo "$target")
    win_link=$(cygpath -w "$link" 2>/dev/null || echo "$link")
    cmd //c "mklink /J \"$win_link\" \"$win_target\"" > /dev/null 2>&1 || {
      echo "  ❌ Failed to create junction: $link"
      echo "     Fallback: copying directory..."
      cp -r "$target" "$link"
    }
  else
    ln -s "$target" "$link"
  fi
}

# ---------- pre-flight check ----------
if [[ ! -d "$GSTACK_SRC" ]]; then
  echo "❌ gstack source not found at $GSTACK_SRC"
  echo "   Please ensure .claude/skills/gstack/ exists in the repository."
  exit 1
fi

if [[ ! -d "$GSTACK_SRC/bin" ]]; then
  echo "❌ gstack source is incomplete (missing bin/)"
  exit 1
fi

echo "🔧 Setting up skill links..."
echo "   Platform: $(uname -s)"
echo "   Source: .claude/skills/gstack/"
echo ""

# ---------- Step 1: .agents/skills/gstack → .claude/skills/gstack ----------
echo "── .agents/skills/gstack ──"
if is_windows; then
  make_link "$GSTACK_SRC" "$AGENTS_SKILLS/gstack"
else
  # Use relative path for portability
  make_link "../../.claude/skills/gstack" "$AGENTS_SKILLS/gstack"
fi
echo "  ✅ .agents/skills/gstack"

# ---------- Step 2: .claude/skills/<name> → gstack/<name> ----------
echo ""
echo "── .claude/skills/ sub-skill links ──"

count=0
for skill_dir in "$GSTACK_SRC"/*/; do
  [[ ! -d "$skill_dir" ]] && continue
  name=$(basename "$skill_dir")

  # Skip non-skill directories
  case "$name" in
    bin|browse|lib|node_modules|docs|scripts|test|supabase|extension|design|.git|.github|.factory|.agents|.cursor|.kiro|.openclaw|.opencode|.slate|agents|autoplan) continue ;;
  esac

  # Must have SKILL.md to be a valid skill
  [[ ! -f "$skill_dir/SKILL.md" ]] && continue

  link_path="$CLAUDE_SKILLS/$name"

  if is_windows; then
    make_link "$skill_dir" "$link_path"
  else
    make_link "gstack/$name" "$link_path"
  fi
  count=$((count + 1))
done

echo "  ✅ $count sub-skill links created"

# ---------- Step 3: Verify ----------
echo ""
echo "── Verification ──"

errors=0

# Check gstack bin accessibility
if [[ -x "$AGENTS_SKILLS/gstack/bin/gstack-config" ]] || [[ -f "$AGENTS_SKILLS/gstack/bin/gstack-config" ]]; then
  echo "  ✅ gstack bin/ accessible"
else
  echo "  ❌ gstack bin/ NOT accessible"
  errors=$((errors + 1))
fi

# Check browse binary
if [[ -x "$AGENTS_SKILLS/gstack/browse/dist/browse" ]] || [[ -f "$AGENTS_SKILLS/gstack/browse/dist/browse" ]]; then
  echo "  ✅ gstack browse/ accessible"
else
  echo "  ❌ gstack browse/ NOT accessible"
  errors=$((errors + 1))
fi

# Check a sample sub-skill
if [[ -f "$CLAUDE_SKILLS/plan-ceo-review/SKILL.md" ]]; then
  echo "  ✅ sample skill (plan-ceo-review) accessible"
else
  echo "  ❌ sample skill (plan-ceo-review) NOT accessible"
  errors=$((errors + 1))
fi

echo ""
if [[ $errors -eq 0 ]]; then
  echo "🎉 Setup complete! All skill links verified."
else
  echo "⚠️  Setup completed with $errors error(s). Check the output above."
fi
