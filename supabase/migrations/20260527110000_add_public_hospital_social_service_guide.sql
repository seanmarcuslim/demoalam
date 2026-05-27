insert into public.guides (
  slug,
  category_id,
  title_en,
  title_fil,
  tagline_en,
  tagline_fil,
  is_featured,
  is_urgent,
  is_published,
  read_time_min,
  difficulty,
  estimated_time,
  estimated_cost,
  tags,
  keywords_en,
  keywords_fil,
  official_sources,
  published_at,
  updated_at
)
values (
  'public-hospital-social-service-desk-guide',
  (select id from public.categories where slug = 'healthcare'),
  'Public hospital social service desk guide before paying',
  'Social service desk sa public hospital bago magbayad',
  'Ask the right desk, prepare the right papers, and avoid fake helpers before settling a hospital bill.',
  'Hanapin ang tamang desk, ihanda ang tamang papeles, at iwasan ang pekeng tumutulong bago magbayad ng hospital bill.',
  true,
  false,
  true,
  7,
  'katamtaman',
  '20-60 minuto magtanong at maghanda',
  'Libre magtanong; depende ang tulong sa assessment',
  array[
    'healthcare',
    'public hospital',
    'social service',
    'medical social worker',
    'malasakit center',
    'hospital bill',
    'medical assistance',
    'maifip',
    'maipp',
    'aics',
    'pcso',
    'philhealth',
    'guarantee letter'
  ],
  'public hospital social service medical social worker malasakit center hospital bill medical assistance financial assistance maifip maipp aics dswd pcso philhealth guarantee letter clinical abstract prescription final bill itemized bill statement of account indigent financially incapacitated patient',
  'public hospital social service medical social worker malasakit center hospital bill medical assistance financial assistance maifip maipp aics dswd pcso philhealth guarantee letter clinical abstract reseta final bill itemized bill statement of account indigent financially incapacitated patient tulong medikal bayarin ospital',
  '[
    {"title":"Republic Act No. 11463 - Malasakit Centers Act","publisher":"Lawphil","url":"https://lawphil.net/statutes/repacts/ra2019/ra_11463_2019.html"},
    {"title":"AICS FAQs","publisher":"DSWD AICS","url":"https://aics.dswd.gov.ph/about-us/faqs/"},
    {"title":"AICS category updates","publisher":"DSWD","url":"https://www.dswd.gov.ph/category/aics/"},
    {"title":"Medical Social Service general information","publisher":"Bicol Medical Center - DOH hospital","url":"https://bmc.doh.gov.ph/patient-care/medical-social-service/general-information"},
    {"title":"Medical Social Work Department","publisher":"Dr. Jose Fabella Memorial Hospital - DOH hospital","url":"https://fabella.doh.gov.ph/medical-social-work-department-mswd/"}
  ]'::jsonb,
  now(),
  now()
)
on conflict (slug) do update
set
  category_id = excluded.category_id,
  title_en = excluded.title_en,
  title_fil = excluded.title_fil,
  tagline_en = excluded.tagline_en,
  tagline_fil = excluded.tagline_fil,
  is_featured = excluded.is_featured,
  is_urgent = excluded.is_urgent,
  is_published = excluded.is_published,
  read_time_min = excluded.read_time_min,
  difficulty = excluded.difficulty,
  estimated_time = excluded.estimated_time,
  estimated_cost = excluded.estimated_cost,
  tags = excluded.tags,
  keywords_en = excluded.keywords_en,
  keywords_fil = excluded.keywords_fil,
  official_sources = excluded.official_sources,
  updated_at = now();

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'public-hospital-social-service-desk-guide'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'public-hospital-social-service-desk-guide'),
    'what_to_know',
    1,
    $${
      "title":"Social service helps assess assistance options, not guarantee free care",
      "body":"In many public hospitals, the Medical Social Service, Malasakit Center, or similar assistance desk helps patients understand possible medical or financial assistance. The usual path is assessment first, then document checking, then referral or assistance processing if eligible. It is not an instant payout line.",
      "items":["Ask the hospital where the official Medical Social Service or Malasakit desk is","Assistance depends on assessment, documents, program rules, and available funds","PhilHealth, PCSO, DSWD AICS, DOH medical assistance, hospital charity, or guarantee letters may be handled differently","Do not pay a private helper to process official assistance","Start asking before final payment or discharge day"]
    }$$::jsonb,
    $${
      "title":"Tumutulong ang social service mag-assess ng options, hindi ito guarantee na libre agad",
      "body":"Sa maraming public hospital, ang Medical Social Service, Malasakit Center, o katulad na assistance desk ang tumutulong sa pasyente na maintindihan ang posibleng medical o financial assistance. Kadalasan, assessment muna, document checking, tapos referral o processing kung eligible. Hindi ito instant payout line.",
      "items":["Itanong sa hospital kung saan ang official Medical Social Service o Malasakit desk","Depende ang tulong sa assessment, documents, program rules, at available funds","Puwedeng magkaiba ang process ng PhilHealth, PCSO, DSWD AICS, DOH medical assistance, hospital charity, o guarantee letter","Huwag magbayad sa private helper para iproseso ang official assistance","Magtanong bago final payment o discharge day"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'public-hospital-social-service-desk-guide'),
    'warning',
    2,
    $${
      "title":"START HERE: go to the official hospital desk only",
      "body":"Hospital bills make families vulnerable to fixers and fake helpers. Use the hospital's official desk, official cashier, official social worker, or official agency counter. If someone asks for a fee to guarantee approval, treat it as a red flag.",
      "severity":"high",
      "items":["Do not give original documents to people outside the official desk","Do not pay for priority number, guaranteed approval, or faster release","Do not send IDs, hospital bills, or bank details to random Facebook pages or private messages","Ask for the name of the office, queue process, required documents, and receiving copy","Keep receipts, claim stubs, screenshots, and transaction numbers"]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: sa official hospital desk lang lumapit",
      "body":"Kapag malaki ang hospital bill, madaling malapitan ng fixers at pekeng tumutulong ang pamilya. Gamitin ang official desk ng hospital, official cashier, official social worker, o official agency counter. Kapag may humihingi ng bayad kapalit ng guaranteed approval, red flag iyon.",
      "severity":"high",
      "items":["Huwag ibigay ang original documents sa taong wala sa official desk","Huwag magbayad para sa priority number, guaranteed approval, o mabilis na release","Huwag mag-send ng IDs, hospital bills, o bank details sa random Facebook pages o private messages","Itanong ang office name, queue process, required documents, at receiving copy","Itabi ang receipts, claim stubs, screenshots, at transaction numbers"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'public-hospital-social-service-desk-guide'),
    'step',
    3,
    $${
      "title":"Ask which desk handles assistance",
      "body":"Hospitals use different names and workflows. Ask clearly instead of guessing where to line up.",
      "step_number":1,
      "items":["Medical Social Service or Medical Social Work Department","Malasakit Center, if available in the hospital","PhilHealth or claims desk","Billing or cashier window","HMO, company benefit, or guarantee letter desk if applicable"]
    }$$::jsonb,
    $${
      "title":"Itanong kung aling desk ang humahawak ng assistance",
      "body":"Magkakaiba ang pangalan at workflow ng hospitals. Mas mabuting magtanong nang malinaw kaysa pumila sa maling lugar.",
      "step_number":1,
      "items":["Medical Social Service o Medical Social Work Department","Malasakit Center, kung meron sa hospital","PhilHealth o claims desk","Billing o cashier window","HMO, company benefit, o guarantee letter desk kung applicable"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'public-hospital-social-service-desk-guide'),
    'step',
    4,
    $${
      "title":"Prepare the usual papers before asking",
      "body":"Requirements can differ by hospital and program, but these are commonly requested for assessment or referral.",
      "step_number":2,
      "items":["Valid ID of patient and representative, if any","Clinical abstract, medical certificate, prescription, or procedure request","Updated hospital bill, statement of account, or itemized bill","PhilHealth details, HMO papers, or company benefit documents if available","Proof of relationship or authorization if a representative is processing","Contact number and address details that match the records"]
    }$$::jsonb,
    $${
      "title":"Ihanda ang karaniwang papeles bago magtanong",
      "body":"Puwedeng mag-iba ang requirements depende sa hospital at program, pero madalas itong hinihingi para sa assessment o referral.",
      "step_number":2,
      "items":["Valid ID ng pasyente at representative kung meron","Clinical abstract, medical certificate, reseta, o procedure request","Updated hospital bill, statement of account, o itemized bill","PhilHealth details, HMO papers, o company benefit documents kung meron","Proof of relationship o authorization kung representative ang nagpa-process","Contact number at address details na tugma sa records"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'public-hospital-social-service-desk-guide'),
    'step',
    5,
    $${
      "title":"Ask what kind of help is realistic",
      "body":"The goal is to understand the possible path before paying or leaving. Be direct, calm, and specific.",
      "step_number":3,
      "items":["Can the patient be assessed for hospital social service assistance?","Is there a Malasakit Center process for this case?","Should we apply through DSWD AICS, PCSO, DOH medical assistance, or another desk?","Is assistance deducted from the bill, issued as a guarantee letter, or handled another way?","What can be processed today, and what needs follow-up?"]
    }$$::jsonb,
    $${
      "title":"Itanong kung anong tulong ang realistic",
      "body":"Ang goal ay maintindihan ang posibleng path bago magbayad o umalis. Maging diretso, mahinahon, at specific.",
      "step_number":3,
      "items":["Puwede bang ma-assess ang pasyente para sa hospital social service assistance?","May Malasakit Center process ba para sa case na ito?","Dapat ba kaming mag-apply sa DSWD AICS, PCSO, DOH medical assistance, o ibang desk?","Mababawas ba sa bill, guarantee letter ba, o ibang process ang assistance?","Ano ang puwedeng ma-process today, at ano ang kailangan ng follow-up?"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'public-hospital-social-service-desk-guide'),
    'mistake',
    6,
    $${
      "title":"Common mistakes that waste time or money",
      "body":"Most mistakes happen because families are tired, scared, or rushing to leave the hospital.",
      "items":["Paying first before asking if assessment is still possible","Going to random online pages instead of the hospital's official desk","Not bringing an updated hospital bill or clinical abstract","Assuming Malasakit, AICS, PCSO, PhilHealth, and hospital charity are the same process","Handing original documents to unofficial helpers","Leaving without a receiving copy, instruction sheet, or contact point"]
    }$$::jsonb,
    $${
      "title":"Karaniwang pagkakamali na sayang sa oras o pera",
      "body":"Madalas nangyayari ito dahil pagod, takot, o nagmamadaling makalabas ng hospital ang pamilya.",
      "items":["Nagbabayad muna bago itanong kung puwede pang ma-assess","Pumupunta sa random online pages imbes na official hospital desk","Walang dalang updated hospital bill o clinical abstract","Ina-assume na pareho ang process ng Malasakit, AICS, PCSO, PhilHealth, at hospital charity","Ibinibigay ang original documents sa unofficial helpers","Umaalis nang walang receiving copy, instruction sheet, o contact point"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'public-hospital-social-service-desk-guide'),
    'tip',
    7,
    $${
      "title":"Desk question checklist",
      "body":"Ask these before final payment or discharge.",
      "items":["Where is the official Medical Social Service, Medical Social Work, or Malasakit desk?","What documents are required for assessment?","Can the current hospital bill still be assessed before payment?","What assistance path applies: PhilHealth, DSWD AICS, PCSO, DOH medical assistance, hospital charity, or guarantee letter?","Will assistance be deducted from the bill or processed separately?","What proof should we keep after submitting documents?"]
    }$$::jsonb,
    $${
      "title":"Checklist ng itatanong sa desk",
      "body":"Itanong ito bago final payment o discharge.",
      "items":["Saan ang official Medical Social Service, Medical Social Work, o Malasakit desk?","Anong documents ang kailangan para sa assessment?","Puwede pa bang ma-assess ang current hospital bill bago magbayad?","Anong assistance path ang applicable: PhilHealth, DSWD AICS, PCSO, DOH medical assistance, hospital charity, o guarantee letter?","Mababawas ba sa bill ang assistance o separate process ito?","Anong proof ang dapat naming itabi pagkatapos mag-submit ng documents?"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'public-hospital-social-service-desk-guide'),
    'tip',
    8,
    $${
      "title":"Sample message to the hospital desk",
      "body":"Use this when you need to ask without sounding demanding.",
      "sample":"Hello po. Admitted po ang patient namin and we are preparing for the hospital bill. Saan po ang official Medical Social Service or Malasakit desk? Ano po ang documents needed for assessment, and may assistance path po ba na puwedeng i-check before final payment or discharge?"
    }$$::jsonb,
    $${
      "title":"Sample message sa hospital desk",
      "body":"Gamitin ito kapag kailangan magtanong nang maayos at hindi demanding.",
      "sample":"Hello po. Admitted po ang patient namin at naghahanda po kami sa hospital bill. Saan po ang official Medical Social Service o Malasakit desk? Ano po ang documents needed for assessment, at may assistance path po ba na puwedeng i-check bago final payment o discharge?"
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'public-hospital-social-service-desk-guide'),
    'tip',
    9,
    $${
      "title":"What to expect",
      "body":"Assessment can take time. Some help may be partial, document-based, or subject to available funds and program rules. A calm paper trail matters: keep copies, names of offices, dates, instructions, and proof of submission."
    }$$::jsonb,
    $${
      "title":"Ano ang aasahan",
      "body":"Puwedeng tumagal ang assessment. May tulong na partial lang, document-based, o depende sa available funds at program rules. Mahalaga ang malinaw na paper trail: magtabi ng copies, pangalan ng offices, dates, instructions, at proof of submission."
    }$$::jsonb
  );
