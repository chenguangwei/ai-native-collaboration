# 运维工程师操作手册

> 过渡期版。参考 [README.md](README.md) 了解完整团队协作流程。

---

## 角色配置

```json
{
  "currentRole": "platform-engineer",
  "gitUser": "ops@company.com"
}
```

---

## 标准发布序列

```
1. 确认测试报告，质量门禁全通过
2. /ship          → 发布前检查清单
3. 部署预发环境 → 冒烟测试
4. /canary        → 灰度 5%，观察 15 分钟
5. /land-and-deploy → 全量发布
6. 验证关键指标（错误率 / P99 / 业务指标）
7. /retro         → 每次发布复盘（必做）
```

---

## 故障响应流程

```
告警触发
    ↓
/investigate       → 快速定位影响范围
    ↓
/systematic-debugging → 找到根因
    ↓
能热修复？→ 修复并观察
不能？    → 回滚（ops/runbook/rollback.md）
    ↓
通知相关方
    ↓
/retro → /learner  → 更新 Runbook
```

---

## 关键监控指标

| 指标 | 正常阈值 |
|------|---------|
| 错误率 | < 0.1% |
| P99 响应时间 | < SLA 阈值 |
| CPU | < 80% |
| 内存 | < 80% |
| 业务成功率 | > 99.9% |

---

## 安全操作保护

```
/guard    → 高风险操作前全安全防护
/careful  → 破坏性命令前二次确认
/freeze   → 锁定目录防止误操作
```

**常用文件**：`ops/docker-compose.yml` · `ops/k8s/` · `docs/05_ops/runbook.md`
