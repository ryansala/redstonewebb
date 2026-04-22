<script setup>
import { ref } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()
const isMobileMenuOpen = ref(false) // Состояние для мобильного меню

const menu = [
  { name: 'Server', icon: 'pi pi-power-off', route: '/' },
  { name: 'Settings', icon: 'pi pi-cog', route: '/settings' },
  { name: 'Console', icon: 'pi pi-code', route: '/console' },
  { name: 'Files', icon: 'pi pi-folder', route: '/files' },
  // ... остальные пункты
]

const isActiveLink = (routePath) => route.path === routePath
const toggleMenu = () => { isMobileMenuOpen.value = !isMobileMenuOpen.value }
</script>

<template>
  <header class="lg:hidden fixed top-0 left-0 w-full bg-ctp-mantle border-b border-ctp-surface0 z-30 p-4 flex justify-between items-center">
    <div class="flex items-center gap-2">
      <img src="@/assets/img/logo.png" class="w-8 h-8" alt="Logo" />
      <span class="text-ctp-text font-bold">Редстоун ВЕБ</span>
    </div>
    <button @click="toggleMenu" class="text-ctp-mauve text-2xl p-2">
      <i :class="isMobileMenuOpen ? 'pi pi-times' : 'pi pi-bars'"></i>
    </button>
  </header>

  <aside 
    :class="[
      'h-screen w-64 bg-ctp-mantle flex flex-col py-6 px-4 fixed left-0 top-0 z-40 border-r border-ctp-surface0 transition-transform duration-300 ease-in-out lg:translate-x-0',
      isMobileMenuOpen ? 'translate-x-0 shadow-2xl' : '-translate-x-full'
    ]"
  >
    <div class="hidden lg:flex items-center gap-3 mb-10 px-2">
      <img src="@/assets/img/logo.png" class="w-10 h-10" alt="Logo" />
      <span class="text-ctp-text text-xl font-bold tracking-wide">Редстоун ВЕБ</span>
    </div>

    <nav class="flex-1">
      <ul class="space-y-2">
        <li v-for="item in menu" :key="item.name">
          <button
            @click="() => { $router.push(item.route); isMobileMenuOpen = false; }"
            :class="[
              'flex items-center w-full text-left px-4 py-3 rounded-xl transition group',
              isActiveLink(item.route)
                ? 'bg-ctp-surface0 text-ctp-mauve shadow-lg'
                : 'text-ctp-subtext hover:bg-ctp-surface0/50 hover:text-ctp-mauve'
            ]"
          >
            <i :class="[item.icon, 'mr-4 text-xl', isActiveLink(item.route) ? 'text-ctp-mauve' : 'group-hover:text-ctp-mauve']"></i>
            <span class="font-medium">{{ item.name }}</span>
          </button>
        </li>
      </ul>
    </nav>

    <div 
      v-if="isMobileMenuOpen" 
      @click="toggleMenu" 
      class="lg:hidden fixed inset-0 bg-ctp-base/80 -z-10"
    ></div>
  </aside>
</template>
