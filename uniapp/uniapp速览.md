# UniApp 速览

UniApp = DCloud 团队推出的多端框架，语法基于 Vue，一套代码打包到小程序/App/H5。

## 核心概念

```
一套 Vue 代码
    ↓ 条件编译
  ├── 微信小程序
  ├── 支付宝小程序
  ├── iOS App
  ├── Android App
  └── H5 网页
```

**优点：** 写一次到处跑，生态全（UniCloud/UniPay/UniCSS）
**缺点：** 复杂交互不如原生，各端表现可能有差异

## 项目结构

```
uniapp-project/
├── pages/                     # 页面（每个页面一个文件夹）
│   └── index/index.vue
├── components/                # 组件
├── static/                    # 静态资源（不编译）
├── uni_modules/               # uni 插件
├── App.vue                    # 根组件
├── main.js                    # 入口
├── pages.json                 # 页面路由+全局样式
├── manifest.json              # 应用配置（App权限/图标）
└── uni.scss                   # 全局样式变量
```

## 基本语法（跟 Vue 一样）

```vue
<template>
  <view>                          <!-- view = div -->
    <text>{{ msg }}</text>        <!-- text = span -->
    <button @click="handleClick">点我</button>
    <image :src="url" />          <!-- image = img -->
  </view>
</template>

<script>
export default {
  data() { return { msg: '你好', url: '' } },
  methods: { handleClick() { uni.showToast({ title: '点了' }) } },
  onLoad() { console.log('页面加载') }
}
</script>

<style scoped>
view { padding: 20rpx; }          /* rpx 是响应式单位，750rpx = 屏幕宽度 */
</style>
```

## 常用 API

```js
// 跳转
uni.navigateTo({ url: '/pages/detail/detail' })     // 新开页面
uni.redirectTo({ url: '/pages/login/login' })        // 替换当前页
uni.switchTab({ url: '/pages/home/home' })           // 切 Tab

// 提示
uni.showToast({ title: '成功', icon: 'success' })    // 轻提示
uni.showModal({ title: '确认', content: '确定删除？' }) // 弹窗

// 请求
uni.request({ url: 'https://api.xxx.com/data', success: res => {} })

// 存储
uni.setStorageSync('token', 'abc')
uni.getStorageSync('token')  // 'abc'
```

## 条件编译

一套代码兼容多端，用注释标记平台：

```vue
<!-- #ifdef H5 -->
<view>只在 H5 显示</view>
<!-- #endif -->

<!-- #ifdef MP-WEIXIN -->
<view>只在微信小程序显示</view>
<!-- #endif -->

<!-- #ifdef APP-PLUS -->
<view>只在 App 显示</view>
<!-- #endif -->
```

## 环境配置（必做）

### 1. 下载工具

| 工具 | 用途 | 下载地址 |
|------|------|---------|
| HBuilder X | UniApp 开发 IDE | dcloud.io/hbuilderx.html |
| 微信开发者工具 | 预览/调试小程序 | 微信公众平台 → 开发工具 |

### 2. 微信小程序 AppID

1. 打开 [微信公众平台](https://mp.weixin.qq.com/) → 注册小程序（个人即可）
2. 登录后左侧菜单 → **开发** → **开发管理** → **开发设置**
3. 复制 **AppID（小程序ID）**

### 3. HBuilder 项目配置

```
1. HBuilder 新建项目 → 选择 uni-app → 填项目名
2. 打开 manifest.json → 微信小程序配置 → 粘贴 AppID
3. 菜单栏 运行 → 运行到小程序模拟器 → 微信开发者工具
4. 首次运行会提示安装微信开发者工具路径：
   HBuilder → 工具 → 设置 → 运行配置 → 微信开发者工具路径
   （安装路径例如：C:\Program Files (x86)\Tencent\微信web开发者工具）
```

### 4. 微信开发者工具设置

```
1. 打开微信开发者工具
2. 右上角 设置 → 安全 → 开启服务端口（必须开，否则 HBuilder 调不起来）
3. 扫码登录
4. HBuilder 点运行后，微信开发者工具自动弹出预览
```

## pages.json 配置

```json
{
  "pages": [
    { "path": "pages/index/index", "style": { "navigationBarTitleText": "首页" } }
  ],
  "globalStyle": { "navigationBarBackgroundColor": "#fff" },
  "tabBar": {
    "list": [
      { "pagePath": "pages/index/index", "text": "首页" },
      { "pagePath": "pages/mine/mine", "text": "我的" }
    ]
  }
}
```

## 生态（了解即可）

| 名称 | 用途 |
|------|------|
| UniCloud | 云开发（数据库/云函数/存储），免服务器 |
| UniPay | 支付聚合（微信/支付宝） |
| UniAD | 广告变现 |
| UniCloud | 云开发（数据库/云函数/存储） |
| UniPay | 支付聚合（微信/支付宝） |
| UniCSS | CSS 框架（rpx 响应式） |
| UniAD | 广告变现 |
| uni-id | 用户登录注册体系 |

## pages.json 配置

```json
{
  "pages": [
    { "path": "pages/index/index", "style": { "navigationBarTitleText": "首页" } }
  ],
  "globalStyle": { "navigationBarBackgroundColor": "#fff" },
  "tabBar": {
    "list": [
      { "pagePath": "pages/index/index", "text": "首页" },
      { "pagePath": "pages/mine/mine", "text": "我的" }
    ]
  }
}
```

## 打包发布

| 目标 | 操作 |
|------|------|
| **微信小程序** | HBuilder 菜单 → 发行 → 小程序-微信 → 填 AppID → 自动上传到微信后台 |
| **H5 网页** | 发行 → 网站-H5手机版 → 生成 dist → 丢到 nginx 目录 |
| **iOS/Android App** | 发行 → 原生App-云打包 → 需要证书（iOS $99/年，Android 免费） |

打包后在微信小程序后台（mp.weixin.qq.com）→ **版本管理** → 提交审核 → 通过后用户就能搜到。

