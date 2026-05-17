import { Category } from './category'

export interface Guide {
  id: string
  slug: string
  category_id: string
  title_en: string
  title_fil: string
  tagline_en: string
  tagline_fil: string
  is_featured: boolean
  is_urgent: boolean
  is_published: boolean
  read_time_min: number
  difficulty: 'madali' | 'katamtaman' | 'mahirap' | null
  estimated_time: string | null
  estimated_cost: string | null
  tags: string[]
  published_at: string
  created_at: string
  updated_at: string
  category?: Category
  sections?: GuideSection[]
}

export interface GuideSection {
  id: string
  guide_id: string
  section_type: 'what_to_know' | 'mistake' | 'step' | 'warning' | 'tip' | 'related'
  order_index: number
  content_en: SectionContent
  content_fil: SectionContent
}

export interface SectionContent {
  title?: string
  body: string
  icon?: string
  step_number?: number
  severity?: 'low' | 'medium' | 'high'
}