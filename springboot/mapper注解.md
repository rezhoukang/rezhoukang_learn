# Mapper 注解

## 完整数据流（Bean 注册时机）

```
数据库
  ↓ SQL 查询
MyBatis Plus（BaseMapper）
  ↓ 自动封装成 Entity（❌ 不进容器，用完就丢）
Service（✅ @Service 注册进 Bean 容器）
  ↓ 返回
Controller（✅ @RestController 注册进 Bean 容器，转 JSON 响应）
```

## MyBatis Plus 注解一览（用在 Entitywen 文件里）

```
MyBatis Plus（你用的）
├── @Data（Lombok）    ← 省写 getter/setter，每个 Entity 都要加
├── @TableName（可选）  ← 类名和表名不一致时才用
└── @TableId（可选）    ← 主键字段不叫 id 时才用
```

## 核心注解详解

| 注解 | 位置 | 作用 |
|------|------|------|
| `@MapperScan` | 启动类或配置类 | 批量扫描 Mapper 接口，不用每个加 `@Mapper` |
| `@TableName("表名")` | Entity 类 | 指定表名（类名跟表名不一致时用） |
| `@TableId(type = IdType.AUTO)` | 主键字段 | 主键自增 |
| `@TableField("列名")` | 字段 | 指定列名（字段名跟列名不一致时用） |
| `@TableLogic` | 字段 | 逻辑删除标记 |
| `@Version` | 字段 | 乐观锁标记 |
| `@TableField(fill = ...)` | 字段 | 自动填充（插入/更新时自动赋值） |

## 自动填充

自动给某些字段填值，不用每次手动 set。常用于 `create_time`、`update_time`。

### 第一步：Entity 字段标记

```java
@Data
public class Dept {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String name;
    private String location;

    @TableField(fill = FieldFill.INSERT)          // 插入时自动填充
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)   // 插入+更新时自动填充
    private LocalDateTime updateTime;
}
```

### 第二步：实现处理器

```java
package com.demo.config;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;
import java.time.LocalDateTime;

@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {
        // 插入时，自动设值
        this.strictInsertFill(metaObject, "createTime", LocalDateTime.class, LocalDateTime.now());
        this.strictInsertFill(metaObject, "updateTime", LocalDateTime.class, LocalDateTime.now());
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        // 更新时，自动设值
        this.strictUpdateFill(metaObject, "updateTime", LocalDateTime.class, LocalDateTime.now());
    }
}
```

### 效果

```java
// 插入时 — 不用手动 set createTime 和 updateTime
Dept dept = new Dept();
dept.setName("研发部");
deptMapper.insert(dept);
// MP 自动补上：createTime = now, updateTime = now

// 更新时 — 不用手动 set updateTime
dept.setName("技术部");
deptMapper.updateById(dept);
// MP 自动补上：updateTime = now
```

| `FieldFill.INSERT` | 插入时填充 |
| `FieldFill.UPDATE` | 更新时填充 |
| `FieldFill.INSERT_UPDATE` | 插入和更新都填充 |

## 用 MP 后的简化

```java
// 1. 启动类 — 扫包
@SpringBootApplication
@MapperScan("com.demo.mapper")   // 扫整个 mapper 包
public class DeptApplication { ... }

// 2. Entity — 表映射
@Data
@TableName("dept")
public class Dept {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String name;
    private String location;
}

// 3. Mapper — 继承 BaseMapper，自带 CRUD
public interface DeptMapper extends BaseMapper<Dept> {
    // selectById() / insert() / updateById() / deleteById() 全内置
}

// 4. Service — 调 Mapper
@Service
public class DeptService {
    @Autowired
    private DeptMapper mapper;

    public Dept getById(Integer id) {
        return mapper.selectById(id);  // 不用写 SQL
    }
}
```
MyBatis Plus 是 ORM 框架，Entity 是被 ORM 映射的对象。

ORM = Object-Relational Mapping（对象关系映射）
        ↓
MyBatis Plus（实现 ORM 的框架,同时还附赠快捷的基础增删改查轮子）
        ↓
Entity（ORM 的结果——数据库的行 → Java 对象）

广义上ORM = 映射定义（Entity） + 操作能力（Mapper）
半 ORM（MyBatis）
├── SQL 自己写（@Select、XML）
├── 只帮你做"行 → 对象"的映射
└── 增删改查手动写

全 ORM（MyBatis Plus）
├── 基础增删改查自动生成（BaseMapper）
├── 复杂 SQL 自己写
└── 介于全 ORM 和半 ORM 之间



// MyBatis Plus（ORM 框架）做这件事：
// 1. 执行 SELECT * FROM dept WHERE id = 1
// 2. 把结果行 → new Dept() 并填值
// 3. 返回给 Service

// Entity（ORM 的结果）：
@Data
public class Dept {     // 对应数据库里的一行
    Integer id;          // 对应 dept.id
    String name;         // 对应 dept.name
}