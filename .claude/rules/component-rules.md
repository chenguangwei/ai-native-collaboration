---
paths:
  - "src/components/**"
  - "src/ui/**"
  - "src/widgets/**"
  - "**/*.component.tsx"
  - "**/*.component.ts"
---

# 🎨 组件开发规范

> 作用域: `src/components/**`, `src/ui/**`, `src/widgets/**`

## 1. 组件结构

### 推荐的文件结构

```
src/components/
├── Button/
│   ├── Button.tsx        # 组件实现
│   ├── Button.test.tsx   # 单元测试
│   ├── Button.styles.ts  # 样式 (如需要)
│   └── index.ts          # 导出入口
```

### 禁止的结构

```typescript
// ❌ 禁止: 一个文件塞太多东西
// Button.tsx 包含: 类型定义、组件实现、样式、导出

// ✅ 推荐: 单一职责分离
Button.tsx        # 只管渲染
Button.types.ts   # 类型定义
Button.styles.ts  # 样式
```

## 2. Props 定义

### 必须使用 TypeScript

```typescript
// ✅ 必须: 完整类型定义
interface ButtonProps {
  /** 按钮文字 */
  children: React.ReactNode;
  /** 按钮类型 */
  variant?: 'primary' | 'secondary' | 'ghost';
  /** 是否加载中 */
  isLoading?: boolean;
  /** 点击事件 */
  onClick?: () => void;
  /** 是否禁用 */
  disabled?: boolean;
}

// ✅ 推荐: 使用 type 而不是 interface (如需扩展)
type ButtonVariant = 'primary' | 'secondary' | 'ghost';
```

### 禁止的做法

```typescript
// ❌ 禁止: any 类型
interface Props {
  data: any;  // 不要!
}

// ❌ 禁止: 缺少必填标记
interface Props {
  title: string;  // 是必填还是可选?
}
```

## 3. 组件编写

### 必须包含

```typescript
// ✅ 必须: 导出的组件有名称
export function SubmitButton({ ... }: ButtonProps) { }

// ✅ 必须: 组件文档注释 (复杂组件)
/**
 * 提交按钮组件
 * - 自动处理 loading 状态
 * - 防止重复提交
 */
export function SubmitButton() { }

// ✅ 必须: 合理的默认值
interface Props {
  variant?: 'primary' | 'secondary' = 'primary';
}
```

### 禁止的模式

```typescript
// ❌ 禁止: 内联样式对象
<button style={{ padding: '10px', background: 'blue' }}>

// ❌ 禁止: 魔法字符串
if (status === 'loading') { }

// ❌ 禁止: 深层嵌套三元
return isLoading ? isError ? <Error /> : <Loading /> : <Content />
```

## 4. 样式规范

### 推荐方案

```typescript
// ✅ 推荐: CSS Modules / Tailwind
import styles from './Button.module.css';

// 或
import { cn } from '@/lib/utils';

<button className={cn(
  'px-4 py-2 rounded',
  variant === 'primary' && 'bg-blue-600'
)}>

// ✅ 推荐: 样式常量 (如需自定义)
const variants = {
  primary: 'bg-indigo-600 text-white hover:bg-indigo-700',
  secondary: 'bg-gray-200 text-gray-800 hover:bg-gray-300'
};
```

## 5. 事件处理

```typescript
// ✅ 推荐: 显式事件处理
const handleClick = useCallback((e: React.MouseEvent<HTMLButtonElement>) => {
  e.preventDefault();
  onSubmit?.();
}, [onSubmit]);

<button onClick={handleClick}>

// ❌ 禁止: 内联匿名函数 (每次渲染创建新函数)
<button onClick={(e) => {
  console.log('clicked');
  onClick();
}}>
```

## 6. 性能优化

```typescript
// ✅ 推荐: 使用 useMemo / useCallback
const buttonStyles = useMemo(() => ({
  backgroundColor: variant === 'primary' ? 'blue' : 'gray'
}), [variant]);

const handleClick = useCallback(() => {
  onClick?.();
}, [onClick]);

// ✅ 推荐: React.memo (纯展示组件)
export const IconButton = React.memo(function IconButton({
  icon,
  onClick
}: IconButtonProps) {
  return <button onClick={onClick}>{icon}</button>;
});
```

---

## 检查清单

- [ ] Props 有完整的 TypeScript 类型定义
- [ ] 组件有清晰的命名
- [ ] 样式使用 CSS Modules / Tailwind
- [ ] 事件处理使用 useCallback
- [ ] 没有内联样式对象
- [ ] 避免 any 类型
- [ ] 组件单一职责
