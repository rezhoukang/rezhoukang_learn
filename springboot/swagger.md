# Swagger 参考（SpringDoc OpenAPI）

| 用途 | URL |
|------|-----|
| Swagger UI | http://localhost:8080/swagger-ui/index.html |
| OpenAPI JSON | http://localhost:8080/v3/api-docs |

## 实现

**Maven 依赖**（`pom.xml`）：
```xml
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
    <version>2.3.0</version>
</dependency>
```

**配置**（`application.yml`）：
```yaml
springdoc:
  swagger-ui:
    path: /swagger-ui/index.html
    display-request-duration: true
```

SpringDoc 自动扫描 `@RestController`，**无需任何注解**，零侵入业务代码。

- **404 排查**：确认路径是 `/swagger-ui/index.html`（非旧版 `/swagger-ui.html`）