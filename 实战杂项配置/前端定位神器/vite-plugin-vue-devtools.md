import { fileURLToPath, URL } from 'node:url'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import tailwindcss from '@tailwindcss/vite'
import VueDevTools from 'vite-plugin-vue-devtools'

// ============================================================
// Vue DevTools 开关
// - true：开启（默认）
// - false：关闭（插件完全不加载）
// 下方保留「生产自动关」保护：构建生产包时不注入 DevTools
// ============================================================
const DEVTOOLS_ENABLED = false

const enableDevTools =
  DEVTOOLS_ENABLED && process.env.NODE_ENV !== 'production'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    ...(enableDevTools
      ? [
          VueDevTools({
            launchEditor: 'code', // 点击组件用 VS Code 打开源码
            componentInspector: true, // 组件检查器（Ctrl+Shift 定位组件）
          }),
        ]
      : []),
    vue(),
    tailwindcss(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
})
