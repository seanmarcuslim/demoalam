insert into public.categories (slug, name_en, name_fil, icon, color, order_index)
values
  ('ids', 'IDs', 'Mga ID', '🪪', '#2563A9', 1),
  ('gov', 'Government', 'Gobyerno', '🏛️', '#6D5BA8', 2),
  ('money', 'Money', 'Pera', '💸', '#D9902F', 3),
  ('work', 'Work', 'Trabaho', '💼', '#267A4D', 4),
  ('healthcare', 'Healthcare', 'Healthcare', '⚕️', '#2F8F83', 5),
  ('education', 'Education', 'Edukasyon', '🎓', '#4F73C7', 6),
  ('scams', 'Scams', 'Scam Alerts', '🚨', '#C83E3A', 7),
  ('digital-safety', 'Digital Safety', 'Digital Safety', '🛡️', '#3A7CA5', 8),
  ('emergency', 'Emergency', 'Emergency', '🚑', '#B86B16', 9),
  ('adulting', 'Adulting', 'Adulting', '🧭', '#2F8277', 10)
on conflict (slug) do update set
  name_en = excluded.name_en,
  name_fil = excluded.name_fil,
  icon = excluded.icon,
  color = excluded.color,
  order_index = excluded.order_index,
  is_active = true;

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
  published_at
)
values
  (
    'fast-valid-id',
    (select id from public.categories where slug = 'ids'),
    'Fastest valid ID options for first-time applicants',
    'Pinakamabilis na valid ID para sa first-time applicants',
    'Know which IDs are realistic to get first and what to prepare.',
    'Alamin kung anong ID ang realistic kunin muna at ano ang ihahanda.',
    true,
    false,
    4,
    'madali',
    '1-3 araw',
    'Libre-₱500',
    array['valid id', 'philippines', 'first job', 'government id'],
    now()
  ),
  (
    'gcash-scam-red-flags',
    (select id from public.categories where slug = 'digital-safety'),
    'GCash scam red flags before you send money',
    'GCash scam signs bago ka magpadala ng pera',
    'Pause before sending money when these warning signs appear.',
    'Huminto muna bago magpadala kapag nakita mo ang mga warning signs na ito.',
    false,
    true,
    3,
    'madali',
    '5 minuto',
    'Libre',
    array['gcash', 'scam', 'money', 'online safety'],
    now()
  ),
  (
    'first-job-requirements',
    (select id from public.categories where slug = 'work'),
    'First job requirements checklist',
    'Checklist ng requirements sa unang trabaho',
    'Prepare the usual documents before your first job application moves forward.',
    'Ihanda ang karaniwang dokumento bago umusad ang first job application mo.',
    true,
    false,
    4,
    'madali',
    '1-2 araw',
    'Libre-₱300',
    array['work', 'job', 'first job', 'requirements', 'trabaho', 'employment'],
    now()
  ),
  (
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
    now()
  ),
  (
    'lost-wallet-first-steps',
    (select id from public.categories where slug = 'emergency'),
    'What to do first when your wallet is lost',
    'Unang gagawin kapag nawala ang wallet',
    'Secure your accounts, IDs, and cards before replacing documents.',
    'Unahin i-secure ang accounts, IDs, at cards bago magpa-replace ng documents.',
    false,
    true,
    5,
    'katamtaman',
    '1 araw',
    'Depende sa replacement fees',
    array['emergency', 'lost wallet', 'cards', 'ids', 'urgent', 'nawala wallet'],
    now()
  ),
  (
    'renting-first-time-checklist',
    (select id from public.categories where slug = 'adulting'),
    'First-time renting checklist',
    'Checklist bago unang mag-rent',
    'Check deposits, contracts, utilities, and move-in rules before paying.',
    'I-check ang deposit, kontrata, utilities, at move-in rules bago magbayad.',
    false,
    false,
    4,
    'katamtaman',
    '1-2 oras',
    'Depende sa rent at deposit',
    array['adulting', 'rent', 'apartment', 'deposit', 'contract', 'boarding house'],
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
  published_at = excluded.published_at,
  updated_at = now();

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
  published_at
)
values
  (
    'nbi-clearance-first-timers',
    (select id from public.categories where slug = 'ids'),
    'NBI clearance checklist for first-timers',
    'NBI clearance checklist para sa first-timers',
    'Know what to prepare before booking and going to your appointment.',
    'Alamin ang ihahanda bago mag-book at pumunta sa appointment.',
    false,
    false,
    4,
    'madali',
    '1 araw',
    '₱130-₱200',
    array['nbi', 'clearance', 'valid id', 'first job', 'requirements'],
    now()
  ),
  (
    'everyday-rights-philippines-checklist',
    (select id from public.categories where slug = 'gov'),
    'Everyday rights in the Philippines many people miss',
    'Everyday rights sa Pilipinas na madalas hindi alam',
    'Know basic rights for shopping, work pay, personal data, and dealing with authorities.',
    'Alamin ang basic rights sa pagbili, sweldo, personal data, at pakikipag-usap sa authorities.',
    false,
    false,
    6,
    'katamtaman',
    '20-30 minuto',
    'Libre',
    array['rights', 'law', 'consumer rights', 'labor rights', 'data privacy', 'bill of rights', 'philippines', 'karapatan', 'batas'],
    now()
  ),
  (
    'resume-no-experience',
    (select id from public.categories where slug = 'work'),
    'How to write a resume with no work experience',
    'Paano gumawa ng resume kahit walang work experience',
    'Show school, projects, volunteer work, and useful skills clearly.',
    'Ipakita nang malinaw ang school, projects, volunteer work, at useful skills.',
    false,
    false,
    5,
    'madali',
    '1-2 oras',
    'Libre',
    array['resume', 'work', 'job', 'no experience', 'trabaho', 'fresh graduate'],
    now()
  ),
  (
    'job-interview-basic-answers',
    (select id from public.categories where slug = 'work'),
    'Basic interview answers for first job applicants',
    'Basic interview answers para sa first job applicants',
    'Prepare simple answers for common questions without sounding memorized.',
    'Maghanda ng simpleng sagot sa common questions nang hindi tunog memorize.',
    false,
    false,
    5,
    'katamtaman',
    '1 oras',
    'Libre',
    array['interview', 'work', 'job', 'first job', 'answers', 'trabaho'],
    now()
  ),
  (
    'bank-account-first-time',
    (select id from public.categories where slug = 'money'),
    'Opening a bank account for the first time',
    'Pag-open ng bank account sa unang pagkakataon',
    'Prepare IDs, initial deposit, and basic questions before visiting a branch.',
    'Ihanda ang ID, initial deposit, at basic questions bago pumunta sa branch.',
    true,
    false,
    4,
    'madali',
    '1-2 oras',
    '₱0-₱3,000',
    array['bank', 'bank account', 'money', 'savings', 'valid id', 'pera'],
    now()
  ),
  (
    'loan-red-flags-before-borrowing',
    (select id from public.categories where slug = 'money'),
    'Loan red flags before you borrow',
    'Loan red flags bago ka umutang',
    'Check fees, payment schedule, penalties, and app permissions before borrowing.',
    'I-check ang fees, hulog, penalties, at app permissions bago umutang.',
    false,
    true,
    4,
    'katamtaman',
    '20 minuto',
    'Depende sa loan',
    array['loan', 'debt', 'money', 'utang', 'fees', 'online lending'],
    now()
  ),
  (
    'payday-budget-simple-split',
    (select id from public.categories where slug = 'money'),
    'Simple payday budget split',
    'Simpleng hati ng sweldo tuwing payday',
    'Separate needs, bills, savings, debt, and small wants before spending.',
    'Ihiwalay muna ang needs, bills, savings, utang, at konting wants bago gumastos.',
    false,
    false,
    4,
    'madali',
    '20 minuto',
    'Libre',
    array['money', 'budget', 'payday', 'salary', 'savings', 'pera', 'sweldo'],
    now()
  ),
  (
    'sss-number-first-job',
    (select id from public.categories where slug = 'gov'),
    'Getting an SSS number for your first job',
    'Pagkuha ng SSS number para sa unang trabaho',
    'Know what details you need before creating or verifying your SSS record.',
    'Alamin ang details na kailangan bago gumawa o mag-verify ng SSS record.',
    false,
    false,
    4,
    'madali',
    '30 minuto-1 araw',
    'Libre',
    array['sss', 'government', 'first job', 'work', 'gobyerno', 'employment'],
    now()
  ),
  (
    'philhealth-pagibig-tin-basics',
    (select id from public.categories where slug = 'gov'),
    'PhilHealth, Pag-IBIG, and TIN basics for new workers',
    'Basics ng PhilHealth, Pag-IBIG, at TIN para sa bagong worker',
    'Understand what each number is for before submitting job requirements.',
    'Intindihin kung para saan ang bawat number bago mag-submit ng job requirements.',
    false,
    false,
    5,
    'katamtaman',
    '1-3 araw',
    'Libre',
    array['philhealth', 'pagibig', 'tin', 'government', 'work', 'requirements'],
    now()
  ),
  (
    'fake-job-offer-red-flags',
    (select id from public.categories where slug = 'scams'),
    'Fake job offer red flags',
    'Fake job offer red flags',
    'Spot suspicious recruiters before paying fees or sending personal documents.',
    'Kilatisin ang suspicious recruiters bago magbayad o magpadala ng personal documents.',
    false,
    true,
    4,
    'madali',
    '10 minuto',
    'Libre',
    array['scam', 'job scam', 'work', 'recruiter', 'fees', 'trabaho'],
    now()
  ),
  (
    'phishing-link-checklist',
    (select id from public.categories where slug = 'digital-safety'),
    'Phishing link checklist before you tap',
    'Phishing link checklist bago mo i-tap',
    'Check links, sender names, urgency tricks, and login pages before entering details.',
    'I-check ang link, sender, pressure tactics, at login page bago maglagay ng details.',
    false,
    true,
    3,
    'madali',
    '5 minuto',
    'Libre',
    array['phishing', 'scam', 'link', 'otp', 'password', 'online safety'],
    now()
  ),
  (
    'phone-stolen-first-hour',
    (select id from public.categories where slug = 'digital-safety'),
    'First hour checklist when your phone is stolen',
    'First hour checklist kapag nanakaw ang phone',
    'Lock accounts, SIM, e-wallets, and passwords before replacing the device.',
    'I-lock muna ang accounts, SIM, e-wallets, at passwords bago palitan ang device.',
    false,
    true,
    6,
    'mahirap',
    '1 oras',
    'Depende sa replacement',
    array['emergency', 'stolen phone', 'sim', 'gcash', 'password', 'urgent'],
    now()
  ),
  (
    'medical-emergency-documents',
    (select id from public.categories where slug = 'healthcare'),
    'Documents to prepare for a medical emergency',
    'Documents na ihahanda para sa medical emergency',
    'Keep IDs, contacts, PhilHealth details, and medicine notes easy to find.',
    'Ihanda ang IDs, contacts, PhilHealth details, at medicine notes sa madaling makita.',
    false,
    false,
    4,
    'madali',
    '30 minuto',
    'Libre',
    array['emergency', 'medical', 'hospital', 'philhealth', 'documents'],
    now()
  ),
  (
    'moving-out-budget',
    (select id from public.categories where slug = 'adulting'),
    'Moving out budget checklist',
    'Budget checklist bago bumukod',
    'Estimate rent, deposit, food, utilities, commute, and emergency money before moving.',
    'I-estimate ang rent, deposit, pagkain, utilities, pamasahe, at emergency money bago bumukod.',
    false,
    false,
    5,
    'katamtaman',
    '1-2 oras',
    'Depende sa lugar',
    array['adulting', 'moving out', 'budget', 'rent', 'utilities', 'money'],
    now()
  ),
  (
    'first-time-utility-bills',
    (select id from public.categories where slug = 'adulting'),
    'First-time utility bills checklist',
    'Checklist sa unang bayad ng utility bills',
    'Track due dates, account numbers, fees, and payment proof before the deadline.',
    'I-track ang due dates, account number, fees, at payment proof bago deadline.',
    false,
    false,
    3,
    'madali',
    '30 minuto',
    'Depende sa bill',
    array['adulting', 'bills', 'utilities', 'electricity', 'water', 'payment'],
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
  published_at = excluded.published_at,
  updated_at = now();

update public.guides
set
  keywords_en = array_to_string(tags, ' '),
  keywords_fil = array_to_string(tags, ' '),
  updated_at = now()
where slug in (
  'fast-valid-id',
  'gcash-scam-red-flags',
  'first-job-requirements',
  'dswd-aics-assistance-checklist',
  'lost-wallet-first-steps',
  'renting-first-time-checklist',
  'nbi-clearance-first-timers',
  'everyday-rights-philippines-checklist',
  'resume-no-experience',
  'job-interview-basic-answers',
  'bank-account-first-time',
  'loan-red-flags-before-borrowing',
  'payday-budget-simple-split',
  'sss-number-first-job',
  'philhealth-pagibig-tin-basics',
  'fake-job-offer-red-flags',
  'phishing-link-checklist',
  'phone-stolen-first-hour',
  'medical-emergency-documents',
  'moving-out-budget',
  'first-time-utility-bills'
);

update public.guides
set
  official_sources = case slug
    when 'gcash-scam-red-flags' then
      '[{"title":"Report a scam","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/4413295284377-Report-a-scam"}]'::jsonb
    when 'sss-number-first-job' then
      '[{"title":"Become an SSS Member","publisher":"Social Security System","url":"https://www.sss.gov.ph/become-an-sss-member/"}]'::jsonb
    when 'philhealth-pagibig-tin-basics' then
      '[
        {"title":"PhilHealth Online Services","publisher":"PhilHealth","url":"https://www.philhealth.gov.ph/services"},
        {"title":"Pag-IBIG Fund","publisher":"Pag-IBIG Fund","url":"https://www.pagibigfund.gov.ph/"}
      ]'::jsonb
    when 'dswd-aics-assistance-checklist' then
      '[
        {"title":"Assistance to Individuals in Crisis Situation","publisher":"DSWD","url":"https://www.dswd.gov.ph/assistance-to-individuals-in-crisis-situation/"},
        {"title":"With defunded AKAP out, AICS to serve its 3.6M clients with Php63-B budget for 2026","publisher":"DSWD","url":"https://www.dswd.gov.ph/with-defunded-akap-out-aics-to-serve-its-3-6m-clients-with-php63-b-budget-for-2026-dswd-cip-official/"}
      ]'::jsonb
    when 'everyday-rights-philippines-checklist' then
      '[
        {"title":"Article III: Bill of Rights","publisher":"Supreme Court E-Library","url":"https://elibrary.judiciary.gov.ph/thebookshelf/showdocs/45/25549"},
        {"title":"Workers Statutory Monetary Benefits Handbook","publisher":"National Wages and Productivity Commission","url":"https://nwpc.dole.gov.ph/wp-content/uploads/2024/11/Workers-Statutory-Monetary-Benefits-Handbook-2024-Edition.pdf"},
        {"title":"Know your rights and responsibilities as consumers","publisher":"Department of Trade and Industry","url":"https://www.dti.gov.ph/dti-archives/dti-consumers-rights-responsibilities/"},
        {"title":"Data Subject Rights","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/data-subject-rights/"}
      ]'::jsonb
    when 'medical-emergency-documents' then
      '[
        {"title":"Benefits","publisher":"PhilHealth","url":"https://www.philhealth.gov.ph/benefits/"},
        {"title":"Downloads","publisher":"PhilHealth","url":"https://www.philhealth.gov.ph/downloads/"},
        {"title":"Local Call Centers","publisher":"Emergency 911 National Office","url":"https://e911.gov.ph/local-call-centers/"}
      ]'::jsonb
    when 'phishing-link-checklist' then
      '[{"title":"GCash Help Center","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/"}]'::jsonb
    when 'phone-stolen-first-hour' then
      '[
        {"title":"Lost or stolen SIM, phone, or device","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/900006457043-Report-lost-or-stolen-GCash-registered-phone-or-SIM"},
        {"title":"Loss / Stolen Cellphone","publisher":"National Telecommunications Commission","url":"https://ntc.gov.ph/loss-stolen-cellphone/"},
        {"title":"How to register and unregister your phone to use GCash","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/36302878095385-I-want-to-use-GCash-on-another-phone-or-device"}
      ]'::jsonb
    else official_sources
  end,
  updated_at = now()
where slug in (
  'gcash-scam-red-flags',
  'dswd-aics-assistance-checklist',
  'everyday-rights-philippines-checklist',
  'sss-number-first-job',
  'philhealth-pagibig-tin-basics',
  'medical-emergency-documents',
  'phishing-link-checklist',
  'phone-stolen-first-hour'
);

delete from public.guide_sections
where guide_id in (
  select id
  from public.guides
  where slug in (
    'fast-valid-id',
    'gcash-scam-red-flags',
    'first-job-requirements',
    'dswd-aics-assistance-checklist',
    'lost-wallet-first-steps',
    'renting-first-time-checklist',
    'nbi-clearance-first-timers',
    'everyday-rights-philippines-checklist',
    'resume-no-experience',
    'job-interview-basic-answers',
    'bank-account-first-time',
    'loan-red-flags-before-borrowing',
    'payday-budget-simple-split',
    'sss-number-first-job',
    'philhealth-pagibig-tin-basics',
    'fake-job-offer-red-flags',
    'phishing-link-checklist',
    'phone-stolen-first-hour',
    'medical-emergency-documents',
    'moving-out-budget',
    'first-time-utility-bills'
  )
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'fast-valid-id'),
    'what_to_know',
    1,
    '{"title":"What to know","body":"Start with an ID that matches your current documents. A postal ID, national ID transaction slip, or barangay certificate can help unlock other applications."}'::jsonb,
    '{"title":"Ano ang dapat malaman","body":"Magsimula sa ID na tugma sa hawak mong dokumento ngayon. Makakatulong ang postal ID, national ID transaction slip, o barangay certificate para makapag-apply sa iba pang ID."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'fast-valid-id'),
    'step',
    2,
    '{"title":"Prepare basic documents","body":"Bring your birth certificate or existing school/company ID, proof of address, and photocopies before going to the office.","step_number":1}'::jsonb,
    '{"title":"Ihanda ang basic documents","body":"Magdala ng birth certificate o existing school/company ID, proof of address, at photocopies bago pumunta sa opisina.","step_number":1}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'warning',
    1,
    '{"title":"Scam warning","body":"Never share OTPs, MPINs, or screen-sharing access. Real support will not ask for these.","severity":"high"}'::jsonb,
    '{"title":"Babala sa scam","body":"Huwag ibigay ang OTP, MPIN, o screen-sharing access. Hindi ito hihingin ng totoong support.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'step',
    2,
    '{"title":"Verify the sender","body":"Check the name, number, and reason for payment. Call the person through a trusted contact before sending money.","step_number":1}'::jsonb,
    '{"title":"I-verify ang nagpadala ng request","body":"Tingnan ang pangalan, number, at dahilan ng bayad. Tumawag muna gamit ang trusted contact bago magpadala.","step_number":1}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'first-job-requirements'),
    'what_to_know',
    1,
    '{"title":"What to prepare","body":"Most first jobs ask for a valid ID, resume, NBI or police clearance, SSS, PhilHealth, Pag-IBIG, TIN, and bank or payroll details."}'::jsonb,
    '{"title":"Ano ang ihahanda","body":"Karaniwang hinihingi sa unang trabaho ang valid ID, resume, NBI o police clearance, SSS, PhilHealth, Pag-IBIG, TIN, at bank o payroll details."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'first-job-requirements'),
    'step',
    2,
    '{"title":"Ask for the company checklist","body":"Before spending money, ask HR which documents are required now and which can follow after hiring.","step_number":1}'::jsonb,
    '{"title":"Humingi ng checklist sa company","body":"Bago gumastos, itanong sa HR kung anong documents ang kailangan agad at alin ang pwedeng ihabol after hiring.","step_number":1}'::jsonb
  ),
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
  ),
  (
    (select id from public.guides where slug = 'lost-wallet-first-steps'),
    'warning',
    1,
    '{"title":"Secure money access first","body":"Freeze or lock cards and e-wallet access before focusing on replacement IDs.","severity":"high"}'::jsonb,
    '{"title":"Unahin i-secure ang pera","body":"I-freeze o i-lock muna ang cards at e-wallet access bago asikasuhin ang replacement IDs.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'renting-first-time-checklist'),
    'mistake',
    1,
    '{"title":"Do not pay without proof","body":"Avoid paying reservation or deposit without a written agreement, receipt, and verified owner or landlord details."}'::jsonb,
    '{"title":"Huwag magbayad nang walang proof","body":"Iwasang magbayad ng reservation o deposit kung walang written agreement, resibo, at verified owner o landlord details."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'nbi-clearance-first-timers'),
    'step',
    1,
    '{"title":"Create or check your online account","body":"Use your own email and mobile number. Save your reference number before paying or going to the branch.","step_number":1}'::jsonb,
    '{"title":"Gumawa o i-check ang online account","body":"Gamitin ang sariling email at mobile number. I-save ang reference number bago magbayad o pumunta sa branch.","step_number":1}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'nbi-clearance-first-timers'),
    'mistake',
    2,
    '{"title":"Do not book without checking valid IDs","body":"Some branches may ask for accepted IDs. Prepare more than one ID or supporting document if possible."}'::jsonb,
    '{"title":"Huwag mag-book nang hindi chine-check ang valid IDs","body":"May branches na naghahanap ng accepted IDs. Maghanda ng higit sa isang ID o supporting document kung kaya."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'everyday-rights-philippines-checklist'),
    'what_to_know',
    1,
    '{"title":"What this guide covers","body":"This is not legal advice. It is a practical checklist of everyday rights many Filipinos can use when buying products, working for pay, sharing personal data, or dealing with authorities."}'::jsonb,
    '{"title":"Ano ang sakop ng guide na ito","body":"Hindi ito legal advice. Practical checklist ito ng everyday rights na magagamit ng maraming Pilipino kapag bumibili, nagtatrabaho, nagbibigay ng personal data, o humaharap sa authorities."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'everyday-rights-philippines-checklist'),
    'step',
    2,
    '{"title":"For defective products, do not stop at no return, no exchange","body":"If a product is defective or not as represented, keep the receipt, photos, messages, warranty card, and ask the store for the proper remedy. DTI consumer rights materials explain that consumers have rights to safety, information, choice, representation, redress, education, basic needs, and a healthy environment.","step_number":1,"items":["Receipt or proof of payment","Photo or video of defect","Chat/order details","Warranty card if any","Store name, branch, and date"]}'::jsonb,
    '{"title":"Kung defective ang binili, huwag tumigil sa no return, no exchange","body":"Kung defective o iba sa sinabi ang produkto, itago ang resibo, photos, messages, warranty card, at humingi ng tamang remedy sa store. Ayon sa DTI consumer rights materials, may karapatan ang consumer sa safety, information, choice, representation, redress, education, basic needs, at healthy environment.","step_number":1,"items":["Resibo o proof of payment","Photo o video ng defect","Chat/order details","Warranty card kung meron","Pangalan ng store, branch, at date"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'everyday-rights-philippines-checklist'),
    'step',
    3,
    '{"title":"For work pay, check the written basics","body":"Before resigning, accepting unpaid work, or ignoring missing pay, check your wage, overtime, rest day, holiday pay, service incentive leave, 13th month pay, and statutory deductions. Use DOLE/NWPC benefit references for the current rules.","step_number":2,"sample":"Hello po. Pwede po bang makahingi ng breakdown ng sahod ko, deductions, overtime/holiday pay kung meron, at 13th month computation?"}'::jsonb,
    '{"title":"Sa sweldo at trabaho, i-check ang written basics","body":"Bago mag-resign, pumayag sa unpaid work, o palampasin ang kulang na sahod, i-check ang wage, overtime, rest day, holiday pay, service incentive leave, 13th month pay, at statutory deductions. Gamitin ang DOLE/NWPC references para sa current rules.","step_number":2,"sample":"Hello po. Pwede po bang makahingi ng breakdown ng sahod ko, deductions, overtime/holiday pay kung meron, at 13th month computation?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'everyday-rights-philippines-checklist'),
    'step',
    4,
    '{"title":"For personal data, ask why it is needed","body":"Under data privacy rules, you have rights over your personal data, including being informed, accessing your data, correcting inaccurate data, objecting in certain cases, and filing a complaint with the National Privacy Commission.","step_number":3,"sample":"Para saan po gagamitin ang ID/photo/data ko, sino po ang may access, at paano po ito ide-delete kung hindi na kailangan?"}'::jsonb,
    '{"title":"Sa personal data, itanong kung bakit kailangan","body":"Sa data privacy rules, may rights ka sa personal data mo, kasama ang right to be informed, access your data, correct inaccurate data, object in certain cases, at mag-file ng complaint sa National Privacy Commission.","step_number":3,"sample":"Para saan po gagamitin ang ID/photo/data ko, sino po ang may access, at paano po ito ide-delete kung hindi na kailangan?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'everyday-rights-philippines-checklist'),
    'warning',
    5,
    '{"title":"If authorities are involved, stay calm and ask for basics","body":"The Bill of Rights protects people against unreasonable searches and seizures and protects due process. In risky situations, do not argue aggressively. Ask who is in charge, what the reason is, and contact family or legal help as soon as possible.","severity":"high"}'::jsonb,
    '{"title":"Kung may authorities, kumalma at itanong ang basics","body":"Pinoprotektahan ng Bill of Rights ang tao laban sa unreasonable searches and seizures at pinoprotektahan ang due process. Sa risky situations, huwag makipagtalo nang agresibo. Itanong kung sino ang in charge, ano ang dahilan, at kontakin agad ang pamilya o legal help.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'everyday-rights-philippines-checklist'),
    'mistake',
    6,
    '{"title":"Do not rely on viral legal posts alone","body":"Laws have details and exceptions. Use viral posts only as a starting point, then verify with official sources such as DTI, DOLE/NWPC, NPC, Supreme Court/Official Gazette, or a lawyer/public legal aid office."}'::jsonb,
    '{"title":"Huwag umasa sa viral legal posts lang","body":"May details at exceptions ang batas. Gawing starting point lang ang viral posts, tapos i-verify sa official sources tulad ng DTI, DOLE/NWPC, NPC, Supreme Court/Official Gazette, o lawyer/public legal aid office."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'resume-no-experience'),
    'step',
    1,
    '{"title":"Lead with useful proof","body":"Put education, projects, school leadership, volunteer work, certificates, and tools you can actually use.","step_number":1}'::jsonb,
    '{"title":"Unahin ang useful proof","body":"Ilagay ang education, projects, school leadership, volunteer work, certificates, at tools na kaya mong gamitin.","step_number":1}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'resume-no-experience'),
    'tip',
    2,
    '{"title":"Keep it one page","body":"For first-time applicants, one clean page is better than a long resume with filler."}'::jsonb,
    '{"title":"Gawing one page","body":"Para sa first-time applicants, mas okay ang isang malinis na page kaysa mahabang resume na puro filler."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'job-interview-basic-answers'),
    'step',
    1,
    '{"title":"Prepare your three stories","body":"Have one story about learning, one about responsibility, and one about solving a small problem.","step_number":1}'::jsonb,
    '{"title":"Maghanda ng tatlong kwento","body":"Maghanda ng isang kwento tungkol sa pagkatuto, isang responsibility, at isang maliit na problemang nasolusyonan.","step_number":1}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'step',
    1,
    '{"title":"Ask the maintaining balance first","body":"Before opening, ask about minimum deposit, maintaining balance, dormancy fees, and online banking access.","step_number":1}'::jsonb,
    '{"title":"Itanong muna ang maintaining balance","body":"Bago mag-open, itanong ang minimum deposit, maintaining balance, dormancy fees, at online banking access.","step_number":1}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'warning',
    1,
    '{"title":"Watch the total repayment","body":"Do not focus only on the cash you receive. Check total repayment, penalties, and collection practices.","severity":"high"}'::jsonb,
    '{"title":"Tingnan ang total na babayaran","body":"Huwag lang tumingin sa cash na matatanggap. I-check ang total repayment, penalties, at collection practices.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'step',
    1,
    '{"title":"Split before spending","body":"Set aside fixed bills, food, transport, savings, and debt payments first. Spend wants only after the basics are covered.","step_number":1}'::jsonb,
    '{"title":"Hatiin bago gumastos","body":"Ihiwalay muna ang bills, pagkain, pamasahe, savings, at bayad utang. Gumastos sa wants kapag covered na ang basics.","step_number":1}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'sss-number-first-job'),
    'step',
    1,
    '{"title":"Use your legal details","body":"Match your name, birthday, and civil status with your valid documents to avoid correction delays.","step_number":1}'::jsonb,
    '{"title":"Gamitin ang legal details","body":"Itugma ang pangalan, birthday, at civil status sa valid documents para iwas delay sa correction.","step_number":1}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'philhealth-pagibig-tin-basics'),
    'what_to_know',
    1,
    '{"title":"Each number has a different purpose","body":"SSS, PhilHealth, Pag-IBIG, and TIN are separate records. Ask HR which ones they can help process."}'::jsonb,
    '{"title":"Magkakaiba ang gamit ng bawat number","body":"Separate records ang SSS, PhilHealth, Pag-IBIG, at TIN. Itanong sa HR kung alin ang matutulungan nilang i-process."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'fake-job-offer-red-flags'),
    'warning',
    1,
    '{"title":"Do not pay recruitment fees","body":"Be careful when a recruiter asks for training fees, processing fees, or deposits before any verified contract.","severity":"high"}'::jsonb,
    '{"title":"Huwag magbayad ng recruitment fees","body":"Mag-ingat kapag may hinihinging training fee, processing fee, o deposit bago magkaroon ng verified contract.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'step',
    1,
    '{"title":"Pause before logging in","body":"Open the official app or website yourself instead of using a link from text, chat, or email.","step_number":1}'::jsonb,
    '{"title":"Huminto bago mag-login","body":"Buksan mismo ang official app o website imbes na gamitin ang link galing text, chat, o email.","step_number":1}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'what_to_know',
    1,
    '{"title":"The first hour is about blocking access","body":"Do not focus on buying a new phone first. Secure the SIM, e-wallets, banking apps, email, and social accounts before someone uses OTPs or saved sessions."}'::jsonb,
    '{"title":"Ang unang oras ay tungkol sa pag-block ng access","body":"Huwag unahin ang pagbili ng bagong phone. I-secure muna ang SIM, e-wallets, banking apps, email, at social accounts bago may gumamit ng OTP o saved sessions."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'warning',
    2,
    '{"title":"Lock money apps first","body":"Use another device to lock e-wallets, banking apps, email, and social accounts as soon as possible.","severity":"high"}'::jsonb,
    '{"title":"I-lock muna ang money apps","body":"Gumamit ng ibang device para i-lock ang e-wallets, banking apps, email, at social accounts sa lalong madaling panahon.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'step',
    3,
    '{"title":"Block or secure your e-wallet immediately","body":"For GCash, use another phone with the GCash app, go to Help Center on the login screen, choose Lost SIM/Phone, and follow the steps to block the account. Do this before trying to recover funds.","step_number":1,"items":["Use a spare or trusted phone","Open the GCash app, not a random browser link","Use Help Center from the login screen","Choose Lost SIM/Phone","Save the ticket or email update"]}'::jsonb,
    '{"title":"I-block o i-secure agad ang e-wallet","body":"Para sa GCash, gumamit ng ibang phone na may GCash app, pumunta sa Help Center sa login screen, piliin ang Lost SIM/Phone, at sundin ang steps para ma-block ang account. Gawin ito bago mag-recover ng funds.","step_number":1,"items":["Gumamit ng spare o trusted phone","Buksan ang GCash app, hindi random browser link","Gamitin ang Help Center sa login screen","Piliin ang Lost SIM/Phone","I-save ang ticket o email update"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'step',
    4,
    '{"title":"Call your telco or visit a store for SIM replacement","body":"Ask how to block the lost SIM and replace it. Bring ID and prepare an affidavit of loss if your provider requires it. Recovering the old number is usually safer than moving accounts one by one.","step_number":2,"items":["Valid government ID","Affidavit of loss if required","Old mobile number","SIM card holder or proof if available","List of accounts using that number for OTP"]}'::jsonb,
    '{"title":"Tumawag sa telco o pumunta sa store para sa SIM replacement","body":"Itanong kung paano i-block ang lost SIM at palitan ito. Magdala ng ID at maghanda ng affidavit of loss kung kailangan ng provider. Mas safe kadalasan ang ma-recover ang old number kaysa ilipat isa-isa ang accounts.","step_number":2,"items":["Valid government ID","Affidavit of loss kung kailangan","Old mobile number","SIM card holder o proof kung meron","Listahan ng accounts na gumagamit ng number para sa OTP"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'step',
    5,
    '{"title":"Change passwords from a clean device","body":"Use a trusted phone or computer to change passwords for email, banking, e-wallets, Facebook, Messenger, and other accounts. Start with the email used for password resets.","step_number":3,"items":["Primary email password","E-wallet and bank app passwords or PINs","Facebook, Messenger, and social accounts","Remove unknown logged-in devices","Turn on 2-step verification where possible"]}'::jsonb,
    '{"title":"Palitan ang passwords gamit ang malinis na device","body":"Gumamit ng trusted phone o computer para palitan ang passwords ng email, banking, e-wallets, Facebook, Messenger, at ibang accounts. Unahin ang email na ginagamit sa password reset.","step_number":3,"items":["Primary email password","E-wallet at bank app passwords o PINs","Facebook, Messenger, at social accounts","Tanggalin ang unknown logged-in devices","I-on ang 2-step verification kung pwede"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'tip',
    6,
    '{"title":"Prepare the IMEI before asking NTC or telco for blocking","body":"NTC lost/stolen cellphone guidance asks for proof details such as IMEI. Look for it on the phone box, receipt, account device record, or screenshots you saved earlier.","sample":"My phone was stolen. I need to block the SIM and ask about IMEI blocking. What exact documents do you need from me?"}'::jsonb,
    '{"title":"Ihanda ang IMEI bago magtanong sa NTC o telco tungkol sa blocking","body":"Sa NTC lost/stolen cellphone guidance, kailangan ang proof details tulad ng IMEI. Hanapin ito sa phone box, resibo, account device record, o screenshots na na-save mo dati.","sample":"Nanakaw po ang phone ko. Kailangan kong i-block ang SIM at magtanong tungkol sa IMEI blocking. Anong exact documents po ang kailangan ninyo sa akin?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'mistake',
    7,
    '{"title":"Posting your number publicly to ask for help","body":"Do not post your lost number, OTP screenshots, email, or account details publicly. Message official support channels directly and keep ticket numbers private."}'::jsonb,
    '{"title":"Pinopost publicly ang number para humingi ng tulong","body":"Huwag i-post publicly ang lost number, OTP screenshots, email, o account details. Dumiretso sa official support channels at itago ang ticket numbers."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'medical-emergency-documents'),
    'what_to_know',
    1,
    '{"title":"Prepare before there is panic","body":"This guide is not medical advice. It is a document and communication checklist so a patient or companion can move faster during an emergency, hospital visit, or transfer."}'::jsonb,
    '{"title":"Maghanda bago may panic","body":"Hindi ito medical advice. Document at communication checklist ito para mas mabilis kumilos ang pasyente o kasama kapag may emergency, hospital visit, o transfer."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'medical-emergency-documents'),
    'step',
    2,
    '{"title":"Save the emergency contact set","body":"Keep a printed or phone-accessible list of people and numbers to contact first. Include the national emergency hotline, local barangay or city emergency response number if you know it, nearest hospital, and one family decision-maker.","step_number":1,"items":["National emergency hotline: 911","Nearest hospital or clinic","Barangay/city emergency response number","Primary family contact","Backup contact if your phone is locked or dead"]}'::jsonb,
    '{"title":"I-save ang emergency contact set","body":"Maghanda ng printed o madaling buksan na listahan ng unang tatawagan. Isama ang national emergency hotline, barangay o city emergency response number kung alam mo, pinakamalapit na ospital, at isang family decision-maker.","step_number":1,"items":["National emergency hotline: 911","Pinakamalapit na hospital o clinic","Barangay/city emergency response number","Primary family contact","Backup contact kung locked o lowbat ang phone"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'medical-emergency-documents'),
    'step',
    3,
    '{"title":"Prepare the patient identity pack","body":"Put the patient details in one envelope or phone note. This helps admission, billing, PhilHealth checking, and contacting family if the patient cannot answer.","step_number":2,"items":["Valid ID or photo of ID","Full name and birthday","Address and emergency contact","PhilHealth number or Member Data Record if available","HMO card or company medical benefit details if any"]}'::jsonb,
    '{"title":"Ihanda ang patient identity pack","body":"Ilagay sa isang envelope o phone note ang patient details. Makakatulong ito sa admission, billing, PhilHealth checking, at pagtawag sa family kung hindi makasagot ang pasyente.","step_number":2,"items":["Valid ID o photo ng ID","Full name at birthday","Address at emergency contact","PhilHealth number o Member Data Record kung meron","HMO card o company medical benefit details kung meron"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'medical-emergency-documents'),
    'step',
    4,
    '{"title":"Write the medical notes that doctors ask for","body":"Do not guess during panic. Prepare a short note with current medicines, allergies, known conditions, recent procedures, and the time symptoms started.","step_number":3,"items":["Current medicines and dosage","Allergies to medicine or food","Known conditions like diabetes, asthma, hypertension, pregnancy","Recent surgery, confinement, or lab results","Time symptoms started and what happened before"]}'::jsonb,
    '{"title":"Isulat ang medical notes na madalas tinatanong","body":"Huwag manghula habang nagpapanic. Gumawa ng short note ng current medicines, allergies, known conditions, recent procedures, at oras kung kailan nagsimula ang symptoms.","step_number":3,"items":["Current medicines at dosage","Allergy sa gamot o pagkain","Known conditions tulad ng diabetes, asthma, hypertension, pregnancy","Recent surgery, confinement, o lab results","Oras nagsimula ang symptoms at ano ang nangyari bago iyon"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'medical-emergency-documents'),
    'tip',
    5,
    '{"title":"Ask about PhilHealth, billing, and social service early","body":"Once the patient is stable enough, ask where to verify PhilHealth eligibility, what documents are needed, and whether the hospital has a social service or medical social worker desk.","sample":"Where can we verify PhilHealth or HMO coverage, what documents do you need from us, and is there a social service desk we can ask about assistance?"}'::jsonb,
    '{"title":"Magtanong agad tungkol sa PhilHealth, billing, at social service","body":"Kapag stable na ang pasyente, itanong kung saan ipa-verify ang PhilHealth eligibility, anong documents ang kailangan, at kung may social service o medical social worker desk ang hospital.","sample":"Saan po pwedeng ipa-verify ang PhilHealth o HMO coverage, anong documents ang kailangan namin, at may social service desk po ba para magtanong tungkol sa assistance?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'medical-emergency-documents'),
    'warning',
    6,
    '{"title":"Do not hand original documents to random people","body":"Only give documents to official hospital staff, billing, admitting, or claims personnel. If someone offers to fix papers or speed up benefits for a fee, verify with the official hospital desk first.","severity":"high"}'::jsonb,
    '{"title":"Huwag ibigay ang original documents sa kung sinu-sino","body":"Ibigay lang ang documents sa official hospital staff, billing, admitting, o claims personnel. Kung may nag-aalok mag-ayos ng papeles o pabilisin ang benefits kapalit ng bayad, i-verify muna sa official hospital desk.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'medical-emergency-documents'),
    'mistake',
    7,
    '{"title":"Waiting until discharge before asking about documents","body":"Many families only ask about PhilHealth, HMO, social service, or receipts near discharge. Ask earlier so missing documents can be prepared while treatment is ongoing."}'::jsonb,
    '{"title":"Sa discharge pa lang nagtatanong tungkol sa documents","body":"Maraming pamilya ang nagtatanong lang tungkol sa PhilHealth, HMO, social service, o resibo kapag malapit na ang discharge. Magtanong nang mas maaga para maihanda ang kulang habang ongoing ang treatment."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'moving-out-budget'),
    'step',
    1,
    '{"title":"Compute the first month honestly","body":"Include deposit, advance rent, food, transport, utilities, internet, cleaning items, and emergency money.","step_number":1}'::jsonb,
    '{"title":"I-compute nang honest ang unang buwan","body":"Isama ang deposit, advance rent, pagkain, pamasahe, utilities, internet, cleaning items, at emergency money.","step_number":1}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'first-time-utility-bills'),
    'step',
    1,
    '{"title":"Track account numbers and due dates","body":"Save screenshots or receipts after paying. Keep account numbers in a notes app or notebook.","step_number":1}'::jsonb,
    '{"title":"I-track ang account numbers at due dates","body":"I-save ang screenshots o resibo pagkatapos magbayad. Itago ang account numbers sa notes app o notebook.","step_number":1}'::jsonb
  )
on conflict do nothing;

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
  'student-financial-aid-philippines-checklist',
  (select id from public.categories where slug = 'education'),
  'Student financial assistance programs Filipinos often miss',
  'Student financial assistance na madalas hindi alam ng Filipinos',
  'Check CHED, TESDA, DSWD, LGU, and school aid before giving up or trusting random posts.',
  'I-check ang CHED, TESDA, DSWD, LGU, at school aid bago sumuko o maniwala sa random posts.',
  true,
  false,
  7,
  'katamtaman',
  '1-2 oras mag-check',
  'Libre magtanong',
  array[
    'student aid',
    'scholarship',
    'financial assistance',
    'ched',
    'unifast',
    'tesda',
    'dswd education assistance',
    'lgu scholarship',
    'school assistance',
    'edukasyon',
    'tulong estudyante',
    'ayuda estudyante'
  ],
  'student aid scholarship financial assistance ched unifast tes tesda dswd education assistance lgu scholarship school assistance tuition subsidy tertiary education tulong estudyante ayuda estudyante',
  'student aid scholarship financial assistance ched unifast tes tesda dswd education assistance lgu scholarship school assistance tuition subsidy tertiary education tulong estudyante ayuda estudyante edukasyon',
  '[
    {"title":"Unified Student Financial Assistance System for Tertiary Education","publisher":"CHED","url":"https://ched.gov.ph/unifast/"},
    {"title":"Tertiary Education Subsidy","publisher":"UniFAST","url":"https://www.unifast.gov.ph/tes.html"},
    {"title":"Scholarship and Student Assistance Programs","publisher":"TESDA","url":"https://tesda.gov.ph/About/TESDA/1279"},
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

delete from public.guide_sections
where guide_id = (
  select id
  from public.guides
  where slug = 'student-financial-aid-philippines-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'what_to_know',
    1,
    '{"title":"Start with real offices, not viral posts","body":"Student aid in the Philippines can come from CHED-UniFAST, TESDA, DSWD AICS, LGUs, schools, and sometimes private foundations. The safest first step is to list which office actually covers your situation, then verify requirements directly."}'::jsonb,
    '{"title":"Magsimula sa totoong opisina, hindi sa viral post","body":"Ang student aid sa Pilipinas ay maaaring galing sa CHED-UniFAST, TESDA, DSWD AICS, LGU, school, at minsan private foundations. Pinaka-safe na unang step: alamin muna kung aling opisina ang sakop ng sitwasyon mo, tapos i-verify ang requirements diretso sa kanila."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'step',
    2,
    '{"title":"Check the right program bucket","body":"Do not search only for scholarship. Some help is called subsidy, grant-in-aid, training support, educational assistance, or student aid.","step_number":1,"items":["CHED-UniFAST for tertiary education subsidies and grants","TESDA for tech-voc scholarships or training support","DSWD AICS for education-related crisis assistance","LGU scholarship or educational assistance office","Your school registrar, guidance, student affairs, or financial aid office"]}'::jsonb,
    '{"title":"Hanapin ang tamang klase ng programa","body":"Huwag scholarship lang ang hanapin. Minsan ang tawag ay subsidy, grant-in-aid, training support, educational assistance, o student aid.","step_number":1,"items":["CHED-UniFAST para sa tertiary education subsidies at grants","TESDA para sa tech-voc scholarship o training support","DSWD AICS para sa education-related crisis assistance","LGU scholarship o educational assistance office","Registrar, guidance, student affairs, o financial aid office ng school"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'step',
    3,
    '{"title":"Decide which office to ask first","body":"Match your need to the office most likely to handle it. This prevents wasted messages, wrong lines, and fake pages pretending to process everything.","step_number":2,"items":["College tuition or tertiary subsidy: CHED-UniFAST or your school","Tech-voc training: TESDA or accredited training center","Crisis school expense: DSWD AICS or DSWD field office","City or provincial resident aid: LGU scholarship or education office","Unpaid school balance: registrar, student affairs, or financial aid office"]}'::jsonb,
    '{"title":"Piliin kung aling office ang unang tatanungin","body":"Itapat ang kailangan mo sa office na mas malamang may hawak nito. Iwas sayang message, maling pila, at fake pages na kunwari lahat kaya nilang i-process.","step_number":2,"items":["College tuition o tertiary subsidy: CHED-UniFAST o school mo","Tech-voc training: TESDA o accredited training center","Crisis school expense: DSWD AICS o DSWD field office","City o provincial resident aid: LGU scholarship o education office","Unpaid school balance: registrar, student affairs, o financial aid office"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'step',
    4,
    '{"title":"Do a quick eligibility check","body":"Before applying, check if your situation fits the program. This saves time and helps you ask the right office with the right proof.","step_number":3,"items":["Are you currently enrolled or accepted?","Are you college, tech-voc, senior high, or another school level?","Is your need tuition, unpaid balance, transport, food, books, training, or emergency school expense?","Are you a resident of a city, municipality, or province with student aid?","Do you have proof such as enrollment, billing, grades, ID, or indigency document?","Is the application posted by an official agency, LGU, school, or verified page?"]}'::jsonb,
    '{"title":"Mag-quick eligibility check muna","body":"Bago mag-apply, i-check kung pasok ang sitwasyon mo sa program. Makakatipid ito ng oras at mas malinaw mong matatanong ang tamang office na may tamang proof.","step_number":3,"items":["Currently enrolled o accepted ka ba?","College, tech-voc, senior high, o ibang school level ka ba?","Ang kailangan ba ay tuition, unpaid balance, pamasahe, pagkain, books, training, o emergency school expense?","Resident ka ba ng city, municipality, o province na may student aid?","May proof ka ba tulad ng enrollment, billing, grades, ID, o indigency document?","Official agency, LGU, school, o verified page ba ang nag-post ng application?"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'tip',
    5,
    '{"title":"Compare the main aid paths","body":"Use this as your first sorting tool. If one path does not fit, move to the next closest office instead of sending documents everywhere.","items":["CHED-UniFAST: best for college or tertiary subsidy; ask your school or CHED/UniFAST; usually needs enrollment and school records; watch for fake links using CHED names","TESDA: best for skills or tech-voc training; ask TESDA or accredited centers; usually needs ID and program requirements; watch for fake training fees","DSWD AICS: best for crisis school expense; ask DSWD or field office; usually needs proof of crisis and school expense; watch for fake ayuda pages","LGU scholarship: best for city or provincial resident aid; ask city hall, municipal hall, or LGU scholarship office; usually needs residency and school proof; watch for deadline changes","School aid: best for unpaid balance or school-specific support; ask registrar, student affairs, guidance, or financial aid office; usually needs enrollment and billing proof; watch for limited slots"]}'::jsonb,
    '{"title":"I-compare ang main aid paths","body":"Gamitin ito bilang unang sorting tool. Kapag hindi pasok ang isang path, lumipat sa mas tamang office imbes na kung saan-saan magpasa ng documents.","items":["CHED-UniFAST: para sa college o tertiary subsidy; magtanong sa school o CHED/UniFAST; madalas kailangan ang enrollment at school records; mag-ingat sa fake links na gumagamit ng pangalan ng CHED","TESDA: para sa skills o tech-voc training; magtanong sa TESDA o accredited centers; madalas kailangan ang ID at program requirements; mag-ingat sa fake training fees","DSWD AICS: para sa crisis school expense; magtanong sa DSWD o field office; madalas kailangan ang proof ng crisis at school expense; mag-ingat sa fake ayuda pages","LGU scholarship: para sa city o provincial resident aid; magtanong sa city hall, municipal hall, o LGU scholarship office; madalas kailangan ang residency at school proof; mag-ingat sa pabago-bagong deadline","School aid: para sa unpaid balance o school-specific support; magtanong sa registrar, student affairs, guidance, o financial aid office; madalas kailangan ang enrollment at billing proof; mag-ingat dahil limited ang slots"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'step',
    6,
    '{"title":"Prepare the usual proof before asking","body":"Requirements vary, but these documents are often requested. Having them ready makes it easier to ask a clear question and avoid repeated trips.","step_number":2,"items":["School ID or proof of enrollment","Certificate of registration or enrollment","Grades or transcript if available","Barangay certificate or certificate of indigency if requested","Parent or guardian ID when needed","Proof of billing, unpaid balance, or school-related expense","Contact number, address, and email"]}'::jsonb,
    '{"title":"Ihanda ang common proof bago magtanong","body":"Nag-iiba ang requirements, pero ito ang madalas hanapin. Kapag handa na, mas malinaw kang makakapagtanong at iwas balik-balik.","step_number":2,"items":["School ID o proof of enrollment","Certificate of registration o enrollment","Grades o transcript kung meron","Barangay certificate o certificate of indigency kung hinihingi","ID ng parent o guardian kung kailangan","Proof ng billing, balance, o school-related expense","Contact number, address, at email"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'step',
    7,
    '{"title":"Ask using one clear message","body":"Do not send a vague message like may ayuda po ba. Say your school level, location, need, and what document you already have.","step_number":3,"sample":"Hello po. Student po ako sa [school/program] at taga-[city/municipality]. Naghahanap po ako ng possible educational assistance para sa [tuition/books/transport/unpaid balance]. May open application po ba, ano po ang requirements, at saan po ang official submission?"}'::jsonb,
    '{"title":"Magtanong gamit ang isang malinaw na message","body":"Huwag basta mag-message ng may ayuda po ba. Sabihin ang school level, lugar, kailangan, at anong document ang meron ka na.","step_number":3,"sample":"Hello po. Student po ako sa [school/program] at taga-[city/municipality]. Naghahanap po ako ng possible educational assistance para sa [tuition/books/transport/unpaid balance]. May open application po ba, ano po ang requirements, at saan po ang official submission?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'warning',
    8,
    '{"title":"Fake scholarship posts often copy real program names","body":"Be careful when a post asks for processing fees, OTPs, passwords, bank login, or private documents through random links. Verify through the official agency, LGU, school office, or published contact details before submitting anything.","severity":"high","items":["Processing fee before assessment","OTP, password, bank login, or e-wallet login request","Shortened or random submission link","No official agency, school, or LGU page","Guaranteed approval promise","Extreme deadline pressure with no official memo"]}'::jsonb,
    '{"title":"Madalas ginagamit ng fake posts ang pangalan ng totoong programa","body":"Mag-ingat kapag may processing fee, OTP, password, bank login, o private documents na pinapasubmit sa random link. I-verify muna sa official agency, LGU, school office, o published contact details bago magpasa ng kahit ano.","severity":"high","items":["Processing fee bago ma-assess","Hinihinging OTP, password, bank login, o e-wallet login","Shortened o random submission link","Walang official agency, school, o LGU page","Guaranteed approval promise","Matinding deadline pressure pero walang official memo"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'mistake',
    9,
    '{"title":"Do not apply blindly to everything","body":"Some programs are for college, some for tech-voc, some for students in crisis, and some for residents of a specific city or province. Applying to the wrong program wastes time and can expose your documents to unsafe pages."}'::jsonb,
    '{"title":"Huwag basta apply sa lahat","body":"May program na para sa college, may para sa tech-voc, may para sa students in crisis, at may para lang sa residente ng isang city o province. Kapag mali ang program, sayang oras at mas delikado kung kung saan-saan napapasa ang documents mo."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'tip',
    10,
    '{"title":"Save proof before and after applying","body":"Keep screenshots and confirmation details in one folder. If there is a delay or issue, these are easier to show than trying to remember where you applied.","items":["Official post or memo","Requirements list","Deadline","Submission link or office address","Contact number or email","Confirmation receipt or reference number","Name of office or person contacted"]}'::jsonb,
    '{"title":"I-save ang proof bago at pagkatapos mag-apply","body":"Itago ang screenshots at confirmation details sa isang folder. Kapag may delay o issue, mas madaling ipakita ito kaysa alalahanin kung saan ka nag-apply.","items":["Official post o memo","Requirements list","Deadline","Submission link o office address","Contact number o email","Confirmation receipt o reference number","Pangalan ng office o taong nakausap"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'tip',
    11,
    '{"title":"Use three verification doors","body":"If you are unsure, verify through three doors: the agency website, your school office, and your LGU education or scholarship office. If all three do not recognize the offer, treat it as suspicious."}'::jsonb,
    '{"title":"Gamitin ang tatlong verification doors","body":"Kung hindi ka sigurado, mag-verify sa tatlong lugar: agency website, school office, at LGU education o scholarship office. Kung walang nakakakilala sa offer, ituring itong suspicious."}'::jsonb
  );
