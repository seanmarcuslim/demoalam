import type { Category, CategoryCopy } from '../types/category'
import type { Language, TranslationMessages } from '../utils/translations'

type CategorySignalKey =
  keyof TranslationMessages['categoriesScreen']['signals']

type CategorySignalTone = 'priority' | 'urgent'

interface CategorySignal {
  labelKey: CategorySignalKey
  tone: CategorySignalTone
}

export const CATEGORY_COPY: Record<string, CategoryCopy> = {
  ids: {
    en: 'Valid IDs, document recovery, and first-time requirements',
    fil: 'Valid IDs, pagbawi ng dokumento, at unang requirements',
    accent: '#2563A9',
  },
  work: {
    en: 'Job hunting, requirements, interviews, and workplace basics',
    fil: 'Trabaho, requirements, interview, at workplace basics',
    accent: '#267A4D',
  },
  money: {
    en: 'Banking, e-wallets, loans, fees, benefits, and cash aid',
    fil: 'Bank, e-wallets, utang, fees, benepisyo, at ayuda',
    accent: '#D9902F',
  },
  gov: {
    en: 'DSWD aid, benefits, forms, offices, and appointments',
    fil: 'DSWD ayuda, benepisyo, forms, opisina, at schedule',
    accent: '#6D5BA8',
  },
  healthcare: {
    en: 'Medical access, PhilHealth, hospital documents, and patient support',
    fil: 'Medical access, PhilHealth, hospital documents, at tulong sa pasyente',
    accent: '#2F8F83',
  },
  education: {
    en: 'Scholarships, school documents, DSWD student aid, and pathways',
    fil: 'Scholarships, school documents, DSWD student aid, at school options',
    accent: '#4F73C7',
  },
  scams: {
    en: 'Red flags before sending money, OTPs, or personal information',
    fil: 'Mga babala bago magpadala ng pera, OTP, o personal na impormasyon',
    accent: '#C83E3A',
  },
  'digital-safety': {
    en: 'Protect accounts, e-wallets, passwords, phones, and online identity',
    fil: 'Proteksyon sa accounts, e-wallets, passwords, phone, at online identity',
    accent: '#3A7CA5',
  },
  emergency: {
    en: 'Fast actions for urgent documents, safety, and help',
    fil: 'Mabilis na hakbang para sa urgent na dokumento, safety, at tulong',
    accent: '#B86B16',
  },
  adulting: {
    en: 'Practical life tasks no one explained clearly',
    fil: 'Praktikal na gawain na bihirang ipaliwanag nang malinaw',
    accent: '#2F8277',
  },
}

export const CATEGORY_SIGNALS: Record<string, CategorySignal> = {
  gov: {
    labelKey: 'highImpact',
    tone: 'priority',
  },
  money: {
    labelKey: 'highImpact',
    tone: 'priority',
  },
  healthcare: {
    labelKey: 'highImpact',
    tone: 'priority',
  },
  education: {
    labelKey: 'highImpact',
    tone: 'priority',
  },
  'digital-safety': {
    labelKey: 'protection',
    tone: 'priority',
  },
  scams: {
    labelKey: 'warning',
    tone: 'urgent',
  },
  emergency: {
    labelKey: 'urgent',
    tone: 'urgent',
  },
}

const CATEGORY_RECOMMENDATIONS: Record<string, string[]> = {
  ids: ['gov', 'work'],
  work: ['ids', 'money'],
  money: ['gov', 'scams'],
  gov: ['ids', 'healthcare'],
  healthcare: ['gov', 'emergency'],
  education: ['work', 'gov'],
  scams: ['digital-safety', 'money'],
  'digital-safety': ['scams', 'emergency'],
  emergency: ['healthcare', 'digital-safety'],
  adulting: ['money', 'work'],
}

export function getCategoryName(category: Category, language: Language) {
  return language === 'fil' ? category.name_fil : category.name_en
}

export function getCategorySecondaryName(
  category: Category,
  language: Language
) {
  return language === 'fil' ? category.name_en : category.name_fil
}

export function getCategoryDescription(
  category: Category,
  language: Language,
  fallbackDescription: string
) {
  const copy = CATEGORY_COPY[category.slug]

  if (!copy) {
    return fallbackDescription
  }

  return language === 'fil' ? copy.fil : copy.en
}

export function getCategorySignal(
  category: Category,
  labels: TranslationMessages['categoriesScreen']
) {
  const signal = CATEGORY_SIGNALS[category.slug]

  if (!signal) {
    return null
  }

  return {
    label: labels.signals[signal.labelKey],
    tone: signal.tone,
  }
}

export function getSuggestedCategories(
  currentCategory: Category | undefined,
  categories: Category[]
) {
  const currentSlug = currentCategory?.slug

  if (!currentSlug) {
    return []
  }

  const slugs = CATEGORY_RECOMMENDATIONS[currentSlug] || []

  return slugs
    .map((slug) => categories.find((category) => category.slug === slug))
    .filter((category): category is Category => Boolean(category))
}
