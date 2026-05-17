import { useEffect } from 'react'
import { supabase } from '../services/supabase'
import { useSessionStore } from '../stores/sessionStore'

export function useAuthSession() {
  const setUser = useSessionStore((state) => state.setUser)
  const clearUser = useSessionStore((state) => state.clearUser)

  useEffect(() => {
    supabase.auth.getSession().then(({ data }) => {
      if (data.session?.user) {
        setUser(data.session.user.id, data.session.user.email)
      }
    })

    const { data: listener } = supabase.auth.onAuthStateChange((_event, session) => {
      if (session?.user) {
        setUser(session.user.id, session.user.email)
      } else {
        clearUser()
      }
    })

    return () => {
      listener.subscription.unsubscribe()
    }
  }, [setUser, clearUser])
}