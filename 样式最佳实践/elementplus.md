## 1. 传统组件库，黑盒引入
`npm install element-plus` 全量引入，样式和行为封装在黑盒里。想改样式得用 CSS 变量覆盖或 `:deep()` 穿透，源码不可见。

## 2. 自带 UI + UX，无需额外库
- **Element Plus** → Vue 3
- **Element UI** → Vue 2
- **Ant Design** → React

**自带完整样式和交互**：按钮、表单、弹窗、表格等开箱即用，不需要 Tailwind 也不需要无头库，装一个库全搞定。

## 3. 框架限定
- **Element Plus** → 仅 Vue 3
- **Element UI** → 仅 Vue 2
- **Ant Design** → 仅 React

## 示例

```bash
# 安装
npm install element-plus
```

```vue
<script setup>
import { ElButton } from 'element-plus'
</script>

<template>
  <ElButton type="danger">删除</ElButton>
</template>
```

```vue
<!-- 想改 danger 的样式？不能直接改源码，只能用 CSS 覆盖 -->
<style scoped>
/* 需要 :deep() 穿透，且依赖 Element 的 CSS 变量名 */
:deep(.el-button--danger) {
  background-color: orange;
  border-color: orange;
}
</style>
```

## 对比总结

| | Element UI / Ant Design | shadcn |
|--|------------------------|--------|
| 源码 | 黑盒，只读 | 在项目里，直接改 |
| 样式 | 自带，覆盖麻烦 | Tailwind，改类名就行 |
| 交互 | 自带，不用操心 | 无头库提供 |
| 安装 | 全量引入 | 按需复制 |