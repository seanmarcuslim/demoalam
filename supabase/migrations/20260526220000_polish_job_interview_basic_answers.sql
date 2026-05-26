update public.guides
set
  title_en = 'First job interview answers without fake scripts',
  title_fil = 'Unang interview sa trabaho: sagot na honest at hindi scripted',
  tagline_en = 'Prepare honest first-job answers, salary expectations, and safe questions without memorizing fake lines.',
  tagline_fil = 'Maghanda ng honest na sagot, expected salary, at safe na tanong nang hindi nagme-memorize ng fake lines.',
  tags = array[
    'interview',
    'job interview',
    'first job interview',
    'work',
    'job',
    'first job',
    'answers',
    'expected salary',
    'salary expectation',
    'fresh graduate',
    'student',
    'no experience',
    'walang experience',
    'philjobnet',
    'jobstart',
    'resume'
  ],
  keywords_en = 'interview job interview first job interview interview answers first job fresh graduate no experience tell me about yourself strengths weakness why should we hire you expected salary salary expectation availability job offer hr recruiter philjobnet jobstart practice honest answers fake scripts',
  keywords_fil = 'interview job interview unang interview sa trabaho interview answers unang trabaho first job fresh graduate walang experience tell me about yourself strengths weakness bakit ka namin ihahire expected salary salary expectation availability job offer hr recruiter philjobnet jobstart practice honest answers fake scripts',
  updated_at = now()
where slug = 'job-interview-basic-answers';

update public.guide_sections
set
  content_fil = jsonb_set(
    content_fil,
    '{title}',
    to_jsonb('Ang magandang interview answer ay honest, specific, at konektado sa trabaho'::text)
  )
where guide_id = (select id from public.guides where slug = 'job-interview-basic-answers')
  and section_type = 'what_to_know'
  and order_index = 1;

update public.guide_sections
set
  content_en = jsonb_set(
    content_en,
    '{title}',
    to_jsonb('START HERE: prepare stories, not fake scripts'::text)
  ),
  content_fil = jsonb_set(
    content_fil,
    '{title}',
    to_jsonb('UNAHIN ITO: maghanda ng totoong kwento, hindi fake script'::text)
  )
where guide_id = (select id from public.guides where slug = 'job-interview-basic-answers')
  and section_type = 'warning'
  and order_index = 2;
