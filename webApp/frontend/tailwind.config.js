/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        // Добавляем палитру Catppuccin
        ctp: {
          base: '#1e1e2e',     // Основной фон
          mantle: '#181825',   // Фон навигации
          surface0: '#313244', // Цвет активных кнопок
          mauve: '#cba6f7',    // Акцентный фиолетовый
          green: '#a6e3a1',    // Акцентный зеленый
          red:  '#d20f39',     // красный
          text: '#cdd6f4',     // Основной текст
          subtext: '#a6adc8',  // Второстепенный текст
        },
      },
      fontFamily: {
        sans: ['Poppins', 'sans-serif'],
      },
      gridTemplateColumns: {
        '70/30': '70% 28%',
      },
    },
  },
  plugins: [],
};
