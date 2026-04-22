import { createRouter, createWebHistory } from 'vue-router'
import NotFoundView from '@/views/NotFoundView.vue'
import ServerView from '@/views/ServerView.vue'
import SettingsView from '@/views/SettingsView.vue'
import ConsoleView from '@/views/ConsoleView.vue'
// Импортируем новый компонент
import FilesView from '@/views/FilesView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'server',
      component: ServerView,
    },
    {
      path: '/settings',
      name: 'settings',
      component: SettingsView,
    },
    {
      path: '/console',
      name: 'console',
      component: ConsoleView,
    },
    {
      // Добавляем путь для файлов
      path: '/files',
      name: 'files',
      component: FilesView,
    },
    {
      path: '/:catchAll(.*)', // Исправил опечатку в параметре catchAll
      name: 'not-found',     // Исправил опечатку в name
      component: NotFoundView,
    },
  ],
})

export default router
