import { supabase } from './supabase'
import { Guide } from '../types/guide'

function toPlainTextQuery(query: string) {
  return query.trim().replace(/\s+/g, ' ')
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
      console.error(
        'Error fetching guides:',
        error
      )
      throw error
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
      console.error(
        'Error fetching guide:',
        error
      )
      throw error
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
      console.error(
        'Error fetching featured:',
        error
      )
      throw error
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
      console.error(
        'Error fetching urgent:',
        error
      )
      throw error
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
      console.error(
        'Error searching guides:',
        error
      )
      throw error
    }

    return data || []
  },
}
