export const SEARCH_SUGGESTIONS = [
  'first job',
  'resume',
  'interview',
  'payroll',
  'rent',
  'utility bills',
  'moving out',
  'loan app',
  'fake job',
  'ayuda',
  'DSWD AICS',
  '4Ps',
  'Walang Gutom',
  'student aid',
  'livelihood',
  'social pension',
  'batas',
  'consumer rights',
  'gcash scam',
]

export type SearchSuggestionGroup = {
  title_en: string
  title_fil: string
  subtitle_en: string
  subtitle_fil: string
  colorKey: 'success' | 'accent' | 'primary' | 'danger'
  items: string[]
}

export function getSuggestionGroupTitle(group: SearchSuggestionGroup, language: 'en' | 'fil') {
  return language === 'fil' ? group.title_fil : group.title_en
}

export function getSuggestionGroupSubtitle(group: SearchSuggestionGroup, language: 'en' | 'fil') {
  return language === 'fil' ? group.subtitle_fil : group.subtitle_en
}

export const SEARCH_SUGGESTION_GROUPS: SearchSuggestionGroup[] = [
  {
    title_en: 'First job flow',
    title_fil: 'Unang trabaho',
    subtitle_en: 'Resume, interview, requirements, payroll, and payday basics.',
    subtitle_fil: 'Resume, interview, requirements, payroll, at payday basics.',
    colorKey: 'success' as const,
    items: ['first job', 'resume', 'interview', 'job requirements', 'payroll'],
  },
  {
    title_en: 'Adulting basics',
    title_fil: 'Adulting basics',
    subtitle_en: 'Rent, utility bills, moving out, and first home decisions.',
    subtitle_fil: 'Rent, utility bills, pagbukod, at first home decisions.',
    colorKey: 'accent' as const,
    items: ['rent', 'utility bills', 'moving out', 'kuryente', 'tubig'],
  },
  {
    title_en: 'Aid & benefits',
    title_fil: 'Ayuda at benefits',
    subtitle_en: 'Start here for DSWD, cash assistance, and public programs.',
    subtitle_fil: 'Unahin ito para sa DSWD, cash assistance, at public programs.',
    colorKey: 'primary' as const,
    items: ['ayuda', 'DSWD AICS', '4Ps', 'Walang Gutom', 'social pension'],
  },
  {
    title_en: 'Rights & protection',
    title_fil: 'Karapatan at proteksyon',
    subtitle_en: 'Useful when money, accounts, privacy, or complaints are involved.',
    subtitle_fil: 'Useful kapag pera, account, privacy, o reklamo ang involved.',
    colorKey: 'danger' as const,
    items: ['batas', 'consumer rights', 'data privacy act', 'gcash scam'],
  },
  {
    title_en: 'Scam checks',
    title_fil: 'Scam checks',
    subtitle_en: 'Loan apps, fake recruiters, e-wallet scams, and phishing.',
    subtitle_fil: 'Loan apps, fake recruiters, e-wallet scams, at phishing.',
    colorKey: 'danger' as const,
    items: ['loan app', 'fake job', 'job scam', 'recruiter', 'gcash scam'],
  },
  {
    title_en: 'Student & livelihood',
    title_fil: 'Student at kabuhayan',
    subtitle_en: 'Find education aid, cash-for-work, and livelihood support.',
    subtitle_fil: 'Hanapin ang education aid, cash-for-work, at kabuhayan support.',
    colorKey: 'accent' as const,
    items: ['student aid', 'livelihood', 'scholarship', 'cash-for-work'],
  },
]
