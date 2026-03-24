# 前端应用

选择技术栈后，此目录结构由 `scripts/replace-placeholders.sh` 自动生成。

## 支持的技术栈

| 技术栈 | 初始化命令 | 模板文档 |
|--------|------------|------|
| React + Vite | `./scripts/replace-placeholders.sh <名称> react <后端>` | `templates/frontend/react/README.md` |
| Vue 3 + Vite | `./scripts/replace-placeholders.sh <名称> vue <后端>` | `templates/frontend/vue/README.md` |
| Next.js 14 | `./scripts/replace-placeholders.sh <名称> next <后端>` | `templates/frontend/next/README.md` |

## 开发规范（所有技术栈通用）

- 组件/函数命名语义化（见 `.claude/rules/anti-slop.md`）
- 状态管理按需引入，不提前设计
- API 类型定义放 `../shared/types/`，前后端共享
- 遵循 TDD：先写测试，再写实现
