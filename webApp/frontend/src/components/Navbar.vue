<script setup>
import { useRoute } from 'vue-router'

const route = useRoute()
const menu = [
  { name: 'Server', icon: 'pi pi-power-off', route: '/' },
  { name: 'Settings', icon: 'pi pi-cog', route: '/settings' },
  { name: 'Console', icon: 'pi pi-code', route: '/console' },
  { name: 'Core', icon: 'pi pi-microchip', route: '/core' },
  { name: 'Files', icon: 'pi pi-folder', route: '/files' },
  { name: 'Journal', icon: 'pi pi-book', route: '/journal' },
  { name: 'Players', icon: 'pi pi-users', route: '/players' },
]
const isActiveLink = (routePath) => route.path === routePath
</script>

<template>
  <aside class="h-screen w-56 bg-ctp-mantle flex flex-col py-6 px-2 fixed left-0 top-0 z-20 border-r border-ctp-surface0">
    <div class="flex items-center gap-2 mb-8 px-2">
      <img src="@/assets/img/logo.png" class="w-12 h-12" alt="Logo" />
      <span class="text-ctp-text text-xl font-bold tracking-wide">Редстоун ВЕБ</span>
    </div>
    <nav class="flex-1">
      <ul class="space-y-2">
        <li v-for="item in menu" :key="item.name">
          <button
            @click="() => $router.push(item.route)"
            :class="[
              'flex items-center w-full text-left px-4 py-3 rounded-lg transition group',
              isActiveLink(item.route)
                /* Активная ссылка: фон surface0, текст mauve (фиолетовый) */
                ? 'bg-ctp-surface0 text-ctp-mauve'
                /* Обычная ссылка: текст subtext, при ховере текст mauve */
                : 'text-ctp-subtext hover:bg-ctp-surface0 hover:text-ctp-mauve'
            ]"
          >
            <span :class="[item.icon, 'mr-3 text-lg', isActiveLink(item.route) ? 'text-ctp-mauve' : 'group-hover:text-ctp-mauve']"></span>
            <span class="font-medium">{{ item.name }}</span>
          </button>
        </li>
      </ul>
    </nav>
  </aside>
</template>
