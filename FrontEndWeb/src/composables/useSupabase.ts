import { supabase } from '@/lib/supabase'

export interface SavedItem {
  id?: string
  name: string
  web?: string
  contact?: string
  address?: string
  description?: string
  type: 'entidad' | 'centro'
  created_at?: string
  user_id?: string
}

export const useSupabase = () => {
  // Auth functions
  const login = async (email: string, password: string) => {
    try {
      const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password,
      })
      if (error) throw error
      return { data, error: null }
    } catch (error) {
      return { data: null, error }
    }
  }

  const signup = async (email: string, password: string) => {
    try {
      const { data, error } = await supabase.auth.signUp({
        email,
        password,
      })
      if (error) throw error
      return { data, error: null }
    } catch (error) {
      return { data: null, error }
    }
  }

  const logout = async () => {
    try {
      const { error } = await supabase.auth.signOut()
      if (error) throw error
      return { error: null }
    } catch (error) {
      return { error }
    }
  }

  const getCurrentUser = async () => {
    try {
      const { data: { user }, error } = await supabase.auth.getUser()
      if (error) throw error
      return { user, error: null }
    } catch (error) {
      return { user: null, error }
    }
  }

  // Database functions
  const addItem = async (item: SavedItem) => {
    try {
      const { data: { user }, error: userError } = await supabase.auth.getUser()
      if (userError || !user) throw new Error('Not authenticated')

      const { data, error } = await supabase
        .from('saved_items')
        .insert([
          {
            name: item.name,
            web: item.web || null,
            contact: item.contact || null,
            address: item.address || null,
            description: item.description || null,
            type: item.type,
            user_id: user.id,
          },
        ])
        .select()

      if (error) throw error
      return { data, error: null }
    } catch (error) {
      return { data: null, error }
    }
  }

  const getItems = async (type?: 'entidad' | 'centro') => {
    try {
      const { data: { user }, error: userError } = await supabase.auth.getUser()
      if (userError || !user) throw new Error('Not authenticated')

      let query = supabase
        .from('saved_items')
        .select('*')
        .eq('user_id', user.id)

      if (type) {
        query = query.eq('type', type)
      }

      const { data, error } = await query.order('created_at', { ascending: false })

      if (error) throw error
      return { data, error: null }
    } catch (error) {
      return { data: null, error }
    }
  }

  const updateItem = async (id: string, item: Partial<SavedItem>) => {
    try {
      const { data, error } = await supabase
        .from('saved_items')
        .update({
          name: item.name,
          web: item.web || null,
          contact: item.contact || null,
          address: item.address || null,
          description: item.description || null,
        })
        .eq('id', id)
        .select()

      if (error) throw error
      return { data, error: null }
    } catch (error) {
      return { data: null, error }
    }
  }

  const deleteItem = async (id: string) => {
    try {
      const { error } = await supabase
        .from('saved_items')
        .delete()
        .eq('id', id)

      if (error) throw error
      return { error: null }
    } catch (error) {
      return { error }
    }
  }

  return {
    // Auth
    login,
    signup,
    logout,
    getCurrentUser,
    // Database
    addItem,
    getItems,
    updateItem,
    deleteItem,
  }
}
