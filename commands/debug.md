# /debug

> 唤醒【排障专家】：启动五步 Debug 法

## 触发条件

- 遇到错误
- 功能不工作
- 性能问题
- 任何异常行为

## 执行流程

### 步骤 1: 复现问题

```bash
# 确认错误信息
[粘贴错误日志]

# 确认复现步骤
1. 打开页面 /login
2. 输入用户名 "test"
3. 点击登录按钮
4. 出现错误: "Cannot read property 'length' of undefined"
```

### 步骤 2: 定位根因

#### 2.1 缩小范围

- 最小复现用例
- 二分查找问题代码

#### 2.2 工具使用

```bash
# 浏览器 DevTools
- Console: 查看错误
- Network: 查看请求
- Sources: 断点调试

# 后端调试
- 日志分析
- REPL 交互
```

#### 2.3 根因假设

```
假设 1: API 返回数据结构变化
假设 2: 前端状态管理问题
假设 3: 类型定义不匹配
```

### 步骤 3: 修复问题

```typescript
// 问题代码
const users = data.users.map(u => u.name.length);

// 修复后
const users = (data?.users || []).map(u => u.name?.length || 0);
```

### 步骤 4: 验证修复

```bash
# 运行相关测试
npm run test:unit -- --grep "user name"

# 手动验证
[重新执行复现步骤]
```

### 步骤 5: 总结记录

```markdown
## Bug 修复报告

### 问题描述
登录页面报错: "Cannot read property 'length' of undefined"

### 根因
API 返回的 users 字段在某些情况下为 undefined，
前端直接调用 .map() 导致报错。

### 修复方案
使用可选链和空数组默认值: (data?.users || [])

### 验证
- [x] 正常数据测试通过
- [x] 空数据测试通过
- [x] 单元测试通过
```

---

## 常见问题模式

| 模式 | 可能原因 | 排查方向 |
|------|----------|----------|
| undefined is not | 空值未处理 | 添加默认值 |
| cannot read property | 属性访问错误 | 使用可选链 |
| network error | 网络问题 | 检查请求/响应 |
| timeout | 请求超时 | 检查后端性能 |

---

## 后续行动

1. 添加单元测试覆盖此场景
2. 更新文档防止类似问题
3. 清理调试代码
