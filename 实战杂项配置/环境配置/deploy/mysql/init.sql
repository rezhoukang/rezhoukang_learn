-- ============================================
-- Library Management System - 数据库初始化
-- ============================================

CREATE DATABASE IF NOT EXISTS library DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE library;

-- 用户表
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') NOT NULL DEFAULT 'user',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_role (role)
);

-- 图书表
CREATE TABLE IF NOT EXISTS books (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(30) NOT NULL,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    publisher VARCHAR(100) DEFAULT '',
    category VARCHAR(50) DEFAULT '',
    total_stock INT NOT NULL DEFAULT 0,
    stock INT NOT NULL DEFAULT 0,
    cover VARCHAR(500) DEFAULT '',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_isbn (isbn),
    INDEX idx_title (title),
    INDEX idx_author (author),
    INDEX idx_category (category),
    INDEX idx_stock (stock)
);

-- 借阅记录表
CREATE TABLE IF NOT EXISTS borrow_records (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    book_id BIGINT NOT NULL,
    borrow_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    return_date DATETIME NULL,
    status ENUM('borrowed', 'returned', 'overdue') NOT NULL DEFAULT 'borrowed',
    INDEX idx_user_id (user_id),
    INDEX idx_book_id (book_id),
    INDEX idx_status (status),
    INDEX idx_borrow_date (borrow_date),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

-- Casbin RBAC 策略表
CREATE TABLE IF NOT EXISTS casbin_rules (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ptype VARCHAR(100) NOT NULL DEFAULT '',
    v0 VARCHAR(100) NOT NULL DEFAULT '',
    v1 VARCHAR(100) NOT NULL DEFAULT '',
    v2 VARCHAR(100) NOT NULL DEFAULT '',
    v3 VARCHAR(100) NOT NULL DEFAULT '',
    v4 VARCHAR(100) NOT NULL DEFAULT '',
    v5 VARCHAR(100) NOT NULL DEFAULT ''
);

-- ============================================
-- 初始数据
-- ============================================

-- 管理员账号 (密码: 你的初始密码 的 bcrypt 哈希)
INSERT INTO users (username, password, role) VALUES
('admin', '你的密码哈希占位', 'admin'),
('librarian', '你的密码哈希占位', 'admin');

-- 初始图书数据
INSERT INTO books (isbn, title, author, publisher, category, total_stock, stock, cover) VALUES
('978-7-115-42875-6', 'Python编程：从入门到实践', 'Eric Matthes', '人民邮电出版社', '编程', 5, 5, 'https://picsum.photos/seed/book1/200/280'),
('978-7-115-42875-7', 'JavaScript高级程序设计', 'Nicholas C. Zakas', '人民邮电出版社', '编程', 3, 3, 'https://picsum.photos/seed/book2/200/280'),
('978-7-115-42875-8', 'Vue.js设计与实现', '刘俊达', '电子工业出版社', '编程', 4, 4, 'https://picsum.photos/seed/book3/200/280'),
('978-7-115-42875-9', '深入理解计算机系统', 'Randal E. Bryant', '机械工业出版社', '编程', 2, 2, 'https://picsum.photos/seed/book4/200/280'),
('978-7-115-42876-0', '算法导论', 'Thomas H. Cormen', '机械工业出版社', '编程', 3, 3, 'https://picsum.photos/seed/book5/200/280'),
('978-7-115-42876-1', '红楼梦', '曹雪芹', '人民文学出版社', '文学', 6, 6, 'https://picsum.photos/seed/book6/200/280'),
('978-7-115-42876-2', '活着', '余华', '作家出版社', '文学', 8, 8, 'https://picsum.photos/seed/book7/200/280'),
('978-7-115-42876-3', '三体', '刘慈欣', '重庆出版社', '科幻', 5, 5, 'https://picsum.photos/seed/book8/200/280'),
('978-7-115-42876-4', '人类简史', '尤瓦尔·赫拉利', '中信出版社', '历史', 4, 4, 'https://picsum.photos/seed/book9/200/280'),
('978-7-115-42876-5', '设计心理学', '唐纳德·诺曼', '中信出版社', '设计', 3, 3, 'https://picsum.photos/seed/book10/200/280'),
('978-7-559-42273-4', '流浪地球', '刘慈欣', '江苏凤凰文艺出版社', '科幻', 4, 4, 'https://picsum.photos/seed/book11/200/280'),
('978-7-559-62942-3', '沙丘', '弗兰克·赫伯特', '北京联合出版公司', '科幻', 3, 3, 'https://picsum.photos/seed/book12/200/280'),
('978-7-539-98322-6', '基地', '艾萨克·阿西莫夫', '江苏凤凰文艺出版社', '科幻', 3, 3, 'https://picsum.photos/seed/book13/200/280');
