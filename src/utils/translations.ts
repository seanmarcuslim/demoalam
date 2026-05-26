import { enTranslations } from './translations/en'
import { filTranslations } from './translations/fil'

export type TranslationMessages = typeof enTranslations

export const translations = {
  fil: filTranslations,
  en: enTranslations,
} satisfies Record<'fil' | 'en', TranslationMessages>

export type Language = keyof typeof translations
