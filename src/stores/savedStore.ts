import { create } from 'zustand'
import { persist, createJSONStorage } from 'zustand/middleware'
import AsyncStorage from '@react-native-async-storage/async-storage'
import { Guide } from '../types/guide'

const SAVED_STORE_VERSION = 2

interface SavedStore {
  savedIds: string[]
  cachedGuides: Record<string, Guide>
  save: (guide: Guide) => void
  hydrateSavedGuides: (guides: Guide[]) => void
  unsave: (id: string) => void
  isSaved: (id: string) => boolean
  toggleSave: (guide: Guide) => void
}

export const useSavedStore = create<SavedStore>()(
  persist(
    (set, get) => ({
      savedIds: [],
      cachedGuides: {},

      save: (guide: Guide) =>
        set((state) => {
          const alreadySaved = state.savedIds.includes(guide.id)

          return {
            savedIds: alreadySaved
              ? state.savedIds
              : [...state.savedIds, guide.id],
            cachedGuides: {
              ...state.cachedGuides,
              [guide.id]: guide,
            },
          }
        }),

      hydrateSavedGuides: (guides: Guide[]) =>
        set((state) => {
          const nextCachedGuides = { ...state.cachedGuides }

          guides.forEach((guide) => {
            if (state.savedIds.includes(guide.id)) {
              nextCachedGuides[guide.id] = {
                ...nextCachedGuides[guide.id],
                ...guide,
              }
            }
          })

          return {
            cachedGuides: nextCachedGuides,
          }
        }),

      unsave: (id: string) =>
        set((state) => {
          const { [id]: _, ...rest } = state.cachedGuides

          return {
            savedIds: state.savedIds.filter((savedId) => savedId !== id),
            cachedGuides: rest,
          }
        }),

      isSaved: (id: string) => get().savedIds.includes(id),

      toggleSave: (guide: Guide) => {
        const saved = get().isSaved(guide.id)

        if (saved) {
          get().unsave(guide.id)
        } else {
          get().save(guide)
        }
      },
    }),
    {
      name: 'saved-guides',
      version: SAVED_STORE_VERSION,
      storage: createJSONStorage(() => AsyncStorage),
      migrate: (persistedState) => {
        const state = persistedState as Partial<SavedStore> | undefined

        return {
          savedIds: Array.isArray(state?.savedIds) ? state.savedIds : [],
          cachedGuides: {},
        }
      },
    }
  )
)
