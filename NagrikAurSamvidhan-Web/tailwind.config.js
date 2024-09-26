/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        mustard: 'E09F3E',
        vanilla: 'FFF3B0'
      },
      keyframes: {
        fadeSlideUp: {
          '0%': { opacity: 0, transform: 'translateY(20px)' },
          '100%': { opacity: 1, transform: 'translateY(0)' },
        },
      },
      animation: {
        fadeSlideUp: 'fadeSlideUp 0.8s ease-out',
      },
    },
  },
  plugins: [],
}

