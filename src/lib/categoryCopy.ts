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
    fil: 'Valid IDs, document recovery, at first-time requirements',
    accent: '#2563A9',
  },
  work: {
    en: 'Job hunting, requirements, interviews, and workplace basics',
    fil: 'Trabaho, requirements, interview, at workplace basics',
    accent: '#267A4D',
  },
  money: {
    en: 'Banking, e-wallets, loans, fees, benefits, and cash aid',
    fil: 'Bank, e-wallets, utang, fees, benefits, at cash aid',
    accent: '#D9902F',
  },
  gov: {
    en: 'DSWD aid, benefits, forms, offices, and appointments',
    fil: 'DSWD ayuda, benefits, forms, opisina, at appointments',
    accent: '#6D5BA8',
  },
  healthcare: {
    en: 'Medical access, PhilHealth, hospital documents, and patient support',
    fil: 'Medical access, PhilHealth, hospital documents, at patient support',
    accent: '#2F8F83',
  },
  education: {
    en: 'Scholarships, school documents, DSWD student aid, and pathways',
    fil: 'Scholarships, school documents, DSWD student aid, at pathways',
    accent: '#4F73C7',
  },
  scams: {
    en: 'Red flags before sending money, OTPs, or personal information',
    fil: 'Warning signs bago magpadala ng pera, OTP, o personal info',
    accent: '#C83E3A',
  },
  'digital-safety': {
    en: 'Protect accounts, e-wallets, passwords, phones, and online identity',
    fil: 'Proteksyon sa accounts, e-wallets, passwords, phone, at online identity',
    accent: '#3A7CA5',
  },
  emergency: {
    en: 'Fast actions for urgent documents, safety, and help',
    fil: 'Mabilis na steps para sa urgent documents, safety, at tulong',
    accent: '#B86B16',
  },
  adulting: {
    en: 'Practical life tasks no one explained clearly',
    fil: 'Practical life tasks na bihirang ipaliwanag nang malinaw',
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
