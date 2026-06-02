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
            >
              Confirmar
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useUserStore } from '../store/userStore'

const userStore = useUserStore()

const username = ref('')
const password = ref('')
const submitted = ref(false)
const hasEverFailed = ref(false)

const correctUsername = 'Admin'
const correctPassword = 'admin123'

const isAuthenticated = computed(() => userStore.authenticated)

const showError = computed(() => {
  if (!submitted.value) return false
  return username.value !== correctUsername || password.value !== correctPassword || hasEverFailed.value
})

const isUsernameInvalid = computed(() => submitted.value && username.value !== correctUsername)
const isPasswordInvalid = computed(() => submitted.value && password.value !== correctPassword)

const handleRegister = () => {
  submitted.value = true
  if (username.value !== correctUsername || password.value !== correctPassword) {
    hasEverFailed.value = true
  }

  if (username.value === correctUsername && password.value === correctPassword) {
    userStore.login(username.value)
  }
}
</script>

<style src="./RegisterModal.css"></style>
