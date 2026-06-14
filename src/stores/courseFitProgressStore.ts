import AsyncStorage from '@react-native-async-storage/async-storage'
import { create } from 'zustand'
import { createJSONStorage, persist } from 'zustand/middleware'

interface CourseFitProgressStore {
  courseFitOpened: boolean
  courseFitStarted: boolean
  courseFitCompleted: boolean
  courseFitGuideViewed: boolean
  courseFitNextMoveDismissed: boolean
  markCourseFitOpened: () => void
  markCourseFitStarted: () => void
  markCourseFitCompleted: () => void
  markCourseFitGuideViewed: () => void
  dismissCourseFitNextMove: () => void
  resetCourseFitProgress: () => void
}

export const useCourseFitProgressStore = create<CourseFitProgressStore>()(
  persist(
    (set) => ({
      courseFitOpened: false,
      courseFitStarted: false,
      courseFitCompleted: false,
      courseFitGuideViewed: false,
      courseFitNextMoveDismissed: false,

      markCourseFitOpened: () =>
        set({
          courseFitOpened: true,
          courseFitNextMoveDismissed: false,
        }),

      markCourseFitStarted: () =>
        set({
          courseFitOpened: true,
          courseFitStarted: true,
          courseFitNextMoveDismissed: false,
        }),

      markCourseFitCompleted: () =>
        set({
          courseFitOpened: true,
          courseFitStarted: true,
          courseFitCompleted: true,
          courseFitNextMoveDismissed: false,
        }),

      markCourseFitGuideViewed: () =>
        set({
          courseFitOpened: true,
          courseFitGuideViewed: true,
          courseFitNextMoveDismissed: false,
        }),

      dismissCourseFitNextMove: () =>
        set({
          courseFitNextMoveDismissed: true,
        }),

      resetCourseFitProgress: () =>
        set({
          courseFitOpened: false,
          courseFitStarted: false,
          courseFitCompleted: false,
          courseFitGuideViewed: false,
          courseFitNextMoveDismissed: false,
        }),
    }),
    {
      name: 'course-fit-progress',
      storage: createJSONStorage(() => AsyncStorage),
    }
  )
)
