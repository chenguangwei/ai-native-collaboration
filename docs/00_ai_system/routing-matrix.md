# 🤖 AI 运维域 - 模型分发路由图

> 何种任务派给 Claude，何种派给 DeepSeek/o3-mini

---

## 路由规则

### 任务类型 → 模型映射

| 任务类型 | 推荐模型 | 原因 |
|----------|----------|------|
| 代码审查 | Claude | 理解力强，代码质量高 |
| Bug 修复 | Claude | 推理能力强 |
| 快速原型 | o3-mini | 速度快，成本低 |
| 批量处理 | DeepSeek | 成本优化 |
| 复杂推理 | Claude | 深度思考 |
| 简单脚本 | o3-mini | 快速交付 |

---

## 场景示例

### 场景 1: 新功能开发

```bash
# 使用 Claude - 需要深度理解
/planceo → 分析需求
/plan-architect → 技术设计
```

### 场景 2: 批量代码修改

```bash
# 可使用 o3-mini
批量重命名文件
批量替换字符串
```

### 场景 3: 成本优化

```bash
# 使用 DeepSeek
日志分析
数据处理
```

---

## 配置

```json
{
  "routing": {
    "default": "claude",
    "fallback": "o3-mini",
    "costThreshold": 0.1,
    "speedThreshold": 5000
  }
}
```
