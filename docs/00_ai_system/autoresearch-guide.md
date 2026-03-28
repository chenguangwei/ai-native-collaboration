# Autoresearch 使用手册

> 自主目标驱动迭代引擎。灵感来源：[Karpathy's autoresearch](https://github.com/karpathy/autoresearch)
> 插件来源：[uditgoenka/autoresearch](https://github.com/uditgoenka/autoresearch) v1.8.2

---

## 核心思想

**修改 → 验证 → 保留/丢弃 → 重复**

对任何有可量化指标的目标，AI 进入无限自主循环，直到被中断或达到 `Iterations: N` 上限。

---

## 子命令速览

| 命令 | 用途 |
|------|------|
| `/autoresearch` | 通用自主优化循环（默认入口） |
| `/autoresearch:plan` | 将自然语言目标转化为可执行配置 |
| `/autoresearch:debug` | 科学方法驱动的 Bug 猎杀循环 |
| `/autoresearch:fix` | 自动修复测试/类型/Lint/构建错误，直至归零 |
| `/autoresearch:security` | STRIDE + OWASP Top 10 安全审计 |
| `/autoresearch:ship` | 通用交付工作流（代码/内容/营销/设计） |
| `/autoresearch:scenario` | 场景驱动用例生成，探索边界与失效模式 |
| `/autoresearch:predict` | 多专家视角群体预测（架构师/安全分析/性能工程师等） |
| `/autoresearch:learn` | 自主学习代码库，生成/更新文档 |

---

## 快速上手

### 无界循环（默认）

```
/autoresearch
Goal: 将测试覆盖率提升到 90%
Scope: src/**/*.ts
Metric: 覆盖率百分比（更高越好）
Verify: npm test -- --coverage
```

### 有界循环（限定迭代次数）

```
/autoresearch
Goal: 减少 Bundle 体积到 200KB 以下
Scope: src/components/**
Metric: bundle size KB（更低越好）
Verify: npm run build && du -k dist/bundle.js | cut -f1
Iterations: 15
```

### 只配规划，不立即执行

```
/autoresearch:plan
Goal: 提升 API 响应速度
```

---

## 常用场景示例

### 安全审计

```
# 全量审计
/autoresearch:security

# 仅审计变更文件
/autoresearch:security --diff

# 审计后自动修复 Critical/High 问题
/autoresearch:security --fix
Iterations: 15

# CI/CD 门控——发现 Critical 则非零退出
/autoresearch:security --fail-on critical
Iterations: 10
```

### Bug 猎杀

```
/autoresearch:debug
Issue: 用户登录后偶发 500 错误
Scope: src/auth/**
```

### 错误修复循环

```
# 修复直到所有测试通过
/autoresearch:fix
Target: src/api/**
Guard: npm test
```

### 交付前验收

```
# 自动检测交付类型
/autoresearch:ship

# 仅生成并检查发布清单
/autoresearch:ship --checklist-only

# 回滚上次交付
/autoresearch:ship --rollback
```

### 场景探索

```
/autoresearch:scenario
Scenario: 用户携带多种支付方式结账
Domain: software
Depth: standard
Iterations: 25
```

### 多专家视角预测

```
# 标准分析
/autoresearch:predict
Scope: src/**/*.ts
Goal: 找出可靠性问题

# 链式：预测 → 场景 → Debug → 修复
/autoresearch:predict --chain scenario,debug,fix
Scope: src/**
Goal: 新功能全质量流水线
```

### 代码库文档化

```
# 自动检测并初始化/更新文档
/autoresearch:learn

# 强制初始化
/autoresearch:learn --mode init --depth deep

# 仅健康检查（只读）
/autoresearch:learn --mode check
```

---

## 循环机制

```
LOOP (无限 or N 次):
  1. Review  — 读取当前状态 + git 历史 + 结果日志
  2. Ideate  — 基于目标和历史结果选取下一步改动
  3. Modify  — 对范围内文件做一次聚焦改动
  4. Commit  — git commit（验证前先提交）
  5. Verify  — 运行指标命令
  6. Guard   — 若设置了 Guard，运行防回归检查
  7. Decide  — 改善且 Guard 通过 → Keep；否则 git revert → Discard
  8. Log     — 记录结果到 TSV
  9. Repeat
```

**核心原则**：
- 每次迭代只做一件事（原子改动）
- 纯机械指标，零主观判断
- `git revert` 而非 `git reset --hard`，失败实验留在历史中
- 困境时重读代码，不轻易找用户求助

---

## 输出目录结构

各子命令在项目根目录创建对应文件夹：

| 子命令 | 输出目录 |
|--------|---------|
| `security` | `security/{YYMMDD}-{HHMM}-{slug}/` |
| `ship` | `ship/{YYMMDD}-{HHMM}-{slug}/` |
| `scenario` | `scenario/{YYMMDD}-{HHMM}-{slug}/` |
| `predict` | `predict/{YYMMDD}-{HHMM}-{slug}/` |
| `learn` | `learn/{YYMMDD}-{HHMM}-{slug}/` |

---

## 与项目工作流的集成建议

| 场景 | 推荐命令 |
|------|---------|
| 功能开发完成后回归 | `/autoresearch:fix` + Guard: npm test |
| PR 合并前质量门控 | `/autoresearch:predict --chain fix --fail-on critical` |
| 上线前发布检查 | `/autoresearch:ship --checklist-only` |
| 定期安全扫描 | `/autoresearch:security --diff` |
| 新人理解代码库 | `/autoresearch:learn --mode summarize --scan` |

---

## 与其他技能的定位差异

| 技能 | 定位 |
|------|------|
| `/autoresearch` | **自主闭环迭代**，有指标，无人监督 |
| `/ultrawork` | 并行执行引擎，Haiku/Sonnet/Opus 分层路由 |
| `/ralph` | PRD 驱动的持续执行，不完成不停止 |
| `/ultraqa` | QA 循环直到全部测试通过 |
| `/autopilot` | idea → 规格 → 实现 → QA 全自动流水线 |

autoresearch 的核心差异：**有可量化的机械指标驱动的修改-验证循环**，适合有明确"好/坏"判断标准的任务。

---

*插件版本: v1.8.2 | 上游: [uditgoenka/autoresearch](https://github.com/uditgoenka/autoresearch)*
