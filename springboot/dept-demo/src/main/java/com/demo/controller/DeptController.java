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
        boolean success = deptService.save(dept);
        return Map.of("success", success);   // ⑧ 返回 {"success": true}
    }

    // GET   /depts
    @GetMapping
    public Map<String, Object> list() {
        return Map.of("success", true, "data", deptService.list());
    }

    // GET   /depts/3
    @GetMapping("/{id}")                     // ⑨ {id} 是路径变量
    public Map<String, Object> get(@PathVariable Integer id) {
        return Map.of("success", true, "data", deptService.getById(id));
    }

    // PUT   /depts/3   Body: {"name":"技术部","location":"深圳"}
    @PutMapping("/{id}")
    public Map<String, Object> update(@PathVariable Integer id, @RequestBody Dept dept) {
        dept.setId(id);
        boolean success = deptService.update(dept);
        return Map.of("success", success);
    }

    // DELETE  /depts/3
    @DeleteMapping("/{id}")
    public Map<String, Object> delete(@PathVariable Integer id) {
        boolean success = deptService.removeById(id);
        return Map.of("success", success);
    }
}
