# 🎨 设计系统

> 视觉规范 - 颜色、字体、组件等

---

## 1. 颜色系统

### 主色 (Primary)

| 用途 | 颜色 | Hex |
|------|------|-----|
| 主色 | Indigo 600 | #4F46E5 |
| 主色悬停 | Indigo 700 | #4338CA |
| 主色浅色 | Indigo 50 | #EEF2FF |

### 中性色 (Neutral)

| 用途 | 颜色 | Hex |
|------|------|-----|
| 文本主色 | Gray 900 | #111827 |
| 文本次色 | Gray 600 | #4B5563 |
| 背景色 | White | #FFFFFF |
| 边框色 | Gray 200 | #E5E7EB |

### 功能色

| 用途 | 颜色 | Hex |
|------|------|-----|
| 成功 | Green 500 | #22C55E |
| 警告 | Amber 500 | #F59E0B |
| 错误 | Red 500 | #EF4444 |
| 信息 | Blue 500 | #3B82F6 |

---

## 2. 字体系统

### 字体栈

```css
/* 中文 */
font-family: 'Noto Sans SC', -apple-system, BlinkMacSystemFont, sans-serif;

/* 英文 */
font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;

/* 代码 */
font-family: 'JetBrains Mono', 'Fira Code', monospace;
```

### 字号

| 用途 | 字号 | 行高 |
|------|------|------|
| H1 | 32px | 1.2 |
| H2 | 24px | 1.3 |
| H3 | 20px | 1.4 |
| Body | 16px | 1.5 |
| Small | 14px | 1.5 |
| Caption | 12px | 1.4 |

---

## 3. 组件规范

### 按钮

```
Primary:   bg-indigo-600, text-white
Secondary: bg-gray-100, text-gray-700
Ghost:     bg-transparent, text-gray-600
Danger:    bg-red-600, text-white
```

### 间距

```
xs: 4px
sm: 8px
md: 16px
lg: 24px
xl: 32px
2xl: 48px
```

### 圆角

```
sm: 4px
md: 8px
lg: 12px
full: 9999px
```

---

## 4. 阴影

```css
/* 卡片 */
shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);

/* 弹出层 */
shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);

/* 模态框 */
shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1);
```

---

## 5. 动画

```css
/* 过渡时长 */
duration-150: 150ms
duration-200: 200ms
duration-300: 300ms

/* 缓动函数 */
ease-in-out
ease-out

/* 示例 */
transition: all 150ms ease-in-out;
```
