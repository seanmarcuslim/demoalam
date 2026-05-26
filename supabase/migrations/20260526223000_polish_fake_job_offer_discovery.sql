update public.guides
set
  title_en = 'Fake job offer checklist before you pay or send documents',
  title_fil = 'Fake job offer checklist bago magbayad o magpadala ng ID',
  tagline_en = 'Verify recruiter identity, fees, agency records, job orders, and contract details before trusting a job offer.',
  tagline_fil = 'I-verify muna ang recruiter, fees, agency records, job order, at kontrata bago magtiwala sa job offer.',
  tags = array[
    'scam',
    'job scam',
    'work',
    'recruiter',
    'fees',
    'trabaho',
    'illegal recruitment',
    'ofw',
    'dmw',
    'poea',
    'placement fee',
    'processing fee',
    'training fee',
    'work abroad',
    'tourist visa',
    'fake job'
  ],
  keywords_en = 'fake job job scam illegal recruitment recruiter placement fee processing fee training fee ofw dmw poea contract visa tourist visa work abroad job order agency license facebook tiktok direct hire passport id documents',
  keywords_fil = 'fake job job scam illegal recruitment recruiter placement fee processing fee training fee trabaho ofw dmw poea kontrata visa tourist visa work abroad job order agency license facebook tiktok direct hire passport id documents',
  updated_at = now()
where slug = 'fake-job-offer-red-flags';

update public.guide_sections
set
  content_en = jsonb_set(
    content_en,
    '{title}',
    to_jsonb('START HERE: verify before paying or sending IDs'::text)
  ),
  content_fil = jsonb_set(
    content_fil,
    '{title}',
    to_jsonb('UNAHIN ITO: i-verify bago magbayad o mag-send ng ID'::text)
  )
where guide_id = (select id from public.guides where slug = 'fake-job-offer-red-flags')
  and section_type = 'warning'
  and order_index = 2;
