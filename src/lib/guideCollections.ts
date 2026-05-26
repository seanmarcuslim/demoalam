import type { Guide } from '../types/guide'

const GOVERNMENT_AID_TERMS = [
  'dswd',
  'aics',
  'social pension',
  'walang gutom',
  '4ps',
  'emergency cash transfer',
  'sustainable livelihood',
  'livelihood assistance',
  'student cash for work',
  'cash-for-work',
  'tara basa',
  'kalahi',
]

function guideSearchText(guide: Guide) {
  return [
    guide.slug,
    guide.title_en,
    guide.title_fil,
    guide.tagline_en,
    guide.tagline_fil,
    guide.keywords_en,
    guide.keywords_fil,
    ...(guide.tags || []),
  ]
    .filter(Boolean)
    .join(' ')
    .toLowerCase()
}

export function isGovernmentAidGuide(guide: Guide) {
  const searchText = guideSearchText(guide)

  return GOVERNMENT_AID_TERMS.some((term) => searchText.includes(term))
}
