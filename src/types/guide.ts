import { Category } from './category'

export type GuideDifficulty =
  | 'madali'
  | 'katamtaman'
  | 'mahirap'
  | null

export type GuideSectionType =
  | 'what_to_know'
  | 'mistake'
  | 'step'
  | 'warning'
  | 'tip'
  | 'related'

export type SectionSeverity =
  | 'low'
  | 'medium'
  | 'high'

export interface Guide {
  id: string
  slug: string

  category_id: string

  title_en: string
  title_fil: string

  tagline_en: string
  tagline_fil: string

  keywords_en?: string | null
  keywords_fil?: string | null
  official_sources?: GuideOfficialSource[] | null

  is_featured: boolean
  is_urgent: boolean
  is_published: boolean

  read_time_min: number

  difficulty: GuideDifficulty

  estimated_time: string | null
  estimated_cost: string | null

  tags: string[]

  published_at: string
  created_at: string
  updated_at: string

  category?: Category
  sections?: GuideSection[]
}

export interface GuideOfficialSource {
  title: string
  url: string
  publisher?: string
}

export interface GuideSection {
  id: string

  guide_id: string

  section_type: GuideSectionType

  order_index: number

  content_en: SectionContent
  content_fil: SectionContent
}

export interface SectionContent {
  title?: string

  body: string

  icon?: string

  step_number?: number

  severity?: SectionSeverity

  items?: string[]

  sample?: string
}
