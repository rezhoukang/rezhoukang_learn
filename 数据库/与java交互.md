# Java 与数据库交互

## 原生 JDBC（最底层）

JDK 自带的 `java.sql` 包，手写所有步骤，代码繁琐。

```java
Connection conn = DriverManager.getConnection(URL, 用户名, 密码);
PreparedStatement ps = conn.prepareStatement("SELECT * FROM student WHERE id = ?");
ps.setInt(1, 1001);
ResultSet rs = ps.executeQuery();
while (rs.next()) {
    System.out.println(rs.getString("name"));
}
rs.close();
ps.close();
conn.close();  // 还得手动关
```

重复代码多，容易漏关资源，实际开发基本不用。

## MyBatis（半自动 ORM）

SQL 写在 XML 或注解里，实体类自动映射数据库表。

```xml
<!-- StudentMapper.xml -->
<mapper namespace="com.example.mapper.StudentMapper">
    <select id="findById" resultType="Student">
        SELECT * FROM student WHERE id = #{id}
    </select>
    <insert id="insert">
        INSERT INTO student(name, age, gender, score)
        VALUES (#{name}, #{age}, #{gender}, #{score})
    </insert>
    <update id="updateById">
        UPDATE student SET name=#{name}, score=#{score} WHERE id=#{id}
    </update>
    <delete id="deleteById">
        DELETE FROM student WHERE id=#{id}
    </delete>
</mapper>
```

```java
// 调用
Student s = studentMapper.findById(1001);    // 查
studentMapper.insert(new Student("张三",18)); // 增
studentMapper.updateById(student);           // 改
studentMapper.deleteById(1001);              // 删
```

SQL 完全可控，适合复杂查询。

## MyBatis-Plus（基于MyBatis继承封装好的CRUD，相当于完全体ORM）

在 MyBatis 基础上封装了常用 CRUD，不用写重复 SQL。

```java
// 继承 BaseMapper，自带增删改查
public interface StudentMapper extends BaseMapper<Student> {
}

// 直接调用
studentMapper.selectById(1001);           // 查
studentMapper.insert(student);            // 增
studentMapper.updateById(student);        // 改
studentMapper.deleteById(1001);           // 删

// 条件构造器
QueryWrapper<Student> qw = new QueryWrapper<>();
qw.ge("score", 90);                       // score >= 90
List<Student> list = studentMapper.selectList(qw);
```

大幅减少重复 SQL，国内最流行。

## 对比总结

| | JDBC | MyBatis | MyBatis-Plus |
|--|------|---------|-------------|
| 复杂度 | 高 | 中 | 低 |
| SQL 控制 | 全手动 | 自己写 XML | 自动生成+可自定义 |
| 开发效率 | 低 | 中 | 高 |
| 适用 | 几乎不用 | 复杂查询多 | 常规 CRUD 多 |