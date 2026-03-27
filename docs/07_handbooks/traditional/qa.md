# 测试工程师操作手册

> 过渡期版。参考 [README.md](README.md) 了解完整团队协作流程。

---

## 角色配置

```json
{
  "currentRole": "quality-engineer",
  "gitUser": "qa@company.com"
}
```

---

## 核心工作流

### 1. 制定测试计划

读取 PRD 验收标准 → 拆解为测试用例 → 写入 `docs/04_qa/test_cases_{feature}.md`

### 2. 执行测试

```
/qa         → 自动化执行（单元 + 集成 + E2E）+ 自动修复
/qa-only    → 只看报告，不修复
/ultraqa    → 循环执行直到全部通过
```

### 3. 专项检查

```
/cso        → 安全审计
/benchmark  → 性能基线
/audit      → UI 质量审计
```

### 4. 经验沉淀

```
/learner    → Bug 修复后提取可复用知识
```

---

## 测试用例格式

```markdown
## TC-001 正常登录流程

**对应 AC**：AC-01
**前置条件**：用户已注册，账号未锁定
**步骤**：POST /api/auth/login { email, password }
**预期结果**：返回 200 + JWT token
**自动化**：是
```

---

## 上线准入（质量门禁）

- [ ] 所有 AC 验收通过
- [ ] P0/P1 缺陷清零
- [ ] 自动化覆盖率 ≥ 80%
- [ ] 安全扫描无高危漏洞
- [ ] P99 响应时间达标

**全部通过后**，修改 `active-tasks.json` 状态为 `ready_for_deploy`。

---

## 推荐 Agents

| Agent | 用途 |
|-------|------|
| `omc-qa-tester` | QA 测试方案设计 |
| `omc-verifier` | 验收标准核查 |
| `omc-security-reviewer` | 安全测试 |
| `security-auditor`（内置）| 自动漏洞扫描 |
