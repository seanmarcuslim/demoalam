update public.guides
set slug = 'government-benefits-programs-checklist'
where slug = 'government-appointment-basics'
  and not exists (
    select 1
    from public.guides
    where slug = 'government-benefits-programs-checklist'
  );

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
  'government-benefits-programs-checklist',
  (select id from public.categories where slug = 'gov'),
  'Government benefits and member programs to check first',
  'Government benefits at member programs na dapat mong i-check',
  'Know which official programs may help with health, savings, loans, work benefits, or crisis expenses.',
  'Alamin kung aling official programs ang pwedeng makatulong sa health, savings, loans, work benefits, o biglaang gastos.',
  true,
  false,
  6,
  'katamtaman',
  '30-45 minuto',
  'Libre mag-check',
  array['government benefits', 'sss', 'philhealth', 'pagibig', 'dswd', 'aics', 'membership', 'financial assistance', 'gobyerno', 'benepisyo'],
  'government benefits sss philhealth pagibig dswd aics membership financial assistance',
  'government benefits sss philhealth pagibig dswd aics membership financial assistance gobyerno benepisyo ayuda',
  '[
    {"title":"Benefits","publisher":"Social Security System","url":"https://www.sss.gov.ph/benefits/"},
    {"title":"Benefits","publisher":"PhilHealth","url":"https://www.philhealth.gov.ph/benefits/"},
    {"title":"Pag-IBIG Fund","publisher":"Pag-IBIG Fund","url":"https://www.pagibigfund.gov.ph/"},
    {"title":"Assistance to Individuals in Crisis Situation","publisher":"DSWD","url":"https://www.dswd.gov.ph/assistance-to-individuals-in-crisis-situation/"}
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

delete from public.guides
where slug = 'government-appointment-basics';

delete from public.guide_sections
where guide_id = (
  select id
  from public.guides
  where slug = 'government-benefits-programs-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'government-benefits-programs-checklist'),
    'what_to_know',
    1,
    '{"title":"What this guide is for","body":"Before borrowing money or ignoring salary deductions, check the government programs already connected to your work, health, savings, or crisis needs: SSS, PhilHealth, Pag-IBIG, and DSWD AICS."}'::jsonb,
    '{"title":"Para saan ang guide na ito","body":"Bago umutang o balewalain ang salary deductions, i-check muna ang government programs na konektado sa trabaho, health, savings, o crisis needs mo: SSS, PhilHealth, Pag-IBIG, at DSWD AICS."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'government-benefits-programs-checklist'),
    'step',
    2,
    '{"title":"Check SSS for work-related and long-term benefits","body":"SSS may matter for sickness, maternity, disability, retirement, death, funeral, unemployment, salary loan, calamity loan, and other member benefits. Log in to My.SSS and confirm your contributions are posted.","step_number":1}'::jsonb,
    '{"title":"I-check ang SSS para sa work at long-term benefits","body":"Mahalaga ang SSS para sa sickness, maternity, disability, retirement, death, funeral, unemployment, salary loan, calamity loan, at iba pang member benefits. Mag-login sa My.SSS at siguraduhing posted ang contributions mo.","step_number":1}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'government-benefits-programs-checklist'),
    'step',
    3,
    '{"title":"Check PhilHealth before medical expenses get heavy","body":"For hospital or treatment needs, check PhilHealth eligibility, benefit packages, and required documents before admission or billing if possible.","step_number":2}'::jsonb,
    '{"title":"I-check ang PhilHealth bago lumaki ang gastos sa health","body":"Para sa hospital o treatment needs, i-check ang PhilHealth eligibility, benefit packages, at required documents bago admission o billing kung kaya.","step_number":2}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'government-benefits-programs-checklist'),
    'step',
    4,
    '{"title":"Check Pag-IBIG for savings, housing, and loans","body":"Pag-IBIG is not only for housing. Check your regular savings, MP2 if you want voluntary savings, and member loan options only after reviewing eligibility and repayment terms.","step_number":3}'::jsonb,
    '{"title":"I-check ang Pag-IBIG para sa savings, housing, at loans","body":"Hindi lang pang-housing ang Pag-IBIG. I-check ang regular savings, MP2 kung gusto mo ng voluntary savings, at member loan options pagkatapos maintindihan ang eligibility at hulog.","step_number":3}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'government-benefits-programs-checklist'),
    'warning',
    5,
    '{"title":"For crisis expenses, verify DSWD AICS directly","body":"DSWD AICS may help people in crisis with medical, burial, transportation, education, food, or other support needs. Requirements and release process can change, so verify with the official DSWD page or field office first.","severity":"high"}'::jsonb,
    '{"title":"Para sa biglaang gastos, i-verify ang DSWD AICS","body":"Ang DSWD AICS ay maaaring makatulong sa crisis needs tulad ng medical, burial, transportation, education, food, o iba pang support. Nagbabago ang requirements at proseso, kaya i-verify muna sa official DSWD page o field office.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'government-benefits-programs-checklist'),
    'mistake',
    6,
    '{"title":"Do not trust fixers or guaranteed approval posts","body":"Government benefits are not guaranteed just because someone online says so. Avoid people asking for processing fees, screenshots of OTPs, or account passwords."}'::jsonb,
    '{"title":"Huwag magtiwala sa fixer o guaranteed approval posts","body":"Hindi guaranteed ang government benefits dahil lang sinabi ng tao online. Iwasan ang humihingi ng processing fee, OTP screenshots, o account password."}'::jsonb
  );
