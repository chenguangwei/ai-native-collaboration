# 🔄 系统流程图

> 并发状态机与时序图

---

## 1. 用户认证流程

```mermaid
sequenceDiagram
    participant U as 用户
    participant F as 前端
    participant A as API
    participant D as 数据库

    U->>F: 输入账号密码
    F->>A: POST /api/v1/auth/login
    A->>D: 验证用户
    D-->>A: 用户数据
    A-->>F: JWT Token
    F-->>U: 登录成功
```

---

## 2. 状态机

### 任务状态

```mermaid
stateDiagram-v2
    [*] --> TODO: 创建任务
    TODO --> IN_PROGRESS: 开始
    IN_PROGRESS --> REVIEW: 提交审查
    REVIEW --> IN_PROGRESS: 需修改
    REVIEW --> DONE: 审核通过
    DONE --> [*]
    IN_PROGRESS --> CANCELLED: 取消
    CANCELLED --> [*]
```

---

## 3. 数据流

```mermaid
flowchart LR
    subgraph Client
        UI[用户界面]
        S[状态管理]
    end

    subgraph Server
        API[API 网关]
        V[验证层]
        B[业务逻辑]
    end

    subgraph Storage
        DB[(数据库)]
        C[(缓存)]
    end

    UI --> S
    S --> API
    API --> V
    V --> B
    B --> C
    C --> DB
```

---

## 4. 并发控制

### 乐观锁

```typescript
// 版本号控制并发
interface VersionedEntity {
  id: string;
  version: number;
}

async function updateWithOptimisticLock(
  entity: VersionedEntity,
  update: Partial<Entity>
) {
  const result = await db.update({
    ...update,
    version: entity.version + 1
  }).where({
    id: entity.id,
    version: entity.version
  });

  if (result.count === 0) {
    throw new ConflictError('数据已被其他请求修改');
  }
}
```

---

## 5. 错误处理流程

```mermaid
flowchart TD
    E[发生错误] --> C{错误类型}
    C -->|客户端错误| V[验证错误]
    C -->|业务错误| B[业务异常]
    C -->|系统错误| S[系统异常]

    V --> 400[返回 400]
    B --> 400[返回 4xx]
    S --> 500[返回 500]

    400 --> L[记录日志]
    500 --> L
    L --> R[响应客户端]
```
