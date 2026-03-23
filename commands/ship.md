# /ship

> 唤醒【发布工程师】：执行发版前 Checklist 与合规检查

## 触发条件

- 准备发布新版本
- 部署到生产环境
- 合并到主分支

## 执行流程

### 1. 代码状态检查

```bash
# 检查工作区状态
git status

# 检查分支
git branch

# 检查提交历史
git log --oneline -10
```

### 2. 测试验证

```bash
# 运行所有测试
npm test

# 检查覆盖率
npm run test:coverage
```

### 3. 构建验证

```bash
# 构建生产版本
npm run build

# 检查构建产物
ls -la dist/
```

### 4. 安全检查

```bash
# 依赖安全审计
npm audit

# 敏感信息检查
git secrets scan
```

### 5. 发布 Checklist

```markdown
## 发布 Checklist

### 代码质量
- [ ] 所有测试通过
- [ ] 覆盖率达标 (>60%)
- [ ] 无 lint 错误
- [ ] 无安全警告

### 功能完整
- [ ] 所有 P0 功能完成
- [ ] 已知 bug 已修复
- [ ] 文档已更新

### 配置
- [ ] 环境变量已配置
- [ ] 数据库迁移就绪
- [ ] 回滚方案已准备

### 监控
- [ ] 日志配置正确
- [ ] 告警阈值已设置
- [ ] 监控面板就绪
```

---

## 版本号规范

遵循语义化版本:

```
MAJOR.MINOR.PATCH
1.0.0 → 1.0.1 (patch)
1.0.0 → 1.1.0 (minor)
1.0.0 → 2.0.0 (major)
```

---

## 后续行动

1. 创建 Git tag
2. 编写 Release Notes
3. 执行部署
4. 通知相关人员
