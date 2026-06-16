<template>
  <div v-if="!isAuthenticated" class="modal-ov">
    <div class="modal-bg"></div>

    <div class="modal-wrap">
      <div class="modal-box">
        <div>
          <!-- Título -->
          <h2 class="modal-title">
            Login
          </h2>

          <form @submit.prevent="handleRegister" class="modal-form" novalidate autocomplete="off">

            <div>
              <input
                v-model="username"
                type="text"
                placeholder="Nombre de usuario"
                class="modal-in"
                :class="{ error: showError || hasEverFailed }"
              />
            </div>

            <div>
              <input
                v-model="password"
                type="password"
                placeholder="Contraseña"
                class="modal-in"
                :class="{ error: showError || hasEverFailed }"
              />
            </div>

            <p v-if="showError" class="modal-error">
              El usuario o la contraseña son incorrectas
            </p>

            <button
              type="submit"
              class="modal-btn"
              :disabled="isLoading"
            >
              {{ isLoading ? 'Autenticando...' : 'Confirmar' }}
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useUserStore } from '../store/userStore'
import { useSupabase } from '../composables/useSupabase'

const userStore = useUserStore()
const { login: supabaseLogin, getCurrentUser } = useSupabase()

const username = ref('')
const password = ref('')
const submitted = ref(false)
const hasEverFailed = ref(false)
const isLoading = ref(false)

const isAuthenticated = computed(() => userStore.authenticated)

const showError = computed(() => {
  if (!submitted.value) return false
  return hasEverFailed.value
})

// Mira si ya está logueado
onMounted(async () => {
  const { user } = await getCurrentUser()
  if (user) {
    userStore.login(user.email || 'Usuario')
  }
})

const handleRegister = async () => {
  submitted.value = true
  isLoading.value = true

  try {
    const { data, error } = await supabaseLogin(username.value, password.value)
    if (error) {
      hasEverFailed.value = true
      isLoading.value = false
      return
    }

    if (data?.user) {
      userStore.login(data.user.email || 'Usuario')
    }
  } catch (error) {
    hasEverFailed.value = true
  }

  isLoading.value = false
}
</script>

<style src="./RegisterModal.css"></style>
