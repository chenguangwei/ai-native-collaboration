# 共享层 (Shared)

> 前后端共用的类型定义、枚举常量，保持单一来源。

## 使用场景

- API 请求/响应的 TypeScript 类型
- 前后端共享的枚举值（如状态码、角色类型）
- 通用常量（如分页默认值）

## 目录结构

```
shared/
├── types/           # TypeScript 接口/类型定义
│   ├── api.ts       # API 响应通用结构
│   └── user.ts      # 用户相关类型
└── constants/       # 共享常量
    └── index.ts
```

## 示例

```typescript
// shared/types/api.ts
export interface ApiResponse<T> {
  code: number;
  data: T;
  message: string;
}

// shared/constants/index.ts
export const PAGE_SIZE = 20;
export const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
```

## 注意

- 只放纯类型定义和常量，不引入业务逻辑
- Java 后端对应的 DTO 类从这里的类型定义同步
- Python 后端对应的 Pydantic Schema 从这里的类型定义同步
