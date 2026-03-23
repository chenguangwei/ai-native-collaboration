# 单元测试

基于 Jest 的单元测试。

## 运行

```bash
npm run test:unit
```

## 测试结构

```typescript
describe('utils', () => {
  describe('formatDate', () => {
    it('should format date', () => {
      expect(formatDate('2024-01-01')).toBe('2024-01-01');
    });
  });
});
```
