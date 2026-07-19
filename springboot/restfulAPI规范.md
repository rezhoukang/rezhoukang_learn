# RESTful API 规范

RESTful = 一种 API 设计风格，前后端通过**统一规则**通信。

## 核心规则

```
资源（名词）用 URL 表示
操作（动词）用 HTTP 方法表示
结果统一返回 JSON
```

## 4 种方法

| 方法 | 含义 | 示例 |
|------|------|------|
| `GET` | 查 | `/api/user/1` |
| `POST` | 增 | `/api/user` |
| `PUT` | 改 | `/api/user` |
| `DELETE` | 删 | `/api/user/1` |

## 常见接口

```
GET    /api/user?page=1              → 分页查询
GET    /api/user/1                   → 查单个
POST   /api/user                     → 新增
PUT    /api/user                     → 修改
DELETE /api/user/1                   → 删除
POST   /api/auth/login               → 登录
```

## 统一返回格式

```json
// 成功
{ "code": 200, "message": "成功", "data": { ... } }
// 失败
{ "code": 400, "message": "参数错误", "data": null }
// 分页
{ "code": 200, "data": { "total": 100, "list": [...] } }
```

## 状态码

| 状态码 | 含义 |
|--------|------|
| 200 | 成功 |
| 400 | 参数错误 |
| 401 | 未登录 |
| 403 | 没权限 |
| 404 | 找不到 |
| 500 | 服务器异常 |

## ⚠️ 重要：HTTP 状态码 ≠ 业务成功

HTTP 状态码是**传输层面**的，业务成功与否是**应用层面**的，两回事。

HTTP 200 = 请求没崩；`success: true` = 操作真的成了。**

## 开发习惯

```java
@RequestMapping("/api/user")
public class UserController {

    @GetMapping                                    // 查全部
    public ApiResult<List<User>> list() {
        return ApiResult.success(userService.list());
    }

    @GetMapping("/{id}")                           // 查单个
    public ApiResult<User> get(@PathVariable Integer id) {
        return ApiResult.success(userService.get(id));
    }

    @PostMapping                                   // 新增
    public ApiResult<Void> add(@RequestBody User user) {
        userService.add(user);
        return ApiResult.success(null);
    }

    @PutMapping                                    // 修改
    public ApiResult<Void> edit(@RequestBody User user) {
        userService.edit(user);
        return ApiResult.success(null);
    }

    @DeleteMapping("/{id}")                        // 删除
    public ApiResult<Void> delete(@PathVariable Integer id) {
        userService.delete(id);
        return ApiResult.success(null);
    }
}
```
