# 📂 路径过滤规则

> 让规则文件只在特定目录生效

## 概述

默认情况下，`.claude/rules/` 目录下的所有规则文件都会被全局加载。但有时候你需要一个**只针对特定目录**的规则——比如 API 开发规范只对 `src/api/` 生效，组件规范只对 `src/components/` 生效。

路径过滤功能允许你通过 YAML frontmatter 声明规则文件的作用域。

## 使用方法

### 1. 添加路径声明

在规则文件顶部添加 YAML frontmatter，使用 `paths` 字段。**注意**：不添加 `paths` 声明的文件默认为全局规则。

```yaml
---
paths:
  - "src/api/**"
  - "src/handlers/**"
---

# API 开发规范

所有 API 端点必须:
- 返回统一的 JSON 格式
- 包含错误处理
- 记录请求日志
```

### 2. 路径匹配规则

| 模式 | 说明 | 示例 |
|------|------|------|
| `src/api/**` | 匹配 api 目录下所有文件 | `src/api/users.ts`, `src/api/v2/auth/login.ts` |
| `src/components/*.tsx` | 匹配指定类型文件 | `src/components/Button.tsx` |
| `src/**/*.test.ts` | 任意层级的测试文件 | `src/utils/helpers.test.ts` |
| `"src/api"` | 精确匹配目录 | 只匹配 `src/api` 目录本身 |

### 3. 加载逻辑

```
当 Claude 需要加载规则时:

1. 扫描 `.claude/rules/` 目录下所有 `.md` 文件
2. 读取每个文件的 frontmatter
3. 对于没有 paths 声明的文件 → 全局加载
4. 对于有 paths 声明的文件:
   - 检查当前编辑的文件路径是否匹配
   - 匹配 → 加载该规则
   - 不匹配 → 跳过
```

## 示例

### 全局规则 (无 paths)

```yaml
---
# 无 paths 声明 = 全局规则
---

# 反 AI 味规范

所有代码都要遵循...
```

### 局部规则 (有 paths)

```yaml
---
paths:
  - "src/api/**"
  - "src/handlers/**"
---

# API 开发规范

## 响应格式

所有 API 必须返回统一格式:
{
  "code": 0,
  "data": {},
  "message": "success"
}
```

```yaml
---
paths:
  - "src/components/**"
  - "src/ui/**"
---

# 组件规范

## Props 定义

使用 TypeScript 严格类型定义...
```

## 最佳实践

### 1. 规则分类

| 类型 | 放置位置 | 示例 |
|------|----------|------|
| 全局规则 | `.claude/rules/` | `01-behaviors.md`, `02-memory-protocol.md`, `03-anti-slop.md` |
| 领域规则 | `.claude/rules/` + paths | `api-rules.md`, `component-rules.md` |
| 项目规则 | `.claude/rules/project/` | `project-conventions.md` |

### 2. 避免重复

```yaml
# ❌ 避免: 在全局规则里写领域特定内容
# 01-behaviors.md 里写 "API 必须返回 JSON"

# ✅ 推荐: 创建独立的领域规则
# api-rules.md with paths: ["src/api/**"]
```

### 3. 路径要精确

```yaml
# ❌ 避免: 过于宽泛
paths:
  - "src/**"  # 太宽泛，等于全局规则

# ✅ 推荐: 精确作用域
paths:
  - "src/api/**"
  - "src/graphql/**"
```

## 现有规则

| 规则文件 | 作用域 |
|---------|--------|
| `01-behaviors.md` | 全局 |
| `02-memory-protocol.md` | 全局 |
| `03-anti-slop.md` | 全局 |
| `api-rules.md` | `src/api/**`, `src/handlers/**`, `src/server/**` |
| `component-rules.md` | `src/components/**`, `src/ui/**`, `src/widgets/**` |

---

*路径过滤让规则更精确，避免无关规则干扰当前工作上下文。*
