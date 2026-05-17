import { create } from 'zustand'
import { persist, createJSONStorage } from 'zustand/middleware'
import AsyncStorage from '@react-native-async-storage/async-storage'

interface SessionStore {
  isGuest: boolean
  userId: string | null
  email: string | null
  setUser: (userId: string, email?: string | null) => void
  clearUser: () => void
}

export const useSessionStore = create<SessionStore>()(
  persist(
    (set) => ({
      isGuest: true,
      userId: null,
      email: null,

      setUser: (userId, email = null) =>
        set({
          userId,
          email,
          isGuest: false,
        }),

      clearUser: () =>
        set({
          userId: null,
          email: null,
          isGuest: true,
        }),
    }),
    {
      name: 'app-session',
      storage: createJSONStorage(() => AsyncStorage),
    }
  )
)