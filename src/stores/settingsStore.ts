import { create } from 'zustand'
import { persist, createJSONStorage } from 'zustand/middleware'
import AsyncStorage from '@react-native-async-storage/async-storage'

interface SettingsStore {
  language: 'en' | 'fil'
  theme: 'light' | 'dark'
  hasSeenOnboarding: boolean
  setLanguage: (lang: 'en' | 'fil') => void
  setTheme: (theme: 'light' | 'dark') => void
  toggleTheme: () => void
  markOnboardingSeen: () => void
}

export const useSettingsStore = create<SettingsStore>()(
  persist(
    (set, get) => ({
      language: 'fil',
      theme: 'light',
      hasSeenOnboarding: false,

      setLanguage: (lang) => set({ language: lang }),

      setTheme: (theme) => set({ theme }),

      toggleTheme: () =>
        set({
          theme: get().theme === 'light' ? 'dark' : 'light',
        }),

      markOnboardingSeen: () => set({ hasSeenOnboarding: true }),
    }),
    {
      name: 'app-settings',
      storage: createJSONStorage(() => AsyncStorage),
    }
  )
)