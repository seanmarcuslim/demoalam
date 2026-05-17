import { useState } from 'react'
import { authService } from '../services/authService'
import { useSessionStore } from '../stores/sessionStore'

export function useAuth() {
  const [isLoading, setIsLoading] = useState(false)

  const setUser = useSessionStore((state) => state.setUser)
  const clearUser = useSessionStore((state) => state.clearUser)

  const signUp = async (email: string, password: string) => {
    setIsLoading(true)

    try {
      const data = await authService.signUp(email, password)

      if (data.user) {
        setUser(data.user.id, data.user.email)
      }

      return data
    } finally {
      setIsLoading(false)
    }
  }

  const signIn = async (email: string, password: string) => {
    setIsLoading(true)

    try {
      const data = await authService.signIn(email, password)

      if (data.user) {
        setUser(data.user.id, data.user.email)
      }

      return data
    } finally {
      setIsLoading(false)
    }
  }

  const signOut = async () => {
    setIsLoading(true)

    try {
      await authService.signOut()
      clearUser()
    } finally {
      setIsLoading(false)
    }
  }

  return {
    signUp,
    signIn,
    signOut,
    isLoading,
  }
}