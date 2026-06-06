export const SEARCH_SUGGESTIONS = [
  'nawala phone',
  'gcash scam',
  'kulang sahod',
  'pcso medical assistance',
  'valid id',
  'first job',
  'resume',
  'interview',
  'payroll',
  'emergency fund',
  'rent',
  'utility bills',
  'moving out',
  'loan app',
  'loan app harassment',
  'fake job',
  'wrong send gcash',
  'lost atm',
  'lost sim',
  'ayuda',
  'DSWD AICS',
  '4Ps',
  'Walang Gutom',
  'student aid',
  'livelihood',
  'social pension',
  'batas',
  'consumer rights',
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
    title_en: 'First job help',
    title_fil: 'Unang trabaho',
    subtitle_en: 'Resume, interview, requirements, payroll, and payday basics.',
    subtitle_fil: 'Resume, interview, requirements, payroll, at payday basics.',
    colorKey: 'success' as const,
    items: ['first job', 'resume', 'interview', 'job requirements', 'kulang sahod'],
  },
  {
    title_en: 'Money safety',
    title_fil: 'Safety sa pera',
    subtitle_en: 'Emergency fund, lost cards, wrong sends, and loan app pressure.',
    subtitle_fil: 'Emergency fund, nawalang card, maling send, at loan app pressure.',
    colorKey: 'primary' as const,
    items: ['emergency fund', 'lost atm', 'wrong send gcash', 'loan app harassment', 'payday'],
  },
  {
    title_en: 'Bills and home',
    title_fil: 'Bayarin at bahay',
    subtitle_en: 'Rent, utility bills, moving out, and first home decisions.',
    subtitle_fil: 'Upa, bills, pagbukod, at unang bahay.',
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
    subtitle_fil: 'Kapag pera, account, privacy, o reklamo ang problema.',
    colorKey: 'danger' as const,
    items: ['batas', 'consumer rights', 'data privacy act', 'lost sim', 'gcash scam'],
  },
  {
    title_en: 'Scam safety',
    title_fil: 'Iwas-scam',
    subtitle_en: 'Loan apps, fake recruiters, e-wallet scams, and phishing.',
    subtitle_fil: 'Loan app, pekeng recruiter, e-wallet scam, at phishing.',
    colorKey: 'danger' as const,
    items: ['loan app harassment', 'fake job', 'job scam', 'wrong send gcash', 'gcash scam'],
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
