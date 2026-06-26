import { trustShieldRules } from './rules'
import type { TrustDecision, TrustScenarioId } from './types'

type Language = 'en' | 'fil'

export function evaluateTrustScenario(
  scenarioId: TrustScenarioId,
  language: Language
): TrustDecision | null {
  const rule = trustShieldRules.find((item) => item.id === scenarioId)

  if (!rule) {
    return null
  }

  const isFilipino = language === 'fil'

  return {
    situation: isFilipino ? rule.situation_fil : rule.situation_en,
    riskLevel: rule.riskLevel,
    why: isFilipino ? rule.why_fil : rule.why_en,
    warningSigns: isFilipino
      ? rule.warningSigns_fil
      : rule.warningSigns_en,
    recommendedAction: isFilipino
      ? rule.recommendedAction_fil
      : rule.recommendedAction_en,
    relatedGuides: rule.relatedGuides,
    sources: isFilipino ? rule.sources_fil : rule.sources_en,
    recoverySteps: isFilipino
      ? rule.recoverySteps_fil
      : rule.recoverySteps_en,
    shareText: isFilipino ? rule.shareText_fil : rule.shareText_en,
  }
}
