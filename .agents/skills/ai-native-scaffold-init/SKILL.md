# AI Native Scaffold Init

初始化新项目基于 AI Native 脚手架。

## 使用场景

当用户说 "基于脚手架创建新项目" 或 "用 AI Native 模板初始化项目" 时使用。

## 工作流程

### 1. 确认项目信息

在开始前，确认以下信息：

| 问题 | 目的 |
|------|------|
| 项目名称 | 用于替换目录名和文档 |
| 项目类型 | Web / Mobile / API / 全栈 |
| 使用的 LLM | Claude / DeepSeek / o3-mini |
| 是否需要移动端 | React Native / Flutter |

### 2. 执行初始化

```bash
# 复制脚手架到新目录
cp -r /path/to/ai-native-project-root /path/to/new-project
cd new-project

# 初始化 git（如果需要）
git init

# 安装依赖
npm install
```

### 3. 替换占位符

使用项目的 `replace-placeholders.sh` 脚本：

```bash
# 替换所有占位符
./scripts/replace-placeholders.sh "项目名称" "项目类型"
```

或手动替换：

| 占位符 | 替换为 |
|--------|--------|
| `[项目名称]` | 实际项目名 |
| `[项目类型]` | Web / Mobile / API |
| `2024-01-01` | 当前日期 |

### 4. 自定义配置

根据项目需求调整：

- [ ] 修改 `CLAUDE.md` 中的角色定义
- [ ] 更新 `docs/01_product/prd_v1.0.md`
- [ ] 配置 `rules/skill-triggers.md` 中的触发条件
- [ ] 设置 `/memory/today.md` 的初始状态

### 5. 初始化检查清单

```
□ README.md 已更新项目信息
□ CLAUDE.md 角色已自定义
□ PRD 已创建
□ Git 已初始化
□ 依赖已安装
□ VSCode 配置已调整（如果需要）
```

## 输出

完成后输出：

```
✅ AI Native 项目初始化完成

项目: [项目名称]
类型: [项目类型]
位置: /path/to/new-project

下一步:
1. cd new-project
2. 启动 AI 助手
3. 使用 /plan-ceo 开始规划
```
