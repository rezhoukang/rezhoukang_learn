# SSH 连接与部署指南

## 1. 首次连接

```bash
# 基本格式
ssh 用户名@服务器IP

# 示例（用 pem 密钥）
ssh -i deploy/你的密钥.pem root@你的服务器IP
```
## 2. 打包上传

```powershell
# 从项目根目录打包（排除 node_modules / .git / 构建产物）
cd /你的本地项目路径
tar --exclude=node_modules --exclude=.git --exclude=Server/tmp --exclude=Web/dist -czf library.tar.gz .

# 上传到服务器
scp -i deploy/你的密钥.pem library.tar.gz 你的用户名@你的服务器IP:/opt/library.tar.gz

# 清理本地包
del library.tar.gz
```

## 3. 服务器部署

```bash
# 连接服务器
ssh -i deploy/你的密钥.pem 你的用户名@你的服务器IP

# 停旧容器
cd /opt/library
docker compose -f deploy/docker-compose.yml down
docker stop server-nginx 2>/dev/null
docker rm server-nginx 2>/dev/null

# 删旧网络（让 compose 重新创建）
docker network rm server_shared 2>/dev/null

# 解压新代码
rm -rf /opt/library/*
tar -xzf /opt/library.tar.gz -C /opt/library/

# 先起 Nginx（创建共享网络 server_shared）
docker compose -f /opt/library/deploy/server-nginx/docker-compose.yml up -d

# 再起全部服务（前后端自动构建）
docker compose -f /opt/library/deploy/docker-compose.yml up -d --build

# 看看状态
docker ps --format 'table {{.Names}}\t{{.Status}}'

# 验证
curl http://localhost/api/health
curl -s -o /dev/null -w '%{http_code}' http://localhost
```

## 4. 日常更新（代码不变时）

```bash
ssh -i deploy/你的密钥名.pem root@你的服务器IP "cd /opt/library && docker compose -f deploy/docker-compose.yml up -d --build"
```

## 常用命令

```bash
# 传文件
scp -i key.pem 本地文件 root@IP:/远程路径/

# 服务器上执行单条命令
ssh -i key.pem root@IP "docker ps"

# 查看日志
ssh -i key.pem root@IP "docker compose -f /opt/library/deploy/docker-compose.yml logs --tail 50"

# 进入容器
ssh -i key.pem root@IP "docker exec -it library-backend sh"
```
