# DeptService.java

```java
package com.demo.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.demo.entity.Dept;
import com.demo.mapper.DeptMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service                                    // 注册：这个类进 Bean 容器，Spring 自动创建实例
public class DeptService {

    @Autowired                              // 注入：Spring 把 DeptMapper 塞进来，不用自己去 new
    private DeptMapper mapper;

    // 增
    public boolean insert(Dept dept) {
        return mapper.insert(dept) > 0;
    }

    // 查全部
    public List<Dept> selectList() {
        return mapper.selectList(null);
    }

    // 查单个
    public Dept selectById(Integer id) {
        return mapper.selectById(id);
    }

    // 改
    public boolean updateById(Dept dept) {
        return mapper.updateById(dept) > 0;
    }

    // 删
    public boolean deleteById(Integer id) {
        return mapper.deleteById(id) > 0;
    }

    // ─── 分页 ──────────────────────────────
    public Page<Dept> pageDept(int pageNum, int pageSize) {
        Page<Dept> page = new Page<>(pageNum, pageSize);
        return mapper.selectPage(page, null);
        // MP 自动拼接: SELECT * FROM dept LIMIT ? OFFSET ?
    }
}
```
