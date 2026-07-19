# Controller 层注解

## @RestController 拆解

`@RestController` = **`@Controller`** + **`@ResponseBody`**

**`@ResponseBody`** = 回应给用户，告诉 Spring "方法的返回值直接发给浏览器，别去找 JSP 页面"。

**为什么并在一块？** 因为不用在每个方法上都写一遍 `@ResponseBody`，类上写一次 `@RestController` 就代表所有方法都直接返回 JSON。

| 注解 | 作用 |
|------|------|
| `@Controller` | 标记这个类是控制器，Spring 把它注册到容器 |
| `@ResponseBody` | 方法的返回值自动转成 JSON 返回，而不是找页面 |

## 增删改查完整流程

你 Postman 发了一个 POST 请求到 `http://localhost:8080/depts`，Body 里带着 JSON `{"name":"研发部","location":"北京"}`。

1. **`@RequestMapping("/depts")`** — 所有以 `/depts` 开头的请求都进这个类
2. **`@PostMapping`** — 这个方法处理 POST 请求
3. **`@RequestBody`** — 把请求体 JSON 转成 Java 对象 `dept`
4. **`@Autowired`** — Spring 把 `deptService` 自动注入进来
5. 拿着 `dept` 对象调 `save` 方法存进数据库
6. 存完得到 `true`，打包成 Map 返回
7. **`@RestController`** — 把 Map 自动转成 JSON 发回给 Postman
8. Postman 收到：`{"success": true}`

```java
@RestController
@RequestMapping("/depts")
public class DeptController {

    @Autowired
    private DeptService deptService;

    @PostMapping
    public Map<String, Object> add(@RequestBody Dept dept) {
        boolean success = deptService.save(dept);
        return Map.of("success", success);
    }

    @GetMapping
    public Map<String, Object> list() {
        return Map.of("success", true, "data", deptService.list());
    }

    @GetMapping("/{id}")
    public Map<String, Object> get(@PathVariable Integer id) {
        return Map.of("success", true, "data", deptService.getById(id));
    }

    @PutMapping("/{id}")
    public Map<String, Object> update(@PathVariable Integer id, @RequestBody Dept dept) {
        dept.setId(id);
        boolean success = deptService.update(dept);
        return Map.of("success", success);
    }

    @DeleteMapping("/{id}")
    public Map<String, Object> delete(@PathVariable Integer id) {
        boolean success = deptService.removeById(id);
        return Map.of("success", success);
    }
}
```

## 区别总结

| 方法 | 需要路径吗 | 需要请求体吗 | 原因 |
|------|-----------|-------------|------|
| `@GetMapping`（查） | ✅ `/user/1` | ❌ | 只要知道"对谁"查 |
| `@DeleteMapping`（删） | ✅ `/user/1` | ❌ | 只要知道"对谁"删 |
| `@PostMapping`（增） | ⚠️ `/user`（不指定具体哪个） | ✅ JSON | 知道"加到哪" + "加什么" |
| `@PutMapping`（改） | ✅ `/user/1` | ✅ JSON | 知道"改哪个" + "改成什么" |

**`@PathVariable`** 是 `/1`，是 URL 路径上的参数；**`@RequestBody`** 是接收到的请求体，是 JSON。

**增和改都要有"新东西"（请求体），查和删只要知道"对谁"（路径）就够了。**
