# 📁 代码开发区

> 严格映射 Layer 2 的设计

---

## 目录结构

```
src/
├── /frontend/          # 前端应用
│   ├── /components/    # 共享组件
│   ├── /features/      # 功能模块
│   ├── /hooks/         # 自定义 Hooks
│   ├── /lib/           # 工具函数
│   ├── /pages/        # 页面路由
│   ├── App.tsx        # 根组件
│   └── main.tsx       # 入口文件
│
└── /backend/           # 后端服务
    ├── /controllers/  # 控制器
    ├── /middleware/   # 中间件
    ├── /models/       # 数据模型
    ├── /routes/       # 路由
    ├── /services/     # 业务逻辑
    ├── /utils/       # 工具函数
    └── index.ts       # 入口文件
```

---

## 前端规范

### 技术栈
- React 18+
- TypeScript
- Tailwind CSS

### 组件结构
```typescript
// 组件示例
import { useState } from 'react';

interface Props {
  title: string;
  onSubmit: (data: Data) => void;
}

export function Component({ title, onSubmit }: Props) {
  const [value, setValue] = useState('');

  return (
    <div>
      <h1>{title}</h1>
    </div>
  );
}
```

---

## 后端规范

### 技术栈
- Node.js 18+
- Express / Fastify
- PostgreSQL + Prisma

### 控制器结构
```typescript
// 控制器示例
export const userController = {
  async getUser(req: Request, res: Response) {
    const { id } = req.params;
    const user = await userService.findById(id);
    res.json(user);
  }
};
```

---

## 开发指南

1. 先读 `/docs/03_architecture/api_specs.md`
2. 遵循 `/rules/anti-slop.md` 规范
3. 使用 TDD 方式开发
4. 完成后调用 `/review`
