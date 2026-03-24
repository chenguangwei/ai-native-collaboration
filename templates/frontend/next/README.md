# 前端应用 (Next.js 14+ App Router)

## 技术栈
- Next.js 14+ (App Router)
- TypeScript 5+
- Tailwind CSS

## 目录结构

```
frontend/
├── app/                 # App Router 页面
│   ├── (auth)/          # 路由分组
│   ├── api/             # Route Handlers
│   ├── layout.tsx
│   └── page.tsx
├── components/          # 共享组件（Server/Client 组件）
├── features/            # 功能模块
├── lib/                 # 工具函数
├── hooks/               # Client 端 hooks
├── public/
├── next.config.js
└── package.json
```

## 开发

```bash
npm install
npm run dev
```

## 规范

- 优先使用 Server Components（无 `'use client'` 标注）
- Client Components 文件顶部加 `'use client'`
- 数据获取在 Server Components 中直接 async/await
- API 路由放在 `app/api/` 下
