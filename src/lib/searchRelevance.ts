import type { Guide } from '../types/guide'
import { SEARCH_ALIASES } from './searchAliases'

function toSearchTerms(query: string) {
  return query
    .toLowerCase()
    .split(/\s+/)
    .map((term) => term.trim())
    .filter((term) => term.length > 0)
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
  const slug = guide.slug.toLowerCase()
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
    cleanQuery.includes('loan app') ||
    cleanQuery.includes('online lending') ||
    cleanQuery.includes('ola')
  ) {
    if (
      slug === 'loan-red-flags-before-borrowing' ||
      title.includes('online loan') ||
      title.includes('loan red flags')
    ) {
      score += 120
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
    cleanQuery.includes('senior pension') ||
    cleanQuery.includes('social pension') ||
    cleanQuery.includes('senior citizen') ||
    cleanQuery.includes('elderly')
  ) {
    if (
      title.includes('social pension') ||
      keywords.includes('social pension') ||
      keywords.includes('senior citizen') ||
      keywords.includes('older persons')
    ) {
      score += 95
    }
  }

  if (
    cleanQuery.includes('walang gutom') ||
    cleanQuery.includes('food stamp') ||
    cleanQuery.includes('food credits')
  ) {
    if (
      title.includes('walang gutom') ||
      keywords.includes('walang gutom') ||
      keywords.includes('food credits') ||
      keywords.includes('food stamp')
    ) {
      score += 95
    }
  }

  if (
    cleanQuery.includes('cash for work') ||
    cleanQuery.includes('cash-for-work') ||
    cleanQuery.includes('tara basa') ||
    cleanQuery.includes('kalahi')
  ) {
    if (
      title.includes('cash-for-work') ||
      title.includes('cash for work') ||
      keywords.includes('cash for work') ||
      keywords.includes('cash-for-work') ||
      keywords.includes('tara basa') ||
      keywords.includes('kalahi')
    ) {
      score += 95
    }
  }

  if (
    cleanQuery.includes('livelihood') ||
    cleanQuery.includes('slp') ||
    cleanQuery.includes('negosyo')
  ) {
    if (
      title.includes('livelihood') ||
      keywords.includes('sustainable livelihood') ||
      keywords.includes('slp') ||
      keywords.includes('negosyo')
    ) {
      score += 95
    }
  }

  if (
    cleanQuery.includes('bagyo') ||
    cleanQuery.includes('baha') ||
    cleanQuery.includes('calamity') ||
    cleanQuery.includes('disaster') ||
    cleanQuery.includes('emergency cash transfer') ||
    cleanQuery.includes('cash aid') ||
    cleanQuery.includes('ect')
  ) {
    if (
      title.includes('emergency cash') ||
      title.includes('disaster') ||
      keywords.includes('emergency cash transfer') ||
      keywords.includes('disaster cash aid') ||
      keywords.includes('calamity') ||
      keywords.includes('relief')
    ) {
      score += 95
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
    cleanQuery.includes('unang trabaho') ||
    cleanQuery.includes('first job requirements') ||
    cleanQuery.includes('pre employment') ||
    cleanQuery.includes('hr requirements') ||
    cleanQuery.includes('first time jobseeker') ||
    cleanQuery.includes('free nbi') ||
    cleanQuery.includes('nbi first job') ||
    cleanQuery.includes('barangay certificate') ||
    cleanQuery.includes('sss philhealth pagibig tin') ||
    cleanQuery.includes('trabaho') ||
    cleanQuery.includes('work') ||
    cleanQuery.includes('job')
  ) {
    if (
      slug === 'first-job-requirements' ||
      title.includes('first job') ||
      title.includes('unang trabaho') ||
      keywords.includes('first job') ||
      keywords.includes('unang trabaho') ||
      keywords.includes('pre employment') ||
      keywords.includes('first time jobseeker') ||
      keywords.includes('resume') ||
      keywords.includes('interview') ||
      keywords.includes('requirements') ||
      keywords.includes('payroll')
    ) {
      score += slug === 'first-job-requirements' ? 120 : 65
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
    cleanQuery.includes('salary') ||
    cleanQuery.includes('kulang sweldo') ||
    cleanQuery.includes('kulang sahod') ||
    cleanQuery.includes('petsa de peligro') ||
    cleanQuery.includes('before payday') ||
    cleanQuery.includes('salary short')
  ) {
    if (
      title.includes('payday') ||
      title.includes('salary short') ||
      title.includes('kulang ang sweldo') ||
      title.includes('bank account') ||
      keywords.includes('cash short') ||
      keywords.includes('shortfall') ||
      keywords.includes('petsa de peligro') ||
      keywords.includes('payday') ||
      keywords.includes('payroll') ||
      keywords.includes('bank account')
    ) {
      score += 70
    }
  }

  if (
    cleanQuery.includes('bank') ||
    cleanQuery.includes('bank account') ||
    cleanQuery.includes('first bank account') ||
    cleanQuery.includes('unang bank account') ||
    cleanQuery.includes('savings account') ||
    cleanQuery.includes('payroll account') ||
    cleanQuery.includes('basic deposit account') ||
    cleanQuery.includes('bda') ||
    cleanQuery.includes('maintaining balance') ||
    cleanQuery.includes('no maintaining balance') ||
    cleanQuery.includes('dormancy fee') ||
    cleanQuery.includes('deposit insurance') ||
    cleanQuery.includes('pdic')
  ) {
    if (
      title.includes('bank account') ||
      keywords.includes('bank account') ||
      keywords.includes('basic deposit account') ||
      keywords.includes('maintaining balance') ||
      keywords.includes('dormancy') ||
      keywords.includes('pdic') ||
      keywords.includes('payroll')
    ) {
      score += 90
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
    cleanQuery.includes('gcash') ||
    cleanQuery.includes('maling send') ||
    cleanQuery.includes('wrong send') ||
    cleanQuery.includes('wrong number') ||
    cleanQuery.includes('fake support') ||
    cleanQuery.includes('gcash support') ||
    cleanQuery.includes('account secure') ||
    cleanQuery.includes('device registration') ||
    cleanQuery.includes('unauthorized transaction')
  ) {
    if (
      title.includes('gcash') ||
      keywords.includes('gcash') ||
      keywords.includes('wrong send') ||
      keywords.includes('fake support') ||
      keywords.includes('device registration') ||
      keywords.includes('unauthorized transaction') ||
      keywords.includes('account secure')
    ) {
      score += 95
    }
  }

  if (
    cleanQuery.includes('gcash support') ||
    cleanQuery.includes('fake support') ||
    cleanQuery.includes('maling send') ||
    cleanQuery.includes('wrong send') ||
    cleanQuery.includes('account secure') ||
    cleanQuery.includes('device registration') ||
    cleanQuery.includes('unauthorized transaction')
  ) {
    if (
      title.includes('gcash scam') ||
      keywords.includes('wrong send') ||
      keywords.includes('fake support') ||
      keywords.includes('account secure') ||
      keywords.includes('device registration') ||
      keywords.includes('unauthorized transaction')
    ) {
      score += 70
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
