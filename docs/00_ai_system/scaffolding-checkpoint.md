# 🏗️ 架构防过度设计清单

> "You aren't gonna need it" (YAGNI) 检查表

---

## 核心原则

**YAGNI**: 只实现当前需要的功能，不要为未来可能的需求提前设计。

---

## 检查清单

### 开始实现前

- [ ] 真的需要这个功能吗？
- [ ] 能否用更简单的方案替代？
- [ ] 当前需要还是未来需要？

### 设计决策时

- [ ] 避免过度抽象
- [ ] 避免提前优化
- [ ] 避免不必要的可扩展性
- [ ] 避免不必要的配置化

### 代码层面

| 模式 | 何时使用 | 何时避免 |
|------|----------|----------|
| 继承 | 明确的 is-a 关系 | 代码复用 |
| 抽象类 | 多个实现需要共享代码 | 仅为复用代码 |
| 接口 | 需要多态 | 仅为命名约定 |
| 设计模式 | 解决实际问题 | 展示技术 |

---

## 过度设计警示

### ❌ 过度设计示例

```typescript
// 为"未来"预留的过度设计
abstract class AnimalRepository<T extends Animal> {
  abstract findById(id: string): Promise<T>;
  abstract findAll(filter?: Filter<T>): Promise<T[]>;
  abstract save(entity: T): Promise<T>;
  abstract delete(id: string): Promise<void>;
  // 10+ 方法...
}

// 实际只需要:
const users = await db.user.findMany();
```

### ✅ 适度设计

```typescript
// 只实现当前需要的
const users = await db.user.findMany();
```

---

## 决策框架

```
问: 我需要这个功能吗？
├── 现在需要 → 实现
└── 未来可能需要 → ❌ 不实现

问: 能否用更简单方案？
├── 能 → 使用简单方案
└── 不能 → 评估成本后再决定
```

---

## 何时打破规则

以下情况可以提前设计:

1. **基础设施**: 数据库 schema 一旦上线难以修改
2. **API 契约**: 公开 API 需要考虑兼容性
3. **安全相关**: 身份验证、加密等
4. **性能关键**: 架构性性能问题
