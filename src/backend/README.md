# 后端服务

选择技术栈后，此目录结构由 `scripts/replace-placeholders.sh` 自动生成。

## 支持的技术栈

| 技术栈 | 初始化命令 | 模板文档 |
|--------|------------|------|
| Java 17 + Spring Boot 3 | `./scripts/replace-placeholders.sh <名称> <前端> java` | `templates/backend/java/README.md` |
| Python 3.11 + FastAPI | `./scripts/replace-placeholders.sh <名称> <前端> python` | `templates/backend/python/README.md` |

## 开发规范（所有技术栈通用）

- 禁止字符串拼接 SQL，使用参数化查询
- API 响应 Schema 放 `../shared/types/`，前后端共享
- 配置项从环境变量读取（禁止硬编码密钥）
- 单元测试覆盖所有业务逻辑层（Service / Use Case）
