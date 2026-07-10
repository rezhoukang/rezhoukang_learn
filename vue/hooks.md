# 自定义 Hooks

**Hook** = 把相关的数据、方法、生命周期封装在一块，组件直接调，不用每处都重写。

```ts
// hooks/useSum.ts — 把"求和"相关的数据和操作封装在一起
import { ref, onMounted } from 'vue'

export default function () {
  const sum = ref(0)

  function add() { sum.value += 1 }

  onMounted(() => add())

  return { sum, add }
}
```

```ts
// hooks/useDog.ts — 把"小狗"相关的数据和操作封装在一起
import { reactive } from 'vue'
import axios from 'axios'

export default function () {
  const dogList = reactive(['https://...jpg'])

  async function getDog() {
    const res = await axios.get('https://dog.ceo/api/...')
    dogList.push(res.data.message)
  }

  return { dogList, getDog }
}
```

```vue
<!-- 组件里直接调，不用关心内部怎么实现的 -->
<script setup>
import useSum from '@/hooks/useSum'
import useDog from '@/hooks/useDog'

const { sum, add } = useSum()
const { dogList, getDog } = useDog()
</script>
```

**什么时候用**：多个组件逻辑相似时抽成 hook。不相似就别硬抽。