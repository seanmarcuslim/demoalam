export type RiskLevel = 'LOW_RISK' | 'VERIFY_FIRST' | 'HIGH_RISK'

export type TrustScenarioId =
  | 'otp_request'
  | 'advance_payment'
  | 'suspicious_link'
  | 'bank_ewallet_message'

export type TrustDecision = {
  situation: string
  riskLevel: RiskLevel
  why: string
  warningSigns: string[]
  recommendedAction: string[]
  relatedGuides: string[]
  sources: string[]
  recoverySteps?: string[]
  shareText?: string
}

export type LocalizedTrustScenario = {
  id: TrustScenarioId
  label_en: string
  label_fil: string
  short_en: string
  short_fil: string
}

export type LocalizedTrustDecisionRule = {
  id: TrustScenarioId
  situation_en: string
  situation_fil: string
  riskLevel: RiskLevel
  why_en: string
  why_fil: string
  warningSigns_en: string[]
  warningSigns_fil: string[]
  recommendedAction_en: string[]
  recommendedAction_fil: string[]
  relatedGuides: string[]
  sources_en: string[]
  sources_fil: string[]
  recoverySteps_en?: string[]
  recoverySteps_fil?: string[]
  shareText_en?: string
  shareText_fil?: string
}
