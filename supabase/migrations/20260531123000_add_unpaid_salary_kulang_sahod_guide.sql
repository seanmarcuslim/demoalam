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
  'unpaid-salary-kulang-sahod-checklist',
  (select id from public.categories where slug = 'work'),
  'Unpaid salary checklist before filing with DOLE',
  'Kulang sahod checklist bago lumapit sa DOLE',
  'Check your payslip, collect proof, ask payroll clearly, and know when to file a SEnA request.',
  'I-check ang payslip, mag-ipon ng ebidensya, magtanong nang malinaw, at alamin kung kailan mag-file ng SEnA request.',
  true,
  false,
  true,
  6,
  'katamtaman',
  '30-60 minuto para ihanda ang ebidensya; depende ang timeline sa HR o DOLE process',
  'Libre, maliban sa printing, pamasahe, o internet data',
  array[
    'unpaid salary',
    'kulang sahod',
    'late sweldo',
    'dole',
    'sena',
    'wage complaint',
    'payslip',
    'payroll',
    'labor rights',
    'work'
  ],
  'unpaid salary delayed salary underpaid salary kulang sahod late sweldo missing pay wrong salary payslip payroll dole sena request for assistance labor complaint wage complaint minimum wage overtime pay final pay salary deduction payslip evidence employer hr',
  'kulang sahod hindi binigay sahod late sweldo delay sahod mali sahod kulang sweldo hindi sumahod payslip payroll dole sena reklamo sa dole request for assistance labor complaint wage complaint minimum wage overtime final pay bawas sahod ebidensya employer hr',
  $$[
    {"title":"DOLE Assistance for Request Management System","publisher":"Department of Labor and Employment","url":"https://arms.dole.gov.ph/"},
    {"title":"DOLE e-SEnA RAMS Manual","publisher":"Department of Labor and Employment","url":"https://arms.dole.gov.ph/assets/manual/2024%20DOLE%20e-SEnA%20RAMS%20Administrators%20Manual.pdf"},
    {"title":"Workers' Statutory Monetary Benefits Handbook","publisher":"National Wages and Productivity Commission / DOLE","url":"https://nwpc.dole.gov.ph/bwc-handbook-workers-statutory-monetary-benefits/"},
    {"title":"Workers' Statutory Monetary Benefits Handbook 2024 Edition","publisher":"National Wages and Productivity Commission / DOLE","url":"https://nwpc.dole.gov.ph/wp-content/uploads/2024/11/Workers-Statutory-Monetary-Benefits-Handbook-2024-Edition.pdf"},
    {"title":"Labor Code of the Philippines, P.D. No. 442","publisher":"Lawphil","url":"https://lawphil.net/statutes/presdecs/pd1974/pd_442a_1974.html"}
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
  updated_at = now();

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'unpaid-salary-kulang-sahod-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'unpaid-salary-kulang-sahod-checklist'),
    'what_to_know',
    1,
    $${
      "title":"Kulang sahod is not always just one problem",
      "body":"Unpaid salary can mean different things: delayed salary, missing overtime, wrong deduction, unpaid final pay, missing 13th month pay, or salary below the agreed rate. Do not start with anger. Start by identifying the exact issue, the missing amount, and the proof you have.",
      "items":[
        "Delayed salary means the pay date passed but salary was not released",
        "Underpaid salary means you were paid less than the agreed or required amount",
        "Wrong deduction means money was deducted without clear basis or explanation",
        "Missing overtime, holiday pay, or night differential should be checked separately",
        "Final pay and benefits may follow a different timeline, so classify the issue first"
      ]
    }$$::jsonb,
    $${
      "title":"Ang kulang sahod ay hindi laging iisang problema",
      "body":"Puwedeng iba-iba ang ibig sabihin ng kulang o hindi nabayarang sahod: delayed na sahod, kulang na overtime, maling bawas, hindi pa nabibigay na final pay, nawawalang 13th month pay, o sahod na mas mababa sa napag-usapan. Huwag magsimula sa galit. Magsimula sa paglinaw ng exact issue, exact na kulang, at ebidensya.",
      "items":[
        "Delayed na sahod kapag lumampas na ang pay date pero walang sahod",
        "Kulang na sahod kapag mas mababa ang natanggap kaysa napag-usapan o required amount",
        "Maling bawas kapag may deduction na walang malinaw na basehan o paliwanag",
        "I-check nang hiwalay ang kulang na overtime, holiday pay, o night differential",
        "Puwedeng iba ang timeline ng final pay at benefits, kaya linawin muna ang klase ng issue"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'unpaid-salary-kulang-sahod-checklist'),
    'warning',
    2,
    $${
      "title":"Do not post publicly or threaten before collecting proof",
      "body":"It is normal to feel stressed when salary is missing, but public posts, threats, or angry messages can make the situation harder to resolve. Keep your proof, communicate clearly, and use official channels when the issue is not fixed.",
      "severity":"high",
      "items":[
        "Do not post payslips, company records, bank details, or private messages publicly",
        "Do not threaten HR, payroll, supervisors, or co-workers",
        "Do not sign blank documents, quitclaims, or settlement papers you do not understand",
        "Do not delete chat logs, payslips, attendance records, or bank proof",
        "Keep your complaint factual: dates, amounts, documents, and messages"
      ]
    }$$::jsonb,
    $${
      "title":"Huwag muna mag-post o manakot bago mag-ipon ng ebidensya",
      "body":"Normal na ma-stress kapag kulang o wala ang sahod, pero puwedeng mas mahirap maayos ang problema kapag nag-post agad sa publiko, nanakot, o nagpadala ng galit na messages. Itabi ang ebidensya, makipag-usap nang malinaw, at gumamit ng official channels kung hindi naayos.",
      "severity":"high",
      "items":[
        "Huwag i-post sa publiko ang payslip, company records, bank details, o private messages",
        "Huwag manakot sa HR, payroll, supervisors, o co-workers",
        "Huwag pumirma sa blank documents, quitclaims, o settlement papers na hindi mo naiintindihan",
        "Huwag burahin ang chat logs, payslips, attendance records, o bank proof",
        "Gawing factual ang concern: dates, amounts, documents, at messages"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'unpaid-salary-kulang-sahod-checklist'),
    'step',
    3,
    $${
      "title":"Write the exact missing amount first",
      "body":"Before asking HR or filing anything, write a simple computation. This helps you avoid vague complaints like kulang sahod and shows exactly what you are asking to be corrected.",
      "step_number":1,
      "items":[
        "Pay period covered",
        "Expected salary or agreed rate",
        "Actual amount received",
        "Exact missing amount",
        "Date salary should have been paid",
        "Payslip, bank credit, cash acknowledgement, or payroll message"
      ]
    }$$::jsonb,
    $${
      "title":"Isulat muna ang exact na kulang",
      "body":"Bago magtanong sa HR o mag-file, gumawa muna ng simpleng computation. Nakakatulong ito para hindi malabo ang concern na kulang sahod at malinaw kung ano ang pinapa-correct mo.",
      "step_number":1,
      "items":[
        "Pay period na sakop",
        "Expected salary o napag-usapang rate",
        "Actual amount na natanggap",
        "Exact na kulang",
        "Date kung kailan dapat nabayaran ang sahod",
        "Payslip, bank credit, cash acknowledgement, o payroll message"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'unpaid-salary-kulang-sahod-checklist'),
    'step',
    4,
    $${
      "title":"Classify the issue clearly",
      "body":"Different salary problems need different proof. Label the issue before you talk to payroll, HR, or DOLE so the next step is easier.",
      "step_number":2,
      "items":[
        "Unpaid salary: no salary released for the pay period",
        "Delayed salary: salary was released late or still pending",
        "Underpaid salary: amount is lower than agreed rate or legal minimum",
        "Wrong deduction: deduction is unclear, unauthorized, or not explained",
        "Missing overtime or holiday pay: hours worked are not reflected",
        "Final pay issue: separation pay, last salary, or remaining benefits are unresolved"
      ]
    }$$::jsonb,
    $${
      "title":"Linawin kung anong klaseng salary issue ito",
      "body":"Iba-iba ang kailangang ebidensya depende sa salary problem. Linawin muna ang klase ng issue bago kausapin ang payroll, HR, o DOLE para mas madali ang next step.",
      "step_number":2,
      "items":[
        "Unpaid salary: walang sahod na nirelease para sa pay period",
        "Delayed salary: late ang release ng sahod o pending pa rin",
        "Underpaid salary: mas mababa ang amount kaysa napag-usapang rate o legal minimum",
        "Wrong deduction: hindi malinaw, walang authorization, o walang paliwanag ang bawas",
        "Missing overtime o holiday pay: hindi reflected ang oras na pinasok",
        "Final pay issue: hindi pa malinaw ang last salary, separation pay, o remaining benefits"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'unpaid-salary-kulang-sahod-checklist'),
    'tip',
    5,
    $${
      "title":"Know the difference between a mistake and a violation",
      "body":"Some payroll issues are honest mistakes, such as wrong attendance records, delayed bank posting, or cut-off misunderstanding. But repeated underpayment, refusal to explain deductions, missing wages, or ignored complaints may need escalation.",
      "items":[
        "Possible mistake: one-time attendance error or missed time record",
        "Possible mistake: bank posting delay after payroll was released",
        "Possible mistake: misunderstanding of payroll cut-off dates",
        "Possible violation: repeated missing wages or unexplained deductions",
        "Possible violation: employer refuses to give payslip, computation, or correction timeline",
        "Escalate when the issue is ignored, repeated, or clearly unsupported by records"
      ]
    }$$::jsonb,
    $${
      "title":"Alamin kung payroll mistake o posibleng seryosong issue",
      "body":"May payroll issues na honest mistake, tulad ng maling attendance record, delayed bank posting, o hindi pagkakaintindihan sa cut-off. Pero kung paulit-ulit ang kulang na sahod, ayaw ipaliwanag ang deductions, nawawala ang sahod, o hindi sinasagot ang concern, puwedeng kailangan nang lumapit sa proper channel.",
      "items":[
        "Possible mistake: one-time attendance error o missed time record",
        "Possible mistake: delayed bank posting pagkatapos ma-release ang payroll",
        "Possible mistake: hindi pagkakaintindihan sa payroll cut-off dates",
        "Possible serious issue: paulit-ulit na nawawalang sahod o hindi maipaliwanag na deductions",
        "Possible serious issue: ayaw magbigay ng payslip, computation, o correction timeline",
        "Lumapit sa proper channel kapag hindi sinasagot, paulit-ulit, o malinaw na hindi suportado ng records ang issue"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'unpaid-salary-kulang-sahod-checklist'),
    'step',
    6,
    $${
      "title":"Ask HR or payroll once in writing",
      "body":"Give the company a clear chance to explain or correct the issue. Written communication creates a record and often solves simple payroll mistakes without a formal complaint.",
      "step_number":3,
      "items":[
        "Send the message by email, HR portal, or chat that can be saved",
        "Include pay period, expected amount, received amount, and missing amount",
        "Ask for the payslip or computation",
        "Ask for the correction timeline",
        "Save screenshots and replies",
        "Sample: Good day. I would like to clarify my salary for ____ because I received ____ but expected ____. May I ask for the payslip/computation and correction timeline?"
      ]
    }$$::jsonb,
    $${
      "title":"Magtanong muna sa HR o payroll nang nakasulat",
      "body":"Bigyan muna ang company ng malinaw na chance na magpaliwanag o mag-correct. Ang written communication ay nagsisilbing record at madalas nakakaayos ng simpleng payroll mistake nang hindi agad formal complaint.",
      "step_number":3,
      "items":[
        "I-send ang message sa email, HR portal, o chat na puwedeng i-save",
        "Ilagay ang pay period, expected amount, received amount, at missing amount",
        "Humingi ng payslip o computation",
        "Humingi ng correction timeline",
        "I-save ang screenshots at replies",
        "Sample: Good day. I would like to clarify my salary for ____ because I received ____ but expected ____. May I ask for the payslip/computation and correction timeline?",
        "Filipino sample: Good day po. Gusto ko lang po i-clarify ang sahod ko para sa ____ dahil ____ ang natanggap ko pero ____ ang expected. Puwede po bang makahingi ng payslip/computation at timeline kung kailan ito ma-correct?"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'unpaid-salary-kulang-sahod-checklist'),
    'step',
    7,
    $${
      "title":"Collect evidence before filing",
      "body":"A stronger complaint is built on proof, not just a story. Gather copies before going to DOLE, especially if you think the company may remove access to records.",
      "step_number":4,
      "items":[
        "Employment contract, job offer, appointment letter, or written agreement",
        "Payslips, payroll summaries, or salary computation",
        "Bank statements, e-wallet records, or cash acknowledgement",
        "Attendance logs, schedules, time records, overtime records, or biometric screenshots",
        "Messages with HR, payroll, supervisor, or employer",
        "Company name, address, branch, and contact person",
        "Your own computation of the missing amount"
      ]
    }$$::jsonb,
    $${
      "title":"Mag-ipon ng ebidensya bago mag-file",
      "body":"Mas malinaw ang concern kung may ebidensya, hindi kwento lang. Mag-ipon ng kopya bago pumunta sa DOLE, lalo na kung posibleng mawala ang access mo sa records.",
      "step_number":4,
      "items":[
        "Employment contract, job offer, appointment letter, o written agreement",
        "Payslips, payroll summaries, o salary computation",
        "Bank statements, e-wallet records, o cash acknowledgement",
        "Attendance logs, schedules, time records, overtime records, o biometric screenshots",
        "Messages sa HR, payroll, supervisor, o employer",
        "Pangalan ng company, address, branch, at contact person",
        "Sarili mong computation ng kulang na amount"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'unpaid-salary-kulang-sahod-checklist'),
    'warning',
    8,
    $${
      "title":"Watch for pressure, intimidation, or unfair settlement",
      "body":"Some workers accept less than what they are owed because they are pressured, embarrassed, or afraid. Stay calm and do not sign anything you do not understand.",
      "severity":"high",
      "items":[
        "Do not sign quitclaims or settlement papers without reading and understanding them",
        "Do not accept a verbal promise without a written payment date or computation",
        "Do not give up payslips, IDs, or original documents without a copy",
        "Do not let threats stop you from keeping records",
        "If you feel pressured, ask for time to review and use official assistance channels"
      ]
    }$$::jsonb,
    $${
      "title":"Mag-ingat sa pressure, pananakot, o hindi malinaw na settlement",
      "body":"May workers na tumatanggap ng mas mababa kaysa dapat dahil napipressure, nahihiya, o natatakot. Kumalma muna at huwag pumirma sa dokumentong hindi mo naiintindihan.",
      "severity":"high",
      "items":[
        "Huwag pumirma sa quitclaims o settlement papers nang hindi binabasa at naiintindihan",
        "Huwag umasa sa verbal promise lang kung walang written payment date o computation",
        "Huwag ibigay ang payslips, IDs, o original documents nang walang copy",
        "Huwag hayaang pigilan ka ng pananakot sa pag-iingat ng records",
        "Kung napipressure ka, humingi ng oras para i-review at gumamit ng official assistance channels"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'unpaid-salary-kulang-sahod-checklist'),
    'step',
    9,
    $${
      "title":"File a DOLE SEnA Request for Assistance if unresolved",
      "body":"If HR or payroll does not respond, refuses to explain, or the issue remains unresolved, you can file a Request for Assistance through DOLE SEnA. SEnA is a conciliation-mediation process meant to help parties settle labor issues before they become bigger cases.",
      "step_number":5,
      "items":[
        "Prepare your name, contact details, employer name, workplace address, and issue summary",
        "Prepare your computation and evidence",
        "Use DOLE ARMS or visit the proper DOLE office if online filing is not practical",
        "Keep your reference number or acknowledgement",
        "Attend scheduled conferences or calls and stay factual",
        "If unresolved, ask the SEnA desk officer about the next proper step or referral"
      ]
    }$$::jsonb,
    $${
      "title":"Mag-file ng DOLE SEnA Request for Assistance kung hindi naayos",
      "body":"Kung hindi sumagot ang HR o payroll, ayaw magpaliwanag, o hindi pa rin naayos ang issue, puwede kang mag-file ng Request for Assistance sa DOLE SEnA. Ang SEnA ay conciliation-mediation process para tulungang linawin at ayusin ang labor issue bago kailanganin ng mas formal na proseso.",
      "step_number":5,
      "items":[
        "Ihanda ang name, contact details, employer name, workplace address, at issue summary",
        "Ihanda ang computation at ebidensya",
        "Gamitin ang DOLE ARMS o pumunta sa tamang DOLE office kung hindi practical ang online filing",
        "Itabi ang reference number o acknowledgement",
        "Dumalo sa scheduled conferences o calls at manatiling factual",
        "Kung hindi pa rin resolved, itanong sa SEnA desk officer ang next proper step o referral"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'unpaid-salary-kulang-sahod-checklist'),
    'tip',
    10,
    $${
      "title":"What to expect after filing",
      "body":"Filing does not always mean an immediate payment or formal case. Usually, the goal is to clarify the issue, invite the employer to respond, and see if settlement is possible through official assistance.",
      "items":[
        "You may be contacted by a SEnA desk officer or DOLE representative",
        "The employer may be asked to attend a conference or respond",
        "You may be asked for more documents or a clearer computation",
        "Settlement may happen if both sides agree",
        "If the issue is not settled, DOLE can guide you on possible next steps",
        "Keep all reference numbers, schedules, settlement terms, and official messages"
      ]
    }$$::jsonb,
    $${
      "title":"Ano ang aasahan pagkatapos mag-file",
      "body":"Ang pag-file ay hindi laging ibig sabihin na may bayad agad o formal case agad. Kadalasan, goal muna na linawin ang issue, makahingi ng response mula sa employer, at tingnan kung puwedeng maayos sa official assistance.",
      "items":[
        "Puwede kang kontakin ng SEnA desk officer o DOLE representative",
        "Puwedeng papuntahin o papag-respond ang employer",
        "Puwede kang hingan ng dagdag na documents o mas malinaw na computation",
        "Puwedeng magkaroon ng settlement kung parehong side ay agree",
        "Kung hindi maayos, puwedeng i-guide ka ng DOLE sa possible next steps",
        "Itabi ang reference numbers, schedules, settlement terms, at official messages"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'unpaid-salary-kulang-sahod-checklist'),
    'related',
    11,
    $${
      "title":"Related guides",
      "body":"Use these guides if your salary issue connects to payroll, first job requirements, budgeting, or asking offices clearly.",
      "items":[
        "Salary and Paycheck Checklist: use this to understand payslip, deductions, and contributions",
        "First Job Requirements: use this if you are preparing employment documents",
        "Payday Budget Simple Split: use this if salary is short and you need to prioritize urgent expenses",
        "Office Help Message Checklist: use this to write a clearer HR, payroll, or office inquiry",
        "Keep this guide saved if your issue may need follow-up"
      ]
    }$$::jsonb,
    $${
      "title":"Related guides",
      "body":"Gamitin ang guides na ito kung connected ang salary issue mo sa payroll, first job requirements, budgeting, o malinaw na pagtatanong sa office.",
      "items":[
        "Salary and Paycheck Checklist: gamitin para maintindihan ang payslip, deductions, at contributions",
        "First Job Requirements: gamitin kung naghahanda ka ng employment documents",
        "Payday Budget Simple Split: gamitin kung kulang ang sahod at kailangan mong unahin ang urgent expenses",
        "Office Help Message Checklist: gamitin para mas malinaw ang message sa HR, payroll, o office",
        "I-save ang guide na ito kung kailangan pa ng follow-up ang issue mo"
      ]
    }$$::jsonb
  );
