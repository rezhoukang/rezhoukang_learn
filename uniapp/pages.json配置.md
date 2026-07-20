# pages.json 全局配置

## 一、pages 配置 — 页面注册

所有页面必须在 `pages.json` 中注册，否则跳转不生效。

```json
{
    "pages": [
        {"path": "pages/index/index", "style": {}},
        {"path": "pages/list/list", "style": {}},
        {"path": "pages/detail/detail", "style": {}}
    ]
}
```

**`style` 常用配置（针对顶部标签栏，不是页面内容）：**

```json
{
    "path": "pages/index/index",
    "style": {
        "navigationBarTitleText": "首页",       // 顶部标签栏标题
        "navigationBarBackgroundColor": "#fff", // 顶部标签栏背景色
        "enablePullDownRefresh": true           // 允许下拉刷新
    }
}
```
<!-- 其实严格来说：

顶部的叫 导航栏（NavigationBar）— 官方属性名就是 navigationBarTitleText
底部的叫 标签栏（TabBar）— 官方属性名就是 tabBar -->
> `style` 里配置的是**顶部标签栏**（顶部那条栏）的样式，不是页面的背景色、字体那些。
> 页面内容的样式在各自的 `.vue` 文件的 `<style>` 里写。

---

## 二、tabBar 配置 — 底部标签栏

```json
{
    "tabBar": {
        "color": "#999",                    // 文字默认颜色
        "selectedColor": "#007AFF",         // 选中时文字颜色
        "list": [
            {
                "text": "首页",
                "pagePath": "pages/index/index",
                "iconPath": "static/tab/home.png",
                "selectedIconPath": "static/tab/home-active.png"
            },
            {
                "text": "列表",
                "pagePath": "pages/list/list",
                "iconPath": "static/tab/list.png",
                "selectedIconPath": "static/tab/list-active.png"
            }
        ]
    }
}
```

**注意：**
- `pagePath` 必须是 `pages` 中已注册的页面
- 跳转 tabBar 页面代码中必须用 `uni.switchTab()`
- 底部 tab 用户点击自动跳转，不需要写代码

---

## 三、easycom 配置 — 组件自动引入

不用手动 `import` 和注册组件，按规则命名即可自动引入。

```json
{
    "easycom": {
        "autoscan": true,                  // 自动扫描组件
        "custom": {
            // 自定义匹配规则
            "^uni-(.*)": "@/components/uni-$1/uni-$1.vue"
        }
    }
}
```

**默认规则：** `components/组件名/组件名.vue` 会自动被识别。

```vue
<!-- 不用 import，直接使用 -->
<template>
    <view>
        <MyButton />    <!-- 自动匹配 components/MyButton/MyButton.vue -->
    </view>
</template>
```

---

## 四、appPlus 配置 — App 端特有配置

只在 App 端生效的配置：

```json
{
    "app-plus": {
        "splashscreen": {
            "alwaysShowBeforeRender": true,    // 启动封面
            "autoclose": false
        },
        "distribute": {
            "android": {
                "icons": {
                    "hdpi": "static/icon.png"  // 安卓图标
                }
            },
            "ios": {
                "icons": {
                    "appstore": "static/icon.png"  // iOS 图标
                }
            }
        }
    }
}
```
