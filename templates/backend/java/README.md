# 后端服务 (Java 17 + Spring Boot 3)

## 技术栈
- Java 17+
- Spring Boot 3+
- Spring Security + JWT
- Spring Data JPA + Hibernate
- PostgreSQL / MySQL
- Maven

## 目录结构

```
backend/
├── src/
│   ├── main/
│   │   ├── java/com/{company}/{project}/
│   │   │   ├── controller/      # REST 控制器（薄层，只做入参校验）
│   │   │   ├── service/         # 业务逻辑
│   │   │   │   └── impl/
│   │   │   ├── repository/      # JPA Repository 接口
│   │   │   ├── model/
│   │   │   │   ├── entity/      # JPA 实体
│   │   │   │   └── dto/         # 请求/响应 DTO
│   │   │   ├── config/          # Spring 配置类
│   │   │   ├── security/        # 认证/授权
│   │   │   └── exception/       # 全局异常处理
│   │   └── resources/
│   │       ├── application.yml
│   │       └── application-{env}.yml
│   └── test/
│       └── java/...             # 单元测试 + 集成测试
├── pom.xml
└── Dockerfile
```

## 开发

```bash
mvn spring-boot:run
```

## 规范

- Controller 不写业务逻辑，只做参数校验和调用 Service
- Service 方法加 `@Transactional`（写操作）
- 数据库查询使用参数化（禁止字符串拼接）
- DTO 与 Entity 严格分离，用 MapStruct 转换
- 单元测试覆盖所有 Service 方法
