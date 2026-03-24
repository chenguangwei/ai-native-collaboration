# AI-Native Scaffold — Codex CLI 指令

> 本文件为 Codex CLI 专属指令，补充根目录 `AGENTS.md`（如有）。

## 项目技术栈

| 层级 | 技术 |
|------|------|
| 前端 | React / Vue 3 / Next.js 14+ |
| 后端 | Java 17 + Spring Boot 3 / Python 3.11 + FastAPI |
| 测试 | JUnit 5 / pytest / Vitest / Playwright |

## 核心开发原则

1. **TDD 先行** — 先写测试，再写实现；测试覆盖率 ≥80%
2. **不可变性** — 永远创建新对象，禁止原地修改现有对象
3. **原子提交** — 每次提交只做一件事
4. **人类确认** — 严禁未经确认直接 push

## Agent 角色分工

| Agent | 职责 | 何时使用 |
|-------|------|---------|
| `explorer` | 只读代码探索，收集证据 | 理解代码结构、追踪执行路径 |
| `reviewer` | 代码正确性/安全性审查 | 提交前、PR 前 |
| `docs_researcher` | 验证 API、框架行为 | 技术选型、库升级、文档核实 |

## 并行 Agent 使用原则

对于独立任务，始终并行启动多个 agent：

```
好的做法：并行执行
- Agent 1: 安全性分析（auth 模块）
- Agent 2: 性能检查（cache 系统）
- Agent 3: 类型检查（工具函数）

不好的做法：没有依赖时仍然串行
```

## 代码质量检查清单

提交前确认：
- [ ] 函数 <50 行，无深嵌套（>4层）
- [ ] 文件 <800 行，按特性/领域组织
- [ ] 每层都有错误处理，禁止吞掉错误
- [ ] 系统边界处验证所有输入
- [ ] 使用不可变模式，无原地修改
- [ ] 无硬编码的值，使用常量或配置

## 目录结构

```
src/
├── frontend/       # 前端代码（React/Vue/Next.js）
├── backend/        # 后端代码（Java/Python）
└── shared/         # 前后端共享类型/常量

tests/
├── unit/
├── api_integration/
└── e2e_browser/
```

## 安全规范（无 Hooks 时）

Codex CLI 不支持 Hooks，安全由指令层保障：
1. 所有用户输入必须在系统边界处验证
2. 禁止硬编码 secrets — 使用环境变量
3. 提交前运行 `npm audit` / `pip audit`
4. 推送前检查 `git diff`

## MCP 服务器

项目默认启用：
- `github` — GitHub 仓库操作
- `context7` — 库文档上下文
- `sequential-thinking` — 复杂问题推理

按需启用（解注释 config.toml）：
- `playwright` — 浏览器自动化测试
- `exa` — 网络搜索
- `memory` — 跨会话记忆
