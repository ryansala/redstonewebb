<template>
  <div class="lg:ml-64 min-h-screen pt-20 lg:pt-0 p-8 bg-gradient-to-br from-ctp-base to-ctp-mantle text-ctp-text transition-all duration-300">    
    <div class="max-w-4xl mx-auto">
      <h1 class="text-3xl font-bold mb-8 flex items-center gap-3 text-ctp-mauve">
        <i class="pi pi-sliders-h"></i>
        Настройки сервера
      </h1>

      <div class="bg-ctp-crust rounded-3xl p-8 border border-ctp-surface0 shadow-2xl">
        <h2 class="text-xl font-semibold mb-8 text-center text-ctp-subtext uppercase tracking-widest">
          Основные свойства (server.properties)
        </h2>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-10">
          
          <div class="space-y-2 p-4 bg-ctp-mantle rounded-2xl border border-ctp-surface0 hover:border-ctp-mauve/50 transition-colors">
            <label class="text-sm font-bold text-ctp-mauve flex items-center gap-2">
              <i class="pi pi-shield"></i> Сложность
            </label>
            <select class="w-full bg-ctp-base text-ctp-text rounded-xl p-3 border border-ctp-surface1 focus:ring-2 focus:ring-ctp-mauve outline-none appearance-none">
              <option value="easy">Easy (Легко)</option>
              <option value="normal">Normal (Нормально)</option>
              <option value="hard">Hard (Сложно)</option>
            </select>
          </div>

          <div class="space-y-2 p-4 bg-ctp-mantle rounded-2xl border border-ctp-surface0 hover:border-ctp-mauve/50 transition-colors">
            <label class="text-sm font-bold text-ctp-mauve flex items-center gap-2">
              <i class="pi pi-map"></i> Режим игры
            </label>
            <select class="w-full bg-ctp-base text-ctp-text rounded-xl p-3 border border-ctp-surface1 focus:ring-2 focus:ring-ctp-mauve outline-none">
              <option value="survival">Survival (Выживание)</option>
              <option value="creative">Creative (Творчество)</option>
            </select>
          </div>

          <div class="space-y-2 p-4 bg-ctp-mantle rounded-2xl border border-ctp-surface0 hover:border-ctp-mauve/50 transition-colors">
            <label class="text-sm font-bold text-ctp-mauve flex items-center gap-2">
              <i class="pi pi-pencil"></i> Имя мира
            </label>
            <input type="text" value="world" class="w-full bg-ctp-base text-ctp-text rounded-xl p-3 border border-ctp-surface1 focus:ring-2 focus:ring-ctp-mauve outline-none" />
          </div>

          <div class="space-y-2 p-4 bg-ctp-mantle rounded-2xl border border-ctp-surface0 hover:border-ctp-mauve/50 transition-colors">
            <label class="text-sm font-bold text-ctp-mauve flex items-center gap-2">
              <i class="pi pi-users"></i> Игроков (макс)
            </label>
            <input type="number" value="20" class="w-full bg-ctp-base text-ctp-text rounded-xl p-3 border border-ctp-surface1 focus:ring-2 focus:ring-ctp-mauve outline-none" />
          </div>

          <div class="space-y-2 p-4 bg-ctp-mantle rounded-2xl border border-ctp-surface0 hover:border-ctp-mauve/50 transition-colors">
            <label class="text-sm font-bold text-ctp-mauve flex items-center gap-2">
              <i class="pi pi-bolt"></i> PVP режим
            </label>
            <select class="w-full bg-ctp-base text-ctp-text rounded-xl p-3 border border-ctp-surface1 focus:ring-2 focus:ring-ctp-mauve outline-none">
              <option value="true">Включено</option>
              <option value="false">Выключено</option>
            </select>
          </div>

          <div class="space-y-2 p-4 bg-ctp-mantle rounded-2xl border border-ctp-surface0 hover:border-ctp-mauve/50 transition-colors">
            <label class="text-sm font-bold text-ctp-mauve flex items-center gap-2">
              <i class="pi pi-directions"></i> Порт сервера
            </label>
            <input type="text" value="25565" class="w-full bg-ctp-base text-ctp-text rounded-xl p-3 border border-ctp-surface1 focus:ring-2 focus:ring-ctp-mauve outline-none" />
          </div>

        </div>

        <div class="flex justify-end gap-4 border-t border-ctp-surface0 pt-8">
          <button class="bg-ctp-surface1 hover:bg-ctp-surface2 text-ctp-text font-bold py-3 px-8 rounded-2xl transition-all flex items-center gap-2">
            <i class="pi pi-refresh"></i> Сбросить
          </button>
          <button class="bg-ctp-green hover:bg-ctp-green/90 text-ctp-base font-bold py-3 px-8 rounded-2xl transition-all shadow-lg hover:shadow-green-900/40 flex items-center gap-2">
            <i class="pi pi-save"></i> Сохранить
          </button>
        </div>

      </div>
    </div>
  </div>
</template>
