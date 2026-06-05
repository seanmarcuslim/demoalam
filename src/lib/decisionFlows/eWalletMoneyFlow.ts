export type EWalletFlowLanguage = 'en' | 'fil'

export type EWalletMoneyOptionId =
  | 'wrong_send'
  | 'suspicious_link_otp'
  | 'unauthorized_transaction'
  | 'lost_access'
  | 'loan_harassment'
  | 'not_sure'

export type EWalletMoneyOutcomeId =
  | 'wrong_send_risk'
  | 'phishing_scam_risk'
  | 'unauthorized_transaction_risk'
  | 'account_access_risk'
  | 'loan_harassment_risk'
  | 'unknown_high_risk'

export type EWalletMoneyPriority = 'HIGH' | 'MEDIUM'

export interface EWalletMoneyOption {
  id: EWalletMoneyOptionId
  label_en: string
  label_fil: string
}

export interface EWalletMoneyQuestion {
  id: 'problem'
  question_en: string
  question_fil: string
  options: EWalletMoneyOption[]
}

export interface EWalletMoneyOutcome {
  id: EWalletMoneyOutcomeId
  priority: EWalletMoneyPriority
  title_en: string
  title_fil: string
  first_action_en: string
  first_action_fil: string
  why_en: string
  why_fil: string
  primary_guide_slug: string
  related_guide_slugs: string[]
  safety_warning_en?: string
  safety_warning_fil?: string
}

export interface EWalletMoneyResult {
  outcome: EWalletMoneyOutcome
  reason_en: string[]
  reason_fil: string[]
}

export const eWalletMoneyFlow = {
  slug: 'ewallet-money',
  title_en: 'GCash or Maya money problem? Start here.',
  title_fil: 'May problema sa GCash o Maya? Dito magsimula.',
  intro_en:
    'Pick what happened so DemoAlam can route you to the safest first step.',
  intro_fil:
    'Piliin ang nangyari para ma-route ka sa pinakaligtas na unang hakbang.',
  entry_title_en: 'GCash or Maya problem?',
  entry_title_fil: 'Problema sa GCash o Maya?',
  entry_body_en: 'Use one quick question to find the right first step.',
  entry_body_fil:
    'Gumamit ng isang mabilis na tanong para mahanap ang tamang unang hakbang.',
  cta_en: 'Start money check',
  cta_fil: 'Simulan ang money check',
  question: {
    id: 'problem',
    question_en: 'What best describes the problem?',
    question_fil: 'Ano ang pinakatugma sa problema?',
    options: [
      {
        id: 'wrong_send',
        label_en: 'I sent money to the wrong person',
        label_fil: 'Nakapag-send ako sa maling tao',
      },
      {
        id: 'suspicious_link_otp',
        label_en: 'I clicked a link or gave OTP/MPIN',
        label_fil: 'Nag-click ako ng link o nagbigay ng OTP/MPIN',
      },
      {
        id: 'unauthorized_transaction',
        label_en: 'I saw a transaction I did not make',
        label_fil: 'May transaction na hindi ako ang gumawa',
      },
      {
        id: 'lost_access',
        label_en: 'I cannot access my GCash/Maya account',
        label_fil: 'Hindi ko ma-access ang GCash/Maya account ko',
      },
      {
        id: 'loan_harassment',
        label_en: 'Someone is threatening me about a loan app',
        label_fil: 'May nananakot tungkol sa loan app',
      },
      {
        id: 'not_sure',
        label_en: 'I am not sure',
        label_fil: 'Hindi ako sigurado',
      },
    ],
  } satisfies EWalletMoneyQuestion,
  outcomes: {
    wrong_send_risk: {
      id: 'wrong_send_risk',
      priority: 'MEDIUM',
      title_en: 'Wrong-send risk',
      title_fil: 'Wrong-send risk',
      first_action_en:
        'Save transaction details and use official support channels.',
      first_action_fil:
        'I-save ang transaction details at gamitin ang official support channels.',
      why_en:
        'A mistaken transfer needs proof, calm contact if safe, and the correct official help path.',
      why_fil:
        'Kailangan ng proof, mahinahong contact kung safe, at tamang official help path kapag maling send.',
      primary_guide_slug: 'wrong-send-gcash-checklist',
      related_guide_slugs: [
        'gcash-scam-red-flags',
        'gcash-maya-account-recovery-first-hour',
      ],
    },
    phishing_scam_risk: {
      id: 'phishing_scam_risk',
      priority: 'HIGH',
      title_en: 'Scam / phishing risk',
      title_fil: 'Scam / phishing risk',
      first_action_en:
        'Stop communicating with the sender and secure account access.',
      first_action_fil:
        'Huminto sa pakikipag-usap sa sender at i-secure ang account access.',
      why_en:
        'OTP, MPIN, fake links, and fake support can expose your account or money access.',
      why_fil:
        'Puwedeng ma-expose ang account o money access dahil sa OTP, MPIN, fake links, at fake support.',
      primary_guide_slug: 'phishing-link-checklist',
      related_guide_slugs: [
        'gcash-scam-red-flags',
        'gcash-maya-account-recovery-first-hour',
      ],
      safety_warning_en:
        'Do not send OTP, MPIN, password, screenshots, or recovery fees.',
      safety_warning_fil:
        'Huwag mag-send ng OTP, MPIN, password, screenshots, o recovery fee.',
    },
    unauthorized_transaction_risk: {
      id: 'unauthorized_transaction_risk',
      priority: 'HIGH',
      title_en: 'Unauthorized transaction risk',
      title_fil: 'Unauthorized transaction risk',
      first_action_en:
        'Secure access before focusing on the missing money.',
      first_action_fil:
        'I-secure muna ang access bago habulin ang nawawalang pera.',
      why_en:
        'Money moved without your permission may mean someone can still access the account.',
      why_fil:
        'Kung gumalaw ang pera nang wala kang pahintulot, posibleng may access pa ang iba sa account.',
      primary_guide_slug: 'gcash-maya-account-recovery-first-hour',
      related_guide_slugs: [
        'phishing-link-checklist',
        'gcash-scam-red-flags',
      ],
    },
    account_access_risk: {
      id: 'account_access_risk',
      priority: 'HIGH',
      title_en: 'Account access risk',
      title_fil: 'Account access risk',
      first_action_en:
        'Secure SIM, email, password, MPIN, and recovery channels.',
      first_action_fil:
        'I-secure ang SIM, email, password, MPIN, at recovery channels.',
      why_en:
        'Lost access can involve SIM, email, password, MPIN, device, or support recovery steps.',
      why_fil:
        'Puwedeng konektado sa SIM, email, password, MPIN, device, o support recovery steps ang lost access.',
      primary_guide_slug: 'gcash-maya-account-recovery-first-hour',
      related_guide_slugs: [
        'phishing-link-checklist',
        'lost-sim-replacement-checklist',
      ],
    },
    loan_harassment_risk: {
      id: 'loan_harassment_risk',
      priority: 'HIGH',
      title_en: 'Loan harassment risk',
      title_fil: 'Loan harassment risk',
      first_action_en:
        'Preserve evidence and avoid panic payments or unsafe replies.',
      first_action_fil:
        'Mag-save ng ebidensya at iwasan ang panic payment o unsafe replies.',
      why_en:
        'Threats, public shaming, fake legal messages, and abusive collection need clean evidence.',
      why_fil:
        'Kailangan ng maayos na ebidensya kapag may threats, public shaming, fake legal messages, o abusive collection.',
      primary_guide_slug: 'loan-app-harassment-evidence-checklist',
      related_guide_slugs: [
        'loan-red-flags-before-borrowing',
        'office-help-message-checklist',
      ],
    },
    unknown_high_risk: {
      id: 'unknown_high_risk',
      priority: 'HIGH',
      title_en: 'Unsure / possible account risk',
      title_fil: 'Hindi sigurado / possible account risk',
      first_action_en:
        'Treat it as possible account compromise until proven otherwise.',
      first_action_fil:
        'Ituring muna itong possible account compromise hangga\'t hindi pa malinaw.',
      why_en:
        'When details are unclear, the safer path is to secure access before chasing refunds.',
      why_fil:
        'Kapag hindi malinaw ang details, mas ligtas na i-secure muna ang access bago habulin ang refund.',
      primary_guide_slug: 'gcash-maya-account-recovery-first-hour',
      related_guide_slugs: [
        'phishing-link-checklist',
        'gcash-scam-red-flags',
      ],
    },
  } satisfies Record<EWalletMoneyOutcomeId, EWalletMoneyOutcome>,
}

const eWalletMoneyIntentTerms = [
  'gcash scam',
  'maya scam',
  'wrong send gcash',
  'wrong send maya',
  'gcash hacked',
  'maya hacked',
  'unauthorized transaction',
  'otp scam',
  'clicked suspicious link',
  'fake gcash support',
  'gcash recovery',
  'maya recovery',
  'money disappeared',
  'nawala pera',
  'nawala pera sa gcash',
  'nawala pera sa maya',
  'nabawas pera',
  'nabawas gcash',
  'nabawas maya',
  'nawala gcash',
  'nawala maya',
  'na scam sa gcash',
  'na scam sa maya',
  'hindi ko mabuksan gcash',
  'hindi ko mabuksan maya',
  'di ko mabuksan gcash',
  'di ko mabuksan maya',
  'hindi ko maopen gcash',
  'hindi ko maopen maya',
  'di ko maopen gcash',
  'di ko maopen maya',
  'may kumuha ng pera',
  'may kumuha ng pera sa gcash',
  'may kumuha ng pera sa maya',
]

const optionOutcomeMap: Record<EWalletMoneyOptionId, EWalletMoneyOutcomeId> = {
  wrong_send: 'wrong_send_risk',
  suspicious_link_otp: 'phishing_scam_risk',
  unauthorized_transaction: 'unauthorized_transaction_risk',
  lost_access: 'account_access_risk',
  loan_harassment: 'loan_harassment_risk',
  not_sure: 'unknown_high_risk',
}

export function shouldShowEWalletMoneyFlow(query: string) {
  const cleanQuery = query.trim().toLowerCase().replace(/\s+/g, ' ')

  if (!cleanQuery) {
    return false
  }

  return eWalletMoneyIntentTerms.some((term) => cleanQuery.includes(term))
}

export function getEWalletMoneyOutcome(
  optionId: EWalletMoneyOptionId
): EWalletMoneyResult {
  const outcomeId = optionOutcomeMap[optionId]
  const outcome = eWalletMoneyFlow.outcomes[outcomeId]
  const option = eWalletMoneyFlow.question.options.find(
    (item) => item.id === optionId
  )

  return {
    outcome,
    reason_en: option ? [`You selected: ${option.label_en}`] : [],
    reason_fil: option ? [`Pinili mo: ${option.label_fil}`] : [],
  }
}

export function getEWalletLocalizedValue(
  item: object,
  key: string,
  language: EWalletFlowLanguage
) {
  return (item as Record<string, string>)[`${key}_${language}`]
}
