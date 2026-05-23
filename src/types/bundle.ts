import type { Guide } from './guide'

export interface GuideBundle {
  id: string
  slug: string
  title_en: string
  title_fil: string
  description_en: string | null
  description_fil: string | null
  icon: string | null
  color: string | null
  is_featured: boolean
  is_published: boolean
  order_index: number
  created_at: string
  updated_at: string
}

export interface GuideBundleItem {
  id: string
  bundle_id: string
  guide_id: string
  order_index: number
  reason_en: string | null
  reason_fil: string | null
  created_at: string
  guide?: Guide
}

export interface GuideBundleWithItems extends GuideBundle {
  items: GuideBundleItem[]
}