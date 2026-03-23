# 🧪 测试用例集

> 基于 BDD (Given/When/Then) 的测试用例

---

## 1. 认证模块

### TC001: 用户登录成功

```gherkin
Feature: 用户登录

  Scenario: 正确的账号密码登录成功
    Given 用户在登录页面
    When 输入邮箱 "user@example.com" 和密码 "password123"
    And 点击登录按钮
    Then 跳转至首页
    And 显示用户信息
```

### TC002: 用户登录失败

```gherkin
  Scenario: 错误的密码登录失败
    Given 用户在登录页面
    When 输入邮箱 "user@example.com" 和密码 "wrongpassword"
    And 点击登录按钮
    Then 显示错误提示 "邮箱或密码错误"
    And 停留在登录页面
```

---

## 2. 用户管理

### TC003: 用户注册

```gherkin
Feature: 用户注册

  Scenario: 新用户注册成功
    Given 用户在注册页面
    When 输入邮箱 "new@example.com"、密码 "Password123"、确认密码 "Password123"
    And 点击注册按钮
    Then 发送验证邮件
    And 显示注册成功提示
```

### TC004: 邮箱已被注册

```gherkin
  Scenario: 使用已存在的邮箱注册
    Given 用户在注册页面
    When 输入已存在的邮箱 "existing@example.com"
    And 点击注册按钮
    Then 显示错误提示 "该邮箱已注册"
```

---

## 3. 项目管理

### TC005: 创建项目

```gherkin
Feature: 项目管理

  Scenario: 创建新项目
    Given 用户已登录
    And 在项目列表页面
    When 点击"新建项目"按钮
    And 输入项目名称 "我的项目" 和描述 "测试项目"
    And 点击保存
    Then 项目创建成功
    And 显示在项目列表中
```

---

## 4. 测试覆盖矩阵

| 模块 | 单元测试 | 集成测试 | E2E |
|------|----------|----------|-----|
| 认证 | ✅ | ✅ | ✅ |
| 用户 | ✅ | ✅ | ✅ |
| 项目 | ✅ | ✅ | ✅ |
| 任务 | ✅ | ✅ | ✅ |

---

## 5. 测试数据

```typescript
// 测试用户
const testUser = {
  email: 'test@example.com',
  password: 'TestPassword123',
  name: '测试用户'
};

// 测试项目
const testProject = {
  name: '测试项目',
  description: '这是一个测试项目'
};
```
