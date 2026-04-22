<script setup>
import { ref, onMounted, nextTick } from 'vue'
import axios from 'axios'

const logs = ref('')
const error = ref('')

const command = ref('')
const rconResponse = ref('')
const rconError = ref('')

const logsContainer = ref(null)

function scrollToBottom() {
  nextTick(() => {
    if (logsContainer.value) {
      logsContainer.value.scrollTop = logsContainer.value.scrollHeight
    }
  })
}

onMounted(() => {
  // Имитируем загрузку логов с цветами Catppuccin
  logs.value = "[INFO] Starting Minecraft server version 1.20.1\n" +
               "[INFO] Loading properties...\n" +
               "[INFO] Default game type: SURVIVAL\n" +
               "[INFO] Generating keypair\n" +
               "[INFO] Starting Minecraft server on *:25565\n" +
               "[INFO] Preparing level \"world\"\n" +
               "[INFO] Done (2.451s)! For help, type \"help\"";
  
  error.value = ''; 
  scrollToBottom();
  
  setTimeout(() => {
    logs.value += "\n[INFO] Player Gemini joined the game";
    scrollToBottom();
  }, 3000);
})

async function sendRconCommand() {
  rconError.value = ''
  rconResponse.value = ''
  if (!command.value.trim()) return
  try {
    const res = await axios.post('/api/v1/console/rcon', { command: command.value })
    rconResponse.value = res.data.response
    command.value = ''
    scrollToBottom()
  } catch (e) {
    rconError.value = e.response?.data?.error || e.message
  }
}
</script>

<template>
  <div class="min-h-screen bg-ctp-base transition-all duration-300">
    <div class="lg:ml-64 pt-20 lg:pt-0 min-h-screen bg-ctp-mantle shadow-2xl flex flex-col">
      
      <h2 class="text-2xl font-bold mb-4 text-ctp-text flex items-center gap-3 px-8 pt-8">
        <span class="pi pi-terminal text-ctp-mauve"></span>
        Игровая консоль
      </h2>

      <div
        class="bg-ctp-crust text-ctp-text font-mono rounded-t-3xl mx-4 lg:mx-8 mb-8 p-6 shadow-inner border border-ctp-surface0 flex-1 flex flex-col"
        style="height: calc(100vh - 14rem); overflow: hidden;"
      >
        <template v-if="!error">
          <div class="flex flex-col h-full">
            <div ref="logsContainer" class="flex-1 overflow-y-auto console-scrollbar mb-4">
              <pre class="whitespace-pre-wrap break-words m-0 text-ctp-subtext leading-relaxed">
                <span class="text-ctp-blue">{{ logs.trim() ? logs : 'Ожидание вывода...' }}</span>
              </pre>
            </div>

            <form @submit.prevent="sendRconCommand" class="flex items-center gap-3 p-3 bg-ctp-base rounded-xl border border-ctp-surface0 focus-within:border-ctp-mauve transition-all">
              <span class="text-ctp-mauve font-bold select-none">λ</span>
              <input v-model="command" type="text" class="flex-1 bg-transparent border-0 focus:outline-none text-ctp-text font-mono" placeholder="Введите команду..." />
              <button type="submit" class="text-ctp-mauve"><i class="pi pi-send"></i></button>
            </form>
          </div>
        </template>
      </div>
    </div>
  </div>
</template>
<style scoped>
/* Кастомный скроллбар в стиле Catppuccin */
.console-scrollbar {
  scrollbar-width: thin;
  scrollbar-color: #585b70 transparent; /* ctp-surface2 */
}
.console-scrollbar::-webkit-scrollbar {
  width: 6px;
}
.console-scrollbar::-webkit-scrollbar-thumb {
  background: #585b70;
  border-radius: 10px;
}
.console-scrollbar::-webkit-scrollbar-track {
  background: transparent;
}

/* Эффект свечения для текста */
pre {
  text-shadow: 0 0 5px rgba(205, 214, 244, 0.05);
}
</style>
