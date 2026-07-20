# UniApp 和 Vue 的区别

## Vue 版本

UniApp 有 **Vue 2 版** 和 **Vue 3 版**两个版本。

新建项目时选择：

```
HBuilder 新建 uni-app 项目
  ├── 默认模板（Vue 2）        ← 旧版，选项式 API
  └── uni-app Vue3/Vite 版      ← 新版，Composition API
```

**选 Vue 3/Vite 版**，跟你之前学的 Vue 3 完全一致。

## 兼容性对比

| 功能 | 能用吗 | 说明 |
|------|--------|------|
| **`<script setup>`** | ✅ | 支持（Vue 3 版） |
| **Composition API (ref/reactive)** | ✅ | 支持 |
| **Pinia** | ✅ | 支持，用法一样 |
| **插件通信（props/emit）** | ✅ | 完全一样 |
| **slot** | ✅ | 完全一样 |
| **Vue Router** | ❌ | 用 `pages.json` + `uni.navigateTo()` |
| **路由守卫 beforeEach** | ❌ | 用 `onShow()` `onHide()` 代替 |
| **axios** | ❌ | 用 `uni.request()` 代替 |
| **shadcn/ui / Element Plus** | ❌ | 基于 HTML DOM，UniApp 是原生渲染，用不了 |
| **v-html** | ⚠️ | 不支持（小程序无 DOM） |

## UniApp 独有写法

### 项目结构

```
uniapp-project/
├── components/         ← 组件
├── pages/              ← 页面
├── static/             ← 静态资源（图片、CSS 文件）
├── App.vue             ← 整个 uni-app 项目的第一个组件
├── index.html
├── main.js             ← 第一个运行的 JS 文件（全局 JS，和 Vue CLI 的 main.js 差不多）
├── manifest.json       ← 全局文件 → 应用的配置
├── pages.json          ← 全局文件 → 页面的配置
└── uni.scss            ← 全局样式文件
```

```vue
<script setup>
// 1. 跳转页（不用 router.push）
uni.navigateTo({ url: '/pages/detail/detail' })

// 2. 守卫用页面生命周期代替
onShow(() => {
  const token = uni.getStorageSync('token')
  if (!token) uni.navigateTo({ url: '/pages/login/login' })
})

// 3. 请求用 uni.request（不用 axios）
uni.request({
  url: 'https://api.xxx.com/user',
  success: (res) => console.log(res.data)
})

// 4. 存储用 uni.setStorageSync（不用 localStorage）
uni.setStorageSync('token', 'abc')
</script>
```




