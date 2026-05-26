import { enTranslations } from './translations/en'
import { filTranslations } from './translations/fil'

export const translations = {
  fil: filTranslations,
  en: enTranslations,
}

export type Language = keyof typeof translations
