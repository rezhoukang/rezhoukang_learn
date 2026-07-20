# .gitignore — 哪些文件不提交到 Git

## 通常忽略的三类

```
# 1. 依赖（体积大，可重新下载）
node_modules/
vendor/
dist/

# 2. 编译产物（每次构建自动生成）
*.class
*.jar
*.log
target/
build/
out/

# 3. 生产环境变量或者一些密钥pem文件（含密码、Key 等敏感信息，不应提交）
.env
.env.local
application-prod.yml
*.pem
```

## 为什么忽略

| 文件 | 原因 |
|------|------|
| `node_modules/` | 用 `npm install` 就能恢复 |
| `target/` | 用 `mvn compile` 就能生成 |
| `.env` | 生产环境变量，含密码、Key，泄露危险 |

> **开发环境变量**（`application-dev.yml`）不忽略，默认密码当模板提交。
> **生产环境变量**（`.env`、`application-prod.yml`）必须忽略，真实密码不能提交。


