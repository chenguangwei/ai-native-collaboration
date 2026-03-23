# 接口集成测试

基于 Jest + Supertest 的 API 测试。

## 运行

```bash
npm run test:api
```

## 测试结构

```typescript
describe('User API', () => {
  it('should create user', async () => {
    const response = await request(app)
      .post('/api/v1/users')
      .send({ email: 'test@example.com' });

    expect(response.status).toBe(201);
  });
});
```
