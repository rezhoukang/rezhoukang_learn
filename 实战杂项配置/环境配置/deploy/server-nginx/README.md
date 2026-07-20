# 服务器 Nginx 部署（一次性，与业务项目无关）

## 初始化

```bash
# 1. 创建需要的目录
sudo mkdir -p /etc/nginx/conf.d /etc/nginx/ssl /var/www

# 2. 创建共享网络（所有项目后端通过这个网络互访）
docker network create server_shared

# 3. 把 docker-compose.yml 上传到服务器
scp docker-compose.yml user@server:/opt/nginx/

# 4. 启动 Nginx
ssh user@server "cd /opt/nginx && docker compose -p server-nginx up -d"
```

## 日常管理

```bash
# 重载配置（不改 docker-compose，只改 .conf 文件时用这个）
ssh user@server "docker exec server-nginx nginx -s reload"

# 重启 Nginx
ssh user@server "cd /opt/nginx && docker compose -p server-nginx restart"

# 查看日志
ssh user@server "docker logs server-nginx"
```

## 新增项目

```bash
# 1. 把项目的 .conf 上传
scp library.conf user@server:/etc/nginx/conf.d/

# 2. 创建前端文件目录
ssh user@server "mkdir -p /var/www/library"

# 3. 重载 Nginx
ssh user@server "docker exec server-nginx nginx -s reload"

# 4. 上传前端 dist
scp -r dist/* user@server:/var/www/library/
```

## 文件结构

```
服务器上:
/etc/nginx/conf.d/
├── library.conf    ← 每个项目一个
├── shop.conf
└── blog.conf

/var/www/
├── library/        ← 前端 dist 文件
├── shop/
└── blog/

/opt/nginx/
└── docker-compose.yml   ← Nginx 容器定义（不动）

## 常见问题

**Q: `docker compose up -d` 执行两次会怎样？**

不会出问题。Docker Compose 是幂等的——对比当前状态和期望状态，一致就跳过。

```
第一次: 创建容器 → 启动
第二次: 检测到已运行、配置没变 → 跳过，什么都不做
```

只有加 `--build` 才会强制重建镜像，但容器本身不会重复创建。放心反复执行。

