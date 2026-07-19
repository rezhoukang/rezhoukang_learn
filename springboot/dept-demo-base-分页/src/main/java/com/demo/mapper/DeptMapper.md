# DeptMapper.java

```java
package com.demo.mapper;

import com.demo.entity.Dept;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * Mapper
 * 
 * extends BaseMapper<Dept>   ← 泛型：指定这个 Mapper 操作哪个表
 *                              <Dept> 表示这个 Mapper 专门操作 dept 表
 *                              换成 <User> 就是操作 user 表
 */
public interface DeptMapper extends BaseMapper<Dept> {

    // 例：自定义复杂查询 — 按名称模糊搜索
    @Select("SELECT * FROM dept WHERE name LIKE CONCAT('%', #{name}, '%')")
    List<Dept> searchByName(String name);
}

// ════════════════════════════════════════════
// BaseMapper 自带的常用方法（不用写 SQL，直接调）：
//
// 增：insert(对象)              → 插入一条数据
// 删：deleteById(id)           → 按主键删除
//     deleteBatchIds(集合)     → 批量删除（传 id 列表）
// 改：updateById(对象)          → 按主键更新
// 查：selectById(id)           → 按主键查单个
//     selectList(null)         → 查全部
//     selectOne(条件)          → 按条件查单个
//     selectBatchIds(集合)     → 按主键列表批量查
//     selectByMap(map)         → 按多字段等值查
// 分页 — MP 内置的
// Page<T> selectPage(Page<T> page, Wrapper<T> queryWrapper);
// ════════════════════════════════════════════
```
