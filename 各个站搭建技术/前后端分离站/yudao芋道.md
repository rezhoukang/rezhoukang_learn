# 芋道 Yudao vs 若依 RuoYi — 避坑压缩版

> **历史渊源**：芋道早期借鉴 RuoYi-Vue 起步，**但已完全独立重构，两套互不兼容，不能互相升级迁移。**

---

## 一、技术栈速览

| 维度 | 芋道 Yudao | 若依 RuoYi-Vue3 |
|------|-----------|----------------|
| 后端 | Spring Boot 2.7/3.x + MyBatis-Plus | Spring Boot + **原生 MyBatis**（无Plus） |
| 安全 | Spring Security + JWT + Redisson | Spring Security + JWT + Redis |
| 缓存 | Redis + Caffeine 二级缓存 | Redis |
| 数据库 | MySQL/PG/达梦/Oracle/SQLServer | **优先MySQL**，其余需改造 |
| 前端 | Vue3 + Vite + TS + Element Plus | Vue3 + Vite + JS/TS + Element Plus |
| 架构 | **Maven多模块 + starter分层** | **单模块，简单直白** |
| 内置组件 | OSS文件抽象、Flowable工作流、支付、短信、三方登录、多租户 | **仅基础RBAC、定时任务、日志、多数据源** ❌无OSS/工作流/支付/多租户 |
| 代码生成 | 主子表CRUD+导入导出+单元测试+API文档 | 仅**单表基础CRUD** |
| 单体→微服务 | yudao-boot / yudao-cloud 同源，迁移成本低 | RuoYi-Vue / RuoYi-Cloud 独立仓库，**重构量巨大** |
| 开源协议 | **AGPLv3**（商用受限） | **MIT**（商用宽松） |

---

## 二、一句话总结

| 框架 | 适合谁 |
|------|--------|
| **芋道 Yudao** | 需要多租户/OSS文件切换/工作流/支付的企业级项目，不惧学习曲线 |
| **若依 RuoYi** | 简单后台、快速Demo、小型内部系统，追求极致轻量和社区资源 |

---

## 三、你的场景选型

> 需求：单体项目，文件先存本地，后续平滑迁移**腾讯云COS**

- **简单后台、无租户无审批无支付** → **若依**（轻量快速，COS需自己手写上传）
- **需要无缝切换本地/COS，未来可能上多租户/审批** → **芋道**（内置文件抽象层完美契合）

---