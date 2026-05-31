import { Platform } from 'react-native'
import { supabase } from './supabase'

type SearchEventPayload = {
  query: string
  resultCount: number
  topResultSlug?: string | null
  language: 'en' | 'fil'
}

function normalizeSearchQuery(query: string) {
  return query.trim().replace(/\s+/g, ' ').toLowerCase().slice(0, 120)
}

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

  async logSearchEvent({
    query,
    resultCount,
    topResultSlug,
    language,
  }: SearchEventPayload) {
    const normalizedQuery = normalizeSearchQuery(query)

    if (normalizedQuery.length < 2) {
      return
    }

    const { error } = await supabase
      .from('search_events')
      .insert({
        query: query.trim().replace(/\s+/g, ' ').slice(0, 120),
        normalized_query: normalizedQuery,
        result_count: resultCount,
        top_result_slug: topResultSlug ?? null,
        language,
        platform: Platform.OS,
      })

    if (error && __DEV__) {
      console.error('Error logging search event:', error)
    }
  },
}
