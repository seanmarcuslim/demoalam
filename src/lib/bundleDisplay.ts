import type { GuideBundle, GuideBundleItem } from '../types/bundle'
import type { Language } from '../utils/translations'

export function getBundleTitle(item: GuideBundle, language: Language) {
  return language === 'fil' ? item.title_fil : item.title_en
}

export function getBundleDescription(item: GuideBundle, language: Language) {
  return language === 'fil' ? item.description_fil : item.description_en
}

export function getBundleItemReason(item: GuideBundleItem, language: Language) {
  return language === 'fil' ? item.reason_fil : item.reason_en
}

export function getBundleItemGuideTitle(item: GuideBundleItem, language: Language) {
  return language === 'fil' ? item.guide?.title_fil : item.guide?.title_en
}
