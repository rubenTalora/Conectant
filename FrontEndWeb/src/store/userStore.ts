import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', {
  state: () => ({
    name: '',
    authenticated: false
  }),
  actions: {
    login(name: string) {
      this.name = name
      this.authenticated = true
    },
    logout() {
      this.name = ''
      this.authenticated = false
    }
  }
})
