update public.guides
set
  title_en = 'First job requirements: what to prepare before you spend',
  title_fil = 'Unang trabaho: requirements na ihanda bago gumastos',
  tagline_en = 'Ask HR what is required now, use first-time jobseeker benefits, and avoid duplicate records or fixer fees.',
  tagline_fil = 'Tanungin muna ang HR kung ano ang kailangan ngayon, gamitin ang first-time jobseeker benefit, at iwasan ang duplicate records o fixer fees.',
  read_time_min = 8,
  estimated_time = '1-3 araw',
  estimated_cost = 'Libre-300 pesos',
  difficulty = 'katamtaman',
  is_featured = true,
  tags = array[
    'work',
    'first job',
    'unang trabaho',
    'requirements',
    'pre employment requirements',
    'hr',
    'nbi',
    'sss',
    'philhealth',
    'pagibig',
    'tin',
    'payroll',
    'first time jobseeker',
    'ra 11261',
    'barangay certificate'
  ],
  keywords_en = 'first job requirements checklist employment hr pre employment documents onboarding start date nbi police clearance barangay certificate first time jobseeker ra 11261 free nbi free documents sss philhealth pagibig tin bir form 1902 payroll bank account medical certificate resume valid id duplicate records fixer',
  keywords_fil = 'unang trabaho requirements checklist employment hr pre employment documents onboarding start date nbi police clearance barangay certificate first time jobseeker ra 11261 libreng nbi libreng documents sss philhealth pagibig tin bir form 1902 payroll bank account medical certificate resume valid id duplicate records fixer',
  updated_at = now()
where slug = 'first-job-requirements';

update public.guide_sections
set
  content_fil = jsonb_set(
    content_fil,
    '{title}',
    to_jsonb('Huwag basta kolektahin lahat ng requirements'::text)
  )
where guide_id = (select id from public.guides where slug = 'first-job-requirements')
  and section_type = 'what_to_know'
  and order_index = 1;

update public.guide_sections
set
  content_en = jsonb_set(
    content_en,
    '{title}',
    to_jsonb('START HERE: ask HR before spending money'::text)
  ),
  content_fil = jsonb_set(
    content_fil,
    '{title}',
    to_jsonb('UNAHIN ITO: magtanong muna sa HR bago gumastos'::text)
  )
where guide_id = (select id from public.guides where slug = 'first-job-requirements')
  and section_type = 'warning'
  and order_index = 2;
