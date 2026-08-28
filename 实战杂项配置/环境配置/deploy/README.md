# Library Management System - 部署说明

## 文件结构

```
deploy/
├── docker-compose.yml      # 唯一的 compose 文件（profiles 区分环境）
├── .env.prod               # 生产环境变量
├── README.md               # 本说明文档
├── Dockerfile.backend      # Go 后端镜像
├── server-nginx/
│   └── library.conf        # 部署到服务器 Nginx 的反代配置
└── mysql/
    └── init.sql            # 建库建表 + 初始数据（仅生产）
```

## 环境对比

| | 开发 | 生产 |
|---|---|---|
| **Redis** | Docker 容器 | Docker 容器 |
| **MySQL** | 本地 `localhost:3306` | Docker 容器 `mysql:3306` |
| **Go 后端** | 本地 `air` | Docker 容器（Dockerfile.backend） |
| **Vue 前端** | 本地 `npm run dev :5173` | Nginx 容器（80 端口） |
| **跨域** | Vite proxy 自动转发 | Nginx 反向代理 |
| **配置** | `Server/.env`（godotenv 加载） | `deploy/.env.prod`（env_file 注入） |
| **Nginx** | 无（Vite 自带代理） | 服务器统一管理，项目不自带 |

## 多项目部署架构

```
服务器
├── 总 Nginx（唯一对外 :80/:443）
│   ├── library.yourdomain.com  → library-backend:8080
│   ├── shop.yourdomain.com     → shop-backend:8080
│   └── ...
│
├── library 项目
│   ├── library-mysql
│   ├── library-redis
│   └── library-backend（容器内 :8080，不暴露宿主机端口）
│
└── shop 项目
    └── shop-backend（容器内 :8080，不暴露宿主机端口）
```

**关键：共享网络 `server_shared`**

所有项目加入同一个 Docker 外部网络，Nginx 通过容器名直接访问后端：

```bash
# 服务器首次执行（创建共享网络）
docker network create server_shared
```

每个项目的 `docker-compose.yml` 末尾声明：

```yaml
networks:
  shared:
    name: server_shared
    external: true
```

**新项目部署步骤**

```bash
# 1. 服务器上：把 .conf 复制到 Nginx 配置目录
cp deploy/server-nginx/library.conf /etc/nginx/conf.d/

# 2. 修改域名
vim /etc/nginx/conf.d/library.conf  # 改 server_name

# 3. 重载 Nginx
nginx -s reload

# 4. 启动项目
docker compose -p library --profile prod up -d --build
```

## 启动命令

```bash
cd deploy

# 开发环境（只启 Redis）
docker compose -p library up -d

# 生产环境（全部服务）
docker compose -p library --profile prod up -d
```

## 为什么只有一个 compose 文件

Docker Compose 不加 `-f` 时只认 `docker-compose.yml` 这一个文件。
多个 compose 文件要么用 `-f` 指定，要么改名为 `docker-compose.override.yml` 自动叠加。
当前方案用 `profiles` 在单文件内区分环境：
- 不加 `--profile` → 只启动没有 profiles 标签的服务（Redis）
- 加 `--profile prod` → 额外启动标记了 `profiles: [prod]` 的服务（MySQL、Backend、Nginx）

## 为什么本地开发不用 Docker 跑后端

- 本地有 Go 环境，`go run main.go` 秒启，改代码不用重建镜像
- Vite 开发服务器自带 API 代理（`/api` → `localhost:8080`），零跨域问题
- 本地不用 Nginx 容器，减少一层转发

## 为什么项目不自带 Nginx

- 服务器只装一个 Nginx，管理所有项目的域名和反代
- 新项目上线只需加一个 `.conf` 文件 + `nginx -s reload`
- 项目代码和 Nginx 解耦，互不影响

## 为什么 Redis 要用 Docker

Redis 是唯一本地没装的依赖，Docker 一行命令搞定，无侵入。

## .env 加载机制

`Server/config/config.go` 使用 `godotenv`：
- `godotenv.Load()` 自动找当前目录的 `.env` 文件
- `go run main.go` 在 `Server/` 下执行，读到 `Server/.env`
- Docker 容器内没有 `.env` 文件，`godotenv.Load()` 静默跳过
- 生产环境中 Docker Compose 的 `env_file: .env.prod` 直接注入环境变量
- `os.Getenv()` 在两种环境都能读到正确的值

## 配置变量说明

| 变量 | 开发值（Server/.env） | 生产值（.env.prod） | 说明 |
|---|---|---|---|
| `SERVER_PORT` | `8080` | `8080` | 后端端口 |
| `DB_HOST` | `localhost` | `mysql` | 开发连本地，生产连容器 |
| `DB_PORT` | `3306` | `3306` | MySQL 端口 |
| `DB_USER` | `root` | `root` | 数据库用户 |
| `MYSQL_ROOT_PASSWORD` | `你的开发密码` | `你的生产密码` | MySQL root 密码（Docker 容器 + Go 后端共用） |
| `DB_NAME` | `library` | `library` | 数据库名 |
| `REDIS_HOST` | `localhost` | `redis` | Redis 地址 |
| `REDIS_PORT` | `6490` | `6379` | 开发走宿主机映射端口，生产走容器内网 |
| `REDIS_PASSWORD` | 空 | 空 | 内网 Redis 无需密码 |
| `JWT_SECRET` | `你的随机JWT密钥` | 同 | JWT 签名密钥 |

## MySQL 初始化脚本自动执行

MySQL 官方镜像的 `/docker-entrypoint-initdb.d/` 目录有自动注入机制：

```yaml
volumes:
  - ./mysql/init.sql:/docker-entrypoint-initdb.d/init.sql
```

**规则：**

- 容器**首次启动**（数据库目录为空）时自动执行
- `.sql`、`.sh`、`.sql.gz` 都支持
- 如果数据卷已有数据（之前跑过），**不会重复执行**

所以生产环境第一次 `docker compose --profile prod up -d` 时，`init.sql` 自动建库建表插入初始数据，之后重启不会丢数据也不会重跑。

## 术语

本项目的工具和文件常用名称：

| 术语 | 指什么 |
|---|---|
| **编排文件** / **compose 文件** / **compose 配置** | `docker-compose.yml` 配置文件 |
| **镜像**（image） | Docker 容器的模板（如 `redis:6.2.7`） |
| **容器**（container） | 镜像的运行实例 |
| **数据卷**（volume） | 持久化存储（如 `library_redis_data`） |
| **profiles** | 条件启动标记，`--profile prod` 时才激活对应服务 |

## 初始账号

| 用户名 | 密码 | 角色 |
|---|---|---|
| `admin` | `你的初始密码` | 管理员 |
| `librarian` | `你的初始密码` | 管理员 |

## 常见问题

**Q: `docker compose up -d` 执行两次会怎样？**

不会出问题。Docker Compose 是幂等的——对比当前状态和期望状态，一致就跳过。加 `--build` 才重建镜像，但容器本身不会重复创建。

## Windows 端口注意

Windows 保留端口范围（Hyper-V / WinNAT）可能占用 6379、6380 等常见端口。
本配置 Redis 使用 6490 端口避免冲突。如果在宿主机启动失败，排查：
```powershell
netsh interface ipv4 show excludedportrange protocol=tcp
```

## 开发环境完整启动步骤

```bash
# 本项目根目录执行（c:\...\library）

# 1. 启动 Redis
cd deploy
docker compose -p library up -d
cd ..

# 2. 启动后端（Air 热更新）
cd Server
air
cd ..

# 3. 启动前端（Vite HMR）
cd Web
npm run dev

# 访问 http://localhost:5173
```

## 生产环境部署

```bash
# 1. 构建前端
cd Web && npm run build

# 2. 上传前端文件
scp -r dist/* user@server:/var/www/library/

# 3. 上传项目代码
scp -r ../Server user@server:/opt/library/
scp docker-compose.yml .env.prod Dockerfile.backend user@server:/opt/library/deploy/
scp -r mysql/init.sql user@server:/opt/library/deploy/mysql/

# 4. 部署 Nginx 配置
scp server-nginx/library.conf user@server:/etc/nginx/conf.d/
ssh user@server "nginx -s reload"

# 5. 启动 Docker 服务
ssh user@server "cd /opt/library/deploy && docker compose -p library --profile prod up -d --build"
```
