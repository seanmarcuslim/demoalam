import { create } from 'zustand'

interface FeedbackState {
  message: string | null
  kind: 'success' | 'info'
  show: (message: string, kind?: 'success' | 'info') => void
  hide: () => void
}

let hideTimer: ReturnType<typeof setTimeout> | null = null

export const useFeedbackStore = create<FeedbackState>((set) => ({
  message: null,
  kind: 'success',

  show: (message, kind = 'success') => {
    if (hideTimer) {
      clearTimeout(hideTimer)
    }

    set({ message, kind })

    hideTimer = setTimeout(() => {
      set({ message: null })
    }, 2200)
  },

  hide: () => {
    if (hideTimer) {
      clearTimeout(hideTimer)
    }

    set({ message: null })
  },
}))
