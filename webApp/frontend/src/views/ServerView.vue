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
    error.value = 'Error: ' + (e.response?.data?.error || e.message)
  }
  loading.value = false
}

onMounted(() => {
  fetchStatus()
  fetchVersion()
})
</script>

<template>
  <div style="margin-left: 14rem;" class="min-h-screen bg-ctp-base flex items-center justify-center">
    <div class="max-w-xl mx-auto p-8 bg-ctp-mantle rounded-xl border border-ctp-surface0 shadow-lg">

      <h2 class="text-2xl font-bold mb-6 text-ctp-text flex items-center gap-2">
        Статус сервера:
        <span :class="status==='Online' ? 'text-ctp-green' : status==='Offline' ? 'text-ctp-red' : 'text-ctp-mauve'">
          {{ status }}
        </span>
      </h2>

      <div class="flex flex-wrap gap-4 mb-6">
        <button
          class="bg-ctp-green hover:opacity-80 text-ctp-base font-semibold py-2 px-6 rounded-lg transition disabled:opacity-30 flex items-center gap-2"
          :disabled="loading || status==='Online'"
          @click="serverAction('start')"
        >
          <span class="pi pi-caret-right"></span>
          Запустить
        </button>

        <button
          class="bg-ctp-red hover:bg-ctp-maroon text-ctp-base font-semibold py-2 px-6 rounded-lg transition-all duration-200 disabled:opacity-30 disabled:cursor-not-allowed flex items-center gap-2 shadow-sm"
          :disabled="loading || status==='Offline'"
          @click="serverAction('stop')"
        >
          <span class="pi pi-power-off"></span>
          Остановить
        </button>

        <button
          class="bg-ctp-mauve hover:opacity-80 text-ctp-base font-semibold py-2 px-6 rounded-lg transition disabled:opacity-30 flex items-center gap-2"
          :disabled="loading || status==='Offline'"
          @click="serverAction('restart')"
        >
          <span class="pi pi-refresh"></span>
          Перезагрузить
        </button>
      </div>

      <div v-if="error" class="text-ctp-red mb-4">{{ error }}</div>

      <div class="mt-6 text-ctp-text space-y-2 border-t border-ctp-surface0 pt-4">
        <div>
          <span class="font-semibold text-ctp-subtext">IP Сервера: </span>
          <span class="text-lg font-mono">{{ serverIp }}</span>
        </div>
        <div>
          <span class="font-semibold text-ctp-subtext">Версия: </span>
          <span class="text-lg">{{ version }}</span>
        </div>
      </div>
    </div>
  </div>
</template>
