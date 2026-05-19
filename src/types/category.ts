export interface Category {
  id: string
  slug: string
  name_en: string
  name_fil: string
  icon: string
  color: string
  order_index: number
  is_active: boolean
  created_at: string
  updated_at?: string | null
}

export type CategoryLanguage = 'en' | 'fil'

export type CategoryCopy = {
  en: string
  fil: string
  accent: string
}