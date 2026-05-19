import { supabase } from './supabase'
import { throwServiceError } from './serviceErrors'

export const authService = {
  async signUp(email: string, password: string) {
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
    })

    if (error) {
      throwServiceError('Error signing up:', error)
    }

    return data
  },

  async signIn(email: string, password: string) {
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    })

    if (error) {
      throwServiceError('Error signing in:', error)
    }

    return data
  },

  async signOut() {
    const { error } = await supabase.auth.signOut()

    if (error) {
      throwServiceError('Error signing out:', error)
    }
  },

  async getCurrentSession() {
    const { data, error } = await supabase.auth.getSession()

    if (error) {
      throwServiceError('Error getting current session:', error)
    }

    return data.session
  },
}
