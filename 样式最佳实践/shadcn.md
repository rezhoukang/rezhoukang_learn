- **Three.js** → 3D 渲染
- **Anime.js** → 动画

## 1. Copy-Paste 模式，无黑盒
传统组件库 `npm install` 全量引入，样式和行为封装在黑盒里，不利于 AI 阅读。shadcn/ui 除 Tailwind + 无头库外，组件通过 CLI 按需复制源码到项目中，代码完全可见可改。

## 2. 基于 Tailwind CSS + 无头库
- **Vue** → shadcn-vue（底层 Radix Vue）
- **React** → Radix UI

**无头库**负责 **UX/JS**（交互逻辑）：状态管理、键盘交互、焦点锁定、定位计算、无障碍、跨浏览器统一。
**Tailwind CSS** 负责 **UI**（样式）：原子化类名 + CSS 变量，改配置即可调整主题/间距/颜色/暗色模式。

## 3. 多框架扩展
- **React** → shadcn/ui（Next.js / Vite / Remix）
- **Vue 3** → shadcn-vue
- **Svelte** → shadcn-svelte

## 示例

```bash
# 安装
npm create vue@latest my-app
cd my-app
npx shadcn-vue init       # 初始化 Tailwind 配置
npx shadcn-vue add button # 复制按钮组件到项目
```

```vue
<script setup>
import { Button } from '@/components/ui/button'
</script>

<template>
  <Button variant="destructive">删除</Button>
</template>
```

```vue
<!-- 但源码就在项目里，直接打开改 -->
<!-- @/components/ui/button/Button.vue -->
<script setup>
// 想改 destructive 的颜色？直接在这里改 Tailwind 类名
const variants = {
  destructive: 'bg-red-500 hover:bg-red-600',  // → 改成 bg-orange-500
}
</script>

<template>
  <button :class="variants[variant]">
    <slot />
  </button>
</template>
```

Tailwind 不依赖无头库，自己也能直接用：

```html
<div class="bg-white shadow-lg rounded-lg p-6 max-w-sm mx-auto mt-10">
  <h2 class="text-xl font-bold text-gray-900">登录</h2>
  <input class="w-full border rounded px-3 py-2 mt-4" placeholder="用户名">
  <button class="w-full bg-blue-500 text-white rounded py-2 mt-4 hover:bg-blue-600">
    提交
  </button>
</div>
```