# Bean 容器注解

## 核心逻辑：先注册，再使用

```java
// 第一步：注册 — 告诉 Spring 这个类归你管
@Service         // 业务层
@Component       // 通用组件
@Mapper          // MyBatis 映射器
@RestController  // 控制器

// 第二步：使用 — @Autowired 自动装配
@Autowired       // 从容器里找到对应的实例，塞进来
```

**`@Autowired` 的中文意思就是"自动装配"——它会从 Spring 容器里扫描，找到匹配的实例后自动注入进来。**

## 举例

```java
// 注册：Spring 启动时 new 一个 DeptService 放到容器
@Service
public class DeptService { ... }

// 使用：@Autowired 从容器找到 DeptService 塞进来
@RestController
public class DeptController {
    @Autowired
    private DeptService deptService;  // 直接就能用了
}
```

规则就一条：**要注入的类必须先注册（加 `@Service` / `@Component` / `@Mapper`），否则 `@Autowired` 找不到会报错。**

## @Autowired 的辅助注解

当同一个接口有多个实现类时，需要指定注入哪一个。

| 注解 | 用处 |
|------|------|
| `@Qualifier("名称")` | 有多个实现时，按名称指定注入哪个 |
| `@Primary` | 有多个实现时，标记谁是默认的 |
| `@Lazy` | 启动时不创建，第一次用到时才创建 |

```java
@Service @Primary          // 默认用 Alipay
public class Alipay implements PayService { ... }

@Service("wechat")
public class WechatPay implements PayService { ... }

@Service
public class Shop {
    @Autowired              // 没写 Qualifier → 取 @Primary 的 Alipay
    private PayService defaultPay;

    @Autowired
    @Qualifier("wechat")    // 指定取 WechatPay
    private PayService wechatPay;
}
```

```java
@Lazy
@Service
public class HeavyService { ... }  // 启动时不 new，第一次调用才创建
```

