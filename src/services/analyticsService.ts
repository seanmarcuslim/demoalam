import { Platform } from 'react-native'
import { supabase } from './supabase'

export const analyticsService = {
  async logGuideView(guideId: string) {
    const { error } = await supabase
      .from('guide_views')
      .insert({
        guide_id: guideId,
        platform: Platform.OS,
      })

    if (error && __DEV__) {
      console.error('Error logging guide view:', error)
    }
  },
}
