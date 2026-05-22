insert into public.guides (
  slug,
  category_id,
  title_en,
  title_fil,
  tagline_en,
  tagline_fil,
  is_featured,
  is_urgent,
  read_time_min,
  difficulty,
  estimated_time,
  estimated_cost,
  tags,
  keywords_en,
  keywords_fil,
  official_sources,
  published_at
)
values (
  'dswd-aics-assistance-checklist',
  (select id from public.categories where slug = 'gov'),
  'DSWD AICS checklist for crisis financial assistance',
  'DSWD AICS checklist para sa financial assistance',
  'Know what AICS may cover, what to prepare, and how to avoid fake assistance posts.',
  'Alamin kung ano ang pwedeng saklaw ng AICS, ano ang ihahanda, at paano umiwas sa fake assistance posts.',
  true,
  false,
  6,
  'katamtaman',
  '30-60 minuto',
  'Libre mag-check',
  array['dswd', 'aics', 'financial assistance', 'medical assistance', 'burial assistance', 'transportation assistance', 'education assistance', 'food assistance', 'gobyerno', 'ayuda'],
  'dswd aics financial assistance medical burial transportation education food crisis ayuda',
  'dswd aics financial assistance medical burial transportation education food crisis ayuda gobyerno tulong',
  '[
    {"title":"Assistance to Individuals in Crisis Situation","publisher":"DSWD","url":"https://www.dswd.gov.ph/assistance-to-individuals-in-crisis-situation/"},
    {"title":"With defunded AKAP out, AICS to serve its 3.6M clients with Php63-B budget for 2026","publisher":"DSWD","url":"https://www.dswd.gov.ph/with-defunded-akap-out-aics-to-serve-its-3-6m-clients-with-php63-b-budget-for-2026-dswd-cip-official/"}
  ]'::jsonb,
  now()
)
on conflict (slug) do update set
  category_id = excluded.category_id,
  title_en = excluded.title_en,
  title_fil = excluded.title_fil,
  tagline_en = excluded.tagline_en,
  tagline_fil = excluded.tagline_fil,
  is_featured = excluded.is_featured,
  is_urgent = excluded.is_urgent,
  is_published = true,
  read_time_min = excluded.read_time_min,
  difficulty = excluded.difficulty,
  estimated_time = excluded.estimated_time,
  estimated_cost = excluded.estimated_cost,
  tags = excluded.tags,
  keywords_en = excluded.keywords_en,
  keywords_fil = excluded.keywords_fil,
  official_sources = excluded.official_sources,
  published_at = coalesce(public.guides.published_at, excluded.published_at),
  updated_at = now();

delete from public.guide_sections
where guide_id = (
  select id
  from public.guides
  where slug = 'dswd-aics-assistance-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'what_to_know',
    1,
    '{"title":"What AICS may help with","body":"DSWD AICS is for people or families in crisis. It may provide support for medical, burial, transportation, education, food, or other urgent needs, depending on assessment and available guidelines."}'::jsonb,
    '{"title":"Saan maaaring makatulong ang AICS","body":"Ang DSWD AICS ay para sa tao o pamilyang may crisis. Maaari itong tumulong sa medical, burial, transportation, education, food, o ibang urgent needs, depende sa assessment at kasalukuyang guidelines."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'step',
    2,
    '{"title":"Identify the type of help you need","body":"Write down the exact need first: hospital bill, medicine, funeral cost, transportation, school expense, food, or another crisis expense. This helps you ask for the right assistance instead of asking vaguely for ayuda.","step_number":1,"items":["Medical assistance","Burial assistance","Transportation assistance","Educational assistance","Food or non-food assistance","Other crisis support"]}'::jsonb,
    '{"title":"Alamin muna kung anong tulong ang kailangan","body":"Isulat muna ang eksaktong kailangan: hospital bill, gamot, funeral cost, pamasahe, school expense, pagkain, o ibang crisis expense. Mas malinaw ito kaysa basta humingi ng ayuda.","step_number":1,"items":["Medical assistance","Burial assistance","Transportation assistance","Educational assistance","Food o non-food assistance","Ibang crisis support"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'step',
    3,
    '{"title":"Prepare proof before going","body":"Requirements can vary by field office and assistance type, but start with valid ID, proof of crisis or billing, barangay certificate or referral if available, and contact details. Bring photocopies if you can.","step_number":2,"items":["Valid ID or supporting ID","Proof of bill, prescription, death certificate, enrollment, or travel need","Barangay certificate or referral if available","Contact number and address","Photocopies"]}'::jsonb,
    '{"title":"Ihanda ang proof bago pumunta","body":"Nag-iiba ang requirements depende sa field office at assistance type, pero magsimula sa valid ID, proof ng crisis o billing, barangay certificate o referral kung meron, at contact details. Magdala ng photocopy kung kaya.","step_number":2,"items":["Valid ID o supporting ID","Proof ng bill, reseta, death certificate, enrollment, o travel need","Barangay certificate o referral kung meron","Contact number at address","Photocopies"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'step',
    4,
    '{"title":"Ask the office what applies to your case","body":"Use a clear question: I need help for [medical/burial/transportation/education/food]. What documents should I bring, and where should I submit them?","step_number":3,"sample":"Hello po. Magtatanong lang po sana ako tungkol sa DSWD AICS. Kailangan ko po ng tulong para sa medical bill. Ano po ang requirements at saan po ako dapat pumunta?"}'::jsonb,
    '{"title":"Itanong kung ano ang applicable sa case mo","body":"Gumamit ng malinaw na tanong: Kailangan ko ng tulong para sa [medical/burial/transportation/education/food]. Anong documents ang dadalhin, at saan ito isusubmit?","step_number":3,"sample":"Hello po. Magtatanong lang po sana ako tungkol sa DSWD AICS. Kailangan ko po ng tulong para sa medical bill. Ano po ang requirements at saan po ako dapat pumunta?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'warning',
    5,
    '{"title":"Do not pay fixers or guaranteed approval pages","body":"AICS assistance is assessed by DSWD. Be careful with pages or people promising guaranteed approval, asking for processing fees, OTPs, account passwords, or private document uploads through random links.","severity":"high"}'::jsonb,
    '{"title":"Huwag magbayad sa fixer o guaranteed approval pages","body":"Ina-assess ng DSWD ang AICS assistance. Mag-ingat sa pages o taong nangangako ng guaranteed approval, humihingi ng processing fee, OTP, account password, o private documents sa random links.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'mistake',
    6,
    '{"title":"Do not go without documents","body":"Many people waste a trip because they only bring a story, not proof. Bring IDs, billing documents, referrals, prescriptions, certificates, or anything that proves the crisis and the amount needed."}'::jsonb,
    '{"title":"Huwag pumunta nang walang documents","body":"Maraming nasasayang ang punta dahil kwento lang ang dala, walang proof. Magdala ng IDs, billing documents, referrals, reseta, certificates, o kahit anong nagpapatunay ng crisis at kailangang halaga."}'::jsonb
  );

update public.guides
set
  is_published = false,
  updated_at = now()
where slug in (
  'common-job-scams',
  'fastest-valid-id',
  'government-appointment-basics',
  'how-to-open-bank-account'
);
