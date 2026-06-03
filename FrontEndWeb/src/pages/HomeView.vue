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
              <h1 class="welcome">Bienvenido, esta es la demo de la página web...</h1>
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
                      class="rounded-full bg-emerald-500 px-3 py-2 text-sm font-semibold text-white transition hover:bg-emerald-600 disabled:opacity-50"
                      :disabled="isSaving"
                      @click="savePopupData"
                    >
                      {{ isSaving ? 'Guardando...' : 'Guardar' }}
                    </button>
                    <button
                      type="button"
                      class="rounded-full bg-slate-100 p-2 text-slate-600 hover:bg-slate-200"
                      @click="showPopup = false"
                      aria-label="Cerrar"
                      :disabled="isSaving"
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
                        v-model="entidadForm.name"
                        type="text"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Nombre de la entidad"
                      />
                      <input
                        v-model="entidadForm.web"
                        type="text"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Web"
                      />
                      <input
                        v-model="entidadForm.description"
                        type="text"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Descripción breve"
                      />
                      <input
                        v-model="entidadForm.address"
                        type="text"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Dirección"
                      />
                      <input
                        v-model="entidadForm.contact"
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
                        v-model="centroForm.name"
                        type="text"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Nombre del centro"
                      />
                      <input
                        v-model="centroForm.email"
                        type="email"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Email"
                      />
                      <input
                        v-model="centroForm.phone"
                        type="tel"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Teléfono"
                      />
                      <input
                        v-model="centroForm.city"
                        type="text"
                        class="mb-2 w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
                        placeholder="Ciudad o pueblo"
                      />
                      <input
                        v-model="centroForm.coordinates"
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
                    class="rounded-full bg-emerald-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-emerald-600 disabled:opacity-50"
                    :disabled="isSaving"
                    @click="saveSavedItem"
                  >
                    {{ isSaving ? 'Guardando...' : 'Guardar cambios' }}
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
import { computed, ref, watch, onMounted } from 'vue'
import { useUserStore } from '../store/userStore'
import { useSupabase } from '../composables/useSupabase'
import BaseLayout from '../components/layout/BaseLayout.vue'
import RegisterModal from '../components/RegisterModal.vue'

const userStore = useUserStore()
const { addItem, getItems, updateItem, deleteItem } = useSupabase()

const isAuthenticated = computed(() => userStore.authenticated)
const showPopup = ref(false)
const showEditPopup = ref(false)
const selectedTab = ref<'entidades' | 'centros'>('entidades')
const selectedPage = ref<'Entidades' | 'Centros' | 'Guardados' | 'Todos'>('Entidades')
const selectedFilter = ref<'Entidades' | 'Centros' | 'Todos'>('Entidades')
const searchQuery = ref('')
const sortOrder = ref<'recientes' | 'antiguos' | 'alfabetico'>('recientes')
const isLoading = ref(false)
const isSaving = ref(false)

// Formulario para entidades
const entidadForm = ref({
  name: '',
  web: '',
  description: '',
  address: '',
  contact: '',
})

// Formulario para centros
const centroForm = ref({
  name: '',
  email: '',
  phone: '',
  city: '',
  coordinates: '',
})

// Item actual siendo editado
const currentSavedItem = ref<any>({
  id: '',
  name: '',
  web: '',
  description: '',
  address: '',
  contact: '',
})

// Items guardados desde la BD
const savedItems = ref<any[]>([])

// Campos dinámicos en el formulario
const entidadFields = ref([{ id: 'entidad-1' }])
const centroFields = ref([{ id: 'centro-1' }])

// Cargar items al autenticarse
onMounted(async () => {
  if (isAuthenticated.value) {
    await loadItems()
  }
})

watch(isAuthenticated, async (newVal) => {
  if (newVal) {
    await loadItems()
  }
})

const loadItems = async () => {
  isLoading.value = true
  try {
    const { data, error } = await getItems()
    if (error) {
      console.error('Error loading items:', error)
      return
    }
    savedItems.value = data || []
  } catch (error) {
    console.error('Error:', error)
  } finally {
    isLoading.value = false
  }
}

const filteredSavedItems = computed(() => {
  let list = [...savedItems.value]
  const query = searchQuery.value.trim().toLowerCase()

  if (selectedPage.value === 'Guardados' && selectedFilter.value !== 'Todos') {
    const filterType = selectedFilter.value === 'Entidades' ? 'entidad' : 'centro'
    list = list.filter((item) => item.type === filterType)
  }

  if (query) {
    list = list.filter((item) => {
      return [item.name, item.web, item.description, item.address, item.contact]
        .some((value) => value && value.toLowerCase().includes(query))
    })
  }

  if (sortOrder.value === 'alfabetico') {
    list.sort((a, b) => a.name.localeCompare(b.name, 'es', { sensitivity: 'base' }))
  } else if (sortOrder.value === 'antiguos') {
    list.sort((a, b) => new Date(a.created_at).getTime() - new Date(b.created_at).getTime())
  } else {
    list.sort((a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime())
  }

  return list
})

const togglePopup = () => {
  showPopup.value = !showPopup.value
  if (showPopup.value) {
    selectedTab.value = 'entidades'
    resetForms()
  }
}

const resetForms = () => {
  entidadForm.value = { name: '', web: '', description: '', address: '', contact: '' }
  centroForm.value = { name: '', email: '', phone: '', city: '', coordinates: '' }
}

watch(selectedFilter, (value) => {
  if (selectedPage.value !== 'Guardados') {
    selectedPage.value = value
  }
})

const savePopupData = async () => {
  if (selectedTab.value === 'entidades') {
    if (!entidadForm.value.name.trim()) {
      alert('Por favor rellena el nombre de la entidad')
      return
    }
    isSaving.value = true
    try {
      await addItem({
        name: entidadForm.value.name,
        web: entidadForm.value.web,
        description: entidadForm.value.description,
        address: entidadForm.value.address,
        contact: entidadForm.value.contact,
        type: 'entidad',
      })
      await loadItems()
      showPopup.value = false
      resetForms()
    } catch (error) {
      console.error('Error saving entidad:', error)
      alert('Error al guardar la entidad')
    } finally {
      isSaving.value = false
    }
  } else {
    if (!centroForm.value.name.trim()) {
      alert('Por favor rellena el nombre del centro')
      return
    }
    isSaving.value = true
    try {
      await addItem({
        name: centroForm.value.name,
        contact: centroForm.value.email,
        web: centroForm.value.phone,
        address: centroForm.value.city,
        description: centroForm.value.coordinates,
        type: 'centro',
      })
      await loadItems()
      showPopup.value = false
      resetForms()
    } catch (error) {
      console.error('Error saving centro:', error)
      alert('Error al guardar el centro')
    } finally {
      isSaving.value = false
    }
  }
}

const openEditPopup = (item: any) => {
  currentSavedItem.value = { ...item }
  showEditPopup.value = true
}

const closeEditPopup = () => {
  showEditPopup.value = false
}

const saveSavedItem = async () => {
  if (!currentSavedItem.value.name.trim()) {
    alert('Por favor rellena el nombre')
    return
  }
  isSaving.value = true
  try {
    await updateItem(currentSavedItem.value.id, currentSavedItem.value)
    await loadItems()
    closeEditPopup()
  } catch (error) {
    console.error('Error updating item:', error)
    alert('Error al guardar los cambios')
  } finally {
    isSaving.value = false
  }
}

const deleteSavedItem = async (id: string) => {
  if (!confirm('¿Estás seguro de que quieres eliminar este elemento?')) {
    return
  }
  try {
    await deleteItem(id)
    await loadItems()
  } catch (error) {
    console.error('Error deleting item:', error)
    alert('Error al eliminar el elemento')
  }
}
</script>
