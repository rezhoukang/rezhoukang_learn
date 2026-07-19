# SSM + Spring Boot 

## SSM 三件套

| 框架 | 作用 | 概述 |
|------|--------|--------|
| Spring | 管理对象 + 增强方法 | IoC：不写 new；AOP：日志权限解耦 |
| SpringMVC | HTTP 请求 | 接收请求，返回 JSON |
| MyBatis | SQL | 写接口 = 写 SQL |

## IoC

```java
// 不写 new，Spring 帮你 new。换实现只改注解，不改源码
@Service public class UserService {
    @Autowired UserMapper mapper;
}
```

## AOP

```java
// 日志/事务抽出来，不污染业务代码，解耦复用
@Before("...") public void log() { System.out.println("方法执行中"); }
```

## Spring Boot 项目结构

src/main/java/com/公司名/项目名/
├── 项目名Application.java          # 启动类
├── controller/                     # 控制器（调用业务，通过restapi用json和外界接收和发送）
├── service/                        # 业务层（实际业务，可调用mapper层的增删改查crud）
├── mapper/                         # 数据层（让实体类有orm能力，同时封装了增删改查crud）
├── entity/                         # 实体类（辅助mapper层做一个注册为bean之前一个打包）
├── config/                         # 配置类（CORS、异常处理、拦截器）
└── common/
    ├── Result.java                 # 统一返回格式
    └── ExceptionHandler.java       # 全局异常处理

src/main/resources/
├── application.yml                 # 配置文件
├── application-dev.yml             # 开发环境配置
└── application-prod.yml            # 生产环境配置

## SSM流程

```
GET /api/user/1 → SpringMVC 匹配 Controller
→ Service（Spring IoC 注入好的）
→ Mapper 执行 SQL（MyBatis）
→ 返回 JSON
```

## SSM vs Spring Boot

| | SSM(过时) | Spring Boot（主流） |
|--|-----|-------------|
| 配置 | XML 手配 3 个文件 | 自动配置，一个 yml |
| 部署 | 打 war，丢外部 Tomcat | 内嵌 Tomcat，java -jar 直接跑 |
| 前后端 | 不分离（JSP 混一起） | 分离（RESTful API 通信） |
| 本质 | 手动挡（已过时） | 自动挡（现在主流） |

## Nginx / Tomcat / Servlet / SpringMVC 区别

```
Nginx                → Web 服务器（反向代理）
Tomcat               → Servlet 容器（Web 容器）
Servlet              → 接收 HTTP 请求的底层 API（SSM 时代手动写，Spring Boot 隐藏了）
SpringMVC            → Web 框架（封装了 Servlet，让你写 @GetMapping 即可）
```

SSM 时代要手动写 Servlet、配 web.xml；Spring Boot 帮你全藏起来了。
spring-boot-starter-web 这个依赖同时装了 SpringMVC 和内嵌 Tomcat。

## 核心注解

```
由外到内：
SpringMVC  → @RestController @GetMapping @PostMapping @PathVariable @RequestBody
Spring     → @Service @Autowired @Configuration @Bean @Transactional
MyBatis    → @Mapper @Select @Insert @Update @Delete
通用       → @Component @Primary @Qualifier
```
if you are 
