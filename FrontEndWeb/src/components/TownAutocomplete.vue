<template>
  <div class="relative">
    <input
      :value="modelValue"
      @input="onInput"
      @focus="onFocus"
      @blur="onBlur"
      type="text"
      class="w-full rounded-xl border border-slate-300 bg-white px-3 py-2 text-sm text-slate-800 focus:border-blue-500 focus:outline-none"
      :placeholder="placeholder"
    />

    <ul
      v-if="isOpen && filteredTowns.length > 0"
      class="absolute z-50 mt-1 max-h-48 w-full overflow-y-auto rounded-xl border border-slate-200 bg-white shadow-lg"
    >
      <li
        v-for="(town, index) in filteredTowns"
        :key="index"
        class="cursor-pointer px-3 py-2 text-sm text-slate-700 transition hover:bg-blue-50 hover:text-blue-700"
        @mousedown.prevent="selectTown(town)"
      >
        {{ town }}
      </li>
    </ul>

    <p
      v-if="isOpen && localQuery && filteredTowns.length === 0"
      class="absolute z-50 mt-1 w-full rounded-xl border border-slate-200 bg-white px-3 py-2 text-sm text-slate-400 shadow-lg"
    >
      No se encontraron pueblos
    </p>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue'
import { filterTowns } from '../data/riberaTowns'

const props = defineProps<{
  modelValue: string
  placeholder?: string
}>()

const emit = defineEmits<{
  (e: 'update:modelValue', value: string): void
}>()

const isOpen = ref(false)
const localQuery = ref(props.modelValue ?? '')

// Sincronizar localQuery cuando el padre resetea modelValue (ej. al resetear formulario)
watch(() => props.modelValue, (newVal) => {
  if (newVal !== localQuery.value) {
    localQuery.value = newVal ?? ''
  }
})

const filteredTowns = computed(() => {
  return filterTowns(localQuery.value)
})

function onInput(event: Event) {
  const target = event.target as HTMLInputElement
  localQuery.value = target.value
  emit('update:modelValue', target.value)
  isOpen.value = true
}

function onFocus() {
  isOpen.value = true
}

function selectTown(town: string) {
  localQuery.value = town
  emit('update:modelValue', town)
  isOpen.value = false
}

function onBlur() {
  // Retrasamos para permitir que el mousedown del li se ejecute antes
  setTimeout(() => {
    isOpen.value = false
  }, 150)
}
</script>