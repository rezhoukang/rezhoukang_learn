# Nginx Docker 部署

## docker-compose.yml

```yaml
# ============================================
# 服务器 Nginx Docker Compose
# 部署: docker compose -p server-nginx up -d
# ============================================

name: server-nginx

services:
  nginx:
    image: nginx:1.27-alpine
    container_name: server-nginx
    restart: always
    ports:
      - "80:80"
      - "443:443"
    networks:
      - shared
    volumes:
      # 前端 dist 产物（library 项目）
      - library_www_data:/var/www/library:ro
      # Nginx 配置（每个项目一个 .conf 文件）
      - /etc/nginx/conf.d:/etc/nginx/conf.d:ro
      # SSL 证书（HTTPS 用）
      - /etc/nginx/ssl:/etc/nginx/ssl:ro

volumes:
  library_www_data:
    name: library_www_data
    external: true

networks:
  shared:
    name: server_shared
```

## Nginx 配置（library.conf）

```nginx
server {
    listen 80;
    server_name _;

    # Docker 内部 DNS，动态解析容器名
    resolver 127.0.0.11 valid=10s;

    # 前端静态文件（named volume: library_www_data）
    root /var/www/library;
    index index.html;

    # SPA 路由兜底
    location / {
        try_files $uri $uri/ /index.html;
    }

    # API 反向代理到后端容器
    location /api/ {
        proxy_pass http://library-backend:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## 关键点

### 卷（`external: true`）

```yaml
volumes:
  library_www_data:
    name: library_www_data
    external: true
```

`external: true` 表示这个卷已经存在（由主 compose 创建），nginx 只引用不创建。

### 网络

```yaml
networks:
  shared:
    name: server_shared
```

nginx 和主服务在同一个网络 `server_shared`，所以能通过容器名 `library-backend` 访问后端。

### 代理到后端

```nginx
proxy_pass http://library-backend:8080;
```

不走 IP，直接走容器名，Docker DNS 自动解析。

### SPA 路由兜底

```nginx
location / {
    try_files $uri $uri/ /index.html;
}
```

前端路由（如 `/books/123`）直接访问 nginx 时文件不存在，返回 `index.html` 让 Vue 路由接管。

### 三个 volume 挂载

| 挂载 | 作用 |
|------|------|
| `library_www_data:/var/www/library:ro` | 前端静态文件，只读 |
| `/etc/nginx/conf.d:/etc/nginx/conf.d:ro` | 所有项目的 .conf 配置 |
| `/etc/nginx/ssl:/etc/nginx/ssl:ro` | SSL 证书 |
