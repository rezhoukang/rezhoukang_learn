# 生产环境部署指南

## 首次部署

```bash
# 1. 克隆项目
git clone <仓库地址> /opt/library
cd /opt/library

# 2. 先启动 Nginx（创建共享网络）
docker compose -f deploy/server-nginx/docker-compose.yml up -d

# 3. 启动全部服务
docker compose -f deploy/docker-compose.yml up -d --build
```

## 日常更新

```bash
cd /opt/library
git pull
docker compose -f deploy/docker-compose.yml up -d --build
# 前端 dist 自动更新到 library_www_data，Nginx 无需重启
```

## 常用命令

```bash
# 查看日志
docker compose -f deploy/docker-compose.yml logs -f

# 查看状态
docker compose -f deploy/docker-compose.yml ps

# 停止服务
docker compose -f deploy/docker-compose.yml down
```

## 新增项目

Nginx 容器掌管 `server_shared` 共享网络，新项目只需在自己的 compose 中引用即可，无需手动建网：

```yaml
# 新项目 compose 中
networks:
  shared:
    name: server_shared
    external: true

# 前端 dist 用独立命名 volume，Nginx 挂载同一个 volume 即可对外服务
```

