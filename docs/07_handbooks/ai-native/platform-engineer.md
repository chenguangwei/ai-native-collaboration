# 🚀 运维工程师操作手册

> 适用于运维/DevOps 角色，基于 AI 原生开发方法论

---

## 角色配置

### 1. 配置当前角色

编辑 `.claude/project-config.json`:

```json
{
  "currentRole": "devops",
  "gitUser": "your@email.com",
  "team": "ops-team"
}
```

### 2. 验证配置

```bash
cat .claude/project-config.json | grep currentRole
```

---

## 日常操作流程

### 1. 启动工作

```bash
# 查看今日任务
cat memory/roles/devops/today.md

# 查看运维文档
cat docs/05_ops/runbook.md
cat docs/05_ops/deploy_env.md
```

### 2. 部署流程

**使用发布技能:**

```
/ship              # 发布检查
/qa                # 自动化验证
```

---

## 常用命令

### 部署发布

| 命令 | 用途 |
|------|------|
| `/ship` | 发布检查清单 |
| `/qa` | 自动化验证 |

### 调试问题

| 命令 | 用途 |
|------|------|
| `/systematic-debugging` | 结构化调试 |
| `/investigate` | 根因调查 |
| `/browse` | 浏览器验证 |

---

## 项目结构

```
ops/
├── docker-compose.yml    # 容器编排
├── k8s/                  # Kubernetes 配置
├── scripts/              # 运维脚本
└── configs/              # 配置文件

docs/05_ops/
├── runbook.md           # 故障排查手册
├── deploy_env.md        # 部署环境配置
└── release-checklists.md # 发布检查单
```

---

## Memory 操作

### 每日开始

```bash
cat memory/roles/devops/today.md
cat docs/05_ops/runbook.md
```

### 每日结束

```markdown
# 更新 memory/roles/devops/today.md
- 记录今日部署
- 记录问题
- 记录解决方案
```

---

## 部署流程

### 1. 部署前检查

```bash
# 检查环境
cat docs/05_ops/deploy_env.md

# 运行测试
npm test
npm run build
```

### 2. 构建镜像

```bash
# 构建 Docker 镜像
docker build -t app:latest .

# 推送镜像
docker push registry/app:latest
```

### 3. 部署

```bash
# 使用 docker-compose
docker-compose up -d

# 或使用 kubectl
kubectl apply -f k8s/
```

### 4. 验证

```bash
# 健康检查
curl http://localhost/health

# 运行冒烟测试
npm run test:e2e
```

---

## 故障排查

### 常用命令

```bash
# 查看日志
docker logs app
kubectl logs app-pod

# 查看状态
docker ps
kubectl get pods

# 进入容器
docker exec -it app sh
kubectl exec -it app-pod -- sh
```

### 常见问题

| 问题 | 排查步骤 |
|------|----------|
| 服务启动失败 | 检查日志 → 检查配置 → 检查资源 |
| 响应慢 | 检查 CPU/内存 → 检查数据库 → 检查网络 |
| 502/504 | 检查服务状态 → 检查负载均衡 → 检查超时配置 |

---

## 监控配置

### 日志

- [ ] 应用日志收集
- [ ] 错误日志告警
- [ ] 日志保留策略

### 指标

- [ ] CPU 使用率
- [ ] 内存使用率
- [ ] 请求延迟
- [ ] 错误率

### 告警

- [ ] 告警阈值设置
- [ ] 告警通知渠道
- [ ] 告警升级策略

---

## 与其他角色协作

### 与开发协作

1. 确认部署需求
2. 提供构建脚本
3. 协助调试

### 与产品协作

1. 确认发布窗口
2. 报告部署状态

---

## 技能触发规则

### 部署流程

```
/ship → 构建 → 部署 → /qa → 验证 → 监控
```

### 问题排查

```
/systematic-debugging → 定位 → 修复 → 验证
```

---

*基于 AI 原生开发方法论 v1.1*
