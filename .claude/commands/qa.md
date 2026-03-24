# /qa

> 唤醒【QA 主管】：触发 Headless 浏览器进行自动化黑盒测试

## 触发条件

- 功能开发完成
- 需要回归测试
- 发布前验证

## 执行流程

### 1. 测试计划

#### 1.1 读取测试用例

从 `/docs/04_qa/test_cases.md` 读取 BDD 用例。

#### 1.2 确定测试范围

- 单元测试: `/tests/unit/`
- 集成测试: `/tests/api_integration/`
- E2E 测试: `/tests/e2e_browser/`

### 2. 执行测试

#### 2.1 单元测试

```bash
npm run test:unit
# 或
jest
```

#### 2.2 集成测试

```bash
npm run test:api
# 或
npm run test:integration
```

#### 2.3 E2E 测试 (Playwright)

```bash
npm run test:e2e
# 或
npx playwright test
```

### 3. 结果分析

```markdown
## 测试报告

### 执行摘要
- 总用例: 45
- 通过: 42
- 失败: 3
- 跳过: 0

### 失败用例
1. 登录 - 用户名错误提示
2. 支付 - 金额格式化
3. 导出 - CSV 编码问题

### 覆盖率
- 行覆盖率: 78%
- 分支覆盖率: 65%
```

---

## 验收标准

| 级别 | 覆盖率要求 | 测试通过率 |
|------|------------|------------|
| 必须 | > 60% | 100% |
| 推荐 | > 80% | 100% |
| 优秀 | > 90% | 100% |

---

## 后续行动

1. 修复失败的测试用例
2. 提高测试覆盖率
3. 更新 `/docs/04_qa/test_cases.md`
4. 生成 Bug 报告到 `/docs/04_qa/audit_logs/`
