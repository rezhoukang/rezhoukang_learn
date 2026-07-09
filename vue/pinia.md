# Pinia 状态管理

**Pinia** = 全局数据仓库，多个组件共享同一份数据。

## 安装与注册

```ts
// main.ts
import { createPinia } from 'pinia'

const pinia = createPinia()
app.use(pinia)
app.mount('#app')
```

## 定义 Store（组合式）

```ts
// store/loveTalk.ts
import { defineStore } from 'pinia'
import { reactive } from 'vue'
import axios from 'axios'
import { nanoid } from 'nanoid'

export const useTalkStore = defineStore('talk', () => {
  const talkList = reactive(JSON.parse(localStorage.getItem('talkList') as string) || [])

  async function getATalk() {
    const { data: { content: title } } = await axios.get('https://api.uomg.com/api/rand.qinghua?format=json')
    talkList.unshift({ id: nanoid(), title })
  }

  return { talkList, getATalk }
})
```

## 组件中使用

```vue
<script setup lang="ts">
import { useCountStore } from '@/store/count'
import { useTalkStore } from '@/store/loveTalk'
import { storeToRefs } from 'pinia'

const countStore = useCountStore()
const talkStore = useTalkStore()

// storeToRefs：只解构数据，不解构方法（保持响应式）
const { sum, school } = storeToRefs(countStore)
const { talkList } = storeToRefs(talkStore)
</script>

<template>
  <h2>{{ sum }}</h2>
  <button @click="countStore.increment(1)">加1</button>

  <ul>
    <li v-for="talk in talkList" :key="talk.id">{{ talk.title }}</li>
  </ul>
  <button @click="talkStore.getATalk()">获取情话</button>
</template>
```

## 监听数据变化

```ts
talkStore.$subscribe((mutate, state) => {
  localStorage.setItem('talkList', JSON.stringify(state.talkList))
})
```

## 关键点

| 概念 | 说明 |
|------|------|
| `defineStore('id', () => {...})` | 定义 store，id 全局唯一 |
| `return { ... }` | 暴露数据和方法的出口 |
| `storeToRefs` | 在组件中解构数据时保持响应性 |

## Hook vs Pinia

| | Hook | Pinia |
|--|------|-------|
| 作用域 | 组件内 | 全局 |
| 数据共享 | 每个组件各自独立 | 所有组件共用一份 |
| 适合 | 组件内逻辑复用 | 全局状态（登录、购物车） |