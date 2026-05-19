import type { Category } from '../types/category'

export const CATEGORY_ACCENTS: Record<string, string> = {
  ids: '#2563A9',
  work: '#267A4D',
  money: '#D9902F',
  gov: '#6D5BA8',
  scams: '#C83E3A',
  emergency: '#B86B16',
  adulting: '#2F8277',
}

export function getCategoryAccent(
  category: Pick<Category, 'slug' | 'color'> | null | undefined,
  fallback: string
) {
  if (!category) {
    return fallback
  }

  return CATEGORY_ACCENTS[category.slug] || category.color || fallback
}
