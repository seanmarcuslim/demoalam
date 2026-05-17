import { create } from 'zustand'
import { persist, createJSONStorage } from 'zustand/middleware'
import AsyncStorage from '@react-native-async-storage/async-storage'

interface SettingsStore {
  language: 'en' | 'fil'
  hasSeenOnboarding: boolean
  setLanguage: (lang: 'en' | 'fil') => void
  markOnboardingSeen: () => void
}

export const useSettingsStore = create<SettingsStore>()(
  persist(
    (set) => ({
      language: 'fil',
      hasSeenOnboarding: false,

      setLanguage: (lang) => set({ language: lang }),
      markOnboardingSeen: () => set({ hasSeenOnboarding: true }),
    }),
    {
      name: 'app-settings',
      storage: createJSONStorage(() => AsyncStorage),
    }
  )
)