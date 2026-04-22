<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'

const status = ref('Loading...')
const version = ref('...')
const serverIp = ref(window.location.host.split(':')[0])
const loading = ref(false)
const error = ref('')

async function fetchStatus() {
  try {
    const res = await axios.get('/api/v1/server/status')
    status.value = res.data.status === 'UP' ? 'Online' : 'Offline'
  } catch (e) {
    status.value = 'Error'
  }
}

async function fetchVersion() {
  try {
    const res = await axios.get('/api/v1/minecraft/current')
    version.value = res.data.version
  } catch (e) {
    version.value = 'Error'
  }
}

async function serverAction(action) {
  loading.value = true
  error.value = ''
  try {
    await axios.post(`/api/v1/server/${action}`)
    await fetchStatus()
  } catch (e) {
    error.value = 'Ошибка: ' + (e.response?.data?.error || e.message)
  }
  loading.value = false
}

onMounted(() => {
  fetchStatus()
  fetchVersion()
})
</script>

<template>
  <div class="lg:ml-64 min-h-screen pt-20 lg:pt-0 bg-ctp-base transition-all duration-300">
    
    <div class="min-h-screen bg-gradient-to-br from-ctp-base to-ctp-mantle p-8 md:p-12 text-ctp-text">
      
      <h1 class="text-3xl font-bold mb-10 flex items-center gap-3 text-ctp-mauve">
        <i class="pi pi-desktop"></i>
        Панель управления сервером
      </h1>

      <div class="grid grid-cols-1 xl:grid-cols-3 gap-8">
        
        <div class="xl:col-span-2 bg-ctp-crust rounded-3xl p-8 border border-ctp-surface0 shadow-2xl transition-all hover:border-ctp-surface1">
          
          <div class="flex flex-col md:flex-row items-center gap-8 mb-10">
            <div :class="[
              'w-24 h-24 rounded-full flex items-center justify-center text-5xl shadow-inner',
              status === 'Online' ? 'bg-ctp-green/20 text-ctp-green animate-pulse' :
              status === 'Offline' ? 'bg-ctp-red/20 text-ctp-red' :
              'bg-ctp-mauve/20 text-ctp-mauve animate-spin'
            ]">
              <i :class="status === 'Online' ? 'pi pi-check-circle' : 'pi pi-power-off'"></i>
            </div>

            <div class="text-center md:text-left flex-1">
              <p class="text-sm text-ctp-subtext uppercase tracking-widest font-semibold mb-1">Сейчас сервер:</p>
              <h2 :class="[
                'text-6xl font-extrabold tracking-tight',
                status==='Online' ? 'text-ctp-green' : status==='Offline' ? 'text-ctp-red' : 'text-ctp-mauve'
              ]">
                {{ status==='Online' ? 'Работает' : status==='Offline' ? 'Выключен' : 'Загрузка...' }}
              </h2>
            </div>
          </div>

          <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mt-8">
            <button
              class="bg-ctp-green hover:bg-ctp-green/90 text-ctp-base font-bold py-4 px-6 rounded-2xl transition-all duration-200 disabled:opacity-30 disabled:cursor-not-allowed flex items-center justify-center gap-3 text-lg shadow-lg hover:shadow-green-900/50"
              :disabled="loading || status==='Online'"
              @click="serverAction('start')"
            >
              <i class="pi pi-play-circle text-2xl"></i>
              Включить
            </button>
            
            <button
              class="bg-ctp-red hover:bg-ctp-maroon text-ctp-base font-bold py-4 px-6 rounded-2xl transition-all duration-200 disabled:opacity-30 disabled:cursor-not-allowed flex items-center justify-center gap-3 text-lg shadow-lg hover:shadow-red-900/50"
              :disabled="loading || status==='Offline'"
              @click="serverAction('stop')"
            >
              <i class="pi pi-stop-circle text-2xl"></i>
              Выключить
            </button>
            
            <button
              class="bg-ctp-mauve hover:bg-ctp-pink text-ctp-base font-bold py-4 px-6 rounded-2xl transition-all duration-200 disabled:opacity-30 disabled:cursor-not-allowed flex items-center justify-center gap-3 text-lg shadow-lg hover:shadow-purple-900/50"
              :disabled="loading || status==='Offline'"
              @click="serverAction('restart')"
            >
              <i class="pi pi-refresh text-2xl"></i>
              Перезагрузить
            </button>
          </div>

          <div v-if="error" class="mt-6 p-4 bg-ctp-red/10 border border-ctp-red text-ctp-red rounded-xl flex items-center gap-3">
            <i class="pi pi-exclamation-triangle"></i>
            {{ error }}
          </div>
        </div>

        <div class="bg-ctp-mantle rounded-3xl p-8 border border-ctp-surface0 shadow-lg">
          <h3 class="text-xl font-semibold mb-6 text-ctp-text flex items-center gap-2 border-b border-ctp-surface0 pb-4">
            <i class="pi pi-info-circle text-ctp-blue"></i>
            Справка о сервере
          </h3>
          
          <div class="space-y-6">
            <div class="flex items-start gap-4 p-4 bg-ctp-crust rounded-xl border border-ctp-surface0">
              <i class="pi pi-map-marker text-2xl text-ctp-blue mt-1"></i>
              <div>
                <p class="text-xs text-ctp-subtext uppercase font-semibold">Адрес для подключения (IP):</p>
                <p class="text-xl font-mono text-ctp-mauve font-bold tracking-tight">{{ serverIp }}</p>
              </div>
            </div>

            <div class="flex items-start gap-4 p-4 bg-ctp-crust rounded-xl border border-ctp-surface0">
              <i class="pi pi-tag text-2xl text-ctp-blue mt-1"></i>
              <div>
                <p class="text-xs text-ctp-subtext uppercase font-semibold">Версия игры:</p>
                <p class="text-xl font-semibold text-ctp-text">{{ version }}</p>
              </div>
            </div>
          </div>
        </div>

      </div> </div>
  </div>
</template>

<style scoped>
/* Добавляем стили для иконок PrimeIcons, если они еще не подключены */
@import 'primeicons/primeicons.css';

/* Фикс для анимации spin */
.animate-spin {
  animation: spin 1s linear infinite;
}
@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}
</style>
