import AsyncStorage from '@react-native-async-storage/async-storage'
import { create } from 'zustand'
import { createJSONStorage, persist } from 'zustand/middleware'

interface CourseFitProgressStore {
  courseFitOpened: boolean
  courseFitStarted: boolean
  courseFitCompleted: boolean
  courseFitGuideViewed: boolean
  markCourseFitOpened: () => void
  markCourseFitStarted: () => void
  markCourseFitCompleted: () => void
  markCourseFitGuideViewed: () => void
  resetCourseFitProgress: () => void
}

export const useCourseFitProgressStore = create<CourseFitProgressStore>()(
  persist(
    (set) => ({
      courseFitOpened: false,
      courseFitStarted: false,
      courseFitCompleted: false,
      courseFitGuideViewed: false,

      markCourseFitOpened: () =>
        set({
          courseFitOpened: true,
        }),

      markCourseFitStarted: () =>
        set({
          courseFitOpened: true,
          courseFitStarted: true,
        }),

      markCourseFitCompleted: () =>
        set({
          courseFitOpened: true,
          courseFitStarted: true,
          courseFitCompleted: true,
        }),

      markCourseFitGuideViewed: () =>
        set({
          courseFitOpened: true,
          courseFitGuideViewed: true,
        }),

      resetCourseFitProgress: () =>
        set({
          courseFitOpened: false,
          courseFitStarted: false,
          courseFitCompleted: false,
          courseFitGuideViewed: false,
        }),
    }),
    {
      name: 'course-fit-progress',
      storage: createJSONStorage(() => AsyncStorage),
    }
  )
)
