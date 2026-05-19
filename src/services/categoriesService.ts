import { supabase } from './supabase'
import { Category } from '../types/category'
import { throwServiceError } from './serviceErrors'

export const categoriesService = {
  async fetchCategories(): Promise<Category[]> {
    const { data, error } = await supabase
      .from('categories')
      .select('*')
      .eq('is_active', true)
      .order('order_index', { ascending: true })

    if (error) {
      throwServiceError('Error fetching categories:', error)
    }

    return data || []
  },
}
