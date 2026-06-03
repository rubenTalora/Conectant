<template>
  <BaseLayout>
    <section class="page">
      <RegisterModal />

      <template v-if="isAuthenticated">
        <div class="dashboard">
          <main class="content">
            <h1 class="welcome">Bienvenido, esta es la demo de la página web...  </h1>
          </main>

          <div class="fixed bottom-6 right-6 z-50 flex items-end gap-4">
            <button
              type="button"
              class="rounded-full bg-blue-600 px-5 py-4 text-white shadow-xl transition hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-300"
              @click="togglePopup"
            >
              <span class="mr-2 text-lg font-bold">+</span>
              Agregar
            </button>
          </div>

          <transition name="fade">
            <div v-if="showPopup" class="fixed inset-0 z-40 flex items-center justify-center">
              <div class="absolute inset-0 bg-black/30" @click="showPopup = false" aria-hidden="true"></div>

              <div class="relative w-11/12 max-w-md rounded-3xl border border-slate-200 bg-white p-6 shadow-2xl md:max-w-lg">
                <div class="flex items-start justify-between pb-4">
                  <div>
                    <h2 class="text-lg font-semibold text-slate-900">Agregar información</h2>
                    <p class="text-sm text-slate-500">Selecciona una opción o usa la vista por defecto.</p>
                  </div>
                  <div class="flex items-center gap-2">
                    <button
                      type="button"
                      class="rounded-full bg-emerald-500 px-3 py-2 text-sm font-semibold text-white transition hover:bg-emerald-600"
                      @click="showPopup = false"
                    >
                      Guardar
                    </button>
                    <button
                      type="button"
                      class="rounded-full bg-slate-100 p-2 text-slate-600 hover:bg-slate-200"
                      @click="showPopup = false"
                      aria-label="Cerrar"
                    >
                      ×
                    </button>
                  </div>
                </div>

                <div class="mb-4 flex gap-2">
                  <button
                    type="button"
                    class="flex-1 rounded-full border px-3 py-2 text-sm font-medium transition"
                    :class="selectedTab === 'entidades' ? 'border-blue-600 bg-blue-600 text-white' : 'border-slate-300 bg-white text-slate-700 hover:border-slate-400'"
                    @click="selectedTab = 'entidades'"
                  >
                    Entidades
                  </button>
                  <button
                    type="button"
                    class="flex-1 rounded-full border px-3 py-2 text-sm font-medium transition"
                    :class="selectedTab === 'centros' ? 'border-blue-600 bg-blue-600 text-white' : 'border-slate-300 bg-white text-slate-700 hover:border-slate-400'"
                    @click="selectedTab = 'centros'"
                  >
                    Centros
                  </button>
                </div>

                <div class="grid gap-3 max-h-[60vh] overflow-y-auto pr-1">
                  <template v-if="selectedTab === 'entidades'">
                    <div
                      v-for="(item, index) in entidadFields"
                      :key="item.id"
                      class="rounded-2xl border border-slate-200 bg-slate-50 p-4"
                    >
                      <h3 class="mb-2 text-sm font-semibold text-slate-800">Entidad {{ index + 1 }}</h3>
                      <input
                        type="text"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Nombre de la entidad"
                      />
                      <input
                        type="text"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Web"
                      />
                      <input
                        type="text"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Descripción breve"
                      />
                      <input
                        type="text"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Dirección"
                      />
                      <input
                        type="text"
                        class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Contacto"
                      />
                    </div>
                  </template>

                  <template v-else>
                    <div
                      v-for="(item, index) in centroFields"
                      :key="item.id"
                      class="rounded-2xl border border-slate-200 bg-slate-50 p-4"
                    >
                      <h3 class="mb-2 text-sm font-semibold text-slate-800">Centro {{ index + 1 }}</h3>
                      <input
                        type="text"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Nombre del centro"
                      />
                      <input
                        type="email"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Email"
                      />
                      <input
                        type="tel"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Teléfono"
                      />
                      <input
                        type="text"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Ciudad o pueblo"
                      />
                      <input
                        type="text"
                        class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Latitud y longitud"
                      />
                    </div>
                  </template>
                </div>
              </div>
            </div>
          </transition>
        </div>
      </template>
    </section>
  </BaseLayout>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue'
import { useUserStore } from '../store/userStore'
import BaseLayout from '../components/layout/BaseLayout.vue'
import RegisterModal from '../components/RegisterModal.vue'

const userStore = useUserStore()
const isAuthenticated = computed(() => userStore.authenticated)
const showPopup = ref(false)
const selectedTab = ref<'entidades' | 'centros'>('entidades')

const entidadFields = [
  { id: 'entidad-1' },
]

const centroFields = [
  { id: 'centro-1' },
]

const togglePopup = () => {
  showPopup.value = !showPopup.value
  if (showPopup.value) {
    selectedTab.value = 'entidades'
  }
}
</script>
