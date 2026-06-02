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
            <select v-model="selectedPage" class="page-sel">
              <option value="Entidades">Entidades</option>
              <option value="Centros">Centros</option>
            </select>
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
import { ref, computed } from 'vue'
import { useUserStore } from '../../store/userStore'

const userStore = useUserStore()
const isAuthenticated = computed(() => userStore.authenticated)
const username = computed(() => userStore.name)
const searchQuery = ref('')
const selectedPage = ref('Entidades')
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
