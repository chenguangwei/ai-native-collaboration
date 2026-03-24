# 前端应用 (Vue 3 + Vite + TypeScript)

## 技术栈
- Vue 3 (Composition API)
- TypeScript 5+
- Vite
- Tailwind CSS

## 目录结构

```
frontend/
├── public/
├── src/
│   ├── components/      # 共享组件
│   ├── composables/     # 可复用逻辑（对应 React hooks）
│   ├── features/        # 功能模块
│   ├── views/           # 页面组件（路由对应）
│   ├── stores/          # Pinia 状态管理
│   ├── lib/             # 工具函数
│   ├── App.vue
│   └── main.ts
├── vite.config.ts
└── package.json
```

## 开发

```bash
npm install
npm run dev
```

## 规范

- 使用 `<script setup>` 语法
- 使用 Pinia 管理全局状态（不用 Vuex）
- Composable 命名以 `use` 开头
