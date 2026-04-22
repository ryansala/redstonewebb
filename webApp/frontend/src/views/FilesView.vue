<script setup>
import { ref } from 'vue'

const currentPath = ref('/home/container')

// Имитация списка файлов (ваша база данных на клиенте)
const files = ref([
  { name: 'world', type: 'directory', size: '--', date: '20.10.2023' },
  { name: 'plugins', type: 'directory', size: '--', date: '18.10.2023' },
  { name: 'server.properties', type: 'file', size: '1.2 KB', date: '22.10.2023' },
  { name: 'spigot.yml', type: 'file', size: '4.5 KB', date: '21.10.2023' },
  { name: 'logs', type: 'directory', size: '--', date: 'Сегодня' },
  { name: 'whitelist.json', type: 'file', size: '120 B', date: 'Вчера' },
])

// Метод для создания нового файла
const createNewFile = () => {
  const fileName = 'newFile'
  const exists = files.value.some(f => f.name === fileName)
  
  if (!exists) {
    files.value.unshift({
      name: fileName,
      type: 'file',
      size: '0 B',
      date: 'Только что'
    })
  } else {
    alert('Файл с именем newFile уже существует!')
  }
}

// Метод для удаления файла
const deleteFile = (fileName) => {
  if (confirm(`Вы уверены, что хотите удалить ${fileName}?`)) {
    files.value = files.value.filter(f => f.name !== fileName)
  }
}
</script>

<template>
  <div class="lg:ml-64 min-h-screen pt-20 lg:pt-0 p-4 lg:p-8 bg-gradient-to-br from-ctp-base to-ctp-mantle text-ctp-text transition-all duration-300">
    
    <div class="max-w-6xl mx-auto">
      <div class="mb-8">
        <h1 class="text-2xl lg:text-3xl font-bold mb-4 flex items-center gap-3 text-ctp-mauve">
          <i class="pi pi-folder-open"></i>
          Менеджер файлов
        </h1>
        
        <div class="flex items-center gap-2 bg-ctp-crust p-3 rounded-xl border border-ctp-surface0 text-xs lg:text-sm font-mono overflow-x-auto">
          <i class="pi pi-home text-ctp-blue"></i>
          <span class="text-ctp-subtext whitespace-nowrap">{{ currentPath }}</span>
        </div>
      </div>

      <div class="bg-ctp-crust rounded-3xl overflow-hidden border border-ctp-surface0 shadow-2xl">
        <div class="p-4 bg-ctp-mantle border-b border-ctp-surface0 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
          <div class="flex gap-2 w-full sm:w-auto">
            <button 
              @click="createNewFile"
              class="flex-1 sm:flex-none bg-ctp-blue/10 hover:bg-ctp-blue/20 text-ctp-blue px-4 py-2 rounded-lg transition-all active:scale-95 flex items-center justify-center gap-2"
            >
              <i class="pi pi-plus"></i> 
              <span>Создать</span>
            </button>
            
            <button class="flex-1 sm:flex-none bg-ctp-surface1 hover:bg-ctp-surface2 text-ctp-text px-4 py-2 rounded-lg transition flex items-center justify-center gap-2">
              <i class="pi pi-upload"></i> 
              <span>Загрузить</span>
            </button>
          </div>
          <span class="text-[10px] lg:text-xs text-ctp-overlay0 uppercase font-bold tracking-widest">
            Элементов: {{ files.length }}
          </span>
        </div>

        <div class="overflow-x-auto">
          <table class="w-full text-left border-collapse min-w-[600px]">
            <thead class="bg-ctp-mantle/50 text-ctp-subtext0 text-sm uppercase">
              <tr>
                <th class="p-4 font-semibold">Имя</th>
                <th class="p-4 font-semibold text-center">Размер</th>
                <th class="p-4 font-semibold text-right">Действия</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-ctp-surface0">
              <tr v-for="file in files" :key="file.name" class="hover:bg-ctp-surface0/30 transition-colors group">
                <td class="p-4 flex items-center gap-3">
                  <i :class="[
                    'text-xl lg:text-2xl',
                    file.type === 'directory' ? 'pi pi-folder text-ctp-yellow' : 'pi pi-file text-ctp-blue'
                  ]"></i>
                  <span class="font-medium group-hover:text-ctp-mauve transition-colors cursor-pointer truncate max-w-[200px] lg:max-w-none">
                    {{ file.name }}
                  </span>
                </td>
                <td class="p-4 text-center text-ctp-subtext0 font-mono text-xs lg:text-sm">
                  {{ file.size }}
                </td>
                <td class="p-4 text-right">
                  <div class="flex justify-end gap-2 lg:opacity-0 lg:group-hover:opacity-100 transition-opacity">
                    <button class="p-2 hover:bg-ctp-surface1 rounded-lg text-ctp-subtext transition-colors">
                      <i class="pi pi-pencil"></i>
                    </button>
                    <button 
                      @click="deleteFile(file.name)"
                      class="p-2 hover:bg-ctp-red/20 rounded-lg text-ctp-red transition-all active:scale-90"
                    >
                      <i class="pi pi-trash"></i>
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <div v-if="files.length === 0" class="py-20 text-center">
          <i class="pi pi-inbox text-6xl text-ctp-surface1 mb-4"></i>
          <p class="text-ctp-subtext">Папка пуста</p>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* Плавный скроллбар для таблицы */
.overflow-x-auto {
  scrollbar-width: thin;
  scrollbar-color: #585b70 transparent;
}

/* Фикс для того, чтобы на мобилках действия были всегда видны, а на десктопе — при наведении */
@media (max-width: 1024px) {
  .lg:opacity-0 {
    opacity: 1 !important;
  }
}
</style>
