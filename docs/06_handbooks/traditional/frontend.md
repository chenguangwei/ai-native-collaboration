# 🎨 前端工程师操作手册

> 适用于前端开发角色，基于 AI 原生开发方法论

---

## 角色流转 (Role Switch)

在会话输入栏中敲击 ，或者直接编辑  认领待办以隐式切换。

---

## 日常开发流程

### 1. 启动工作

```bash
# 查看今日任务
cat memory/active-task.md (宏观进度) / memory/handoff.md (微观交接单)

# 查看设计文档
cat docs/02_design/design_system.md
```

### 2. 开始新任务

**使用设计技能:**

```
/frontend-design     # 创建前端界面
/ui-ux-pro-max      # UI/UX 设计
```

### 3. 开发流程

```
/brainstorming → /writing-plans → /test-driven-development → 开发 → /verification
```

---

## 常用命令

### UI/UX 设计

| 命令 | 用途 |
|------|------|
| `/frontend-design` | 创建前端界面 |
| `/ui-ux-pro-max` | 专业 UI/UX 设计 |
| `/design-consultation` | 设计方向咨询 |
| `/design-review` | 设计质量审查 |

### 代码开发

| 命令 | 用途 |
|------|------|
| `/react-best-practices` | React 最佳实践 |
| `/test-driven-development` | TDD 开发 |
| `/verification-before-completion` | 完成验证 |

### 代码质量

| 命令 | 用途 |
|------|------|
| `/review` | 代码审查 |
| `/simplify` | 代码简化 |
| `/codex` | 代码风格 |

### UI 质量检查

| 命令 | 用途 |
|------|------|
| `/baseline-ui` | UI 质量基线 |
| `/fixing-accessibility` | 无障碍修复 |
| `/fixing-motion-performance` | 动画性能 |
| `/fixing-metadata` | SEO 元数据 |

### 测试发布

| 命令 | 用途 |
|------|------|
| `/qa` | 自动化测试 |
| `/ship` | 发布检查 |

---

## 设计迭代技能

| 技能 | 命令 | 用途 |
|------|------|------|
| 适配 | `/adapt` | 响应式适配 |
| 动画 | `/animate` | 交互动画 |
| 布局 | `/arrange` | 布局优化 |
| 调色 | `/colorize` | 色彩添加 |
| 抛光 | `/polish` | 最终打磨 |
| 排版 | `/typeset` | 字体优化 |
| 规范化 | `/normalize` | 设计系统匹配 |
| 优化 | `/optimize` | 性能优化 |

---

## Memory 操作

### 每日开始

```bash
cat memory/active-task.md (宏观进度) / memory/handoff.md (微观交接单)
cat docs/02_design/design_system.md
```

### 每日结束

```markdown
# 更新 memory/active-task.md (宏观进度) / memory/handoff.md (微观交接单)
- 记录今日完成
- 记录待办
- 记录问题
```

---

## 项目结构

```
src/frontend/
├── components/      # UI 组件
├── pages/          # 页面
├── hooks/          # 自定义 Hooks
├── styles/          # 样式
└── utils/          # 工具函数

tests/
├── unit/           # 组件测试
└── e2e_browser/   # E2E 测试
```

---

## 常用开发命令

```bash
# 安装依赖
npm install

# 开发服务器
npm run dev

# 构建
npm run build

# 测试
npm run test

# Lint
npm run lint
```

---

## 与其他角色协作

### 与后端协作

1. 查看 API 文档: `docs/03_architecture/api_specs.md`
2. 对接接口
3. 处理错误

### 与设计协作

1. 使用 `/design-review` 审查设计
2. 使用 `/ui-ux-pro-max` 优化 UI

### 与 QA 协作

1. 确保 E2E 测试覆盖
2. 使用 `/qa` 验证功能

---

## 技能触发规则

### 新功能开发

```
/brainstorming → /frontend-design → /writing-plans → /test-driven-development → /verification → /review
```

### UI 优化

```
/design-review → /polish|/optimize|/arrange → /verification
```

### 发布

```
/ship → /qa → /verification → 合并
```

---

*基于 AI 原生开发方法论 v1.1*
