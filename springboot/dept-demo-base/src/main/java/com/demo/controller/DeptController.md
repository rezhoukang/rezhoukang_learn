# DeptController.java

```java
package com.demo.controller;

import com.demo.entity.Dept;
import com.demo.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController                             // ③ = @Controller + @ResponseBody
@RequestMapping("/depts")                    // ④ 所有 /depts 开头的请求进这个类
public class DeptController {

    @Autowired                              // ⑤ Spring 把 DeptService 自动注入进来
    private DeptService deptService;

    // POST  /depts   Body: {"name":"研发部","location":"北京"}
    @PostMapping                            // ⑥ 这个方法处理 POST 请求
    public Map<String, Object> add(@RequestBody Dept dept) {
        // ⑦ @RequestBody 把请求体 JSON 转成 Dept 对象
        boolean success = deptService.insert(dept);
        return Map.of("success", success);   // ⑧ 返回 {"success": true}
    }

    // GET   /depts
    @GetMapping
    public Map<String, Object> list() {
        return Map.of("success", true, "data", deptService.selectList());
    }

    // GET   /depts/3
    @GetMapping("/{id}")                     // ⑨ {id} 是路径变量
    // Map<key, value>，Map<0001, 香蕉>返回值类型。
    // 表示这个方法返回一个 Map，key 是 String，value 是 Object（任意类型）
    public Map<String, Object> get(@PathVariable Integer id) {
        return Map.of("success", true, "data", deptService.selectById(id));
        // Map.of("success", true, "data", ①的结果)map.of就是可以一次性装好多个
        // 把 true 和 Dept 对象装进一个 Map结果是：{"success": true, "data": {"id":3, "name":"研发部", "location":"北京"}}
    }

    // PUT   /depts/3   Body: {"name":"技术部","location":"深圳"}
    @PutMapping("/{id}")
    public Map<String, Object> update(@PathVariable Integer id, @RequestBody Dept dept) {
        dept.setId(id);//setid是lombok自动生成的方法，@Data只是帮它们生成了 setId()、getId() 等方法，
        // 但是并没有任何像是@service和@mapper还有@autowired之类的bean注册和引用的注解，所以称不上注册bean容器，@Data只能算偷懒，帮忙写了两个方法
        boolean success = deptService.updateById(dept);
        return Map.of("success", success);
    }

    // DELETE  /depts/3
    @DeleteMapping("/{id}")
    public Map<String, Object> delete(@PathVariable Integer id) {
        boolean success = deptService.removeById(id);
        return Map.of("success", success);
    }
}
```
