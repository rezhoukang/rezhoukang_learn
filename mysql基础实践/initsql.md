```sql
-- ==================== 清理旧数据（防止重复运行报错） ====================
DROP DATABASE IF EXISTS school;
DROP TABLE IF EXISTS student;

-- ==================== 建库 ====================
CREATE DATABASE school DEFAULT CHARACTER SET utf8mb4;
USE school;

-- ==================== 建表 ====================
CREATE TABLE student (
    id       INT          PRIMARY KEY AUTO_INCREMENT,
    name     VARCHAR(20)  NOT NULL,
    age      INT          DEFAULT 0,
    gender   CHAR(1)      DEFAULT '男',
    score    DOUBLE(5,2)  DEFAULT 0.00
) DEFAULT CHARSET=utf8mb4;

-- 插入
INSERT INTO student (name, age, gender, score) VALUES
('张三', 18, '男', 92.5),
('李四', 19, '女', 88.0),
('王五', 20, '男', 95.5);
```

## 常用类型

| 类型 | 说明 | 用法 |
|------|------|------|
| `INT` | 整数 | `id INT` |
| `VARCHAR(n)` | 变长字符串 | `name VARCHAR(20)` |
| `CHAR(n)` | 定长字符串 | `gender CHAR(1)` |
| `DOUBLE(m,d)` | 小数 | `score DOUBLE(5,2)` → 总5位小数2位 |
| `DATE` | 日期 | `birth DATE` |

## 常用约束

| 约束 | 说明 |
|------|------|
| `PRIMARY KEY` | 主键（唯一+非空） |
| `AUTO_INCREMENT` | 自增（一般用于 id） |
| `NOT NULL` | 不能为空 |
| `DEFAULT 值` | 默认值 |
| `UNIQUE` | 唯一（不可重复） |