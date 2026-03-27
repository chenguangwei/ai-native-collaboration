# 传统岗位配置（过渡期）

> 保留原有分工协作方式，用 AI 工具放大每个岗位的产出效率。

---

## 快速配置

编辑 `.claude/project-config.json`，设置 `currentRole`：

```json
{
  "currentRole": "delivery-engineer",
  "gitUser": "your@email.com"
}
```

## 传统岗位 → currentRole 映射

| 你的岗位 | currentRole 值 | 说明 |
|---------|---------------|------|
| 产品经理 | `product-manager` | 需求策略、PRD |
| 前端工程师 | `frontend` | UI、交互、前端逻辑 |
| 后端工程师 | `backend` | API、服务、数据层 |
| 测试工程师 | `qa` | 测试、安全、质量保障 |
| 运维工程师 | `devops` | 基础设施、部署、监控 |

---

## 各岗位核心命令

### 产品经理

```bash
/deep-interview   # 需求 Socratic 澄清
/plan-ceo-review  # CEO 视角评审
/office-hours     # YC 压力测试
/ralplan          # 复杂功能规划
/retro            # 迭代复盘
```

### 前端工程师

```bash
/brainstorming         # 新功能启动
/test-driven-development  # TDD 开发
/frontend-design       # UI 界面构建
/react-best-practices  # React 性能优化
/ai-slop-cleaner       # 清理 AI 代码味道
/review                # 提 PR 前代码审查
```

### 后端工程师

```bash
/brainstorming         # 新功能启动
/test-driven-development  # TDD 开发
/api-design            # REST API 设计
/backend-patterns      # 架构模式参考
/systematic-debugging  # 遇到 Bug 时
/learner               # 复杂 Bug 修复后提取经验
```

### 测试工程师

```bash
/qa              # 自动化测试（执行+修复）
/qa-only         # 只看报告
/ultraqa         # QA 循环直到通过
/cso             # 安全审计
/benchmark       # 性能基线
/learner         # 提取 Bug 模式
```

### 运维工程师

```bash
/ship            # 发布前检查清单
/land-and-deploy # 合并+部署
/canary          # 金丝雀发布监控
/investigate     # 根因调查
/retro           # 故障/迭代复盘
/learner         # 提取运维经验
```

---

## 过渡路径

当团队准备好迁移到 AI-Native 体系时，参考 [../ai-native/ROLE_SETUP.md](../ai-native/ROLE_SETUP.md)。

迁移信号：
- 前端/后端工程师开始互相承接对方的工作
- 不再需要"会 Java 的后端"这样的岗位描述
- 需求→上线由更少的人完成
