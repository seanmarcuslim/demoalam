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
  'pcso-medical-assistance-checklist',
  (select id from public.categories where slug = 'healthcare'),
  'PCSO medical assistance checklist before you line up',
  'PCSO medical assistance checklist bago pumila',
  'Know the right route, prepare the documents, and avoid fixers before applying for PCSO MAP assistance.',
  'Alamin ang tamang route, ihanda ang documents, at umiwas sa fixers bago mag-apply sa PCSO MAP assistance.',
  true,
  false,
  true,
  7,
  'katamtaman',
  '30-60 minuto para ayusin ang documents; depende sa hospital, branch, o online route ang processing',
  'Libre ang application; posibleng may gastos sa photocopy, scan, print, pamasahe, o internet data',
  array[
    'pcso',
    'medical assistance',
    'map',
    'malasakit center',
    'hospital bill',
    'guarantee letter',
    'medical abstract',
    'statement of account',
    'healthcare',
    'financial assistance'
  ],
  'pcso medical assistance medical access program map malasakit center hospital bill guarantee letter gl medical abstract statement of account soa confinement chemotherapy dialysis medicine prescription quotation hospital assistance medical financial assistance pcso online application branch office',
  'pcso medical assistance medical access program map malasakit center hospital bill guarantee letter gl medical abstract statement of account soa confinement chemo chemotherapy dialysis gamot reseta quotation hospital assistance medical financial assistance pcso online application branch office tulong medikal',
  $$[
    {"title":"Medical Assistance Program","publisher":"Philippine Charity Sweepstakes Office","url":"https://pcso-gov.ph/ProgramsAndServices/CAD/MedicalAccessProgram.html"},
    {"title":"PCSO Frequently Asked Questions: Medical Access Program Requirements","publisher":"Philippine Charity Sweepstakes Office","url":"https://www.pcso.gov.ph/FAQs.aspx"},
    {"title":"2025 PCSO Citizen's Charter","publisher":"Philippine Charity Sweepstakes Office","url":"https://www.pcso.gov.ph/pcsofiles/transparency/2025%20PCSO%20Citizen%27s%20Charter.pdf"},
    {"title":"NCR MAP Online Medicine Procedure for Outpatients","publisher":"Philippine Charity Sweepstakes Office","url":"https://www.pcso.gov.ph/pcsofiles/downloads/MAP-NCR-New-Medicine-Procedure-for-Outpatient-2021-09-28.pdf"},
    {"title":"DOH-DSWD-PCSO-PhilHealth Joint Administrative Order on Malasakit Centers","publisher":"Department of Health, DSWD, PCSO, and PhilHealth","url":"https://law.upd.edu.ph/wp-content/uploads/2021/04/DOH-DSWD-PCSO-PHIC-Joint-Administrative-Order-No-2020-0001.pdf"}
  ]$$::jsonb,
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
  published_at = excluded.published_at,
  updated_at = now();

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'pcso-medical-assistance-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'pcso-medical-assistance-checklist'),
    'what_to_know',
    1,
    $${
      "title":"PCSO help is usually not cash handed to you",
      "body":"PCSO Medical Assistance Program assistance is commonly processed through documents such as a Guarantee Letter or related assistance addressed to a partner hospital, dialysis center, medicine retailer, diagnostic center, or health facility. Do not treat it like automatic cash aid. Your route and requirements depend on the medical need and where the patient is being treated.",
      "items":[
        "PCSO assistance is meant to augment medical funds, not replace every cost",
        "Hospital confinement, chemotherapy, dialysis, medicines, procedures, and diagnostics may have different requirements",
        "Patients in hospitals with Malasakit Centers may be routed through that desk",
        "NCR online applications and branch applications may follow different steps",
        "This guide is practical preparation, not medical advice or a promise of approval"
      ]
    }$$::jsonb,
    $${
      "title":"Kadalasan, hindi cash na iaabot sa iyo ang PCSO help",
      "body":"Ang PCSO Medical Assistance Program ay karaniwang pinoproseso gamit ang documents tulad ng Guarantee Letter o related assistance na naka-address sa partner hospital, dialysis center, medicine retailer, diagnostic center, o health facility. Huwag itong ituring na automatic cash aid. Depende sa medical need at kung saan ginagamot ang patient ang route at requirements.",
      "items":[
        "Ang PCSO assistance ay pandagdag sa medical funds, hindi laging pambayad ng lahat",
        "Magkaiba ang requirements para sa confinement, chemotherapy, dialysis, medicines, procedures, at diagnostics",
        "Kung may Malasakit Center ang hospital, puwedeng doon ka i-route",
        "Puwedeng magkaiba ang NCR online application at branch application steps",
        "Practical preparation ito, hindi medical advice o promise ng approval"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'pcso-medical-assistance-checklist'),
    'warning',
    2,
    $${
      "title":"START HERE: do not pay a fixer for PCSO assistance",
      "body":"A fixer cannot guarantee approval, a bigger amount, or faster release. PCSO requirements should come from official PCSO pages, the hospital social service desk, Malasakit Center, or official branch/online channels.",
      "severity":"high",
      "items":[
        "Do not pay processing fees to strangers or social media pages",
        "Do not send full IDs, hospital bills, or medical records to unofficial chats",
        "Do not believe guaranteed approval or guaranteed amount claims",
        "Do not give login access to your PCSO online account or email",
        "Ask the hospital social service desk or PCSO branch which route applies to your case"
      ]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: huwag magbayad sa fixer para sa PCSO assistance",
      "body":"Hindi kayang i-guarantee ng fixer ang approval, mas malaking amount, o mas mabilis na release. Dapat official PCSO pages, hospital social service desk, Malasakit Center, o official branch/online channels ang source ng requirements.",
      "severity":"high",
      "items":[
        "Huwag magbayad ng processing fee sa strangers o social media pages",
        "Huwag mag-send ng full IDs, hospital bills, o medical records sa unofficial chats",
        "Huwag maniwala sa guaranteed approval o guaranteed amount claims",
        "Huwag ibigay ang login access sa PCSO online account o email mo",
        "Tanungin ang hospital social service desk o PCSO branch kung anong route ang applicable sa case mo"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'pcso-medical-assistance-checklist'),
    'step',
    3,
    $${
      "title":"Identify the exact medical assistance type",
      "body":"Do this before lining up. PCSO requirements differ depending on what you are asking help for.",
      "step_number":1,
      "items":[
        "Confinement or hospital bill",
        "Chemotherapy drugs or radiation therapy",
        "Dialysis or erythropoietin injection",
        "Specialty medicines",
        "Laboratory, diagnostic, imaging, or cardiologic procedures",
        "Medical devices, implants, or rehabilitation therapy"
      ]
    }$$::jsonb,
    $${
      "title":"Alamin ang exact type ng medical assistance",
      "body":"Gawin ito bago pumila. Nag-iiba ang PCSO requirements depende sa hinihingi mong tulong.",
      "step_number":1,
      "items":[
        "Confinement o hospital bill",
        "Chemotherapy drugs o radiation therapy",
        "Dialysis o erythropoietin injection",
        "Specialty medicines",
        "Laboratory, diagnostic, imaging, o cardiologic procedures",
        "Medical devices, implants, o rehabilitation therapy"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'pcso-medical-assistance-checklist'),
    'step',
    4,
    $${
      "title":"Find the right route before traveling",
      "body":"The route can depend on the hospital or health facility location, whether there is a Malasakit Center, and whether online submission is available for your case.",
      "step_number":2,
      "items":[
        "Ask the hospital social service or billing office if they accept PCSO Guarantee Letters",
        "Ask if the hospital has a Malasakit Center and if PCSO requests are routed there",
        "For NCR cases, check whether the online MAP route applies",
        "For provincial cases, check the nearest PCSO branch or official instructions",
        "Confirm office hours, cut-off time, and whether original documents are required"
      ]
    }$$::jsonb,
    $${
      "title":"Hanapin ang tamang route bago bumiyahe",
      "body":"Depende ang route sa hospital o health facility location, kung may Malasakit Center, at kung available ang online submission para sa case mo.",
      "step_number":2,
      "items":[
        "Tanungin ang hospital social service o billing office kung tumatanggap sila ng PCSO Guarantee Letter",
        "Tanungin kung may Malasakit Center ang hospital at kung doon dumadaan ang PCSO requests",
        "Para sa NCR cases, i-check kung applicable ang online MAP route",
        "Para sa provincial cases, i-check ang nearest PCSO branch o official instructions",
        "I-confirm ang office hours, cut-off time, at kung kailangan ang original documents"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'pcso-medical-assistance-checklist'),
    'step',
    5,
    $${
      "title":"Prepare the core documents first",
      "body":"These are commonly needed across PCSO MAP requests, but the final checklist still depends on the assistance type.",
      "step_number":3,
      "items":[
        "MAP application form, if required by the route",
        "Government-issued ID of the patient",
        "Valid ID of representative or next of kin, if applicable",
        "Medical abstract, clinical abstract, discharge summary, or medical certificate with doctor details",
        "Statement of Account or official billing statement for confinement cases",
        "Prescription, treatment protocol, request, or quotation depending on the case"
      ]
    }$$::jsonb,
    $${
      "title":"Ihanda muna ang core documents",
      "body":"Ito ang madalas kailangan sa PCSO MAP requests, pero depende pa rin sa assistance type ang final checklist.",
      "step_number":3,
      "items":[
        "MAP application form, kung required sa route",
        "Government-issued ID ng patient",
        "Valid ID ng representative o next of kin, kung applicable",
        "Medical abstract, clinical abstract, discharge summary, o medical certificate na may doctor details",
        "Statement of Account o official billing statement para sa confinement cases",
        "Prescription, treatment protocol, request, o quotation depende sa case"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'pcso-medical-assistance-checklist'),
    'step',
    6,
    $${
      "title":"Check if PhilHealth, HMO, or other deductions must appear first",
      "body":"For hospital bills, assistance offices often need the bill to show what has already been deducted or applied. Ask billing or social service before requesting documents.",
      "step_number":4,
      "items":[
        "Ask if PhilHealth benefits must be reflected in the Statement of Account",
        "Ask if HMO, guarantee letters, or other assistance must be deducted first",
        "Ask if the document should show outstanding balance or final bill",
        "Ask if the patient must still be admitted or if promissory note rules apply",
        "Save copies before submitting original documents"
      ]
    }$$::jsonb,
    $${
      "title":"I-check kung kailangan munang lumabas ang PhilHealth, HMO, o ibang deductions",
      "body":"Sa hospital bills, madalas kailangan makita kung ano na ang na-deduct o na-apply. Magtanong muna sa billing o social service bago kumuha ng documents.",
      "step_number":4,
      "items":[
        "Tanungin kung dapat reflected na ang PhilHealth benefits sa Statement of Account",
        "Tanungin kung dapat ma-deduct muna ang HMO, guarantee letters, o ibang assistance",
        "Tanungin kung outstanding balance o final bill ang kailangan",
        "Tanungin kung kailangan admitted pa ang patient o kung may promissory note rules",
        "Mag-save ng copies bago mag-submit ng original documents"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'pcso-medical-assistance-checklist'),
    'mistake',
    7,
    $${
      "title":"Common mistakes that waste a whole day",
      "body":"Most delays happen because the route was wrong or one document was incomplete.",
      "items":[
        "Going to PCSO before asking the hospital if it accepts PCSO GLs",
        "Bringing old billing statements or incomplete medical abstracts",
        "Forgetting the patient ID or representative ID",
        "Using screenshots when original or certified documents are required",
        "Applying through an unofficial Facebook page or fixer",
        "Expecting cash instead of a Guarantee Letter or direct partner-facility process"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes na nakakaubos ng isang araw",
      "body":"Madalas na-delay dahil mali ang route o may isang kulang na document.",
      "items":[
        "Pumupunta sa PCSO bago tanungin ang hospital kung tumatanggap sila ng PCSO GL",
        "Nagdadala ng lumang billing statement o kulang na medical abstract",
        "Nakakalimutan ang patient ID o representative ID",
        "Screenshots lang ang dala kahit original o certified documents ang required",
        "Nag-aapply sa unofficial Facebook page o fixer",
        "Inaasahang cash ang ibibigay imbes na Guarantee Letter o direct partner-facility process"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'pcso-medical-assistance-checklist'),
    'warning',
    8,
    $${
      "title":"Red flags of fake PCSO assistance pages",
      "body":"Medical bills make families vulnerable to scams. Be extra careful with pages or people promising shortcuts.",
      "severity":"high",
      "items":[
        "They ask for a processing fee before checking your documents",
        "They ask for OTP, bank login, or e-wallet PIN",
        "They promise a fixed approved amount before evaluation",
        "They use a personal wallet for payment",
        "They ask you to send unredacted medical records and IDs through random chat",
        "They discourage you from contacting PCSO, the hospital, or Malasakit Center directly"
      ]
    }$$::jsonb,
    $${
      "title":"Red flags ng fake PCSO assistance pages",
      "body":"Kapag may malaking medical bill, mas vulnerable ang pamilya sa scams. Mag-ingat sa pages o taong nangako ng shortcuts.",
      "severity":"high",
      "items":[
        "Humihingi ng processing fee bago i-check ang documents",
        "Humihingi ng OTP, bank login, o e-wallet PIN",
        "Nangangako ng fixed approved amount bago evaluation",
        "Personal wallet ang pinagbabayaran",
        "Pinapasend ang unredacted medical records at IDs sa random chat",
        "Pinipigilan kang kumontak mismo sa PCSO, hospital, o Malasakit Center"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'pcso-medical-assistance-checklist'),
    'tip',
    9,
    $${
      "title":"Sample question before lining up",
      "body":"Ask this at the hospital social service desk, billing office, PCSO branch, or Malasakit Center.",
      "sample":"Good day. The patient is applying for PCSO medical assistance for ____. Which route should we use: Malasakit Center, PCSO branch, or online MAP? What exact documents are required for this case, and should the billing statement already show PhilHealth, HMO, or other deductions?"
    }$$::jsonb,
    $${
      "title":"Sample question bago pumila",
      "body":"Itanong ito sa hospital social service desk, billing office, PCSO branch, o Malasakit Center.",
      "sample":"Good day po. Mag-aapply po ang patient ng PCSO medical assistance para sa ____. Aling route po ang dapat gamitin: Malasakit Center, PCSO branch, o online MAP? Ano po ang exact documents para sa case na ito, at kailangan po ba na reflected na ang PhilHealth, HMO, o ibang deductions sa billing statement?"
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'pcso-medical-assistance-checklist'),
    'tip',
    10,
    $${
      "title":"PCSO assistance checklist",
      "body":"Use this before leaving the hospital or traveling to an office.",
      "items":[
        "Exact assistance type identified",
        "Correct route confirmed: hospital desk, Malasakit Center, branch, or online",
        "Updated Statement of Account or quotation prepared",
        "Medical abstract, prescription, treatment protocol, or doctor request prepared",
        "Patient ID and representative ID prepared",
        "PhilHealth, HMO, or other deductions clarified",
        "Copies and scans saved before submitting originals",
        "Official contact, branch, or portal verified"
      ]
    }$$::jsonb,
    $${
      "title":"PCSO assistance checklist",
      "body":"Gamitin ito bago umalis ng hospital o bumiyahe papuntang office.",
      "items":[
        "Na-identify ang exact assistance type",
        "Na-confirm ang tamang route: hospital desk, Malasakit Center, branch, o online",
        "Handa ang updated Statement of Account o quotation",
        "Handa ang medical abstract, prescription, treatment protocol, o doctor request",
        "Handa ang patient ID at representative ID",
        "Na-clarify ang PhilHealth, HMO, o ibang deductions",
        "May copies at scans bago mag-submit ng originals",
        "Na-verify ang official contact, branch, o portal"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'pcso-medical-assistance-checklist'),
    'related',
    11,
    $${
      "title":"Related guides",
      "body":"Use these depending on your hospital situation.",
      "items":[
        "Public Hospital Social Service Desk Guide: start here if you are still in the hospital",
        "PhilHealth Hospital Benefits Checklist: check deductions before seeking extra assistance",
        "Medical Emergency Documents Checklist: prepare hospital papers before the situation gets stressful",
        "DSWD AICS Assistance Checklist: compare medical assistance routes",
        "Office Help Message Checklist: write a clear inquiry before traveling"
      ]
    }$$::jsonb,
    $${
      "title":"Related guides",
      "body":"Gamitin ang guides na ito depende sa hospital situation mo.",
      "items":[
        "Public Hospital Social Service Desk Guide: unahin ito kung nasa hospital pa kayo",
        "PhilHealth Hospital Benefits Checklist: i-check ang deductions bago humingi ng extra assistance",
        "Medical Emergency Documents Checklist: ihanda ang hospital papers bago maging stressful",
        "DSWD AICS Assistance Checklist: ikumpara ang medical assistance routes",
        "Office Help Message Checklist: gumawa ng malinaw na inquiry bago bumiyahe"
      ]
    }$$::jsonb
  );
