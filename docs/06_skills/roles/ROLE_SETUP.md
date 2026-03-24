# 角色技能配置说明

> 各角色启动时需要了解的技能和工作模式。

---

## 快速配置

编辑 `.claude/project-config.json`，设置 `currentRole`：

```json
{
  "currentRole": "backend",
  "gitUser": "your@email.com"
}
```

或使用命令切换：`/switch-role backend`

---

## 各角色说明

### fullstack（全栈工程师）

**工作焦点：** `src/frontend/`、`src/backend/`、`src/shared/`

**常用命令：**
- `/plan-architect` — 技术方案设计
- `/review` — 代码审查（前后端均覆盖）
- `/qa` — 全栈测试

**推荐 Agent：**
- `frontend-reviewer`（前端代码审查）
- `java-reviewer` 或 `python-reviewer`（后端代码审查）
- `security-auditor`（安全扫描）

---

### frontend（前端工程师）

**工作焦点：** `src/frontend/`、`src/shared/types/`

**常用命令：**
- `/review` — 前端代码审查
- `/qa` — 前端测试

**推荐 Agent：**
- `frontend-reviewer`
- `performance-analyzer`（性能分析）

**专属规则：** `.claude/rules/component-rules.md`（组件规范）

---

### backend（后端工程师）

**工作焦点：** `src/backend/`、`src/shared/types/`

**常用命令：**
- `/review` — 后端代码审查
- `/qa` — API 集成测试

**推荐 Agent：**
- `java-reviewer` 或 `python-reviewer`
- `security-auditor`

**专属规则：** `.claude/rules/api-rules.md`（API 规范）

---

### pm（产品经理）

**工作焦点：** `docs/01_product/`、`memory/roles/pm/`

**常用命令：**
- `/plan-ceo` — 产品规划
- `/retro` — 迭代复盘

**日常文件：**
- `docs/01_product/prd_v1.0.md` — PRD
- `docs/01_product/business_rules.md` — 业务规则

---

### qa（测试工程师）

**工作焦点：** `tests/`、`docs/04_qa/`

**常用命令：**
- `/qa` — 执行测试计划
- `/review` — 测试代码审查

**目录说明：**
- `tests/unit/` — 单元测试
- `tests/api_integration/` — API 集成测试
- `tests/e2e_browser/` — 端到端测试

---

### devops（运维工程师）

**工作焦点：** `ops/`、`docs/05_ops/`

**常用命令：**
- `/ship` — 发布检查
- `/debug` — 生产问题排查

**常用文件：**
- `ops/docker-compose.yml`
- `ops/k8s/`
- `docs/05_ops/runbook.md`

---

### architect（架构师）

**工作焦点：** `docs/03_architecture/`

**常用命令：**
- `/plan-architect` — 架构设计
- `/retro` — 架构复盘

**核心文档：**
- `docs/03_architecture/system_flow.md`
- `docs/03_architecture/api_specs.md`
- `docs/03_architecture/db_schema.md`

---

## 多 AI 并发配置

多人/多窗口并发工作时：

```bash
# 创建独立工作目录（前端 AI 使用）
git worktree add ../workspace-frontend feature/login-ui
cd ../workspace-frontend
# 修改此目录的 .claude/project-config.json → currentRole = "frontend"
```

任务协调使用 `scripts/lock.sh`：

```bash
./scripts/lock.sh acquire login-ui-task frontend
# ... 完成工作 ...
./scripts/lock.sh release login-ui-task
```

查看所有角色任务锁状态：

```bash
./scripts/lock.sh status
```
