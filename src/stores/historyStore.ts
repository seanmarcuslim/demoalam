import { create } from 'zustand'
import { persist, createJSONStorage } from 'zustand/middleware'
import AsyncStorage from '@react-native-async-storage/async-storage'
import { Guide } from '../types/guide'

interface HistoryStore {
  recentIds: string[]
  cachedGuides: Record<string, Guide>
  addToHistory: (guide: Guide) => void
  clearHistory: () => void
}

export const useHistoryStore = create<HistoryStore>()(
  persist(
    (set) => ({
      recentIds: [],
      cachedGuides: {},

      addToHistory: (guide: Guide) =>
        set((state) => {
          const filteredIds = state.recentIds.filter((id) => id !== guide.id)

          return {
            recentIds: [guide.id, ...filteredIds].slice(0, 20),
            cachedGuides: {
              ...state.cachedGuides,
              [guide.id]: guide,
            },
          }
        }),

      clearHistory: () =>
        set({
          recentIds: [],
          cachedGuides: {},
        }),
    }),
    {
      name: 'recent-guides',
      storage: createJSONStorage(() => AsyncStorage),
    }
  )
)