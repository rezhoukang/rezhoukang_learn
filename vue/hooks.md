# 自定义 Hooks

**Hook** = 把组件里可复用的逻辑（数据 + 方法 + 生命周期）抽出来，封装成函数。

## 什么时候用 Hook？

当多个组件有相同的逻辑时，不用每个组件都写一遍，抽成 hook 共用。

## 示例：useSum

```ts
// hooks/useSum.ts
import { ref, onMounted, computed } from 'vue'

export default function () {
  const sum = ref(0)
  const bigSum = computed(() => sum.value * 10)

  function add() {
    sum.value += 1
  }

  onMounted(() => add())

  return { sum, add, bigSum }
}
```

## 示例：useDog

```ts
// hooks/useDog.ts
import { reactive, onMounted } from 'vue'
import axios from 'axios'

export default function () {
  const dogList = reactive([
    'https://images.dog.ceo/breeds/pembroke/n02113023_4373.jpg'
  ])

  async function getDog() {
    const result = await axios.get('https://dog.ceo/api/breed/pembroke/images/random')
    dogList.push(result.data.message)
  }

  onMounted(() => getDog())

  return { dogList, getDog }
}
```

## 组件中使用

```vue
<script lang="ts" setup>
import useSum from '@/hooks/useSum'
import useDog from '@/hooks/useDog'

const { sum, add, bigSum } = useSum()
const { dogList, getDog } = useDog()
</script>

<template>
  <h2>{{ sum }}，放大10倍：{{ bigSum }}</h2>
  <button @click="add">加1</button>
  <img v-for="(dog, i) in dogList" :src="dog" :key="i">
  <button @click="getDog">再来一只</button>
</template>
```

## 总结

| | 直接写在组件里 | 抽成 Hook |
|--|-------------|----------|
| 复用性 | 换个组件就得重写 | 别的组件直接 import 用 |
| 代码整洁 | 组件越来越臃肿 | 组件只调 hook，逻辑清晰 |
| 维护 | 改逻辑要在每个组件里改 | 改一个 hook 所有地方全变 |