import { create } from 'zustand'
import { persist, createJSONStorage } from 'zustand/middleware'
import AsyncStorage from '@react-native-async-storage/async-storage'

interface SessionStore {
  isGuest: boolean
  userId: string | null
  setUser: (userId: string) => void
  clearUser: () => void
}

export const useSessionStore = create<SessionStore>()(
  persist(
    (set) => ({
      isGuest: true,
      userId: null,

      setUser: (userId) => set({ userId, isGuest: false }),
      clearUser: () => set({ userId: null, isGuest: true }),
    }),
    {
      name: 'app-session',
      storage: createJSONStorage(() => AsyncStorage),
    }
  )
)