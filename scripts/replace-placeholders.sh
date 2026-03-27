#!/bin/bash
# 项目初始化脚本 - 替换脚手架占位符，复制技术栈模板
# 用法：./scripts/replace-placeholders.sh <项目名> <frontend:react|vue|next> <backend:java|python>

set -e

PROJECT_NAME="${1:?用法: $0 <项目名> <frontend:react|vue|next> <backend:java|python>}"
FRONTEND="${2:-react}"
BACKEND="${3:-java}"

case "$FRONTEND" in react|vue|next) ;; *)
  echo "❌ frontend 参数必须是: react | vue | next"; exit 1
esac

case "$BACKEND" in java|python) ;; *)
  echo "❌ backend 参数必须是: java | python"; exit 1
esac

echo "🚀 初始化项目: $PROJECT_NAME (frontend: $FRONTEND, backend: $BACKEND)"
echo ""

# Step 1: 替换文档中的占位符
echo "📝 替换占位符..."
find . \( -name "*.md" -o -name "*.json" -o -name "*.yml" \) \
  -not -path "./.git/*" \
  -not -path "./node_modules/*" \
  -not -path "./.scaffold/*" \
  -exec sed -i.bak "s/\[项目名称\]/$PROJECT_NAME/g" {} \;
find . -name "*.bak" -delete
echo "   ✅ 占位符替换完成"

# Step 2: 复制前端技术栈模板
FRONTEND_TEMPLATE="templates/frontend/$FRONTEND"
if [ -d "$FRONTEND_TEMPLATE" ]; then
  echo "📦 复制前端模板 ($FRONTEND)..."
  cp -r "$FRONTEND_TEMPLATE/." src/frontend/
  echo "   ✅ 前端模板复制完成"
else
  echo "   ⚠️  前端模板 $FRONTEND_TEMPLATE 不存在，跳过"
fi

# Step 3: 复制后端技术栈模板
BACKEND_TEMPLATE="templates/backend/$BACKEND"
if [ -d "$BACKEND_TEMPLATE" ]; then
  echo "📦 复制后端模板 ($BACKEND)..."
  cp -r "$BACKEND_TEMPLATE/." src/backend/
  echo "   ✅ 后端模板复制完成"
else
  echo "   ⚠️  后端模板 $BACKEND_TEMPLATE 不存在，跳过"
fi

# Step 4: 更新 project-config.json
echo "⚙️  更新项目配置..."
if command -v python3 &>/dev/null; then
  python3 - <<EOF
import json

with open('.claude/project-config.json', 'r') as f:
    cfg = json.load(f)

cfg['project'] = '$PROJECT_NAME'
cfg['version'] = '1.0.0'

with open('.claude/project-config.json', 'w') as f:
    json.dump(cfg, f, indent=2, ensure_ascii=False)
    f.write('\n')

print('   ✅ project-config.json 已更新')
EOF
else
  echo "   ⚠️  未找到 python3，请手动更新 .claude/project-config.json"
fi

echo ""
echo "✅ 项目初始化完成！"
echo ""
echo "项目名称: $PROJECT_NAME"
echo "前端技术栈: $FRONTEND"
echo "后端技术栈: $BACKEND"
echo ""
echo "下一步："
echo "  1. git init && git add -A && git commit -m 'feat: 初始化项目 $PROJECT_NAME'"
echo "  2. 【重要】更新 memory/active-task.md 写下第一批执行 Checklist"
echo "  3. 启动 Claude Code，运行 /plan-ceo 开始规划"
