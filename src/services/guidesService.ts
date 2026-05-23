import { supabase } from './supabase'
import { Guide } from '../types/guide'
import { throwServiceError } from './serviceErrors'

function toPlainTextQuery(query: string) {
  return query.trim().replace(/\s+/g, ' ')
}

function toIlikePattern(query: string) {
  return `%${query.replace(/[%_]/g, '\\$&')}%`
}

function toSearchTerms(query: string) {
  return query
    .toLowerCase()
    .split(/\s+/)
    .map((term) => term.trim())
    .filter((term) => term.length > 0)
}

const SEARCH_ALIASES: Record<string, string[]> = {
  ayuda: [
    'dswd',
    'aics',
    'assistance',
    'cash assistance',
    'financial aid',
    'benefits',
    'social pension',
    '4ps',
    'walang gutom',
    'emergency cash transfer',
    'livelihood',
  ],
  aid: [
    'ayuda',
    'assistance',
    'dswd',
    'aics',
    'benefits',
    'cash assistance',
    'financial aid',
  ],
  assistance: [
    'ayuda',
    'dswd',
    'aics',
    'cash assistance',
    'financial aid',
    'social pension',
  ],
  benefits: [
    'ayuda',
    'assistance',
    'dswd',
    '4ps',
    'social pension',
    'philhealth',
    'pagibig',
    'sss',
  ],
  dswd: [
    'ayuda',
    'aics',
    '4ps',
    'walang gutom',
    'social pension',
    'emergency cash transfer',
    'sustainable livelihood',
    'student cash for work',
  ],
  aics: [
    'dswd',
    'ayuda',
    'cash assistance',
    'medical assistance',
    'educational assistance',
    'burial assistance',
    'transportation assistance',
  ],
  pension: [
    'social pension',
    'senior citizen',
    'elderly',
    'older persons',
    'dswd',
  ],
  senior: [
    'social pension',
    'senior citizen',
    'elderly',
    'older persons',
    'dswd',
  ],
  gutom: [
    'walang gutom',
    'food credits',
    'food stamp',
    'dswd',
    'beneficiary',
  ],
  food: [
    'walang gutom',
    'food credits',
    'food stamp',
    'dswd',
  ],
  livelihood: [
    'sustainable livelihood',
    'slp',
    'negosyo',
    'capital',
    'employment',
    'dswd',
  ],
  negosyo: [
    'livelihood',
    'sustainable livelihood',
    'slp',
    'capital',
    'dswd',
  ],
  student: [
    'student aid',
    'cash-for-work',
    'cash for work',
    'tara basa',
    'educational assistance',
    'scholarship',
    'dswd',
  ],
  estudyante: [
    'student',
    'student aid',
    'cash-for-work',
    'educational assistance',
    'scholarship',
    'dswd',
  ],
  calamity: [
    'disaster',
    'emergency cash transfer',
    'ect',
    'evacuation',
    'relief',
    'dswd',
  ],
  disaster: [
    'calamity',
    'emergency cash transfer',
    'ect',
    'evacuation',
    'relief',
    'dswd',
  ],
  '4ps': [
    'pantawid',
    'pantawid pamilya',
    'conditional cash transfer',
    'household validation',
    'dswd',
  ],
}

function expandSearchTerms(query: string) {
  const cleanQuery = query.toLowerCase()
  const baseTerms = [cleanQuery, ...toSearchTerms(cleanQuery)]
  const expandedTerms = baseTerms.flatMap((term) => [
    term,
    ...(SEARCH_ALIASES[term] || []),
  ])

  return expandedTerms.filter(
    (term, index, items) => term.length > 1 && items.indexOf(term) === index
  )
}

function searchableText(guide: Guide) {
  return [
    guide.slug,
    guide.title_en,
    guide.title_fil,
    guide.tagline_en,
    guide.tagline_fil,
    guide.keywords_en,
    guide.keywords_fil,
    ...(guide.tags || []),
    guide.category?.name_en,
    guide.category?.name_fil,
    guide.category?.slug,
  ]
    .filter(Boolean)
    .join(' ')
    .toLowerCase()
}

function matchesSearch(guide: Guide, query: string) {
  const text = searchableText(guide)
  const normalizedQuery = query.toLowerCase()
  const terms = toSearchTerms(normalizedQuery)
  const expandedTerms = expandSearchTerms(normalizedQuery)

  return (
    text.includes(normalizedQuery) ||
    terms.every((term) => text.includes(term)) ||
    expandedTerms.some((term) => text.includes(term))
  )
}

function uniqueGuides(guides: Guide[]) {
  const byId = new Map<string, Guide>()

  guides.forEach((guide) => {
    byId.set(guide.id, guide)
  })

  return Array.from(byId.values())
}

function scoreGuide(guide: Guide, query: string) {
  const text = searchableText(guide)
  const title = `${guide.title_en} ${guide.title_fil}`.toLowerCase()
  const keywords = `${guide.keywords_en || ''} ${guide.keywords_fil || ''}`.toLowerCase()
  const cleanQuery = query.toLowerCase()
  const directTerms = toSearchTerms(cleanQuery)
  const expandedTerms = expandSearchTerms(cleanQuery)

  let score = 0

  if (title.includes(cleanQuery)) score += 20
  if (text.includes(cleanQuery)) score += 12

  directTerms.forEach((term) => {
    if (title.includes(term)) score += 8
    if (keywords.includes(term)) score += 5
    if (text.includes(term)) score += 3
  })

  expandedTerms.forEach((term) => {
    if (keywords.includes(term)) score += 2
    if (text.includes(term)) score += 1
  })

  if (guide.is_urgent) score += 2
  if (guide.is_featured) score += 1

  return score
}

function sortBySearchRelevance(guides: Guide[], query: string) {
  return [...guides].sort((first, second) => {
    const scoreDifference =
      scoreGuide(second, query) - scoreGuide(first, query)

    if (scoreDifference !== 0) {
      return scoreDifference
    }

    return (
      new Date(second.published_at).getTime() -
      new Date(first.published_at).getTime()
    )
  })
}

export const guidesService = {
  async fetchGuides(
    categoryId?: string
  ): Promise<Guide[]> {
    let query = supabase
      .from('guides')
      .select(
        '*, category:categories(*)'
      )
      .eq('is_published', true)
      .order('published_at', {
        ascending: false,
      })

    if (categoryId) {
      query = query.eq(
        'category_id',
        categoryId
      )
    }

    const { data, error } = await query

    if (error) {
      throwServiceError('Error fetching guides:', error)
    }

    return data || []
  },

  async fetchGuide(
    id: string
  ): Promise<Guide | null> {
    const { data, error } =
      await supabase
        .from('guides')
        .select(
          '*, category:categories(*), sections:guide_sections(*)'
        )
        .eq('id', id)
        .eq('is_published', true)
        .order('order_index', {
          referencedTable: 'guide_sections',
          ascending: true,
        })
        .single()

    if (error) {
      throwServiceError('Error fetching guide:', error)
    }

    return data
  },

  async fetchFeatured(): Promise<Guide[]> {
    const { data, error } =
      await supabase
        .from('guides')
        .select(
          '*, category:categories(*)'
        )
        .eq('is_featured', true)
        .eq('is_published', true)
        .limit(5)

    if (error) {
      throwServiceError('Error fetching featured:', error)
    }

    return data || []
  },

  async fetchUrgent(): Promise<Guide[]> {
    const { data, error } =
      await supabase
        .from('guides')
        .select(
          '*, category:categories(*)'
        )
        .eq('is_urgent', true)
        .eq('is_published', true)
        .limit(5)

    if (error) {
      throwServiceError('Error fetching urgent:', error)
    }

    return data || []
  },

  async fetchTrending(): Promise<Guide[]> {
    const { data, error } =
      await supabase.rpc('get_trending_guides_with_category', {
        since_interval: '7 days',
        result_limit: 10,
      })

    if (error) {
      // Trending is optional. If the RPC is not migrated yet, Home falls back to regular guides.
      return []
    }

    return data || []
  },

  async searchGuides(
    query: string
  ): Promise<Guide[]> {
    const cleanQuery = toPlainTextQuery(query)

    if (!cleanQuery) {
      return []
    }

    const searchTerms = expandSearchTerms(cleanQuery)

    const { data, error } =
      await supabase
        .from('guides')
        .select(
          '*, category:categories(*)'
        )
        .eq('is_published', true)
        .textSearch('search_vector', cleanQuery, {
          type: 'plain',
        })
        .order('published_at', {
          ascending: false,
        })
        .limit(20)

    if (error) {
      throwServiceError('Error searching guides:', error)
    }

    const patterns = [cleanQuery, ...searchTerms]
      .filter((term, index, items) => items.indexOf(term) === index)
      .map(toIlikePattern)

    const { data: fallbackData, error: fallbackError } =
      await supabase
        .from('guides')
        .select(
          '*, category:categories(*)'
        )
        .eq('is_published', true)
        .or(
          patterns.flatMap((pattern) => [
            `title_en.ilike.${pattern}`,
            `title_fil.ilike.${pattern}`,
            `tagline_en.ilike.${pattern}`,
            `tagline_fil.ilike.${pattern}`,
            `keywords_en.ilike.${pattern}`,
            `keywords_fil.ilike.${pattern}`,
          ]).join(',')
        )
        .order('published_at', {
          ascending: false,
        })
        .limit(20)

    if (fallbackError) {
      throwServiceError('Error searching guides:', fallbackError)
    }

    const allGuides = await guidesService.fetchGuides()
    const localMatches = allGuides.filter((guide) =>
      matchesSearch(guide, cleanQuery)
    )

    return sortBySearchRelevance(uniqueGuides([
      ...(data || []),
      ...(fallbackData || []),
      ...localMatches,
    ]), cleanQuery).slice(0, 20)
  },
}
