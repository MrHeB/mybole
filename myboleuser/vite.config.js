import path from 'path'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import ElementPlus from 'unplugin-element-plus/vite'

const pathSrc = path.resolve(__dirname, 'src')

export default defineConfig({
  resolve: {
    alias: {
      '~/': `${pathSrc}/`,
      '@': pathSrc,
    },
  },
  plugins: [
    vue(),
    ElementPlus({
      useSource: true,
      lib: '@hc/element-plus'
    }),
  ],
})