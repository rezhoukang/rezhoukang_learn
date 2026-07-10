# Pinia 状态管理

**Pinia** = 全局数据仓库，多个组件共享同一份数据。

## 定义 Store

```ts
// store/loveTalk.ts
import { defineStore } from 'pinia'
import { reactive } from 'vue'
import axios from 'axios'
import { nanoid } from 'nanoid'

export const useTalkStore = defineStore('talk', () => {
  // 从 localStorage 读取数据初始化，没有就给空数组
  const talkList = reactive(JSON.parse(localStorage.getItem('talkList') as string) || [])

  async function getATalk() {
    // 发请求获取土味情话，解构出 content 并重命名为 title
    const { data: { content: title } } = await axios.get('https://api.uomg.com/api/rand.qinghua?format=json')
    // 生成唯一 id，把情话加到列表最前面
    talkList.unshift({ id: nanoid(), title })
  }

  return { talkList, getATalk }
})
```

## 组件中使用

```vue
<script setup lang="ts">
import { useTalkStore } from '@/store/loveTalk'
import { storeToRefs } from 'pinia'

const talkStore = useTalkStore()
const { talkList } = storeToRefs(talkStore)
</script>

<template>
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
| `storeToRefs` | 保持响应式：直接从 store 解构会丢失响应式，必须用 `storeToRefs` 包一下 |

## Hook vs Pinia

| | Hook | Pinia Store |
|--|------|-------------|
| 数据 | 每个组件独立 | 全局共享一份 |
| 写法 | `function useXxx()` | `defineStore('id', () => {...})` |
| 解构 | 直接解构就行 | 必须用 `storeToRefs` |
| 调试 | 无 | Vue DevTools 可视化 |
| 监听 | 自己写 `watch` | 内置 `$subscribe` |

**写起来一样，跑起来不同。** Hook 是菜谱，每次照做一份新的；Store 是食堂，所有人吃同一锅。

---

全用 Pinia 也能跑，但没必要。就像买菜也能开卡车，但自行车更方便。

```ts
// 场景1：只在当前组件用 → Hook 就行，不用注册 Pinia
function useMouse() {
  const x = ref(0)
  const y = ref(0)
  window.addEventListener('mousemove', (e) => { x.value = e.x; y.value = e.y })
  return { x, y }
}

// 场景2：多个组件共享 → Pinia
export const useUserStore = defineStore('user', () => {
  const token = ref('')
  function login() { ... }
  return { token, login }
})
```

**原则：数据要跨组件共享 → Pinia；只在当前组件/单页面用 → Hook。** 全用 Pinia 也能跑，但全局 Store 塞一堆杂七杂八的，调试和维护反而更累。