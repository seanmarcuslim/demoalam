import { create } from 'zustand'
import { persist, createJSONStorage } from 'zustand/middleware'
import AsyncStorage from '@react-native-async-storage/async-storage'

interface SearchStore {
  recentSearches: string[]
  addRecentSearch: (term: string) => void
  clearRecentSearches: () => void
}

export const useSearchStore = create<SearchStore>()(
  persist(
    (set) => ({
      recentSearches: [],

      addRecentSearch: (term: string) =>
        set((state) => {
          const cleanTerm = term.trim()

          if (cleanTerm.length < 2) {
            return state
          }

          const withoutDuplicate = state.recentSearches.filter(
            (item) => item.toLowerCase() !== cleanTerm.toLowerCase()
          )

          return {
            recentSearches: [cleanTerm, ...withoutDuplicate].slice(0, 10),
          }
        }),

      clearRecentSearches: () => set({ recentSearches: [] }),
    }),
    {
      name: 'recent-searches',
      storage: createJSONStorage(() => AsyncStorage),
    }
  )
)
