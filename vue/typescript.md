# TypeScript 快速上手

## interface — 定义对象结构

```ts
// types/index.ts
export interface PersonInter {
  id: string
  name: string
  age: number
}
```

## type — 自定义类型

```ts
export type Persons = PersonInter[]
// 等价于：export type Persons = Array<PersonInter>
```

## 在 Vue 中使用

```vue
<script lang="ts" setup>
import { type PersonInter, type Persons } from '@/types'

// 用 interface 限制单个对象
let person: PersonInter = { id: '001', name: '张三', age: 60 }

// 用 type 限制数组
let personList: Persons = [
  { id: '001', name: '张三', age: 60 },
  { id: '002', name: '李四', age: 18 }
]
</script>
```

## 关键点

| 概念 | 作用 |
|------|------|
| `interface` | 定义对象有哪些属性、每个属性什么类型 |
| `type` | 给类型起别名（更灵活，可定义联合类型、数组类型等） |
| `export` | 把类型导出，其他文件可以引用 |
| `import type` | 只引入类型，编译后不保留 |