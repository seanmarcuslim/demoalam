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
  'philhealth-hospital-benefits-checklist',
  (select id from public.categories where slug = 'healthcare'),
  'PhilHealth hospital benefits checklist before discharge',
  'PhilHealth hospital benefits checklist bago ma-discharge',
  'Ask the right hospital billing, PhilHealth, HMO, and social service questions before the final bill surprises you.',
  'Itanong ang tamang billing, PhilHealth, HMO, at social service questions bago ka mabigla sa final bill.',
  true,
  false,
  true,
  7,
  'katamtaman',
  '15-45 minuto mag-verify',
  'Libre magtanong; hospital costs vary',
  array[
    'healthcare',
    'philhealth',
    'hospital',
    'hospital bill',
    'philhealth benefits',
    'case rate',
    'member data record',
    'mdr',
    'claim form 1',
    'hmo',
    'billing',
    'social service'
  ],
  'philhealth hospital benefits hospital bill case rate member data record mdr claim form 1 cf1 philhealth eligibility benefit eligibility form pbef hmo billing discharge social service medical social worker accredited hospital inpatient outpatient',
  'philhealth hospital benefits hospital bill case rate member data record mdr claim form 1 cf1 philhealth eligibility benefit eligibility form pbef hmo billing discharge social service medical social worker accredited hospital inpatient outpatient',
  '[
    {"title":"Benefits","publisher":"PhilHealth","url":"https://www.philhealth.gov.ph/benefits/"},
    {"title":"Online Services","publisher":"PhilHealth","url":"https://www.philhealth.gov.ph/services/"},
    {"title":"Downloads","publisher":"PhilHealth","url":"https://www.philhealth.gov.ph/downloads/"},
    {"title":"Members","publisher":"PhilHealth","url":"https://www.philhealth.gov.ph/members/"},
    {"title":"PhilHealth YAKAP primary care program update","publisher":"PhilHealth","url":"https://www.philhealth.gov.ph/news/up/article/2026/news_69925c2c0008f.php"}
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
where guide_id = (select id from public.guides where slug = 'philhealth-hospital-benefits-checklist');

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'philhealth-hospital-benefits-checklist'),
    'what_to_know',
    1,
    $${
      "title":"PhilHealth is a benefit deduction process, not automatic cash in hand",
      "body":"Many families only ask about PhilHealth when the final bill is already stressful. PhilHealth benefits are usually deducted by the accredited facility from the total bill when the claim is properly processed. Ask early so missing documents, eligibility issues, HMO coordination, or social service options can be handled before discharge.",
      "items":["Ask if the hospital or facility is PhilHealth-accredited for your case","Ask billing or claims what PhilHealth documents are still missing","Ask if the benefit will be deducted before discharge or handled another way","Ask how HMO, company medical benefit, or guarantee letters affect billing","Do not assume every cost is covered or fully deducted"]
    }$$::jsonb,
    $${
      "title":"Ang PhilHealth ay benefit deduction process, hindi automatic cash sa kamay",
      "body":"Maraming pamilya ang nagtatanong lang tungkol sa PhilHealth kapag stressful na ang final bill. Kadalasan, ang PhilHealth benefits ay binabawas ng accredited facility sa total bill kapag maayos ang claim process. Magtanong nang maaga para maayos ang kulang na documents, eligibility issues, HMO coordination, o social service options bago discharge.",
      "items":["Itanong kung PhilHealth-accredited ang hospital o facility para sa case mo","Itanong sa billing o claims kung anong PhilHealth documents pa ang kulang","Itanong kung mababawas ang benefit bago discharge o ibang process ang gagamitin","Itanong paano maaapektuhan ng HMO, company medical benefit, o guarantee letter ang billing","Huwag i-assume na covered o fully deducted ang lahat ng gastos"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'philhealth-hospital-benefits-checklist'),
    'warning',
    2,
    $${
      "title":"START HERE: ask billing or claims before discharge day",
      "body":"Do not wait until the cashier is asking for payment. As soon as the patient is stable enough, ask the official billing, PhilHealth, claims, HMO, or social service desk what is needed and what can still reduce the payable amount.",
      "severity":"high",
      "items":["Do not hand documents to unofficial helpers","Do not pay someone promising faster PhilHealth posting or guaranteed deduction","Do not send OTP, bank login, e-wallet login, or full ID photos through random links","Ask for receipts, receiving copies, claim instructions, and staff/unit details","Keep copies or photos of all documents submitted"]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: magtanong sa billing o claims bago discharge day",
      "body":"Huwag hintayin na nasa cashier ka na at kailangan nang magbayad. Kapag stable na ang pasyente, magtanong agad sa official billing, PhilHealth, claims, HMO, o social service desk kung ano ang kailangan at ano pa ang puwedeng makabawas sa babayaran.",
      "severity":"high",
      "items":["Huwag ibigay ang documents sa unofficial helpers","Huwag magbayad sa nangangakong bibilisan ang PhilHealth posting o guaranteed deduction","Huwag mag-send ng OTP, bank login, e-wallet login, o full ID photos sa random links","Humingi ng receipts, receiving copies, claim instructions, at staff/unit details","Magtabi ng copies o photos ng lahat ng documents na ipinasa"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'philhealth-hospital-benefits-checklist'),
    'step',
    3,
    $${
      "title":"Ask what PhilHealth documents are needed",
      "body":"Requirements can depend on membership status, facility process, case type, and whether the hospital can verify eligibility electronically.",
      "step_number":1,
      "items":["Member Data Record or proof of PhilHealth number if available","PhilHealth Benefit Eligibility Form or facility eligibility verification if available","Claim Form 1 if the facility asks for it","Valid ID and patient details that match records","Authorization or representative document if someone else is processing"]
    }$$::jsonb,
    $${
      "title":"Itanong kung anong PhilHealth documents ang kailangan",
      "body":"Puwedeng mag-iba ang requirements depende sa membership status, facility process, case type, at kung kaya ng hospital i-verify electronically ang eligibility.",
      "step_number":1,
      "items":["Member Data Record o proof ng PhilHealth number kung meron","PhilHealth Benefit Eligibility Form o facility eligibility verification kung available","Claim Form 1 kung hinihingi ng facility","Valid ID at patient details na tugma sa records","Authorization o representative document kung ibang tao ang magpa-process"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'philhealth-hospital-benefits-checklist'),
    'step',
    4,
    $${
      "title":"Clarify what benefit is being applied",
      "body":"PhilHealth has different benefit packages and case rates. You do not need to memorize the amounts, but you should ask which benefit or case rate the facility is applying and what costs remain.",
      "step_number":2,
      "items":["What PhilHealth benefit or case rate applies to this diagnosis or procedure?","What amount is expected to be deducted from the bill?","What charges are not covered or not deducted?","Does the claim depend on doctor documentation, diagnosis, procedure, or admission status?","Can we get a billing breakdown before final payment?"]
    }$$::jsonb,
    $${
      "title":"Linawin kung anong benefit ang ina-apply",
      "body":"May iba't ibang benefit packages at case rates ang PhilHealth. Hindi kailangang kabisaduhin ang amount, pero dapat itanong kung anong benefit o case rate ang ina-apply ng facility at ano pa ang matitirang gastos.",
      "step_number":2,
      "items":["Anong PhilHealth benefit o case rate ang applicable sa diagnosis o procedure na ito?","Magkano ang expected na mababawas sa bill?","Anong charges ang hindi covered o hindi mababawas?","Depende ba ang claim sa doctor documentation, diagnosis, procedure, o admission status?","Puwede bang humingi ng billing breakdown bago final payment?"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'philhealth-hospital-benefits-checklist'),
    'step',
    5,
    $${
      "title":"Coordinate PhilHealth, HMO, company benefit, and social service",
      "body":"If you have multiple possible help sources, ask how they interact. Some hospitals have a social service or medical social worker desk that can assess assistance options.",
      "step_number":3,
      "items":["Does HMO need approval before discharge or procedure?","Will PhilHealth be applied before or after HMO/company benefit?","Is there a social service or medical social worker desk?","Can we ask about DSWD AICS, guarantee letters, charity assistance, or installment options?","What exact documents should we prepare today?"]
    }$$::jsonb,
    $${
      "title":"I-coordinate ang PhilHealth, HMO, company benefit, at social service",
      "body":"Kung may maraming posibleng tulong, itanong kung paano sila pinagsasabay. May hospitals na may social service o medical social worker desk na puwedeng mag-assess ng assistance options.",
      "step_number":3,
      "items":["Kailangan ba ng HMO approval bago discharge o procedure?","Mauuna ba ang PhilHealth bago HMO/company benefit o pagkatapos?","May social service o medical social worker desk ba?","Puwede bang magtanong tungkol sa DSWD AICS, guarantee letters, charity assistance, o installment options?","Anong exact documents ang dapat ihanda today?"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'philhealth-hospital-benefits-checklist'),
    'mistake',
    6,
    $${
      "title":"Common billing mistakes",
      "body":"These mistakes can make discharge more stressful or cause families to miss assistance options.",
      "items":["Asking about PhilHealth only when the final bill is ready","Assuming PhilHealth will cover the entire bill","Not checking if patient details match PhilHealth records","Forgetting HMO pre-approval or company benefit instructions","Not asking the social service desk until after payment","Giving original documents to unofficial helpers","Leaving without receipts, billing breakdown, claim instructions, or copies"]
    }$$::jsonb,
    $${
      "title":"Karaniwang billing mistakes",
      "body":"Puwedeng mas maging stressful ang discharge o may ma-miss na assistance options dahil sa mistakes na ito.",
      "items":["Sa final bill pa lang nagtatanong tungkol sa PhilHealth","Ina-assume na buong bill ang covered ng PhilHealth","Hindi chine-check kung tugma ang patient details sa PhilHealth records","Nakakalimutan ang HMO pre-approval o company benefit instructions","Hindi nagtatanong sa social service desk bago magbayad","Ibinibigay ang original documents sa unofficial helpers","Umalis nang walang receipts, billing breakdown, claim instructions, o copies"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'philhealth-hospital-benefits-checklist'),
    'tip',
    7,
    $${
      "title":"Hospital billing question checklist",
      "body":"Ask these while the patient is still admitted or before final payment.",
      "items":["Is the facility PhilHealth-accredited for this case?","What PhilHealth benefit or case rate is being applied?","What documents are missing from us?","Can we see an updated billing breakdown?","How do HMO, company benefit, or guarantee letters affect the remaining balance?","Is there a social service desk or medical social worker we can speak with?","What receipts, claim records, or discharge papers should we keep?"]
    }$$::jsonb,
    $${
      "title":"Hospital billing question checklist",
      "body":"Itanong ito habang admitted pa ang pasyente o bago final payment.",
      "items":["PhilHealth-accredited ba ang facility para sa case na ito?","Anong PhilHealth benefit o case rate ang ina-apply?","Anong documents ang kulang mula sa amin?","Puwede bang makita ang updated billing breakdown?","Paano maaapektuhan ng HMO, company benefit, o guarantee letter ang remaining balance?","May social service desk o medical social worker ba na puwedeng kausapin?","Anong receipts, claim records, o discharge papers ang dapat naming itabi?"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'philhealth-hospital-benefits-checklist'),
    'tip',
    8,
    $${
      "title":"Sample message to billing or claims",
      "body":"Use this when you are confused about the bill.",
      "sample":"Hello. Our patient is admitted for [case/procedure]. Can you help us verify PhilHealth eligibility, the benefit or case rate being applied, missing documents, HMO/company benefit coordination, and whether we can speak with social service before discharge?"
    }$$::jsonb,
    $${
      "title":"Sample message sa billing o claims",
      "body":"Gamitin ito kapag nalilito sa bill.",
      "sample":"Hello po. Admitted po ang patient namin for [case/procedure]. Puwede po ba kaming magpa-verify ng PhilHealth eligibility, benefit o case rate na ina-apply, kulang na documents, HMO/company benefit coordination, at kung puwede kaming makausap ng social service bago discharge?"
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'philhealth-hospital-benefits-checklist'),
    'tip',
    9,
    $${
      "title":"What to expect",
      "body":"Billing can change as medicines, labs, procedures, doctor fees, room charges, supplies, and discounts are posted. Ask for updates calmly and keep records. PhilHealth helps reduce eligible costs, but it does not mean the final bill will always become zero."
    }$$::jsonb,
    $${
      "title":"Ano ang aasahan",
      "body":"Puwedeng magbago ang billing habang napo-post ang medicines, labs, procedures, doctor fees, room charges, supplies, at discounts. Magtanong nang mahinahon at magtabi ng records. Nakakatulong ang PhilHealth sa eligible costs, pero hindi ibig sabihin laging magiging zero ang final bill."
    }$$::jsonb
  );
