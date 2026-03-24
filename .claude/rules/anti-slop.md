# 🚫 反 AI 味规范

> 严禁模板化、拒绝无意义的代码与设计
> **作用域**: 全局 (所有目录)

## 1. 设计规范

### 禁止的 UI 模式
- ❌ 默认 Bootstrap 样式
- ❌ 渐变色滥用 (blue-to-purple gradient)
- ❌ 彩虹色系
- ❌ 扁平化图标滥用
- ❌ 默认动画效果

### 推荐做法
- ✅ 使用 Tailwind CSS 或自定义设计系统
- ✅ 选择统一的品牌色板
- ✅ 适度的微交互
- ✅ 简洁的线条图标

### 字体规范
```
推荐字体组合:
- 中文: Noto Sans SC, Source Han Sans
- 英文: Inter, SF Pro Display
- 代码: JetBrains Mono, Fira Code
```

---

## 2. 代码规范

### 禁止无意义注释
```javascript
// ❌ 禁止这样的注释:
// 将 count 加 1
count++;

// 计算数组总和
const sum = arr.reduce((a, b) => a + b, 0);
```

### 推荐做法
```javascript
// ✅ 好的注释:
// 处理边界情况: 空数组返回 0，避免 reduce 报错
const sum = arr.length ? arr.reduce((a, b) => a + b, 0) : 0;

// 状态机转换: pending -> fulfilled
count++;
```

### 函数命名
```javascript
// ❌ 禁止:
function handleClick() { ... }
function processData() { ... }
function doSomething() { ... }

// ✅ 推荐:
function submitForm() { ... }
function parseUserInput() { ... }
function validateEmail() { ... }
```

---

## 3. 组件规范

### 拒绝模板化
```jsx
// ❌ 禁止:
function Button({ children }) {
  return (
    <button className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
      {children}
    </button>
  );
}
```

### 推荐做法
```jsx
// ✅ 好的组件:
// 明确组件职责与 Props
function SubmitButton({
  children,
  isLoading = false,
  variant = 'primary'
}) {
  const baseStyles = 'px-4 py-2 rounded-md font-medium transition-colors';
  const variants = {
    primary: 'bg-indigo-600 text-white hover:bg-indigo-700',
    secondary: 'bg-gray-200 text-gray-800 hover:bg-gray-300'
  };

  return (
    <button
      className={`${baseStyles} ${variants[variant]}`}
      disabled={isLoading}
    >
      {isLoading ? <Spinner /> : children}
    </button>
  );
}
```

---

## 4. 文档规范

### 拒绝冗余
```markdown
<!-- ❌ 禁止: -->
# 功能介绍

本文档介绍了一个非常棒的功能，它可以帮助你做很多事情。

这个功能的特点是:
1. 快速
2. 高效
3. 可靠
```

### 推荐做法
```markdown
<!-- ✅ 推荐: -->
# 用户认证 API

## 端点
- `POST /api/auth/login` - 用户登录
- `POST /api/auth/logout` - 用户登出

## 请求体
| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| email | string | 是 | 用户邮箱 |
| password | string | 是 | 密码 |

## 响应
返回 JWT token，有效期 24 小时。
```

---

## 5. 项目结构规范

### 拒绝过度设计
```
<!-- ❌ 禁止: -->
/src
  /core
    /base
      /abstract
      /interface
      /mixin
    /util
      /helper
      /factory
      /builder
  /common
    /components
    /hooks
    /utils
  /features
  /pages
  /layouts
```

### 推荐做法
```
<!-- ✅ 推荐: -->
/src
  /components     # 共享组件
  /features       # 功能模块
  /hooks          # 自定义 Hooks
  /lib            # 工具函数
  /pages          # 页面路由
  App.tsx
  main.tsx
```

---

## 6. 检查清单

在提交代码前，确认:

- [ ] 没有使用默认 Bootstrap/Tailwind 样式
- [ ] 没有渐变色滥用
- [ ] 注释有实际价值
- [ ] 函数名清晰表达意图
- [ ] 组件有明确的职责
- [ ] 文档简洁有用
- [ ] 项目结构简洁
