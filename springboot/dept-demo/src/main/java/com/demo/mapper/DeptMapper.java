package com.demo.mapper;

import com.demo.entity.Dept;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * Mapper — 继承 BaseMapper，自带 CRUD，不用写 SQL
 * 需要在启动类上加 @MapperScan("com.demo.mapper") 扫描
 */
public interface DeptMapper extends BaseMapper<Dept> {
    // 自带方法：selectById() insert() updateById() deleteById() selectList() ...
}
