import { supabase } from './supabase'
import { Category } from '../types/category'

export const categoriesService = {
  async fetchCategories(): Promise<Category[]> {
    const { data, error } = await supabase
      .from('categories')
      .select('*')
      .eq('is_active', true)
      .order('order_index', { ascending: true })

    if (error) {
      console.error('Error fetching categories:', error)
      throw error
    }

    return data || []
  },
}