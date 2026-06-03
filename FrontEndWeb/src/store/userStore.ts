import { defineStore } from 'pinia'
import { useSupabase } from '@/composables/useSupabase'

export const useUserStore = defineStore('user', {
  state: () => ({
    name: '',
    authenticated: false,
    userId: '',
  }),
  actions: {
    login(name: string, userId?: string) {
      this.name = name
      this.authenticated = true
      if (userId) {
        this.userId = userId
      }
    },
    async logout() {
      const { logout } = useSupabase()
      await logout()
      this.name = ''
      this.authenticated = false
      this.userId = ''
    }
  }
})
