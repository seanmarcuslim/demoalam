import type { Guide } from '../types/guide'

function toSearchTerms(query: string) {
  return query
    .toLowerCase()
    .split(/\s+/)
    .map((term) => term.trim())
    .filter((term) => term.length > 0)
}

const SEARCH_ALIASES: Record<string, string[]> = {
  ayuda: [
    'dswd',
    'aics',
    'assistance',
    'cash assistance',
    'financial aid',
    'benefits',
    'social pension',
    '4ps',
    'walang gutom',
    'emergency cash transfer',
    'livelihood',
  ],
  aid: [
    'ayuda',
    'assistance',
    'dswd',
    'aics',
    'benefits',
    'cash assistance',
    'financial aid',
  ],
  assistance: [
    'ayuda',
    'dswd',
    'aics',
    'cash assistance',
    'financial aid',
    'social pension',
  ],
  benefits: [
    'ayuda',
    'assistance',
    'dswd',
    '4ps',
    'social pension',
    'philhealth',
    'pagibig',
    'sss',
  ],
  dswd: [
    'ayuda',
    'aics',
    '4ps',
    'walang gutom',
    'social pension',
    'emergency cash transfer',
    'sustainable livelihood',
    'student cash for work',
  ],
  aics: [
    'dswd',
    'ayuda',
    'cash assistance',
    'medical assistance',
    'educational assistance',
    'burial assistance',
    'transportation assistance',
  ],
  pension: [
    'social pension',
    'senior citizen',
    'elderly',
    'older persons',
    'dswd',
  ],
  senior: [
    'social pension',
    'senior citizen',
    'elderly',
    'older persons',
    'dswd',
  ],
  gutom: [
    'walang gutom',
    'food credits',
    'food stamp',
    'dswd',
    'beneficiary',
  ],
  food: [
    'walang gutom',
    'food credits',
    'food stamp',
    'dswd',
  ],
  livelihood: [
    'sustainable livelihood',
    'slp',
    'negosyo',
    'capital',
    'employment',
    'dswd',
  ],
  negosyo: [
    'livelihood',
    'sustainable livelihood',
    'slp',
    'capital',
    'dswd',
  ],
  student: [
    'student aid',
    'cash-for-work',
    'cash for work',
    'tara basa',
    'educational assistance',
    'scholarship',
    'dswd',
  ],
  estudyante: [
    'student',
    'student aid',
    'cash-for-work',
    'educational assistance',
    'scholarship',
    'dswd',
  ],
  calamity: [
    'disaster',
    'emergency cash transfer',
    'ect',
    'evacuation',
    'relief',
    'dswd',
  ],
  disaster: [
    'calamity',
    'emergency cash transfer',
    'ect',
    'evacuation',
    'relief',
    'dswd',
  ],
  '4ps': [
    'pantawid',
    'pantawid pamilya',
    'conditional cash transfer',
    'household validation',
    'dswd',
  ],
  national: [
    'national id',
    'philsys',
    'philid',
    'ephilid',
    'digital national id',
    'trn',
    'valid id',
  ],
  philsys: [
    'national id',
    'philid',
    'ephilid',
    'digital national id',
    'trn',
    'transaction reference number',
  ],
  philid: [
    'national id',
    'philsys',
    'ephilid',
    'digital national id',
    'trn',
  ],
  ephilid: [
    'national id',
    'philsys',
    'philid',
    'digital national id',
    'valid id',
  ],
  trn: [
    'transaction reference number',
    'national id',
    'philsys',
    'philid',
    'registration slip',
  ],
  otp: [
    'phishing',
    'scam',
    'mpin',
    'password',
    'account takeover',
    'stolen phone',
    'sim',
  ],
  mpin: [
    'otp',
    'phishing',
    'scam',
    'password',
    'gcash',
    'maya',
  ],
  sim: [
    'otp',
    'stolen phone',
    'lost phone',
    'phone stolen',
    'account access',
  ],
  phone: [
    'stolen phone',
    'lost phone',
    'sim',
    'otp',
    'gcash',
    'maya',
  ],
  nanakaw: [
    'stolen',
    'stolen phone',
    'lost phone',
    'phone stolen',
    'wallet',
  ],
  trabaho: [
    'work',
    'job',
    'first job',
    'requirements',
    'resume',
    'interview',
    'sss',
    'payroll',
  ],
  work: [
    'trabaho',
    'job',
    'first job',
    'requirements',
    'resume',
    'interview',
    'payroll',
  ],
  job: [
    'trabaho',
    'work',
    'first job',
    'requirements',
    'resume',
    'interview',
    'payroll',
  ],
  resume: [
    'cv',
    'biodata',
    'no experience',
    'fresh graduate',
    'first job',
    'job application',
  ],
  cv: [
    'resume',
    'biodata',
    'job application',
    'first job',
  ],
  biodata: [
    'resume',
    'cv',
    'job application',
    'first job',
  ],
  interview: [
    'job interview',
    'first job',
    'answers',
    'hr',
    'expected salary',
  ],
  sweldo: [
    'salary',
    'payday',
    'budget',
    'payroll',
    'bank account',
  ],
  sahod: [
    'salary',
    'payday',
    'budget',
    'payroll',
    'bank account',
  ],
  salary: [
    'sweldo',
    'sahod',
    'payday',
    'budget',
    'payroll',
  ],
  payroll: [
    'salary',
    'sweldo',
    'bank account',
    'first job',
    'requirements',
  ],
  rent: [
    'renting',
    'apartment',
    'bedspace',
    'deposit',
    'moving out',
    'landlord',
  ],
  apartment: [
    'rent',
    'renting',
    'bedspace',
    'deposit',
    'utilities',
  ],
  bedspace: [
    'rent',
    'renting',
    'apartment',
    'utilities',
    'moving out',
  ],
  upa: [
    'rent',
    'renting',
    'apartment',
    'deposit',
  ],
  bumukod: [
    'moving out',
    'rent',
    'budget',
    'utilities',
    'adulting',
  ],
  utilities: [
    'utility bills',
    'electricity',
    'water',
    'internet',
    'kuryente',
    'tubig',
  ],
  kuryente: [
    'electricity',
    'utility bills',
    'meralco',
    'disconnection',
  ],
  tubig: [
    'water',
    'utility bills',
    'maynilad',
    'disconnection',
  ],
  meralco: [
    'electricity',
    'kuryente',
    'utility bills',
  ],
  maynilad: [
    'water',
    'tubig',
    'utility bills',
  ],
  loan: [
    'online lending',
    'loan app',
    'ola',
    'utang',
    'pautang',
    'debt',
    'harassment',
    'collection',
  ],
  utang: [
    'loan',
    'online lending',
    'loan app',
    'ola',
    'pautang',
    'debt',
  ],
  pautang: [
    'loan',
    'online lending',
    'loan app',
    'utang',
    'ola',
  ],
  ola: [
    'online lending',
    'loan app',
    'loan',
    'utang',
    'harassment',
  ],
  harassment: [
    'online lending',
    'loan app',
    'collection',
    'data privacy',
  ],
  recruiter: [
    'fake job',
    'job scam',
    'illegal recruitment',
    'placement fee',
    'ofw',
    'dmw',
  ],
  recruitment: [
    'fake job',
    'job scam',
    'illegal recruitment',
    'placement fee',
    'ofw',
    'dmw',
  ],
  ofw: [
    'fake job',
    'job scam',
    'illegal recruitment',
    'placement fee',
    'dmw',
    'poea',
  ],
  'job scam': [
    'fake job',
    'recruiter',
    'illegal recruitment',
    'placement fee',
    'training fee',
  ],
  'fake job': [
    'job scam',
    'recruiter',
    'illegal recruitment',
    'placement fee',
    'training fee',
  ],
  'placement fee': [
    'fake job',
    'job scam',
    'illegal recruitment',
    'recruiter',
    'ofw',
  ],
}

export function expandSearchTerms(query: string) {
  const cleanQuery = query.toLowerCase()
  const baseTerms = [cleanQuery, ...toSearchTerms(cleanQuery)]
  const expandedTerms = baseTerms.flatMap((term) => [
    term,
    ...(SEARCH_ALIASES[term] || []),
  ])

  return expandedTerms.filter(
    (term, index, items) => term.length > 1 && items.indexOf(term) === index
  )
}

function searchableText(guide: Guide) {
  return [
    guide.slug,
    guide.title_en,
    guide.title_fil,
    guide.tagline_en,
    guide.tagline_fil,
    guide.keywords_en,
    guide.keywords_fil,
    ...(guide.tags || []),
    guide.category?.name_en,
    guide.category?.name_fil,
    guide.category?.slug,
  ]
    .filter(Boolean)
    .join(' ')
    .toLowerCase()
}

export function matchesSearch(guide: Guide, query: string) {
  const text = searchableText(guide)
  const normalizedQuery = query.toLowerCase()
  const terms = toSearchTerms(normalizedQuery)
  const expandedTerms = expandSearchTerms(normalizedQuery)

  return (
    text.includes(normalizedQuery) ||
    terms.every((term) => text.includes(term)) ||
    expandedTerms.some((term) => text.includes(term))
  )
}

export function uniqueGuides(guides: Guide[]) {
  const byId = new Map<string, Guide>()

  guides.forEach((guide) => {
    byId.set(guide.id, guide)
  })

  return Array.from(byId.values())
}

function scoreGuide(guide: Guide, query: string) {
  const text = searchableText(guide)
  const title = `${guide.title_en} ${guide.title_fil}`.toLowerCase()
  const keywords =
    `${guide.keywords_en || ''} ${guide.keywords_fil || ''}`.toLowerCase()
  const categorySlug = guide.category?.slug?.toLowerCase() || ''
  const cleanQuery = query.toLowerCase()
  const directTerms = toSearchTerms(cleanQuery)
  const expandedTerms = expandSearchTerms(cleanQuery)
  const readTime = guide.read_time_min || 999
  const officialSourceCount = guide.official_sources?.length || 0

  let score = 0

  if (title.includes(cleanQuery)) score += 100
  if (keywords.includes(cleanQuery)) score += 60
  if (text.includes(cleanQuery)) score += 40

  directTerms.forEach((term) => {
    if (title.includes(term)) score += 20
    if (keywords.includes(term)) score += 12
    if (text.includes(term)) score += 6
  })

  expandedTerms.forEach((term) => {
    if (keywords.includes(term)) score += 4
    if (text.includes(term)) score += 2
  })

  if (officialSourceCount > 0) score += 35
  if (guide.is_urgent) score += 30
  if (guide.is_featured) score += 15
  if (readTime <= 6) score += 10
  if (categorySlug.includes(cleanQuery)) score += 20

  if (cleanQuery.includes('scam') || cleanQuery.includes('phishing')) {
    if (
      categorySlug.includes('scam') ||
      title.includes('phishing') ||
      title.includes('scam')
    ) {
      score += 80
    }
  }

  if (
    cleanQuery.includes('loan') ||
    cleanQuery.includes('utang') ||
    cleanQuery.includes('pautang') ||
    cleanQuery.includes('ola') ||
    cleanQuery.includes('online lending') ||
    cleanQuery.includes('harassment')
  ) {
    if (
      title.includes('loan') ||
      keywords.includes('online lending') ||
      keywords.includes('loan app') ||
      keywords.includes('utang') ||
      keywords.includes('harassment')
    ) {
      score += 90
    }
  }

  if (
    cleanQuery.includes('fake job') ||
    cleanQuery.includes('job scam') ||
    cleanQuery.includes('recruiter') ||
    cleanQuery.includes('recruitment') ||
    cleanQuery.includes('placement fee') ||
    cleanQuery.includes('ofw') ||
    cleanQuery.includes('poea') ||
    cleanQuery.includes('dmw')
  ) {
    if (
      title.includes('fake job') ||
      keywords.includes('job scam') ||
      keywords.includes('illegal recruitment') ||
      keywords.includes('placement fee') ||
      keywords.includes('ofw')
    ) {
      score += 90
    }
  }

  if (cleanQuery.includes('ayuda') || cleanQuery.includes('dswd')) {
    if (title.includes('dswd') || categorySlug.includes('government')) {
      score += 70
    }
  }

  if (
    cleanQuery.includes('lost wallet') ||
    cleanQuery.includes('wallet') ||
    cleanQuery.includes('lost id') ||
    cleanQuery.includes('lost phone') ||
    cleanQuery.includes('stolen phone')
  ) {
    if (
      title.includes('wallet') ||
      title.includes('phone') ||
      keywords.includes('lost wallet') ||
      keywords.includes('lost phone') ||
      keywords.includes('valid id')
    ) {
      score += 70
    }
  }

  if (cleanQuery.includes('nbi') && title.includes('nbi')) score += 90

  if (cleanQuery.includes('philhealth') && title.includes('philhealth')) {
    score += 90
  }

  if (
    cleanQuery.includes('first job') ||
    cleanQuery.includes('trabaho') ||
    cleanQuery.includes('work') ||
    cleanQuery.includes('job')
  ) {
    if (
      title.includes('first job') ||
      keywords.includes('first job') ||
      keywords.includes('resume') ||
      keywords.includes('interview') ||
      keywords.includes('requirements') ||
      keywords.includes('payroll')
    ) {
      score += 65
    }
  }

  if (
    cleanQuery.includes('resume') ||
    cleanQuery.includes('cv') ||
    cleanQuery.includes('biodata') ||
    cleanQuery.includes('interview')
  ) {
    if (
      title.includes('resume') ||
      title.includes('interview') ||
      keywords.includes('resume') ||
      keywords.includes('interview')
    ) {
      score += 85
    }
  }

  if (
    cleanQuery.includes('payday') ||
    cleanQuery.includes('payroll') ||
    cleanQuery.includes('sweldo') ||
    cleanQuery.includes('sahod') ||
    cleanQuery.includes('salary')
  ) {
    if (
      title.includes('payday') ||
      title.includes('bank account') ||
      keywords.includes('payday') ||
      keywords.includes('payroll') ||
      keywords.includes('bank account')
    ) {
      score += 70
    }
  }

  if (
    cleanQuery.includes('rent') ||
    cleanQuery.includes('apartment') ||
    cleanQuery.includes('bedspace') ||
    cleanQuery.includes('upa') ||
    cleanQuery.includes('moving out') ||
    cleanQuery.includes('bumukod') ||
    cleanQuery.includes('utility') ||
    cleanQuery.includes('utilities') ||
    cleanQuery.includes('kuryente') ||
    cleanQuery.includes('tubig') ||
    cleanQuery.includes('meralco') ||
    cleanQuery.includes('maynilad')
  ) {
    if (
      title.includes('renting') ||
      title.includes('moving out') ||
      title.includes('utility') ||
      keywords.includes('renting') ||
      keywords.includes('moving out') ||
      keywords.includes('utility bills') ||
      keywords.includes('kuryente') ||
      keywords.includes('tubig')
    ) {
      score += 75
    }
  }

  if (
    cleanQuery.includes('national id') ||
    cleanQuery.includes('philsys') ||
    cleanQuery.includes('philid') ||
    cleanQuery.includes('ephilid') ||
    cleanQuery.includes('trn')
  ) {
    if (
      title.includes('national id') ||
      keywords.includes('philsys') ||
      keywords.includes('philid') ||
      keywords.includes('trn')
    ) {
      score += 95
    }
  }

  if (
    cleanQuery.includes('otp') ||
    cleanQuery.includes('mpin') ||
    cleanQuery.includes('password')
  ) {
    if (
      title.includes('phishing') ||
      title.includes('stolen') ||
      keywords.includes('account takeover') ||
      keywords.includes('otp')
    ) {
      score += 75
    }
  }

  if (
    cleanQuery.includes('stolen phone') ||
    cleanQuery.includes('lost phone') ||
    cleanQuery.includes('phone stolen') ||
    cleanQuery.includes('nanakaw') ||
    cleanQuery.includes('sim')
  ) {
    if (
      title.includes('phone') ||
      keywords.includes('stolen phone') ||
      keywords.includes('lost phone') ||
      keywords.includes('sim')
    ) {
      score += 85
    }
  }

  return score
}

export function sortBySearchRelevance(guides: Guide[], query: string) {
  return [...guides].sort((first, second) => {
    const scoreDifference =
      scoreGuide(second, query) - scoreGuide(first, query)

    if (scoreDifference !== 0) {
      return scoreDifference
    }

    return (
      new Date(second.published_at).getTime() -
      new Date(first.published_at).getTime()
    )
  })
}
