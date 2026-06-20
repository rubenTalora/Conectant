<template>
  <transition name="fade">
    <div v-if="visible" class="fixed inset-0 z-[9999] flex items-center justify-center">
      <div class="absolute inset-0 bg-black/40" @click="$emit('close')" aria-hidden="true"></div>

      <div class="relative w-11/12 max-w-3xl rounded-3xl border border-slate-200 bg-white p-6 shadow-2xl">
        <div class="flex items-start justify-between pb-4">
          <div>
            <h2 class="text-lg font-semibold text-slate-900">Seleccionar ubicación</h2>
            <p class="text-sm text-slate-500">Haz clic en el mapa para marcar la posición.</p>
          </div>
          <button
            type="button"
            class="rounded-full bg-slate-100 p-2 text-slate-600 hover:bg-slate-200"
            @click="$emit('close')"
            aria-label="Cerrar"
          >
            ×
          </button>
        </div>

        <div ref="mapContainer" class="h-96 w-full rounded-xl border border-slate-300"></div>

        <div class="mt-4 flex items-center justify-between">
          <div v-if="selectedLat !== null && selectedLng !== null" class="text-sm text-slate-700">
            <span class="font-semibold">Latitud:</span> {{ selectedLat.toFixed(6) }} &nbsp;
            <span class="font-semibold">Longitud:</span> {{ selectedLng.toFixed(6) }}
          </div>
          <div v-else class="text-sm text-slate-400">Ninguna coordenada seleccionada</div>

          <div class="flex gap-2">
            <button
              type="button"
              class="rounded-full bg-slate-100 px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-200"
              @click="$emit('close')"
            >
              Cancelar
            </button>
            <button
              type="button"
              class="rounded-full bg-blue-600 px-4 py-2 text-sm font-semibold text-white transition hover:bg-blue-700 disabled:opacity-50"
              :disabled="selectedLat === null || selectedLng === null"
              @click="confirmSelection"
            >
              Confirmar
            </button>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script setup lang="ts">
import { ref, watch, onMounted, onUnmounted, nextTick } from 'vue'
import L from 'leaflet'
import 'leaflet/dist/leaflet.css'

const props = defineProps<{
  visible: boolean
}>()

const emit = defineEmits<{
  (e: 'close'): void
  (e: 'select', coords: { lat: number; lng: number }): void
}>()

const mapContainer = ref<HTMLDivElement | null>(null)
const selectedLat = ref<number | null>(null)
const selectedLng = ref<number | null>(null)

let map: L.Map | null = null
let marker: L.Marker | null = null

// Centro aproximado de La Ribera
const centerLat = 39.15
const centerLng = -0.5

function initMap() {
  if (!mapContainer.value || map) return

  // Fix para iconos de Leaflet con bundlers
  delete (L.Icon.Default.prototype as any)._getIconUrl
  L.Icon.Default.mergeOptions({
    iconRetinaUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon-2x.png',
    iconUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png',
    shadowUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png',
  })

  map = L.map(mapContainer.value, {
    center: [centerLat, centerLng],
    zoom: 10,
    zoomControl: true,
  })

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
    maxZoom: 18,
  }).addTo(map)

  map.on('click', (e: L.LeafletMouseEvent) => {
    const { lat, lng } = e.latlng
    selectedLat.value = lat
    selectedLng.value = lng

    if (marker) {
      marker.setLatLng([lat, lng])
    } else {
      marker = L.marker([lat, lng], { draggable: true }).addTo(map!)
      marker.on('dragend', () => {
        const pos = marker!.getLatLng()
        selectedLat.value = pos.lat
        selectedLng.value = pos.lng
      })
    }
  })
}

function destroyMap() {
  if (map) {
    map.remove()
    map = null
    marker = null
  }
}

watch(
  () => props.visible,
  async (isVisible) => {
    if (isVisible) {
      selectedLat.value = null
      selectedLng.value = null
      await nextTick()
      initMap()
      // Forzar redimensionamiento tras abrirse
      setTimeout(() => map?.invalidateSize(), 100)
    } else {
      destroyMap()
    }
  }
)

onUnmounted(() => {
  destroyMap()
})

function confirmSelection() {
  if (selectedLat.value !== null && selectedLng.value !== null) {
    emit('select', { lat: selectedLat.value, lng: selectedLng.value })
    emit('close')
  }
}
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>