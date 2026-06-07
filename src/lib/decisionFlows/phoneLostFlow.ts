export type FlowLanguage = 'en' | 'fil'

export type PhoneLostQuestionId =
  | 'situation'
  | 'sim'
  | 'financial'
  | 'email'
  | 'tracking'
  | 'contacted'
  | 'other_items'

export type PhoneLostOutcomeId =
  | 'sim_otp_risk'
  | 'financial_access_risk'
  | 'account_recovery_risk'
  | 'device_tracking_option'
  | 'scam_recovery_risk'
  | 'wallet_atm_id_risk'
  | 'mixed_risk'

export type PhoneLostPriority = 'HIGH' | 'MEDIUM'

export interface PhoneLostOption {
  id: string
  label_en: string
  label_fil: string
}

export interface PhoneLostQuestion {
  id: PhoneLostQuestionId
  question_en: string
  question_fil: string
  options: PhoneLostOption[]
}

export interface PhoneLostOutcome {
  id: PhoneLostOutcomeId
  priority: PhoneLostPriority
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

export type PhoneLostAnswers = Partial<Record<PhoneLostQuestionId, string>>

export interface PhoneLostResult {
  outcome: PhoneLostOutcome
  reason_en: string[]
  reason_fil: string[]
}

export const phoneLostFlow = {
  slug: 'phone-lost',
  title_en: 'Phone lost or stolen? Start here.',
  title_fil: 'Nawala o nanakaw ang phone? Dito magsimula.',
  intro_en:
    'Choose the safest first step. Do not chase the phone or meet strangers. Protect yourself and your accounts first.',
  intro_fil:
    'Piliin ang pinakaligtas na unang hakbang. Huwag habulin ang phone o makipagkita sa hindi kilala. Unahin ang kaligtasan at account access.',
  entry_title_en: 'Lost or stolen phone?',
  entry_title_fil: 'Nawala o nanakaw ang phone?',
  entry_body_en: 'Answer a few quick questions to know what to secure first.',
  entry_body_fil:
    'Sagutin ang ilang mabilis na tanong para malaman kung ano ang uunahin.',
  cta_en: 'Start quick check',
  cta_fil: 'Simulan ang mabilisang check',
  questions: [
    {
      id: 'situation',
      question_en: 'What best describes the situation?',
      question_fil: 'Ano ang pinakatugma sa nangyari?',
      options: [
        {
          id: 'stolen',
          label_en: 'I think it was stolen',
          label_fil: 'Sa tingin ko nanakaw',
        },
        {
          id: 'lost',
          label_en: 'I lost it and cannot find it',
          label_fil: 'Nawala at hindi ko mahanap',
        },
        {
          id: 'not_sure',
          label_en: 'I am not sure',
          label_fil: 'Hindi ako sigurado',
        },
      ],
    },
    {
      id: 'sim',
      question_en: 'Was your SIM inside the missing phone?',
      question_fil: 'Nasa nawalang phone ba ang SIM mo?',
      options: [
        {
          id: 'yes',
          label_en: 'Yes',
          label_fil: 'Oo',
        },
        {
          id: 'no',
          label_en: 'No, I still have the SIM',
          label_fil: 'Hindi, nasa akin pa ang SIM',
        },
        {
          id: 'not_sure',
          label_en: 'I am not sure',
          label_fil: 'Hindi ako sigurado',
        },
      ],
    },
    {
      id: 'financial',
      question_en:
        'Were GCash, Maya, bank apps, or cards on that phone?',
      question_fil:
        'May GCash, Maya, bank apps, o cards ba roon?',
      options: [
        {
          id: 'yes',
          label_en: 'Yes',
          label_fil: 'Oo',
        },
        {
          id: 'no',
          label_en: 'No',
          label_fil: 'Wala',
        },
        {
          id: 'not_sure',
          label_en: 'I am not sure',
          label_fil: 'Hindi ako sigurado',
        },
      ],
    },
    {
      id: 'email',
      question_en: 'Can you still access your email or recovery account?',
      question_fil: 'May access ka pa ba sa email o recovery account mo?',
      options: [
        {
          id: 'yes',
          label_en: 'Yes',
          label_fil: 'Oo',
        },
        {
          id: 'no',
          label_en: 'No',
          label_fil: 'Wala',
        },
        {
          id: 'not_sure',
          label_en: 'I am not sure',
          label_fil: 'Hindi ako sigurado',
        },
      ],
    },
    {
      id: 'tracking',
      question_en: 'Can you safely use phone tracking?',
      question_fil:
        'Magagamit mo ba nang ligtas ang phone tracking?',
      options: [
        {
          id: 'yes',
          label_en: 'Yes',
          label_fil: 'Oo',
        },
        {
          id: 'no',
          label_en: 'No',
          label_fil: 'Hindi',
        },
        {
          id: 'dont_know',
          label_en: 'I do not know how',
          label_fil: 'Hindi ko alam paano',
        },
      ],
    },
    {
      id: 'contacted',
      question_en:
        'Did anyone ask for OTP, payment, password, or screenshots?',
      question_fil:
        'May humingi ba ng OTP, bayad, password, o screenshot?',
      options: [
        {
          id: 'yes',
          label_en: 'Yes',
          label_fil: 'Oo',
        },
        {
          id: 'no',
          label_en: 'No',
          label_fil: 'Wala',
        },
        {
          id: 'posted_online',
          label_en: 'I posted about the lost phone',
          label_fil: 'Nag-post ako tungkol sa nawalang phone',
        },
      ],
    },
    {
      id: 'other_items',
      question_en:
        'Were wallet, ATM card, IDs, or documents also lost?',
      question_fil:
        'Kasama bang nawala ang wallet, ATM card, IDs, o dokumento?',
      options: [
        {
          id: 'wallet_ids',
          label_en: 'Wallet or IDs were also lost',
          label_fil: 'Kasama ang wallet o IDs',
        },
        {
          id: 'atm_card',
          label_en: 'ATM or debit card was also lost',
          label_fil: 'Kasama ang ATM o debit card',
        },
        {
          id: 'no',
          label_en: 'No',
          label_fil: 'Hindi',
        },
        {
          id: 'not_sure',
          label_en: 'I am not sure',
          label_fil: 'Hindi ako sigurado',
        },
      ],
    },
  ] satisfies PhoneLostQuestion[],
  outcomes: {
    sim_otp_risk: {
      id: 'sim_otp_risk',
      priority: 'HIGH',
      title_en: 'SIM / OTP risk',
      title_fil: 'SIM / OTP risk',
      first_action_en: 'Secure your SIM and OTP access first.',
      first_action_fil: 'Unahin ang SIM at OTP access.',
      why_en:
        'Your SIM can control OTPs for GCash, Maya, banks, email, and password recovery.',
      why_fil:
        'Puwedeng kontrolin ng SIM ang OTP para sa GCash, Maya, bank, email, at password recovery.',
      primary_guide_slug: 'lost-sim-replacement-checklist',
      related_guide_slugs: [
        'phone-stolen-first-hour',
        'gcash-maya-account-recovery-first-hour',
        'phishing-link-checklist',
      ],
    },
    financial_access_risk: {
      id: 'financial_access_risk',
      priority: 'HIGH',
      title_en: 'Financial access risk',
      title_fil: 'Access sa pera',
      first_action_en: 'Lock down e-wallets, bank apps, and linked cards.',
      first_action_fil: 'I-lock muna ang e-wallets, bank apps, at linked cards.',
      why_en:
        'If someone can open your financial apps, they may attempt transfers, password resets, or OTP-based recovery.',
      why_fil:
        'Kung mabubuksan ng iba ang money apps mo, puwede nilang subukan ang transfers, password reset, o OTP recovery.',
      primary_guide_slug: 'gcash-maya-account-recovery-first-hour',
      related_guide_slugs: [
        'lost-atm-debit-card-checklist',
        'phishing-link-checklist',
        'phone-stolen-first-hour',
      ],
    },
    account_recovery_risk: {
      id: 'account_recovery_risk',
      priority: 'HIGH',
      title_en: 'Account recovery risk',
      title_fil: 'Account recovery',
      first_action_en:
        'Protect your email and recovery accounts before changing everything else.',
      first_action_fil:
        'Unahin ang email at recovery accounts bago baguhin ang iba.',
      why_en:
        'Email and recovery accounts can unlock passwords, e-wallets, bank alerts, and device sessions.',
      why_fil:
        'Puwedeng magamit ang email at recovery accounts para sa passwords, e-wallets, bank alerts, at bukas na device sessions.',
      primary_guide_slug: 'phone-stolen-first-hour',
      related_guide_slugs: [
        'gcash-maya-account-recovery-first-hour',
        'phishing-link-checklist',
      ],
    },
    device_tracking_option: {
      id: 'device_tracking_option',
      priority: 'MEDIUM',
      title_en: 'Device tracking option',
      title_fil: 'Device tracking',
      first_action_en:
        'Use device tracking safely, then lock the device if needed.',
      first_action_fil:
        'Gamitin nang ligtas ang tracking, pagkatapos i-lock ang device kung kailangan.',
      why_en:
        'Tracking may help if the phone is misplaced, but personal safety and account security still come first.',
      why_fil:
        'Makakatulong ang tracking kung naligaw lang ang phone, pero kaligtasan at account security pa rin ang uunahin.',
      primary_guide_slug: 'phone-stolen-first-hour',
      related_guide_slugs: [
        'lost-sim-replacement-checklist',
        'gcash-maya-account-recovery-first-hour',
      ],
      safety_warning_en:
        'Do not chase the phone or meet strangers. Protect yourself first.',
      safety_warning_fil:
        'Huwag habulin ang phone o makipagkita sa hindi kilala. Unahin ang sarili mong kaligtasan.',
    },
    scam_recovery_risk: {
      id: 'scam_recovery_risk',
      priority: 'HIGH',
      title_en: 'Scam / fake recovery risk',
      title_fil: 'Scam / pekeng recovery',
      first_action_en:
        'Do not send OTP, payment, password, screenshots, or ID details to recovery helpers.',
      first_action_fil:
        'Huwag magpadala ng OTP, bayad, password, screenshot, o detalye ng ID sa taong nag-aalok ng recovery.',
      why_en:
        'Fake recovery helpers often use lost-phone posts to steal accounts or ask for fees.',
      why_fil:
        'Madalas gamitin ng pekeng recovery helpers ang posts tungkol sa nawalang phone para magnakaw ng account o maningil ng bayad.',
      primary_guide_slug: 'phishing-link-checklist',
      related_guide_slugs: [
        'phone-stolen-first-hour',
        'gcash-maya-account-recovery-first-hour',
      ],
    },
    wallet_atm_id_risk: {
      id: 'wallet_atm_id_risk',
      priority: 'MEDIUM',
      title_en: 'Wallet / ATM / ID also lost',
      title_fil: 'Kasama ang wallet / ATM / ID',
      first_action_en:
        'After securing accounts, list missing items and block money access before replacing IDs.',
      first_action_fil:
        'Pagkatapos i-secure ang accounts, ilista ang nawala at i-block muna ang access sa pera.',
      why_en:
        'Money access can be misused quickly. ID replacement matters, but account security usually comes first.',
      why_fil:
        'Mabilis maabuso ang access sa pera. Mahalaga ang ID replacement, pero kadalasan account security muna.',
      primary_guide_slug: 'lost-wallet-first-steps',
      related_guide_slugs: [
        'lost-atm-debit-card-checklist',
        'national-id-problems-checklist',
        'phone-stolen-first-hour',
      ],
    },
    mixed_risk: {
      id: 'mixed_risk',
      priority: 'HIGH',
      title_en: 'Unsure / mixed risk',
      title_fil: 'Hindi sigurado / halo-halong risk',
      first_action_en:
        'Treat the phone as high-risk. Secure SIM, email, and financial access first.',
      first_action_fil:
        'Ituring muna na high-risk ang phone. Unahin ang SIM, email, at financial access.',
      why_en:
        'When details are unclear, the safer path is to protect the access points that can unlock other accounts.',
      why_fil:
        'Kapag hindi malinaw ang detalye, mas ligtas na unahin ang mga access point na puwedeng magbukas ng ibang account.',
      primary_guide_slug: 'phone-stolen-first-hour',
      related_guide_slugs: [
        'lost-sim-replacement-checklist',
        'gcash-maya-account-recovery-first-hour',
        'phishing-link-checklist',
      ],
    },
  } satisfies Record<PhoneLostOutcomeId, PhoneLostOutcome>,
}

const phoneLostIntentTerms = [
  'stolen phone',
  'phone stolen',
  'nanakaw phone',
  'nanakaw ang phone',
  'nanakaw cp',
  'nanakaw cellphone',
  'nawala phone',
  'nawala ang phone',
  'nawala cp',
  'nawala cellphone',
  'lost phone',
  'phone with gcash lost',
  'phone nawala',
  'di ko mahanap phone',
  'hindi ko mahanap phone',
  'lost sim',
  'otp phone stolen',
  'gcash hacked phone lost',
]

export function shouldShowPhoneLostFlow(query: string) {
  const cleanQuery = query.trim().toLowerCase().replace(/\s+/g, ' ')

  if (!cleanQuery) {
    return false
  }

  return phoneLostIntentTerms.some((term) => cleanQuery.includes(term))
}

export function getLocalizedValue(
  item: object,
  key: string,
  language: FlowLanguage
) {
  return (item as Record<string, string>)[`${key}_${language}`]
}

export function getPhoneLostOutcome(answers: PhoneLostAnswers): PhoneLostResult {
  const reason_en: string[] = []
  const reason_fil: string[] = []

  const situation = answers.situation
  const sim = answers.sim
  const financial = answers.financial
  const email = answers.email
  const tracking = answers.tracking
  const contacted = answers.contacted
  const otherItems = answers.other_items

  if (situation === 'stolen' || situation === 'not_sure') {
    reason_en.push('The phone may be stolen or high-risk.')
    reason_fil.push('Posibleng nanakaw o high-risk ang phone.')
  }

  if (sim === 'yes' || sim === 'not_sure') {
    reason_en.push('Your SIM may be inside the missing phone.')
    reason_fil.push('Posibleng nasa nawawalang phone ang SIM mo.')

    return {
      outcome: phoneLostFlow.outcomes.sim_otp_risk,
      reason_en,
      reason_fil,
    }
  }

  if (financial === 'yes' || financial === 'not_sure') {
    reason_en.push('GCash, Maya, bank apps, or saved cards may be connected.')
    reason_fil.push('Posibleng may GCash, Maya, bank apps, o cards na connected.')

    return {
      outcome: phoneLostFlow.outcomes.financial_access_risk,
      reason_en,
      reason_fil,
    }
  }

  if (email === 'no' || email === 'not_sure') {
    reason_en.push('Email or recovery account access may be at risk.')
    reason_fil.push('Posibleng at risk ang email o recovery account access.')

    return {
      outcome: phoneLostFlow.outcomes.account_recovery_risk,
      reason_en,
      reason_fil,
    }
  }

  if (contacted === 'yes' || contacted === 'posted_online') {
    reason_en.push('Someone may use the lost-phone situation for a recovery scam.')
    reason_fil.push('Puwedeng gamitin ng iba ang pagkawala ng phone para sa recovery scam.')

    return {
      outcome: phoneLostFlow.outcomes.scam_recovery_risk,
      reason_en,
      reason_fil,
    }
  }

  if (
    otherItems === 'wallet_ids' ||
    otherItems === 'atm_card' ||
    otherItems === 'not_sure'
  ) {
    reason_en.push('Other money access, IDs, or documents may also be missing.')
    reason_fil.push('Posibleng may ibang access sa pera, IDs, o dokumento na nawala rin.')

    return {
      outcome: phoneLostFlow.outcomes.wallet_atm_id_risk,
      reason_en,
      reason_fil,
    }
  }

  if (situation === 'lost' && tracking === 'yes') {
    reason_en.push('The phone may be misplaced and tracking is available.')
    reason_fil.push('Posibleng naligaw lang ang phone at available ang tracking.')

    return {
      outcome: phoneLostFlow.outcomes.device_tracking_option,
      reason_en,
      reason_fil,
    }
  }

  reason_en.push('The details are still unclear.')
  reason_fil.push('Hindi pa malinaw ang detalye.')

  return {
    outcome: phoneLostFlow.outcomes.mixed_risk,
    reason_en,
    reason_fil,
  }
}
