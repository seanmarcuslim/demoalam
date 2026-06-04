import { Platform } from 'react-native'
import { supabase } from './supabase'

type SearchEventPayload = {
  query: string
  resultCount: number
  topResultSlug?: string | null
  language: 'en' | 'fil'
}

type FlowEventPayload = {
  flowSlug: 'phone-lost'
  eventName:
    | 'flow_opened'
    | 'flow_completed'
    | 'flow_outcome_shown'
    | 'flow_guide_opened'
  outcomeId?: string | null
  guideSlug?: string | null
  searchQuery?: string | null
  language: 'en' | 'fil'
}

function normalizeSearchQuery(query: string) {
  return query.trim().replace(/\s+/g, ' ').toLowerCase().slice(0, 120)
}

function getAnalyticsPlatform() {
  if (
    Platform.OS === 'ios' ||
    Platform.OS === 'android' ||
    Platform.OS === 'web'
  ) {
    return Platform.OS
  }

  return 'unknown'
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

  async logFlowEvent({
    flowSlug,
    eventName,
    outcomeId,
    guideSlug,
    searchQuery,
    language,
  }: FlowEventPayload) {
    const normalizedSearchQuery = searchQuery
      ? normalizeSearchQuery(searchQuery)
      : ''

    const { error } = await supabase
      .from('flow_events')
      .insert({
        flow_slug: flowSlug,
        event_name: eventName,
        outcome_id: outcomeId ?? null,
        guide_slug: guideSlug ?? null,
        search_query:
          eventName === 'flow_opened' && normalizedSearchQuery.length >= 2
            ? normalizedSearchQuery
            : null,
        language,
        platform: getAnalyticsPlatform(),
      })

    if (error && __DEV__) {
      console.error('Error logging flow event:', error)
    }
  },
}
