import { create } from 'zustand'
import { persist, createJSONStorage } from 'zustand/middleware'
import AsyncStorage from '@react-native-async-storage/async-storage'
import { Guide } from '../types/guide'

interface SavedStore {
  savedIds: string[]
  cachedGuides: Record<string, Guide>
  save: (guide: Guide) => void
  unsave: (id: string) => void
  isSaved: (id: string) => boolean
}

export const useSavedStore = create<SavedStore>()(
  persist(
    (set, get) => ({
      savedIds: [],
      cachedGuides: {},

      save: (guide: Guide) => set((state) => ({
        savedIds: [...state.savedIds, guide.id],
        cachedGuides: { ...state.cachedGuides, [guide.id]: guide },
      })),

      unsave: (id: string) => set((state) => {
        const { [id]: _, ...rest } = state.cachedGuides
        return {
          savedIds: state.savedIds.filter((savedId) => savedId !== id),
          cachedGuides: rest,
        }
      }),

      isSaved: (id: string) => get().savedIds.includes(id),
    }),
    {
      name: 'saved-guides',
      storage: createJSONStorage(() => AsyncStorage),
    }
  )
)