package com.demo.service;

import com.demo.entity.Dept;
import com.demo.mapper.DeptMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service                                    // 注册：这个类进 Bean 容器，Spring 自动创建实例
public class DeptService {

    @Autowired                              // 注入：Spring 把 DeptMapper 塞进来，不用自己去 new
    private DeptMapper mapper;

    // 增：插入一条部门数据
    public boolean save(Dept dept) {
        return mapper.insert(dept) > 0;     // MP 自动生成 INSERT SQL
    }

    // 查全部：获取所有部门列表
    public List<Dept> list() {
        return mapper.selectList(null);      // null = 无条件，查询全部
    }

    // 查单个：根据主键 id 查询
    public Dept getById(Integer id) {
        return mapper.selectById(id);        // MP 自动生成 SELECT * FROM dept WHERE id = ?
    }

    // 改：根据对象里的 id 更新其他字段
    public boolean update(Dept dept) {
        return mapper.updateById(dept) > 0;  // MP 自动生成 UPDATE SQL
    }

    // 删：根据主键 id 删除
    public boolean removeById(Integer id) {
        return mapper.deleteById(id) > 0;    // MP 自动生成 DELETE SQL
    }
}
