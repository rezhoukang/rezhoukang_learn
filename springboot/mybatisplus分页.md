# MyBatis Plus 物理分页

## 什么是物理分页？

物理分页 = 真正执行 `LIMIT ? OFFSET ?` SQL，只从数据库查当前页的数据。

```sql
-- 物理分页：只查 10 条
SELECT * FROM dept LIMIT 10 OFFSET 0;

-- 逻辑分页：先查全部 100 万条到内存，再截取 10 条（数据大了会炸）
```

**MP 分页 = 物理分页** ✅

---

## 第一步：配置分页插件（做一次就行）

新建 `src/main/java/com/demo/config/MyBatisPlusConfig.java`

```java
package com.demo.config;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class MyBatisPlusConfig {

    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        // 添加分页拦截器（MySQL 用 DbType.MYSQL）
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.MYSQL));
        return interceptor;
    }
}
```

> ⚠️ `pom.xml` 不用额外加依赖，MP 3.5+ 已经自带了分页支持。

---

## 第二步：Service 写分页方法

```java
// DeptService.java
public Page<Dept> pageDept(int pageNum, int pageSize) {
    Page<Dept> page = new Page<>(pageNum, pageSize);
    return deptMapper.selectPage(page, null);
    //                         ↑     ↑
    //                    Page 对象   查询条件（null = 无条件查全部）
}
```

---

## 第三步：Controller 接收分页参数

```java
// DeptController.java
// GET  /depts/page?num=1&size=10
@GetMapping("/page")
public Map<String, Object> page(
        @RequestParam(defaultValue = "1") int num,
        @RequestParam(defaultValue = "10") int size) {

    Page<Dept> result = deptService.pageDept(num, size);

    return Map.of("success", true, "data", Map.of(
        "list",     result.getRecords(),   // 当前页的数据列表
        "total",    result.getTotal(),     // 总记录数
        "current",  result.getCurrent(),   // 当前页码
        "pages",    result.getPages()      // 总页数
    ));
}
```

---

## `Page` 对象常用方法

```java
Page<Dept> page = new Page<>(1, 10);    // 第 1 页，每页 10 条

page.getRecords()     // 当前页的数据（List<Dept>）
page.getTotal()       // 总记录数（MP 自动执行 COUNT 查出来的）
page.getCurrent()     // 当前页码
page.getPages()       // 总页数
page.getSize()        // 每页条数
page.hasNext()        // 是否有下一页（true/false）
page.hasPrevious()    // 是否有上一页（true/false）
```

---

## 分页 + 条件查询

```java
// 带条件的分页
public Page<Dept> pageDeptWithCondition(int pageNum, int pageSize, String name) {
    Page<Dept> page = new Page<>(pageNum, pageSize);

    LambdaQueryWrapper<Dept> wrapper = new LambdaQueryWrapper<>();
    //     Lambda  Query  Wrapper
    //     λ       查询   包装器
    wrapper.like(StringUtils.isNotBlank(name), Dept::getName, name);

    return deptMapper.selectPage(page, wrapper);
    // page	告诉 MP：要第几页、每页几条
    // wrapper	告诉 MP：WHERE 条件是什么
    // 分页 — MP 内置的
    // Page<T> selectPage(Page<T> page, Wrapper<T> queryWrapper);
}
```

---

## 前端收到的完整响应格式

```
GET /depts/page?num=1&size=10
```

```json
{
  "success": true,
  "data": {
    "list": [
      { "id": 1, "name": "研发部", "location": "北京" },
      { "id": 2, "name": "市场部", "location": "上海" }
    ],
    "total": 5,
    "current": 1,
    "pages": 1
  }
}
```

---

## 常见问题

### MP 分页 vs PageHelper（哪个好？）

| 对比项 | ✅ MP 分页 | ❌ PageHelper |
|--------|-----------|-------------|
| **写法** | 显式传 `Page` 对象，安全 | 隐式 `ThreadLocal`，容易串页 |
| **依赖** | MP 自带，无需额外 | 需要额外引入 pagehelper-spring-boot-starter |
| **安全** | 方法参数传，不会串 | `startPage()` 后必须紧跟 SQL，中间插代码就翻车 |

**结论：用 MP 就不用 PageHelper。**

### Mapper 已经 `extends BaseMapper<Dept>`，还需要写 SQL 吗？

不需要。`BaseMapper` 已经自带了 `selectPage(page, wrapper)`，直接调就行。
