---
paths:
  - "src/api/**"
  - "src/handlers/**"
  - "src/server/**"
  - "**/api.ts"
  - "**/api.js"
---

# 🔌 API 开发规范

> 作用域: `src/api/**`, `src/handlers/**`, `src/server/**`

## 1. 响应格式

### 成功响应

```typescript
// ✅ 统一成功响应格式
interface ApiResponse<T> {
  code: number;      // 0 = 成功
  data: T;            // 业务数据
  message: string;   // 提示信息
  timestamp: number; // 服务器时间戳
}

// 示例
{
  "code": 0,
  "data": {
    "user": { "id": 1, "name": "张三" }
  },
  "message": "success",
  "timestamp": 1699999999999
}
```

### 错误响应

```typescript
// ✅ 统一错误响应格式
interface ApiError {
  code: number;      // 错误码 (非0)
  message: string;   // 错误描述
  details?: any;     // 详细错误信息 (可选)
}

// 常用错误码
const ErrorCode = {
  BAD_REQUEST: 400,
  UNAUTHORIZED: 401,
  FORBIDDEN: 403,
  NOT_FOUND: 404,
  SERVER_ERROR: 500
} as const;
```

## 2. 请求处理

### 必做事项

```typescript
// ✅ 必须: 参数校验
async function createUser(req: Request) {
  const { email, name } = req.body;

  if (!email || !isValidEmail(email)) {
    return res.status(400).json({
      code: 400,
      message: 'Invalid email format'
    });
  }

  // 业务逻辑...
}

// ✅ 必须: 错误处理
try {
  const user = await db.users.create({ email, name });
  return res.json({ code: 0, data: user });
} catch (error) {
  logger.error('Create user failed', { error, email });
  return res.status(500).json({
    code: 500,
    message: 'Internal server error'
  });
}

// ✅ 必须: 请求日志
logger.info('API Request', {
  method: req.method,
  path: req.path,
  query: req.query,
  ip: req.ip
});
```

### 禁止事项

```typescript
// ❌ 禁止: 直接返回原始数据库错误
return res.json({ error: error.message }); // 不要!

// ❌ 禁止: 省略状态码
return res.json({ data: user }); // 默认 200?

// ❌ 禁止: 没有校验的请求处理
const { userId } = req.params; // 直接使用?
// 应该先校验 userId 是否存在/合法
```

## 3. 路由定义

### RESTful 规范

```typescript
// ✅ 推荐: RESTful 路由
router.get('/users', listUsers);          // 列表
router.get('/users/:id', getUser);       // 详情
router.post('/users', createUser);        // 创建
router.put('/users/:id', updateUser);     // 更新
router.delete('/users/:id', deleteUser);   // 删除

// ❌ 避免: 行为不当的路由
router.post('/getUser', ...);  // 用 GET
router.get('/users/create', ...); // 行为在路径里
```

### 路由分组

```typescript
// ✅ 推荐: 使用路由前缀分组
const router = express.Router();

// API v1
router.use('/api/v1/users', v1UserRoutes);
router.use('/api/v1/posts', v1PostRoutes);

// API v2
router.use('/api/v2/users', v2UserRoutes);
```

## 4. 中间件

### 必须的中间件

```typescript
// ✅ 必须: 请求日志中间件
app.use((req, res, next) => {
  const start = Date.now();
  res.on('finish', () => {
    logger.info('Request completed', {
      method: req.method,
      path: req.path,
      status: res.statusCode,
      duration: Date.now() - start
    });
  });
  next();
});

// ✅ 必须: 错误处理中间件
app.use((err, req, res, next) => {
  logger.error('Unhandled error', { err });
  res.status(500).json({
    code: 500,
    message: 'Internal server error'
  });
});
```

## 5. 校验规则

### 使用 Schema 校验

```typescript
// ✅ 推荐: 使用 Zod/Yup 进行请求校验
import { z } from 'zod';

const CreateUserSchema = z.object({
  email: z.string().email(),
  name: z.string().min(1).max(100),
  age: z.number().int().min(0).optional()
});

async function createUser(req: Request) {
  const result = CreateUserSchema.safeParse(req.body);

  if (!result.success) {
    return res.status(400).json({
      code: 400,
      message: 'Validation failed',
      details: result.error.format()
    });
  }

  // 使用校验后的数据
  const { email, name, age } = result.data;
}
```

---

## 检查清单

- [ ] 响应格式符合 `ApiResponse` 规范
- [ ] 错误响应包含错误码和消息
- [ ] 关键操作有日志记录
- [ ] 请求参数有校验
- [ ] 路由符合 RESTful 规范
- [ ] 有统一的错误处理中间件
