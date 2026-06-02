<template>
  <BaseLayout>
    <section class="page">
      <div class="max-w-4xl rounded-3xl border border-slate-200 bg-white p-6 shadow-xl">
        <h1 class="mb-4 text-2xl font-semibold text-slate-900">Historial de cambios</h1>
        <p class="mb-6 text-sm text-slate-600">Aquí puedes ver el historial de cambios recientes relacionados con tus entidades y centros.</p>

        <div class="space-y-4">
          <article class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
            <p class="text-sm text-slate-600">2026-06-02 11:43</p>
            <h2 class="mt-2 text-base font-medium text-slate-900">Entidad creada</h2>
            <p class="text-sm text-slate-700">Se añadió una nueva entidad con nombre "Entidad 1".</p>
          </article>
          <article class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
            <p class="text-sm text-slate-600">2026-06-02 11:42</p>
            <h2 class="mt-2 text-base font-medium text-slate-900">Centro añadido</h2>
            <p class="text-sm text-slate-700">Se añadieron 4 campos para registrar centros.</p>
          </article>
          <article class="rounded-2xl border border-slate-200 bg-slate-50 p-4">
            <p class="text-sm text-slate-600">2026-06-02 11:40</p>
            <h2 class="mt-2 text-base font-medium text-slate-900">Modal desplegado</h2>
            <p class="text-sm text-slate-700">Se abrió la ventana de Agregar información desde el botón flotante.</p>
          </article>
        </div>

        <button
          v-show="showScrollButton"
          type="button"
          class="fixed bottom-6 right-6 z-50 rounded-full bg-slate-700 px-4 py-3 text-white shadow-xl transition hover:bg-slate-900 focus:outline-none focus:ring-2 focus:ring-slate-300"
          @click="scrollToTop"
          aria-label="Volver arriba"
        >
          ↑
        </button>
      </div>
    </section>
  </BaseLayout>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue'
import BaseLayout from '../components/layout/BaseLayout.vue'

const showScrollButton = ref(false)

const handleScroll = () => {
  showScrollButton.value = window.scrollY > 300
}

const scrollToTop = () => {
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  handleScroll()
})

onBeforeUnmount(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>
