/// <reference types="vite/client" />

declare module '*.vue' {
  import type { DefineComponent } from 'vue'
  const component: DefineComponent<{}, {}, any>
  export default component
}

declare module '@/lib/supabase' {
  import { supabase } from './lib/supabase'
  export { supabase }
}

declare module '@/composables/useSupabase' {
  export { useSupabase } from './composables/useSupabase'
}

declare module '@/pages/HomeView' {
  export { default } from './pages/HomeView.vue'
}

declare module '@/pages/HistoryView' {
  export { default } from './pages/HistoryView.vue'
}