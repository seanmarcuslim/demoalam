insert into public.categories (slug, name_en, name_fil, icon, color, order_index)
values
  ('ids', 'IDs', 'Mga ID', '🪪', '#2563A9', 1),
  ('work', 'Work', 'Trabaho', '💼', '#267A4D', 2),
  ('money', 'Money', 'Pera', '💸', '#D9902F', 3),
  ('gov', 'Government', 'Gobyerno', '🏛️', '#6D5BA8', 4),
  ('scams', 'Scams', 'Scam Alerts', '🚨', '#C83E3A', 5),
  ('emergency', 'Emergency', 'Emergency', '🚑', '#B86B16', 6),
  ('adulting', 'Adulting', 'Adulting', '🎓', '#2F8277', 7)
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
    (select id from public.categories where slug = 'scams'),
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
    (select id from public.categories where slug = 'scams'),
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
    (select id from public.categories where slug = 'emergency'),
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
    (select id from public.categories where slug = 'emergency'),
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
    when 'phishing-link-checklist' then
      '[{"title":"GCash Help Center","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/"}]'::jsonb
    else official_sources
  end,
  updated_at = now()
where slug in (
  'gcash-scam-red-flags',
  'dswd-aics-assistance-checklist',
  'everyday-rights-philippines-checklist',
  'sss-number-first-job',
  'philhealth-pagibig-tin-basics',
  'phishing-link-checklist'
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
    'warning',
    1,
    '{"title":"Lock money apps first","body":"Use another device to lock e-wallets, banking apps, email, and social accounts as soon as possible.","severity":"high"}'::jsonb,
    '{"title":"I-lock muna ang money apps","body":"Gumamit ng ibang device para i-lock ang e-wallets, banking apps, email, at social accounts sa lalong madaling panahon.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'medical-emergency-documents'),
    'tip',
    1,
    '{"title":"Make an emergency folder","body":"Keep copies of IDs, PhilHealth details, emergency contacts, allergies, and medicines in one easy-to-find place."}'::jsonb,
    '{"title":"Gumawa ng emergency folder","body":"Ilagay sa isang madaling makita na lugar ang copies ng IDs, PhilHealth details, emergency contacts, allergies, at medicines."}'::jsonb
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
