import type { Category } from '../types/category'
import type { Guide, GuideSection } from '../types/guide'
import type { Language, TranslationMessages } from '../utils/translations'

type GuideDetailLabels = TranslationMessages['guideDetail']

export function getGuideTitle(item: Guide, language: Language) {
  return language === 'fil' ? item.title_fil : item.title_en
}

export function getGuideTagline(item: Guide, language: Language) {
  return language === 'fil' ? item.tagline_fil : item.tagline_en
}

export function getGuideCategoryName(item: Category, language: Language) {
  return language === 'fil' ? item.name_fil : item.name_en
}

export function getGuideSectionContent(
  section: GuideSection,
  language: Language
) {
  return language === 'fil' ? section.content_fil : section.content_en
}

export function getGuideDifficultyLabel(
  value: string | null | undefined,
  labels: GuideDetailLabels
) {
  if (!value) {
    return labels.notSpecified
  }

  const normalized = value.toLowerCase()

  if (normalized === 'katamtaman') {
    return labels.moderate
  }

  if (normalized === 'madali') {
    return labels.easy
  }

  if (normalized === 'mahirap') {
    return labels.hard
  }

  return value
}

export function getGuideCostLabel(
  value: string | null | undefined,
  labels: GuideDetailLabels,
  language: Language
) {
  if (!value) {
    return labels.notSpecified
  }

  const normalized = value.toLowerCase()

  if (normalized === 'kadalasang libre') {
    return labels.usuallyFree
  }

  if (normalized === 'libre kung official') {
    return labels.freeOfficial
  }

  if (normalized.includes('depende')) {
    return language === 'fil' ? value : labels.dependsOnIssue
  }

  return value
}

export function getGuideTimeLabel(
  value: string | null | undefined,
  labels: GuideDetailLabels,
  language: Language
) {
  if (!value) {
    return labels.notSpecified
  }

  const normalized = value.toLowerCase()

  if (normalized.includes('depende')) {
    return language === 'fil' ? value : labels.dependsOnIssue
  }

  if (normalized.includes('minuto')) {
    return language === 'fil' ? value : value.replace('minuto', 'min')
  }

  return value
}

export function formatGuideUpdatedDate(
  value: string | null | undefined,
  labels: GuideDetailLabels,
  language: Language
) {
  if (!value) {
    return labels.unknown
  }

  try {
    return new Intl.DateTimeFormat(language === 'fil' ? 'fil-PH' : 'en-US', {
      month: 'short',
      day: 'numeric',
      year: 'numeric',
    }).format(new Date(value))
  } catch {
    return labels.unknown
  }
}
