import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  build: {
    outDir: 'dist',
    sourcemap: true
  },
  server: {
    proxy: {
      '/api': {
        target: process.env.VITE_API_URL || 'https://novicars-backend.railway.app',
        changeOrigin: true,
        secure: false,
      },
    },
  },
}); 