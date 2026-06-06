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
  const hasVehicleAccidentIntent =
    cleanQuery.includes('road accident') ||
    cleanQuery.includes('road crash') ||
    cleanQuery.includes('car accident') ||
    cleanQuery.includes('motorcycle accident') ||
    cleanQuery.includes('traffic accident') ||
    cleanQuery.includes('vehicular accident') ||
    cleanQuery.includes('aksidente') ||
    cleanQuery.includes('aksidente sa motor') ||
    cleanQuery.includes('aksidente sa sasakyan') ||
    cleanQuery.includes('crash') ||
    cleanQuery.includes('banggaan') ||
    cleanQuery.includes('hit and run')
  const hasStolenDeviceIntent =
    cleanQuery.includes('stolen phone') ||
    cleanQuery.includes('nanakaw phone') ||
    cleanQuery.includes('lost phone') ||
    cleanQuery.includes('nawala phone') ||
    cleanQuery.includes('imei') ||
    cleanQuery.includes('sim') ||
    cleanQuery.includes('lost sim')
  const hasGenericBlotterIntent =
    !hasVehicleAccidentIntent &&
    !hasStolenDeviceIntent &&
    (
      cleanQuery.includes('blotter') ||
      cleanQuery.includes('police blotter') ||
      cleanQuery.includes('barangay blotter') ||
      cleanQuery.includes('magpa blotter') ||
      cleanQuery.includes('complaint blotter')
    )

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
    cleanQuery.includes('illegal recruitment') ||
    cleanQuery.includes('recruiter') ||
    cleanQuery.includes('recruitment') ||
    cleanQuery.includes('placement fee') ||
    cleanQuery.includes('processing fee') ||
    cleanQuery.includes('training fee') ||
    cleanQuery.includes('work abroad') ||
    cleanQuery.includes('tourist visa') ||
    cleanQuery.includes('ofw') ||
    cleanQuery.includes('poea') ||
    cleanQuery.includes('dmw')
  ) {
    if (
      slug === 'fake-job-offer-red-flags' ||
      title.includes('fake job') ||
      keywords.includes('job scam') ||
      keywords.includes('illegal recruitment') ||
      keywords.includes('placement fee') ||
      keywords.includes('processing fee') ||
      keywords.includes('training fee') ||
      keywords.includes('work abroad') ||
      keywords.includes('tourist visa') ||
      keywords.includes('ofw')
    ) {
      score += slug === 'fake-job-offer-red-flags' ? 120 : 90
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
    hasVehicleAccidentIntent ||
    cleanQuery.includes('police report') ||
    cleanQuery.includes('insurance claim')
  ) {
    if (
      slug === 'road-accident-first-steps' ||
      title.includes('road accident') ||
      title.includes('road crash') ||
      keywords.includes('road accident') ||
      keywords.includes('road crash') ||
      keywords.includes('police report') ||
      keywords.includes('insurance claim')
    ) {
      score += slug === 'road-accident-first-steps' ? 130 : 85
    }
  }

  if (
    cleanQuery.includes('philhealth benefits') ||
    cleanQuery.includes('hospital bill') ||
    cleanQuery.includes('case rate') ||
    cleanQuery.includes('philhealth mdr') ||
    cleanQuery.includes('member data record') ||
    cleanQuery.includes('claim form 1') ||
    cleanQuery.includes('discharge billing') ||
    cleanQuery.includes('hospital assistance') ||
    cleanQuery.includes('medical assistance') ||
    cleanQuery.includes('malasakit') ||
    cleanQuery.includes('malasakit center') ||
    cleanQuery.includes('public hospital') ||
    cleanQuery.includes('medical social worker') ||
    cleanQuery.includes('maifip') ||
    cleanQuery.includes('maipp') ||
    cleanQuery.includes('medical emergency') ||
    cleanQuery.includes('hospital documents') ||
    cleanQuery.includes('hospital emergency') ||
    cleanQuery.includes('philhealth hospital') ||
    cleanQuery.includes('emergency contact') ||
    cleanQuery.includes('ambulance') ||
    cleanQuery.includes('ambulansya') ||
    cleanQuery.includes('hmo') ||
    cleanQuery.includes('billing') ||
    cleanQuery.includes('social service')
  ) {
    if (
      slug === 'philhealth-hospital-benefits-checklist' ||
      slug === 'public-hospital-social-service-desk-guide' ||
      slug === 'medical-emergency-documents' ||
      title.includes('philhealth') ||
      title.includes('hospital bill') ||
      title.includes('social service') ||
      title.includes('public hospital') ||
      title.includes('malasakit') ||
      title.includes('medical emergency') ||
      title.includes('hospital') ||
      keywords.includes('philhealth benefits') ||
      keywords.includes('hospital bill') ||
      keywords.includes('case rate') ||
      keywords.includes('member data record') ||
      keywords.includes('claim form') ||
      keywords.includes('medical assistance') ||
      keywords.includes('malasakit') ||
      keywords.includes('public hospital') ||
      keywords.includes('medical social worker') ||
      keywords.includes('maifip') ||
      keywords.includes('maipp') ||
      keywords.includes('medical emergency') ||
      keywords.includes('hospital') ||
      keywords.includes('philhealth') ||
      keywords.includes('hmo') ||
      keywords.includes('billing') ||
      keywords.includes('social service')
    ) {
      score +=
        slug === 'philhealth-hospital-benefits-checklist' ||
        slug === 'public-hospital-social-service-desk-guide' ||
        slug === 'medical-emergency-documents'
          ? 125
          : 80
    }
  }

  if (
    cleanQuery.includes('pcso medical assistance') ||
    cleanQuery.includes('pcso medical') ||
    cleanQuery.includes('pcso assistance') ||
    cleanQuery.includes('pcso map')
  ) {
    if (slug === 'pcso-medical-assistance-checklist') {
      score += 260
    }
  }

  if (
    !cleanQuery.includes('pcso') &&
    (
      cleanQuery.includes('medical assistance') ||
      cleanQuery.includes('hospital assistance')
    )
  ) {
    if (slug === 'public-hospital-social-service-desk-guide') {
      score += 180
    }
  }

  if (
    cleanQuery.includes('gamot') ||
    cleanQuery.includes('medicine') ||
    cleanQuery.includes('generic') ||
    cleanQuery.includes('generic medicine') ||
    cleanQuery.includes('reseta') ||
    cleanQuery.includes('prescription') ||
    cleanQuery.includes('pharmacy') ||
    cleanQuery.includes('licensed pharmacy') ||
    cleanQuery.includes('fda verification') ||
    cleanQuery.includes('fda portal') ||
    cleanQuery.includes('fda registered') ||
    cleanQuery.includes('fake medicine') ||
    cleanQuery.includes('counterfeit medicine') ||
    cleanQuery.includes('unregistered medicine')
  ) {
    if (
      slug === 'generic-medicine-buying-checklist' ||
      title.includes('generic medicine') ||
      title.includes('medicine') ||
      title.includes('gamot') ||
      keywords.includes('generic medicine') ||
      keywords.includes('gamot') ||
      keywords.includes('pharmacy') ||
      keywords.includes('fda verification') ||
      keywords.includes('counterfeit medicine') ||
      keywords.includes('fake medicine') ||
      keywords.includes('reseta') ||
      keywords.includes('prescription')
    ) {
      score += slug === 'generic-medicine-buying-checklist' ? 125 : 75
    }
  }

  if (
    cleanQuery.includes('office message') ||
    cleanQuery.includes('ask office') ||
    cleanQuery.includes('office help') ||
    cleanQuery.includes('magtanong') ||
    cleanQuery.includes('pabalik balik') ||
    cleanQuery.includes('requirements') ||
    cleanQuery.includes('documents') ||
    cleanQuery.includes('paper trail') ||
    cleanQuery.includes('reference number') ||
    cleanQuery.includes('customer support') ||
    cleanQuery.includes('support message') ||
    cleanQuery.includes('follow up') ||
    cleanQuery.includes('appointment') ||
    cleanQuery.includes('office hours')
  ) {
    if (
      slug === 'office-help-message-checklist' ||
      title.includes('office') ||
      title.includes('magtanong') ||
      title.includes('pabalik-balik') ||
      keywords.includes('office help') ||
      keywords.includes('office message') ||
      keywords.includes('customer support') ||
      keywords.includes('requirements') ||
      keywords.includes('paper trail') ||
      keywords.includes('reference number') ||
      keywords.includes('follow up')
    ) {
      score += slug === 'office-help-message-checklist' ? 125 : 70
    }
  }

  if (
    cleanQuery.includes('barangay') ||
    cleanQuery.includes('barangay complaint') ||
    cleanQuery.includes('reklamo') ||
    cleanQuery.includes('ebidensya') ||
    cleanQuery.includes('evidence') ||
    cleanQuery.includes('kapitbahay') ||
    cleanQuery.includes('neighbor dispute') ||
    cleanQuery.includes('mediation') ||
    cleanQuery.includes('conciliation') ||
    cleanQuery.includes('katarungang pambarangay') ||
    cleanQuery.includes('lupon') ||
    cleanQuery.includes('barangay protection order') ||
    cleanQuery.includes('bpo')
  ) {
    if (
      slug === 'barangay-complaint-evidence-checklist' ||
      title.includes('barangay') ||
      title.includes('complaint') ||
      title.includes('blotter') ||
      keywords.includes('barangay complaint') ||
      keywords.includes('blotter') ||
      keywords.includes('evidence') ||
      keywords.includes('katarungang pambarangay') ||
      keywords.includes('mediation') ||
      keywords.includes('conciliation') ||
      keywords.includes('kapitbahay') ||
      keywords.includes('barangay protection order')
    ) {
      score += slug === 'barangay-complaint-evidence-checklist' ? 125 : 75
    }
  }

  if (
    hasGenericBlotterIntent &&
    slug === 'barangay-complaint-evidence-checklist'
  ) {
    score += 260
  }

  if (
    cleanQuery.includes('lost wallet') ||
    cleanQuery.includes('nawala wallet') ||
    cleanQuery.includes('nanakaw wallet') ||
    cleanQuery.includes('stolen wallet') ||
    cleanQuery.includes('freeze card') ||
    cleanQuery.includes('block card') ||
    cleanQuery.includes('affidavit of loss') ||
    cleanQuery.includes('wallet') ||
    cleanQuery.includes('lost id') ||
    cleanQuery.includes('nawala id') ||
    cleanQuery.includes('lost phone') ||
    cleanQuery.includes('stolen phone') ||
    cleanQuery.includes('nanakaw phone') ||
    cleanQuery.includes('nawala phone') ||
    cleanQuery.includes('nawala cp') ||
    cleanQuery.includes('nanakaw cp') ||
    cleanQuery.includes('nawala cellphone') ||
    cleanQuery.includes('nanakaw cellphone') ||
    cleanQuery.includes('di ko mahanap phone') ||
    cleanQuery.includes('lost sim') ||
    cleanQuery.includes('sim replacement') ||
    cleanQuery.includes('imei')
  ) {
    if (
      slug === 'lost-wallet-first-steps' ||
      slug === 'phone-stolen-first-hour' ||
      title.includes('wallet') ||
      title.includes('phone') ||
      keywords.includes('lost wallet') ||
      keywords.includes('nawala wallet') ||
      keywords.includes('stolen wallet') ||
      keywords.includes('affidavit of loss') ||
      keywords.includes('lost phone') ||
      keywords.includes('stolen phone') ||
      keywords.includes('nanakaw phone') ||
      keywords.includes('sim replacement') ||
      keywords.includes('imei') ||
      keywords.includes('valid id')
    ) {
      score +=
        slug === 'lost-wallet-first-steps' ||
        slug === 'phone-stolen-first-hour'
          ? 105
          : 70
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
    cleanQuery.includes('no experience') ||
    cleanQuery.includes('walang experience') ||
    cleanQuery.includes('first resume') ||
    cleanQuery.includes('resume fresh graduate') ||
    cleanQuery.includes('resume student') ||
    cleanQuery.includes('interview') ||
    cleanQuery.includes('job interview') ||
    cleanQuery.includes('first job interview') ||
    cleanQuery.includes('interview answers') ||
    cleanQuery.includes('expected salary') ||
    cleanQuery.includes('salary expectation') ||
    cleanQuery.includes('tell me about yourself') ||
    cleanQuery.includes('why should we hire you')
  ) {
    if (
      slug === 'resume-no-experience' ||
      slug === 'job-interview-basic-answers' ||
      title.includes('resume') ||
      title.includes('interview') ||
      keywords.includes('resume') ||
      keywords.includes('no experience') ||
      keywords.includes('walang experience') ||
      keywords.includes('fresh graduate') ||
      keywords.includes('interview') ||
      keywords.includes('expected salary') ||
      keywords.includes('tell me about yourself') ||
      keywords.includes('why should we hire you')
    ) {
      score +=
        slug === 'resume-no-experience' ||
        slug === 'job-interview-basic-answers'
          ? 115
          : 85
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
    cleanQuery.includes('emergency fund') ||
    cleanQuery.includes('ipon emergency') ||
    cleanQuery.includes('ipon pang emergency') ||
    cleanQuery.includes('emergency savings')
  ) {
    if (slug === 'emergency-fund-starter-checklist') {
      score += 260
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
    cleanQuery.includes('maynilad') ||
    cleanQuery.includes('disconnection') ||
    cleanQuery.includes('putol') ||
    cleanQuery.includes('maputulan') ||
    cleanQuery.includes('due date') ||
    cleanQuery.includes('payment posting') ||
    cleanQuery.includes('proof of payment') ||
    cleanQuery.includes('payment arrangement') ||
    cleanQuery.includes('installment') ||
    cleanQuery.includes('partial payment') ||
    cleanQuery.includes('reconnection')
  ) {
    if (
      slug === 'utility-bill-disconnection-checklist' ||
      title.includes('renting') ||
      title.includes('moving out') ||
      title.includes('utility') ||
      keywords.includes('renting') ||
      keywords.includes('moving out') ||
      keywords.includes('utility bills') ||
      keywords.includes('kuryente') ||
      keywords.includes('tubig') ||
      keywords.includes('disconnection') ||
      keywords.includes('due date') ||
      keywords.includes('payment posting') ||
      keywords.includes('proof of payment') ||
      keywords.includes('payment arrangement') ||
      keywords.includes('reconnection')
    ) {
      score += slug === 'utility-bill-disconnection-checklist' ? 125 : 75
    }
  }

  if (
    cleanQuery.includes('valid id') ||
    cleanQuery.includes('national id') ||
    cleanQuery.includes('philsys') ||
    cleanQuery.includes('philid') ||
    cleanQuery.includes('ephilid') ||
    cleanQuery.includes('trn')
  ) {
    if (
      title.includes('national id') ||
      keywords.includes('valid id') ||
      keywords.includes('philsys') ||
      keywords.includes('philid') ||
      keywords.includes('trn')
    ) {
      score += slug === 'national-id-problems-checklist' ? 160 : 95
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
    cleanQuery.includes('maya') ||
    cleanQuery.includes('maling send') ||
    cleanQuery.includes('wrong send') ||
    cleanQuery.includes('wrong number') ||
    cleanQuery.includes('nawala pera') ||
    cleanQuery.includes('nabawas pera') ||
    cleanQuery.includes('nabawas gcash') ||
    cleanQuery.includes('nabawas maya') ||
    cleanQuery.includes('na scam sa gcash') ||
    cleanQuery.includes('na scam sa maya') ||
    cleanQuery.includes('di ko mabuksan gcash') ||
    cleanQuery.includes('di ko maopen gcash') ||
    cleanQuery.includes('hindi ko mabuksan gcash') ||
    cleanQuery.includes('may kumuha ng pera') ||
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
    cleanQuery.includes('nawala pera') ||
    cleanQuery.includes('money disappeared') ||
    cleanQuery.includes('nabawas pera') ||
    cleanQuery.includes('nabawas gcash') ||
    cleanQuery.includes('nabawas maya') ||
    cleanQuery.includes('may kumuha ng pera')
  ) {
    if (slug === 'gcash-maya-account-recovery-first-hour') {
      score += 240
    }
  }

  if (
    cleanQuery.includes('stolen phone') ||
    cleanQuery.includes('lost phone') ||
    cleanQuery.includes('phone stolen') ||
    cleanQuery.includes('nanakaw phone') ||
    cleanQuery.includes('nawala phone') ||
    cleanQuery.includes('nawala cp') ||
    cleanQuery.includes('nanakaw cp') ||
    cleanQuery.includes('nawala cellphone') ||
    cleanQuery.includes('nanakaw cellphone') ||
    cleanQuery.includes('di ko mahanap phone') ||
    cleanQuery.includes('lost sim') ||
    cleanQuery.includes('sim replacement') ||
    cleanQuery.includes('imei') ||
    cleanQuery.includes('nanakaw') ||
    cleanQuery.includes('sim')
  ) {
    if (
      slug === 'phone-stolen-first-hour' ||
      title.includes('phone') ||
      keywords.includes('stolen phone') ||
      keywords.includes('lost phone') ||
      keywords.includes('nanakaw phone') ||
      keywords.includes('nawala cellphone') ||
      keywords.includes('lost sim') ||
      keywords.includes('sim replacement') ||
      keywords.includes('imei') ||
      keywords.includes('sim')
    ) {
      score += slug === 'phone-stolen-first-hour' ? 120 : 85
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
