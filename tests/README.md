# 🕵️ 自动化测试区

> 严格遵循 TDD 原则

---

## 目录结构

```
tests/
├── /e2e_browser/          # 端到端测试 (Playwright)
│   ├── /pages/           # 页面对象
│   ├── /tests/           # 测试用例
│   └── playwright.config.ts
│
├── /api_integration/      # 接口集成测试
│   ├── /tests/           # API 测试
│   └── jest.config.js
│
└── /unit/                # 单元测试
    ├── /src/             # 源代码
    └── /tests/           # 测试文件
```

---

## 测试运行

```bash
# 运行所有测试
npm test

# 运行单元测试
npm run test:unit

# 运行集成测试
npm run test:api

# 运行 E2E 测试
npm run test:e2e

# 运行带覆盖率
npm run test:coverage
```

---

## 测试规范

### 单元测试
- 每个函数/模块必须有测试
- 覆盖率 > 60%

### 集成测试
- 基于 `/docs/03_architecture/api_specs.md`
- 测试 API 契约

### E2E 测试
- 基于 `/docs/04_qa/test_cases.md`
- 模拟真实用户行为

---

## 覆盖率目标

| 级别 | 行覆盖率 | 分支覆盖率 |
|------|----------|------------|
| 最低 | 60% | 50% |
| 推荐 | 80% | 70% |
| 优秀 | 90% | 80% |
