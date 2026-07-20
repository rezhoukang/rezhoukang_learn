# Docker Compose — 生产环境部署

```yaml
============================================
# Docker Compose - Library Management System
# 开发: docker compose -p library up -d redis
# 生产: docker compose -p library up -d
# 这里是因为开发环境redis用的是docker容器
============================================

name: library

services:
  redis:
    image: redis:7.2
    container_name: library-redis
    restart: always
    ports:
      - "6379:6379"
    volumes:
      - library_redis_data:/data
    networks:
      - shared
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  mysql:
    image: mysql:8.0.33
    container_name: library-mysql
    restart: always
    env_file:
      - .env.prod
    environment:
      MYSQL_DATABASE: library
      TZ: Asia/Shanghai
    volumes:
      - library_mysql_data:/var/lib/mysql
      - ./mysql/init.sql:/docker-entrypoint-initdb.d/init.sql
    command:
      - --character-set-server=utf8mb4
      - --collation-server=utf8mb4_unicode_ci
      - --character-set-client-handshake=FALSE
      - --default-authentication-plugin=mysql_native_password
    networks:
      - shared
    healthcheck:
      test: ["CMD-SHELL", "mysqladmin ping -h localhost -u root -p$$MYSQL_ROOT_PASSWORD"]
      interval: 10s
      timeout: 5s
      retries: 5

  backend:
    build:
      context: ..
      dockerfile: deploy/Dockerfile.backend
    container_name: library-backend
    restart: always
    env_file:
      - .env.prod
    depends_on:
      mysql:
        condition: service_healthy
      redis:
        condition: service_healthy
    networks:
      - shared

  frontend:
    build:
      context: ..
      dockerfile: deploy/Dockerfile.frontend
    container_name: library-frontend
    restart: "no"
    volumes:
      - library_www_data:/output
    depends_on:
      - backend
    networks:
      - shared

volumes:
  library_mysql_data:
    name: library_mysql_data
  library_redis_data:
    name: library_redis_data
  library_www_data:
    name: library_www_data

networks:
  shared:
    name: server_shared
    external: true
```

---

## 开发环境 vs 生产环境

```
开发: docker compose -p library up -d redis
生产: docker compose -p library up -d
```

| | 开发环境 | 生产环境 |
|--|---------|---------|
| 启动 | 只启动 redis（`up -d redis`） | 启动全部服务（`up -d`） |
| env 文件 | `env.dev`（本地值） | `env.prod`（占位符）+ `env.docker`（真实值） |
| 目的 | 本地调试，省资源 | 完整部署 |

---

## 网络（`networks`）

```yaml
networks:
  shared:
    name: server_shared
    external: true
```

- `name: server_shared` — 网络名叫 `server_shared`
- `external: true` — 这个网络已经存在（在其他 yml 里创建过），这里直接引用

这样所有服务都在同一个网络里，容器之间通过**服务名**通信（如 `mysql`、`redis`）。

---

## 卷（`volumes`）

```yaml
volumes:
  library_mysql_data:
    name: library_mysql_data
  library_redis_data:
    name: library_redis_data
  library_www_data:
    name: library_www_data
```

**为什么要命名？**

默认 Docker 会给卷随机生成一串 ID，命名后可以清楚知道哪个卷是干什么的：

```
# 默认（看不懂）
library_library_mysql_data

# 命名后（一眼明白）
library_mysql_data
library_redis_data
library_www_data
```

**各卷用途：**

| 卷 | 挂载到 | 存什么 |
|----|--------|--------|
| `library_mysql_data` | mysql → `/var/lib/mysql` | 数据库数据文件 |
| `library_redis_data` | redis → `/data` | Redis 缓存数据 |
| `library_www_data` | frontend → `/output` | 前端构建产物 |
