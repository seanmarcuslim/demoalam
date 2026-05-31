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
  'salary-paycheck-checklist',
  (select id from public.categories where slug = 'money'),
  'Salary and paycheck checklist',
  'Checklist ng sahod at payslip',
  'Know how to read your payslip, verify deductions, and spot missing wages, benefits, and contributions.',
  'Alamin kung paano basahin ang payslip, i-verify ang deductions, at makita kung may kulang sa sahod, benepisyo, at kontribusyon.',
  true,
  false,
  true,
  8,
  'madali',
  '10-15 minuto',
  'Libre',
  array[
    'salary',
    'paycheck',
    'payslip',
    'deductions',
    'SSS',
    'PhilHealth',
    'PagIBIG',
    'payroll',
    'overtime',
    'work',
    'income'
  ],
  'salary paycheck payslip wages sweldo sahod deductions contributions SSS PhilHealth Pag-IBIG tax overtime net pay gross pay checklist verify pay stubs missing pay payroll questions employee rights pay dispute',
  'sweldo paycheck payslip deductions kontribusyon SSS PhilHealth Pag-IBIG buwis overtime net pay gross pay checklist i-verify sahod pay stub nawawalang bayad payroll tanong karapatan ng empleyado',
  '[
    {"title":"Department of Labor and Employment - Wage and Hour Guidelines","publisher":"DOLE","url":"https://www.dole.gov.ph/"},
    {"title":"SSS Contribution Table","publisher":"Social Security System","url":"https://www.sss.gov.ph/"},
    {"title":"PhilHealth Member Contributions","publisher":"PhilHealth","url":"https://www.philhealth.gov.ph/"},
    {"title":"Pag-IBIG Fund Contribution Table","publisher":"Pag-IBIG Fund","url":"https://www.pagibigfund.gov.ph/"},
    {"title":"BIR Withholding Tax Rules for Employees","publisher":"Bureau of Internal Revenue","url":"https://www.bir.gov.ph/"}
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
  where slug = 'salary-paycheck-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'salary-paycheck-checklist'),
    'what_to_know',
    1,
    $${
      "title":"Your payslip is one of your most important proofs of income",
      "body":"A payslip is not just a number. It shows whether your employer is paying the right gross pay, calculating deductions correctly, and submitting your government contributions. If you spot a mistake, ask HR or payroll right away and keep a copy of every payslip.",
      "items":[
        "Gross pay = the full pay before deductions",
        "Net pay = the money that goes into your pocket",
        "Check both amounts and the list of deductions",
        "Verify SSS, PhilHealth, Pag-IBIG, and withholding tax payments",
        "Keep a copy of every payslip, even if you are paid in cash"
      ]
    }$$::jsonb,
    $${
      "title":"Ang payslip mo ay isa sa pinakamahalagang ebidensiya ng kita mo",
 "body":"Ang payslip ay hindi lang numero. Ipinapakita nito kung tama ang gross pay, kung tama ang mga deduction, at kung naipapasang maayos ang government contributions. Kapag may mali, itanong kaagad sa HR o payroll at itabi ang kopya ng bawat payslip.",
      "items":[
        "Gross pay = kabuuang sahod bago ang deductions",
        "Net pay = pera na pumupunta sa bulsa mo",
        "I-check ang parehong halaga at ang listahan ng deductions",
        "I-verify ang SSS, PhilHealth, Pag-IBIG, at withholding tax",
        "Itabi ang kopya ng bawat payslip, kahit cash ang bayad"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'salary-paycheck-checklist'),
    'warning',
    2,
    $${
      "title":"Don't ignore small pay mistakes - they add up fast",
      "body":"A missing overtime hour, wrong deduction, or unpaid contribution may look small now, but it can cost you hundreds or thousands over time. Track every month and fix errors before the next salary cycle.",
      "severity":"high",
      "items":[
        "A single missing overtime or holiday pay can be costly",
        "Wrong contribution amounts hurt your SSS, PhilHealth, and Pag-IBIG records",
        "Underpaid or missing net pay is your employer's responsibility to explain",
        "If the payslip doesn't match your bank or cash pay, do not accept it without asking"
      ]
    }$$::jsonb,
    $${
      "title":"Huwag balewalain ang maliliit na mali sa sahod - lumalaki ang epekto nito",
      "body":"Ang kulang na overtime, maling deduction, o hindi naipadalang kontribusyon ay mukhang maliit ngunit puwedeng umabot sa daan-daan o libo-libong piso sa paglipas ng panahon. I-track buwan-buwan at ayusin bago ang susunod na sahod.",
      "severity":"high",
      "items":[
        "Ang isang kulang na overtime o holiday pay ay mahalaga",
        "Ang maling kontribusyon ay nakakasama sa record ng SSS, PhilHealth, at Pag-IBIG",
        "Ang kulang o nawawalang net pay ay responsibilidad ng employer na ipaliwanag",
        "Kung hindi tumutugma ang payslip sa bank o cash pay, huwag tanggapin nang hindi nagtatanong"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'salary-paycheck-checklist'),
    'step',
    3,
    $${
      "title":"Step 1: Find your payslip or payment record",
      "body":"Ask for a written payslip every pay period, even if you are paid in cash. A written record helps you compare what you were promised to what you actually received.",
      "step_number":1,
      "items":[
        "Get a payslip, paystub, or payroll summary each pay day",
        "Ask for it before or during payday if you do not automatically receive one",
        "Keep it even if the amount looks correct",
        "If you receive pay in cash, keep a signed record or acknowledgement"
      ]
    }$$::jsonb,
    $${
      "title":"Hakbang 1: Hanapin ang payslip o record ng bayad",
      "body":"Hingi ng written payslip bawat pay period, kahit cash ang bayad. Ang written record ay tutulong ikumpara ang inaasahan mo sa aktwal na natanggap.",
      "step_number":1,
      "items":[
        "Kumuha ng payslip, paystub, o payroll summary tuwing payday",
        "Hilingin ito bago o sa payday kung hindi automatic na binibigay",
        "Itabi ito kahit tama ang halaga",
        "Kung cash ang bayad, kumuha ng signed record o acknowledgement"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'salary-paycheck-checklist'),
    'step',
    4,
    $${
      "title":"Step 2: Check gross pay, net pay, and actual amount received",
      "body":"Gross pay is the full amount earned. Net pay is what remains after deductions. The actual amount received should match net pay exactly. If it doesn't, ask for a clear explanation.",
      "step_number":2,
      "items":[
        "Find gross pay or total earnings on the payslip",
        "Find net pay or take-home pay",
        "Compare net pay to the cash or bank amount you actually received",
        "If the bank deposit is lower, ask which deduction caused the difference",
        "If you were paid in cash, make sure the pay slip total matches the cash handed to you"
      ]
    }$$::jsonb,
    $${
      "title":"Hakbang 2: I-check ang gross pay, net pay, at aktwal na natanggap",
      "body":"Ang gross pay ang buong kita. Ang net pay ang natira pagkatapos ng deductions. Dapat eksaktong tumugma ang aktwal na natanggap sa net pay. Kung hindi, hilingin ang malinaw na paliwanag.",
      "step_number":2,
      "items":[
        "Hanapin ang gross pay o total earnings sa payslip",
        "Hanapin ang net pay o take-home pay",
        "I-compare ang net pay sa cash o bank amount na natanggap mo",
        "Kung mas mababa ang bank deposit, itanong kung anong deduction ang dahilan",
        "Kung cash ang bayad, siguraduhing tugma ang payslip total sa cash na ibinigay"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'salary-paycheck-checklist'),
    'step',
    5,
    $${
      "title":"Step 3: Verify statutory contributions and mandatory deductions",
      "body":"Check that SSS, PhilHealth, Pag-IBIG, and withholding tax are listed with the right amounts. These contributions matter for health, loans, benefits, and your official records.",
      "step_number":3,
      "items":[
        "SSS contribution is listed and matches your salary bracket",
        "PhilHealth contribution is listed and matches your salary bracket",
        "Pag-IBIG contribution is listed if required by your employer",
        "Withholding tax is shown for salaried employees",
        "Loan or cash advance deductions are listed with purpose and balance"
      ]
    }$$::jsonb,
    $${
      "title":"Hakbang 3: I-verify ang statutory contributions at mandatory deductions",
      "body":"I-check kung naka-lista ang SSS, PhilHealth, Pag-IBIG, at withholding tax sa tamang halaga. Mahalaga ang mga kontribusyon na ito para sa health, loan, benepisyo, at official records mo.",
      "step_number":3,
      "items":[
        "Naka-lista at tumutugma sa salary bracket ang kontribusyon sa SSS",
        "Naka-lista at tumutugma sa salary bracket ang kontribusyon sa PhilHealth",
        "Naka-lista ang kontribusyon sa Pag-IBIG kung required ng employer",
        "Naka-show ang withholding tax para sa salaried employees",
        "Naka-lista ang loan o cash advance deductions kasama ang purpose at balance"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'salary-paycheck-checklist'),
    'step',
    6,
    $${
      "title":"Step 4: Check overtime, holiday pay, and absence adjustments",
      "body":"Overtime and holiday pay must be added if you worked beyond normal hours. Likewise, absences or undertime may reduce your pay. Confirm that these adjustments are correct before you accept the amount.",
      "step_number":4,
      "items":[
        "Overtime hours are listed with the correct rate",
        "Holiday pay is included when you worked on a holiday",
        "Night differential or special premium pay is shown when due",
        "Absences, undertime, or late arrival deductions are explained",
        "Ask HR if a missing overtime hour or holiday pay is not reflected"
      ]
    }$$::jsonb,
    $${
      "title":"Hakbang 4: I-check ang overtime, holiday pay, at absence adjustments",
      "body":"Dapat idagdag ang overtime at holiday pay kung nagtrabaho ka lampas normal na oras. Kapag may absences o undertime, puwedeng bumaba ang sahod. Siguruhing tama ang mga adjustment bago tanggapin ang halaga.",
      "step_number":4,
      "items":[
        "Naka-lista ang overtime hours sa tamang rate",
        "Naka-include ang holiday pay kapag nagtrabaho sa holiday",
        "Naka-show ang night differential o special premium pay kung dapat",
        "Ipinaliwanag ang absences, undertime, o late arrival deductions",
        "Itanong sa HR kung hindi nakalagay ang kulang na overtime o holiday pay"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'salary-paycheck-checklist'),
    'step',
    7,
    $${
      "title":"Step 5: Ask the right questions when something does not match",
      "body":"Don't accept a wrong payslip. Ask for a clear breakdown so you know exactly why the amount changed. Good questions help HR fix the problem faster.",
      "step_number":5,
      "items":[
        "Which deduction changed this month?",
        "Why is my take-home pay lower than last month?",
        "Is my SSS/PhilHealth/Pag-IBIG contribution up to date?",
        "Why is my overtime/holiday pay missing?",
        "Can I get a corrected payslip or written explanation?"
      ]
    }$$::jsonb,
    $${
      "title":"Hakbang 5: Itanong ang tamang tanong kapag may hindi tugma",
      "body":"Huwag tanggapin ang maling payslip. Humingi ng malinaw na breakdown para malaman mo kung bakit nagbago ang halaga. Mas mabilis maayos ng HR ang problema kapag malinaw ang tanong.",
      "step_number":5,
      "items":[
        "Aling deduction ang nagbago ngayong buwan?",
        "Bakit mababa ang take-home pay ko kaysa last month?",
        "Up to date ba ang SSS/PhilHealth/Pag-IBIG contribution ko?",
        "Bakit nawawala ang overtime/holiday pay ko?",
        "Puwede ba akong makahingi ng corrected payslip o written explanation?"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'salary-paycheck-checklist'),
    'mistake',
    8,
    $${
      "title":"Common paycheck mistakes people miss",
      "body":"These are the biggest traps that make paychecks look okay when they are not.",
      "items":[
        "Trusting net pay without checking the payslip details",
        "Not verifying government contributions every month",
        "Assuming overtime or holiday pay is included automatically",
        "Ignoring a different pay date or amount without asking",
        "Not keeping a copy of the payslip for future reference"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang pagkakamali sa payslip na hindi napapansin",
      "body":"Ito ang mga bitag na nagpapamukhang tama ang payslip kahit may mali.",
      "items":[
        "Pagtiwala sa net pay nang hindi chine-check ang detalye ng payslip",
        "Hindi pag-verify ng government contributions bawat buwan",
        "Pag-aassume na automatic kasama ang overtime o holiday pay",
        "Pag-iignore sa ibang petsa o halaga ng bayad nang hindi nagtatanong",
        "Hindi pag-iingat ng kopya ng payslip para sa susunod"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'salary-paycheck-checklist'),
    'tip',
    9,
    $${
      "title":"Keep a simple pay record",
      "body":"A basic monthly record helps you spot missing pay and government contributions fast.",
      "items":[
        "Keep a file or folder for all payslips",
        "Write the pay date and bank deposit amount next to each slip",
        "Note the SSS, PhilHealth, Pag-IBIG, and tax amounts",
        "Mark overtime and holiday pay separately",
        "Review the record before you accept the next pay"
      ]
    }$$::jsonb,
    $${
      "title":"Panatilihin ang simpleng pay record",
      "body":"Ang simpleng monthly record ay tumutulong makita agad ang nawawalang bayad at kontribusyon.",
      "items":[
        "Magtabi ng file o folder para sa lahat ng payslips",
        "Isulat ang pay date at bank deposit amount sa tabi ng bawat slip",
        "I-note ang SSS, PhilHealth, Pag-IBIG, at tax amounts",
        "I-mark ang overtime at holiday pay ng hiwalay",
        "I-review ang record bago tanggapin ang susunod na bayad"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'salary-paycheck-checklist'),
    'tip',
    10,
    $${
      "title":"Questions to ask payroll or HR",
      "body":"Use these exact questions when something in your payslip looks wrong.",
      "items":[
        "Can you explain this deduction?",
        "Why is my net pay lower this month?",
        "Is my SSS/PhilHealth/Pag-IBIG contribution up to date?",
        "Why is this overtime pay missing or lower?",
        "Can I get a corrected payslip or written explanation?"
      ]
    }$$::jsonb,
    $${
      "title":"Mga tanong sa payroll o HR",
      "body":"Gamitin ang eksaktong tanong na ito kapag may mali sa payslip mo.",
      "items":[
        "Puwede niyo bang ipaliwanag ang deduction na ito?",
        "Bakit mas mababa ang net pay ko ngayon?",
        "Up to date ba ang SSS/PhilHealth/Pag-IBIG contribution ko?",
        "Bakit nawawala o mas mababa ang overtime pay na ito?",
        "Puwede ba akong makahingi ng corrected payslip o written explanation?"
      ]
    }$$::jsonb
  );
