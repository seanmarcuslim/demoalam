export type CourseFitFlowLanguage = 'en' | 'fil'

export type CourseFitQuestionId =
  | 'stage'
  | 'interest'
  | 'constraint'
  | 'first_check'

export type CourseFitAnswerId =
  | 'shs'
  | 'college'
  | 'shifting'
  | 'tesda'
  | 'not_sure_stage'
  | 'people'
  | 'technical'
  | 'creative'
  | 'business'
  | 'care_service'
  | 'not_sure_interest'
  | 'cost'
  | 'work_soon'
  | 'family_pressure'
  | 'low_confidence'
  | 'commute_time'
  | 'cost_aid'
  | 'job_reality'
  | 'skills_fit'
  | 'backup_path'
  | 'study_help'

export type CourseFitOutcomeId =
  | 'cost_aid_path'
  | 'work_reality_path'
  | 'skills_fit_path'
  | 'pressure_undecided_path'
  | 'study_support_path'

export type CourseFitPriority = 'HIGH' | 'MEDIUM'

export type CourseFitAnswers = Partial<Record<CourseFitQuestionId, CourseFitAnswerId>>

export interface CourseFitOption {
  id: CourseFitAnswerId
  label_en: string
  label_fil: string
}

export interface CourseFitQuestion {
  id: CourseFitQuestionId
  question_en: string
  question_fil: string
  options: CourseFitOption[]
}

export interface CourseFitOutcome {
  id: CourseFitOutcomeId
  priority: CourseFitPriority
  title_en: string
  title_fil: string
  first_action_en: string
  first_action_fil: string
  why_en: string
  why_fil: string
  primary_guide_slug: string
  related_guide_slugs: string[]
  mentor_note_en?: string
  mentor_note_fil?: string
}

export interface CourseFitResult {
  outcome: CourseFitOutcome
  reason_en: string[]
  reason_fil: string[]
}

export const courseFitFlow = {
  slug: 'course-fit',
  title_en: 'Choosing a course? Check fit first.',
  title_fil: 'Pipili ng course? I-check muna ang fit.',
  intro_en:
    'Answer a few questions to see what you should verify before committing.',
  intro_fil:
    'Sagutin ang ilang tanong para malaman kung ano ang dapat i-check bago magdesisyon.',
  entry_title_en: 'Choosing a course?',
  entry_title_fil: 'Pipili ng course?',
  entry_body_en: 'Check cost, interest, work reality, and backup paths.',
  entry_body_fil: 'I-check ang gastos, hilig, realidad ng trabaho, at backup paths.',
  cta_en: 'Start course check',
  cta_fil: 'Simulan ang course check',
  questions: [
    {
      id: 'stage',
      question_en: 'Where are you right now?',
      question_fil: 'Nasaan ka ngayon sa pag-aaral?',
      options: [
        {
          id: 'shs',
          label_en: 'I am choosing a strand or college course',
          label_fil: 'Pipili pa lang ako ng strand o college course',
        },
        {
          id: 'college',
          label_en: 'I am entering or already in college',
          label_fil: 'Papasok o nasa college na ako',
        },
        {
          id: 'shifting',
          label_en: 'I am thinking of shifting',
          label_fil: 'Iniisip kong mag-shift',
        },
        {
          id: 'tesda',
          label_en: 'I am considering TESDA or skills training',
          label_fil: 'Tinitingnan ko ang TESDA o skills training',
        },
        {
          id: 'not_sure_stage',
          label_en: 'I am not sure yet',
          label_fil: 'Hindi pa ako sigurado',
        },
      ],
    },
    {
      id: 'interest',
      question_en: 'Which kind of work feels most possible for you?',
      question_fil: 'Anong klase ng trabaho ang pinaka-posible para sa iyo?',
      options: [
        {
          id: 'people',
          label_en: 'Helping, teaching, selling, or talking to people',
          label_fil: 'Tumutulong, nagtuturo, nagbebenta, o nakikipag-usap',
        },
        {
          id: 'technical',
          label_en: 'Tools, computers, systems, or hands-on work',
          label_fil: 'Tools, computer, systems, o hands-on na trabaho',
        },
        {
          id: 'creative',
          label_en: 'Design, writing, content, or creative work',
          label_fil: 'Design, pagsusulat, content, o creative work',
        },
        {
          id: 'business',
          label_en: 'Business, money, operations, or management',
          label_fil: 'Business, pera, operations, o management',
        },
        {
          id: 'care_service',
          label_en: 'Health, care, public service, or safety work',
          label_fil: 'Health, care, public service, o safety work',
        },
        {
          id: 'not_sure_interest',
          label_en: 'I do not know yet',
          label_fil: 'Hindi ko pa alam',
        },
      ],
    },
    {
      id: 'constraint',
      question_en: 'What could make the decision harder?',
      question_fil: 'Ano ang pinakamakapagpapahirap sa desisyon?',
      options: [
        {
          id: 'cost',
          label_en: 'Tuition, allowance, or school expenses',
          label_fil: 'Tuition, allowance, o gastos sa school',
        },
        {
          id: 'work_soon',
          label_en: 'I may need to earn money soon',
          label_fil: 'Baka kailangan kong kumita agad',
        },
        {
          id: 'family_pressure',
          label_en: 'Family pressure or expectations',
          label_fil: 'Pressure o expectation ng pamilya',
        },
        {
          id: 'low_confidence',
          label_en: 'I am worried I cannot keep up',
          label_fil: 'Nag-aalala akong hindi ako makakasabay',
        },
        {
          id: 'commute_time',
          label_en: 'Distance, commute, or schedule',
          label_fil: 'Layo, biyahe, o schedule',
        },
      ],
    },
    {
      id: 'first_check',
      question_en: 'What do you need to check first?',
      question_fil: 'Ano ang kailangan mong i-check muna?',
      options: [
        {
          id: 'cost_aid',
          label_en: 'Cost, scholarship, or financial aid',
          label_fil: 'Gastos, scholarship, o financial aid',
        },
        {
          id: 'job_reality',
          label_en: 'What work looks like after the course',
          label_fil: 'Ano ang trabaho pagkatapos ng course',
        },
        {
          id: 'skills_fit',
          label_en: 'Whether my strengths fit the course',
          label_fil: 'Kung bagay ang strengths ko sa course',
        },
        {
          id: 'backup_path',
          label_en: 'Backup paths if the first plan fails',
          label_fil: 'Backup paths kung hindi matuloy ang unang plano',
        },
        {
          id: 'study_help',
          label_en: 'How to study better before choosing',
          label_fil: 'Paano mag-aral nang mas maayos bago pumili',
        },
      ],
    },
  ] satisfies CourseFitQuestion[],
  outcomes: {
    cost_aid_path: {
      id: 'cost_aid_path',
      priority: 'HIGH',
      title_en: 'Cost and aid check',
      title_fil: 'Check sa gastos at tulong',
      first_action_en:
        'Compare the real cost of 2-3 options before choosing one.',
      first_action_fil:
        'Ikumpara muna ang totoong gastos ng 2-3 option bago pumili.',
      why_en:
        'A course can fit your interests but still fail if tuition, allowance, commute, or aid is unclear.',
      why_fil:
        'Puwedeng bagay ang course sa hilig mo pero mahirapan kung hindi malinaw ang tuition, allowance, biyahe, o ayuda.',
      primary_guide_slug: 'choose-course-fit-checklist',
      related_guide_slugs: [
        'student-financial-aid-philippines-checklist',
        'student-cash-for-work-dswd-checklist',
      ],
      mentor_note_en:
        'Good choices include money reality, not just dream-course energy.',
      mentor_note_fil:
        'Kasama sa magandang desisyon ang realidad ng gastos, hindi lang dream course.',
    },
    work_reality_path: {
      id: 'work_reality_path',
      priority: 'MEDIUM',
      title_en: 'Work reality check',
      title_fil: 'Check sa realidad ng trabaho',
      first_action_en:
        'Check the work tasks, hiring path, and first-job requirements.',
      first_action_fil:
        'I-check ang trabaho mismo, hiring path, at first-job requirements.',
      why_en:
        'A course should be checked against the work it leads to, not only the subject name.',
      why_fil:
        'Dapat ikumpara ang course sa trabahong hahantungan nito, hindi lang sa pangalan ng subject.',
      primary_guide_slug: 'choose-course-fit-checklist',
      related_guide_slugs: [
        'first-job-requirements',
        'resume-no-experience',
        'job-interview-basic-answers',
      ],
    },
    skills_fit_path: {
      id: 'skills_fit_path',
      priority: 'MEDIUM',
      title_en: 'Strengths fit check',
      title_fil: 'Check kung bagay sa strengths',
      first_action_en:
        'List your strongest skills and compare them with the course workload.',
      first_action_fil:
        'Ilista ang pinakamalakas mong skills at ikumpara sa gawain sa course.',
      why_en:
        'Interest matters, but the daily workload also needs to match how you learn and work.',
      why_fil:
        'Mahalaga ang hilig, pero dapat tugma rin ang araw-araw na gawain sa paraan mo ng pag-aaral at pagtatrabaho.',
      primary_guide_slug: 'choose-course-fit-checklist',
      related_guide_slugs: [
        'study-smarter-when-behind-checklist',
        'resume-no-experience',
      ],
    },
    pressure_undecided_path: {
      id: 'pressure_undecided_path',
      priority: 'MEDIUM',
      title_en: 'Undecided / pressure check',
      title_fil: 'Check kung undecided o may pressure',
      first_action_en:
        'Separate your choice from pressure by comparing fit, cost, and backup paths.',
      first_action_fil:
        'Ihiwalay ang sariling pagpili sa pressure gamit ang fit, gastos, at backup paths.',
      why_en:
        'When the decision feels noisy, a simple comparison can make the next conversation easier.',
      why_fil:
        'Kapag magulo ang desisyon, mas madaling makipag-usap kung may simpleng comparison ka.',
      primary_guide_slug: 'choose-course-fit-checklist',
      related_guide_slugs: [
        'student-financial-aid-philippines-checklist',
        'first-job-requirements',
      ],
    },
    study_support_path: {
      id: 'study_support_path',
      priority: 'MEDIUM',
      title_en: 'Study readiness check',
      title_fil: 'Check sa readiness sa pag-aaral',
      first_action_en:
        'Make a small study reset plan before deciding the course is not for you.',
      first_action_fil:
        'Gumawa muna ng maliit na study reset plan bago sabihing hindi para sa iyo ang course.',
      why_en:
        'Sometimes the issue is not the course choice yet. It may be overload, schedule, or study habits.',
      why_fil:
        'Minsan hindi pa course choice ang problema. Baka overload, schedule, o study habits muna.',
      primary_guide_slug: 'study-smarter-when-behind-checklist',
      related_guide_slugs: [
        'choose-course-fit-checklist',
        'student-financial-aid-philippines-checklist',
      ],
    },
  } satisfies Record<CourseFitOutcomeId, CourseFitOutcome>,
}

const courseFitIntentTerms = [
  'choose course',
  'course fit',
  'college course',
  'anong course',
  'what course',
  'which course',
  'pumili ng course',
  'pipili ng course',
  'bagay na course',
  'hindi ko alam course',
  'di ko alam course',
  'undecided course',
  'career path',
  'strand',
  'tesda course',
]

export function shouldShowCourseFitFlow(query: string) {
  const cleanQuery = query.trim().toLowerCase().replace(/\s+/g, ' ')

  if (!cleanQuery) {
    return false
  }

  return courseFitIntentTerms.some((term) => cleanQuery.includes(term))
}

export function getCourseFitOutcome(answers: CourseFitAnswers): CourseFitResult {
  let outcomeId: CourseFitOutcomeId = 'pressure_undecided_path'

  if (answers.first_check === 'study_help' || answers.constraint === 'low_confidence') {
    outcomeId = 'study_support_path'
  } else if (answers.first_check === 'cost_aid' || answers.constraint === 'cost') {
    outcomeId = 'cost_aid_path'
  } else if (
    answers.first_check === 'job_reality' ||
    answers.constraint === 'work_soon'
  ) {
    outcomeId = 'work_reality_path'
  } else if (
    answers.first_check === 'skills_fit' ||
    answers.interest !== 'not_sure_interest'
  ) {
    outcomeId = 'skills_fit_path'
  } else if (
    answers.first_check === 'backup_path' ||
    answers.constraint === 'family_pressure' ||
    answers.stage === 'not_sure_stage'
  ) {
    outcomeId = 'pressure_undecided_path'
  }

  const outcome = courseFitFlow.outcomes[outcomeId]
  const reasons = courseFitFlow.questions
    .map((question) => {
      const answerId = answers[question.id]
      const option = question.options.find((item) => item.id === answerId)

      if (!option) {
        return null
      }

      return {
        en: `${getCourseFitLocalizedValue(question, 'question', 'en')} ${option.label_en}`,
        fil: `${getCourseFitLocalizedValue(question, 'question', 'fil')} ${option.label_fil}`,
      }
    })
    .filter((item): item is { en: string; fil: string } => Boolean(item))
    .slice(-2)

  return {
    outcome,
    reason_en: reasons.map((reason) => reason.en),
    reason_fil: reasons.map((reason) => reason.fil),
  }
}

export function getCourseFitLocalizedValue(
  item: object,
  key: string,
  language: CourseFitFlowLanguage
) {
  return (item as Record<string, string>)[`${key}_${language}`]
}
