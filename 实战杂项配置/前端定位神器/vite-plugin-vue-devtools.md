import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import VueDevTools from 'vite-plugin-vue-devtools'
import path from 'path'

// ═══════════════════════════════════════════════════
// 重点：Ctrl+Shift（Windows）/ Cmd+Shift（Mac）
// 开启：按住快捷键 → 鼠标移到组件上 → 组件高亮
// 点击组件 → 自动跳转到 VS Code 对应源码位置
// 关闭：再按一次快捷键，或点页面右上角的 DevTools 图标关闭
// ═══════════════════════════════════════════════════
const componentInspectorToggleComboKey = process.platform === 'darwin' ? 'meta-shift' : 'control-shift'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    VueDevTools({
      enabled: true, // true=开启 false=关闭；生产环境自动关可改为 process.env.NODE_ENV !== 'production'
      launchEditor: 'code',
      componentInspector: {
        toggleComboKey: componentInspectorToggleComboKey
      }
    }),
    vue()
  ],
  css: {
    preprocessorOptions: {
      scss: {
        api: 'modern-compiler' // 使用 Sass 现代编译器 API，避免 legacy-js-api 弃用警告
      }
    }
  },
  resolve: {
    alias: {
      '@': path.resolve(__dirname, 'src')
    }
  }
})
