# 🎯 技能触发机制

> 场景匹配即自动触发的分级技能体系

## 触发等级

### Level 1: 强制触发 (Always)
这些技能在特定场景下必须触发，无需人类确认。

| 场景 | 技能 | 说明 |
|------|------|------|
| 开始任何创意工作 | brainstorming | 创建功能、组件、功能修改 |
| 遇到 Bug/错误 | systematic-debugging | 系统化排障 |
| 完成实现前 | verification-before-completion | 验证通过后才能声称完成 |
| 收到代码审查反馈 | receiving-code-review | 实现审查建议前 |

### Level 2: 推荐触发 (Recommended)
这些技能在匹配场景时推荐使用。

| 场景 | 技能 | 说明 |
|------|------|------|
| 实现新功能/修复 | test-driven-development | TDD 方式开发 |
| 规划多步骤任务 | writing-plans | 创建实现计划 |
| 需要隔离开发 | using-git-worktrees | 使用 git worktree |
| 提交 PR 前 | requesting-code-review | 请求代码审查 |
| 完成开发分支 | finishing-a-development-branch | 分支收尾工作 |

### Level 3: 可选触发 (Optional)
按需手动调用。

| 场景 | 技能 | 说明 |
|------|------|------|
| 创建新技能 | writing-skills | 创建或编辑技能 |
| 构建前端界面 | frontend-design | 设计前端界面 |
| 构建 API 应用 | claude-api | 使用 Claude API |
| 优化 React 代码 | react-best-practices | React 性能优化 |

---

## 自动触发规则

### 关键词匹配

```
创建 → brainstorming
实现 → test-driven-development
修复 → systematic-debugging
测试 → verification-before-completion
计划 → writing-plans
审查 → code-review
发布 → finishing-a-development-branch
```

### 模式匹配

```typescript
// 触发 brainstorming 的模式
const triggerPatterns = [
  /创建.*功能/,
  /实现.*需求/,
  /添加.*组件/,
  /build.*feature/,
  /implement.*/
];

// 触发 debugging 的模式
const debugPatterns = [
  /错误|报错|bug|fix/i,
  /cannot read/i,
  /undefined is not/i,
  /failed to/i
];
```

---

## 手动触发

### 常用 Slash Commands

```bash
/plan-ceo        # 产品思维
/plan-architect # 架构师思维
/review          # 代码审查
/qa              # 自动化测试
/ship            # 发布检查
/debug           # 排障模式
/retro           # 复盘模式
```

### 技能调用

```bash
# 使用 Skill 工具
Skill: { skill: "brainstorming" }
Skill: { skill: "test-driven-development" }
Skill: { skill: "systematic-debugging" }
```

---

## 技能清单

### 核心技能 (Core)
- [x] brainstorming - 头脑风暴
- [x] systematic-debugging - 系统化排障
- [x] test-driven-development - TDD 开发
- [x] verification-before-completion - 完成前验证
- [x] writing-plans - 编写计划

### 协作技能 (Collaboration)
- [x] receiving-code-review - 接收代码审查
- [x] requesting-code-review - 请求代码审查
- [x] finishing-a-development-branch - 完成开发分支
- [x] using-git-worktrees - Git Worktree 使用

### 开发技能 (Development)
- [x] frontend-design - 前端设计
- [x] frontend-slides - 演示文稿
- [x] react-best-practices - React 最佳实践
- [x] claude-api - Claude API 使用

### 运维技能 (Ops)
- [x] canvas-design - 画布设计
- [x] diagram-generator - 图表生成

---

## 触发流程

```
1. 用户输入
      ↓
2. 关键词/模式匹配
      ↓
3. 确定触发等级
      ↓
4. 执行技能 (强制/推荐)
      ↓
5. 人类确认 (可选触发)
      ↓
6. 继续工作
```

---

## 配置

技能触发可在 `settings.json` 中自定义:

```json
{
  "skillTriggers": {
    "autoTrigger": true,
    "requiredSkills": ["brainstorming", "systematic-debugging"],
    "ignoredPatterns": ["^simple.*", "^minor.*"]
  }
}
```
