<template>
  <div class="app">
    <header class="bar">
      <div class="bar-inner">
        <template v-if="isAuthenticated">
          <div class="bar-left flex flex-wrap items-center gap-3">
            <label class="sr-only" for="search-header">Buscar</label>
            <input
              id="search-header"
              v-model="searchQuery"
              type="text"
              placeholder="Buscar..."
              class="search-in"
            />
            <select v-model="selectedFilter" class="page-sel">
              <option value="Entidades">Entidades</option>
              <option value="Centros">Centros</option>
              <option value="Todos">Todos</option>
            </select>
            <button
              type="button"
              class="saved-btn"
              :class="selectedPage === 'Guardados'
                ? 'bg-slate-800 text-white hover:bg-slate-900'
                : 'bg-slate-200 text-slate-700 hover:bg-slate-300'"
              @click="selectedPage = 'Guardados'"
            >
              Guardados
            </button>
          </div>

          <div class="bar-right relative">
            <button type="button" class="user-btn" @click="toggleUserMenu" aria-label="Usuario">
              <span class="user-icon">👤</span>
            </button>
            <div v-if="userMenuOpen" class="user-box">
              <p class="user-info">Usuario: {{ username }}</p>
              <button type="button" class="history-btn" @click="openHistory">Historial</button>
              <button type="button" class="logout-btn" @click="handleLogout">Cerrar Sesión</button>
            </div>
          </div>
        </template>
        <template v-else>
          <span class="text-lg font-semibold">Conectant</span>
        </template>
      </div>
    </header>
    <main class="mx-auto max-w-6xl px-6 py-10">
      <slot />
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, PropType } from 'vue'
import { useUserStore } from '../../store/userStore'

const props = defineProps({
  selectedPage: {
    type: String as PropType<'Entidades' | 'Centros' | 'Guardados' | 'Todos'>,
    default: 'Entidades',
  },
  selectedFilter: {
    type: String as PropType<'Entidades' | 'Centros' | 'Todos'>,
    default: 'Entidades',
  },
  searchQuery: {
    type: String,
    default: '',
  },
})
const emit = defineEmits<{
  (e: 'update:selectedPage', value: 'Entidades' | 'Centros' | 'Guardados' | 'Todos'): void
  (e: 'update:selectedFilter', value: 'Entidades' | 'Centros' | 'Todos'): void
  (e: 'update:searchQuery', value: string): void
}>()

const userStore = useUserStore()
const isAuthenticated = computed(() => userStore.authenticated)
const username = computed(() => userStore.name)
const searchQuery = computed({
  get: () => props.searchQuery,
  set: (value: string) => emit('update:searchQuery', value),
})
const selectedFilter = computed<
  'Entidades' | 'Centros' | 'Todos'
>({
  get: () => props.selectedFilter,
  set: (value) => emit('update:selectedFilter', value),
})
const selectedPage = computed<
  'Entidades' | 'Centros' | 'Guardados' | 'Todos'
>({
  get: () => props.selectedPage,
  set: (value) => emit('update:selectedPage', value),
})
const userMenuOpen = ref(false)

const handleLogout = () => {
  userStore.logout()
  userMenuOpen.value = false
}

const openHistory = () => {
  window.open('/historial', '_blank')
  userMenuOpen.value = false
}

const toggleUserMenu = () => {
  userMenuOpen.value = !userMenuOpen.value
}
</script>

<style src="./BaseLayout.css"></style>
