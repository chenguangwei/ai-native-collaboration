# 前端应用 (React + Vite + TypeScript)

## 技术栈
- React 18+
- TypeScript 5+
- Vite
- Tailwind CSS

## 目录结构

```
frontend/
├── public/              # 静态资源
├── src/
│   ├── components/      # 共享组件（无业务逻辑）
│   ├── features/        # 功能模块（含组件+hooks+api）
│   │   └── auth/
│   │       ├── components/
│   │       ├── hooks/
│   │       └── api.ts
│   ├── hooks/           # 全局 hooks
│   ├── lib/             # 工具函数（纯函数，可测试）
│   ├── pages/           # 页面路由入口
│   ├── App.tsx
│   └── main.tsx
├── index.html
├── vite.config.ts
├── tsconfig.json
└── package.json
```

## 开发

```bash
npm install
npm run dev
```

## 规范

- 组件使用具名导出
- Props 使用 TypeScript interface 定义
- 禁止在组件内直接调用 API（通过 hooks 封装）
- 遵循 `.claude/rules/anti-slop.md` 设计规范
