<template>
  <BaseLayout
      v-model:selectedPage="selectedPage"
      v-model:selectedFilter="selectedFilter"
      v-model:searchQuery="searchQuery"
    >
    <section class="page">
      <RegisterModal />

      <template v-if="isAuthenticated">
        <div class="dashboard">
          <main class="content">
            <template v-if="selectedPage === 'Entidades'">
              <h1 class="welcome">Bienvenido, esta es la demo de la página web...  </h1>
            </template>
            <template v-else-if="selectedPage === 'Centros'">
              <h1 class="welcome">Centros</h1>
              <p class="text-slate-600">Aquí verás la lista de centros cuando la funcionalidad esté disponible.</p>
            </template>
            <template v-else-if="selectedPage === 'Todos'">
              <h1 class="welcome">Todos</h1>
              <p class="text-slate-600">Mostrando todos los elementos disponibles.</p>
            </template>
            <template v-else>
              <div class="-mt-5 mb-2">
                <button
                  type="button"
                  class="mb-2 inline-flex h-10 w-10 items-center justify-center rounded-full border border-slate-300 bg-white text-slate-700 transition hover:bg-slate-100 hover:text-slate-900"
                  @click="selectedPage = 'Entidades'"
                  aria-label="Volver"
                >
                  ←
                </button>
                <h1 class="welcome">Guardados</h1>
                <p class="text-slate-600">Aquí verás tus elementos guardados. Usa el selector de arriba para filtrar por Entidades, Centros o Todos.</p>
              </div>

              <div class="mb-6 flex flex-wrap gap-2">
                <button
                  type="button"
                  class="rounded-full px-3 py-2 text-sm font-semibold transition"
                  :class="sortOrder === 'recientes' ? 'bg-slate-800 text-white' : 'bg-slate-200 text-slate-700 hover:bg-slate-300'"
                  @click="sortOrder = 'recientes'"
                >
                  Recientes
                </button>
                <button
                  type="button"
                  class="rounded-full px-3 py-2 text-sm font-semibold transition"
                  :class="sortOrder === 'antiguos' ? 'bg-slate-800 text-white' : 'bg-slate-200 text-slate-700 hover:bg-slate-300'"
                  @click="sortOrder = 'antiguos'"
                >
                  Más antiguos
                </button>
                <button
                  type="button"
                  class="rounded-full px-3 py-2 text-sm font-semibold transition"
                  :class="sortOrder === 'alfabetico' ? 'bg-slate-800 text-white' : 'bg-slate-200 text-slate-700 hover:bg-slate-300'"
                  @click="sortOrder = 'alfabetico'"
                >
                  Alfabético
                </button>
              </div>

              <div class="grid gap-4">
                <div
                  v-for="item in filteredSavedItems"
                  :key="item.id"
                  class="flex flex-col gap-4 rounded-3xl border border-slate-200 bg-white p-6 shadow-sm md:flex-row md:items-start md:justify-between"
                >
                  <div class="space-y-2">
                    <h2 class="text-base font-semibold text-slate-900">{{ item.name }}</h2>
                    <p class="text-sm text-slate-600">{{ item.description }}</p>
                    <div class="grid gap-2 text-sm text-slate-700 sm:grid-cols-2">
                      <div><span class="font-semibold">Web:</span> {{ item.web }}</div>
                      <div><span class="font-semibold">Contacto:</span> {{ item.contact }}</div>
                      <div><span class="font-semibold">Dirección:</span> {{ item.address }}</div>
                    </div>
                  </div>

                  <div class="flex flex-col items-start gap-2 md:items-end">
                    <button
                      type="button"
                      class="rounded-full bg-blue-600 px-4 py-2 text-sm font-semibold text-white transition hover:bg-blue-700"
                      @click="openEditPopup(item)"
                    >
                      Modificar
                    </button>
                    <button
                      type="button"
                      class="rounded-full border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-100"
                      @click="deleteSavedItem(item.id)"
                    >
                      Eliminar
                    </button>
                  </div>
                </div>
              </div>
            </template>
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

          <transition name="fade">
            <div v-if="showEditPopup" class="fixed inset-0 z-40 flex items-center justify-center">
              <div class="absolute inset-0 bg-black/30" @click="closeEditPopup" aria-hidden="true"></div>

              <div class="relative w-11/12 max-w-md rounded-3xl border border-slate-200 bg-white p-6 shadow-2xl md:max-w-lg">
                <div class="flex items-start justify-between pb-4">
                  <div>
                    <h2 class="text-lg font-semibold text-slate-900">Modificar guardado</h2>
                    <p class="text-sm text-slate-500">Actualiza los datos y guarda los cambios.</p>
                  </div>
                  <button
                    type="button"
                    class="rounded-full bg-slate-100 p-2 text-slate-600 hover:bg-slate-200"
                    @click="closeEditPopup"
                    aria-label="Cerrar"
                  >
                    ×
                  </button>
                </div>

                <div class="grid gap-3 max-h-[60vh] overflow-y-auto pr-1">
                  <input
                    v-model="currentSavedItem.name"
                    type="text"
                    class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                    placeholder="Nombre"
                  />
                  <input
                    v-model="currentSavedItem.web"
                    type="text"
                    class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                    placeholder="Web"
                  />
                  <input
                    v-model="currentSavedItem.contact"
                    type="text"
                    class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                    placeholder="Contacto"
                  />
                  <input
                    v-model="currentSavedItem.address"
                    type="text"
                    class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                    placeholder="Dirección"
                  />
                  <textarea
                    v-model="currentSavedItem.description"
                    class="h-24 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                    placeholder="Descripción"
                  ></textarea>
                </div>

                <div class="mt-4 flex justify-end gap-3">
                  <button
                    type="button"
                    class="rounded-full bg-slate-100 px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-200"
                    @click="closeEditPopup"
                  >
                    Cancelar
                  </button>
                  <button
                    type="button"
                    class="rounded-full bg-emerald-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-emerald-600"
                    @click="saveSavedItem"
                  >
                    Guardar cambios
                  </button>
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
import { computed, ref, watch } from 'vue'
import { useUserStore } from '../store/userStore'
import BaseLayout from '../components/layout/BaseLayout.vue'
import RegisterModal from '../components/RegisterModal.vue'

const userStore = useUserStore()
const isAuthenticated = computed(() => userStore.authenticated)
const showPopup = ref(false)
const showEditPopup = ref(false)
const selectedTab = ref<'entidades' | 'centros'>('entidades')
const selectedPage = ref<'Entidades' | 'Centros' | 'Guardados' | 'Todos'>('Entidades')
const selectedFilter = ref<'Entidades' | 'Centros' | 'Todos'>('Entidades')
const searchQuery = ref('')
const sortOrder = ref<'recientes' | 'antiguos' | 'alfabetico'>('recientes')
const currentSavedItem = ref({
  id: '',
  name: '',
  web: '',
  description: '',
  address: '',
  contact: '',
  type: 'Entidades',
  createdAt: Date.now(),
})

const entidadFields = [
  { id: 'entidad-1' },
]

const centroFields = [
  { id: 'centro-1' },
]

const savedItems = ref([
  {
    id: 'saved-1',
    type: 'Entidades',
    name: 'Entidad guardada 1',
    web: 'https://ejemplo1.com',
    description: 'Ejemplo de entidad guardada con datos básicos.',
    address: 'Calle Falsa 123',
    contact: 'contacto@ejemplo1.com',
    createdAt: 1680000000000,
  },
  {
    id: 'saved-2',
    type: 'Centros',
    name: 'Centro guardado 2',
    web: 'https://ejemplo2.com',
    description: 'Otro ejemplo de entrada guardada para mostrar la vista.',
    address: 'Plaza Mayor 5',
    contact: 'info@ejemplo2.com',
    createdAt: 1685000000000,
  },
])

const filteredSavedItems = computed(() => {
  let list = [...savedItems.value]
  const query = searchQuery.value.trim().toLowerCase()

  if (selectedPage.value === 'Guardados' && selectedFilter.value !== 'Todos') {
    list = list.filter((item) => item.type === selectedFilter.value)
  }

  if (query) {
    list = list.filter((item) => {
      return [item.name, item.web, item.description, item.address, item.contact]
        .some((value) => value.toLowerCase().includes(query))
    })
  }

  if (sortOrder.value === 'alfabetico') {
    list.sort((a, b) => a.name.localeCompare(b.name, 'es', { sensitivity: 'base' }))
  } else if (sortOrder.value === 'antiguos') {
    list.sort((a, b) => a.createdAt - b.createdAt)
  } else {
    list.sort((a, b) => b.createdAt - a.createdAt)
  }

  return list
})

const togglePopup = () => {
  showPopup.value = !showPopup.value
  if (showPopup.value) {
    selectedTab.value = 'entidades'
  }
}

watch(selectedFilter, (value) => {
  if (selectedPage.value !== 'Guardados') {
    selectedPage.value = value
  }
})

const openEditPopup = (item: typeof currentSavedItem.value) => {
  currentSavedItem.value = { ...item }
  showEditPopup.value = true
}

const closeEditPopup = () => {
  showEditPopup.value = false
}

const saveSavedItem = () => {
  const index = savedItems.value.findIndex((item) => item.id === currentSavedItem.value.id)
  if (index !== -1) {
    savedItems.value[index] = { ...currentSavedItem.value }
  }
  closeEditPopup()
}

const deleteSavedItem = (id: string) => {
  savedItems.value = savedItems.value.filter((item) => item.id !== id)
}
</script>
