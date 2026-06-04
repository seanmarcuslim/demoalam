import type { Category } from '../types/category'
import type { Guide, GuideSection } from '../types/guide'
import type { Language, TranslationMessages } from '../utils/translations'

type GuideDetailLabels = TranslationMessages['guideDetail']

const ENGLISH_FREE_COST_LABELS: Record<string, string> = {
  'libre': 'Free',
  'libre-300 pesos': 'Free-300 pesos',
  'libre mag-check': 'Free to check',
  'libre mag-report; possible towing, hospital, repair, or document costs':
    'Free to report; possible towing, hospital, repair, or document costs',
  'libre maghanda; hospital costs vary':
    'Free to prepare; hospital costs vary',
  'libre magtanong': 'Free to ask',
  'libre magtanong; depende ang bill sa provider':
    'Free to ask; bill depends on the provider',
  'libre magtanong; depende ang tulong sa assessment':
    'Free to ask; assistance depends on assessment',
  'libre magtanong; hospital costs vary':
    'Free to ask; hospital costs vary',
  'libre magtanong; iba-iba ang gastos sa ospital':
    'Free to ask; hospital costs vary',
  'libre magtanong; presyo depende sa gamot':
    'Free to ask; medicine price depends on the item',
  'karaniwang libre magtanong; fees may vary by document request':
    'Usually free to ask; fees may vary by document request',
  'libre; kahit maliit na hulog ay puwedeng simulan':
    'Free; you can start even with a small contribution',
  'libre ang application; posibleng may gastos sa photocopy, scan, print, pamasahe, o internet data':
    'Application is free; possible costs for photocopying, scanning, printing, transport, or internet data',
  'libre kung official': 'Free through official channels',
  'libre maliban sa printing, pamasahe, o affidavit kung kailangan':
    'Free, except for printing, transport, or affidavit costs if needed',
  'libre o may possible replacement, notarization, pamasahe, call, o data cost depende sa telco':
    'Free or possible replacement, notarization, transport, call, or data costs depending on the telco',
  'libre, maliban sa call, pamasahe, printing, o internet data':
    'Free, except for calls, transport, printing, or internet data',
  'libre, maliban sa call, pamasahe, sim replacement, affidavit, o data':
    'Free, except for calls, transport, SIM replacement, affidavit, or data',
  'libre, maliban sa internet data o tawag':
    'Free, except for internet data or calls',
  'libre, maliban sa internet data o tawag kung magve-verify':
    'Free, except for internet data or calls when verifying',
  'libre, maliban sa printing, pamasahe, o document fees kung kailangan':
    'Free, except for printing, transport, or document fees if needed',
  'libre, maliban sa printing, pamasahe, o internet data':
    'Free, except for printing, transport, or internet data',
  'libre, maliban sa printing, pamasahe, o legal/document fees kung kailangan':
    'Free, except for printing, transport, or legal/document fees if needed',
  'libre, maliban sa printing, pamasahe, tawag, o internet data kung kailangan':
    'Free, except for printing, transport, calls, or internet data if needed',
}

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

  if (language === 'en') {
    const englishFreeLabel = ENGLISH_FREE_COST_LABELS[normalized]

    if (englishFreeLabel) {
      return englishFreeLabel
    }
  }

  if (normalized === 'libre') {
    return language === 'fil' ? 'Libre' : 'Free'
  }

  if (normalized === 'kadalasang libre') {
    return labels.usuallyFree
  }

  if (normalized === 'libre kung official') {
    return labels.freeOfficial
  }

  if (normalized.includes('depende')) {
    return language === 'fil' ? value : labels.dependsOnIssue
  }

  if (language === 'en' && normalized.includes('libre')) {
    return value.replace(/libre/gi, 'Free')
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
