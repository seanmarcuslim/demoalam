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

function searchableText(guide: Guide) {
  return [
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

  return (
    text.includes(normalizedQuery) ||
    terms.every((term) => text.includes(term))
  )
}

function uniqueGuides(guides: Guide[]) {
  const byId = new Map<string, Guide>()

  guides.forEach((guide) => {
    byId.set(guide.id, guide)
  })

  return Array.from(byId.values())
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

    const searchTerms = toSearchTerms(cleanQuery)

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

    return uniqueGuides([
      ...(data || []),
      ...(fallbackData || []),
      ...localMatches,
    ]).slice(0, 20)
  },
}
