#!/bin/bash
# =========================================================================
# 脚本：Git Hooks 安装器
# 用途：为项目挂载原生 Git 生命周期事件，保证 Commit 节点 100% 触发记忆流更新
# =========================================================================

set -e

HOOK_DIR=".git/hooks"
HOOK_FILE="$HOOK_DIR/post-commit"

if [ ! -d ".git" ]; then
  echo "❌ 当前目录不是一个 Git 仓库，请先执行 git init"
  exit 1
fi

if [ ! -d "$HOOK_DIR" ]; then
  mkdir -p "$HOOK_DIR"
fi

echo "📦 正在注入 Git 后置断点钩子 (post-commit) ..."

cat << 'EOF' > "$HOOK_FILE"
#!/bin/bash
# =========================================================================
# 此脚本由 install-git-hooks.sh 自动生成。
# 功能：在每次 git commit 成功后，获取提交上下文，自动向 memory/handoff.md 打桩
# =========================================================================

# 获取最后的提交信息、作者和时间
COMMIT_MSG=$(git log -1 --pretty=format:"%s")
AUTHOR=$(git log -1 --pretty=format:"%an")
TIMESTAMP=$(date +"%Y-%m-%d %H:%M")

# 抽取最多 3 个被修改的文件名作为范围标图
FILES_CHANGED=$(git show --name-only --format="" HEAD | grep -v '^$' | head -n 3 | tr '\n' ',' | sed 's/,$//')

# 无感知向交接流文件硬写入
echo "" >> memory/handoff.md
echo "**[Git 物理打桩 ($AUTHOR) - $TIMESTAMP]**: 代码已锁定进版 (\`$COMMIT_MSG\`)。变动辐射范围包含等文件：\`$FILES_CHANGED\`" >> memory/handoff.md

# 向控制台输出温馨提示
echo "🤖 [AI-Native 基建] 已由 Git 钩子将本次 Commit 锚点物理同步至 memory/handoff.md (存档成功！)"
EOF

chmod +x "$HOOK_FILE"

echo ""
echo "🎉 自动追踪 Hook 安装成功！"
echo "未来无论是您手动敲击，还是 AI 用 bash 工具执行了 \`git commit\`，都会在极速 1ms 内触发底层脚本，将本次提交痕迹定死在 handoff.md 尾部，作为极度可靠的兜底存档。"
echo ""
