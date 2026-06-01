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
  'emergency-fund-starter-checklist',
  (select id from public.categories where slug = 'money'),
  'Emergency fund starter checklist',
  'Ipon pang-emergency starter checklist',
  'Start a small emergency fund without guilt, hype, or risky shortcuts.',
  'Magsimula ng maliit na emergency fund nang walang guilt, hype, o risky shortcuts.',
  true,
  false,
  true,
  6,
  'madali',
  '15-30 minuto para gumawa ng first plan; tuloy-tuloy na hulog kada sweldo',
  'Libre; kahit maliit na hulog ay puwedeng simulan',
  array[
    'emergency fund',
    'savings',
    'ipon',
    'budget',
    'payday',
    'basic deposit account',
    'bank account',
    'money',
    'financial safety',
    'utang prevention'
  ],
  'emergency fund savings ipon emergency ipon pang emergency starter fund rainy day fund safety fund budget payday salary sweldo sahod cash reserve first 500 first 1000 bank account basic deposit account bda pdic bsp financial planning avoid debt avoid loan app',
  'emergency fund savings ipon emergency ipon pang emergency panimulang ipon rainy day fund safety fund budget payday sweldo sahod cash reserve unang 500 unang 1000 bank account basic deposit account bda pdic bsp financial planning iwas utang iwas loan app',
  $$[
    {"title":"Saving for emergency fund key to financial stability, BSP says","publisher":"Philippine Information Agency / Bangko Sentral ng Pilipinas","url":"https://pia.gov.ph/news/saving-for-emergency-fund-key-to-financial-stability-bsp-says/"},
    {"title":"How to build an emergency fund to beat debt","publisher":"Philippine Information Agency / Bangko Sentral ng Pilipinas","url":"https://pia.gov.ph/features/how-to-build-an-emergency-fund-to-beat-debt/"},
    {"title":"Financial Planning 101","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/Media_and_Research/Primers%20Faqs/Financial%20Planning%20101.pdf"},
    {"title":"List of Banks Offering Basic Deposit Accounts","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/banking/BDA.pdf"},
    {"title":"Q&A on the New Maximum Deposit Insurance Coverage","publisher":"Philippine Deposit Insurance Corporation","url":"https://www.pdic.gov.ph/files/ccd/Q%26A%20on%20the%20New%20MDIC.pdf"}
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
  where slug = 'emergency-fund-starter-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'emergency-fund-starter-checklist'),
    'what_to_know',
    1,
    $${
      "title":"An emergency fund is not extra money",
      "body":"An emergency fund is money set aside for real surprises: sickness, job loss, urgent travel, phone loss, delayed salary, or a family need that cannot wait. It is not about being rich. It is about having a small buffer so one problem does not immediately become debt.",
      "items":[
        "Start smaller than the perfect target if money is tight",
        "The first goal is not 6 months right away; the first goal is consistency",
        "Keep emergency money separate from spending money",
        "Use it only for real emergencies, then refill it slowly",
        "This guide is practical education, not financial advice or investment advice"
      ]
    }$$::jsonb,
    $${
      "title":"Hindi extra money ang emergency fund",
      "body":"Ang emergency fund ay perang nakatabi para sa totoong biglaan: sakit, pagkawala ng trabaho, urgent na biyahe, pagkawala ng phone, delayed salary, o family need na hindi makapaghintay. Hindi ito tungkol sa pagiging mayaman. Buffer ito para hindi agad maging utang ang isang problema.",
      "items":[
        "Magsimula nang mas maliit kaysa perfect target kung gipit ang budget",
        "Hindi agad 6 months ang first goal; consistency muna ang goal",
        "Ihiwalay ang emergency money sa panggastos",
        "Gamitin lang sa totoong emergency, pagkatapos dahan-dahang palitan",
        "Practical education ito, hindi financial advice o investment advice"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-fund-starter-checklist'),
    'warning',
    2,
    $${
      "title":"START HERE: do not chase high returns for emergency money",
      "body":"Emergency money should be easy to access and low-risk. If your emergency fund is locked, volatile, or placed in a scheme promising fast profit, it may fail when you need it most.",
      "severity":"medium",
      "items":[
        "Do not put emergency money in investment schemes you do not understand",
        "Do not use loan apps as your emergency plan",
        "Do not keep all emergency cash in one wallet, one phone, or one account",
        "Do not skip bills or food just to hit a savings target",
        "Do not feel ashamed if your first target is only a small amount"
      ]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: huwag habulin ang mataas na kita para sa emergency money",
      "body":"Ang emergency money dapat madaling ma-access at low-risk. Kung naka-lock, pabago-bago ang value, o nasa scheme na nangangako ng mabilis na tubo, baka hindi ito makatulong kapag kailangan mo na.",
      "severity":"medium",
      "items":[
        "Huwag ilagay ang emergency money sa investment schemes na hindi mo naiintindihan",
        "Huwag gawing emergency plan ang loan apps",
        "Huwag ilagay lahat ng emergency cash sa iisang wallet, iisang phone, o iisang account",
        "Huwag isakripisyo ang bills o pagkain para lang ma-hit ang savings target",
        "Huwag mahiya kung maliit lang ang first target mo"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-fund-starter-checklist'),
    'step',
    3,
    $${
      "title":"Define what counts as an emergency",
      "body":"If everything is an emergency, the fund will disappear. Decide in advance what the money is for.",
      "step_number":1,
      "items":[
        "Medical need, medicine, checkup, or hospital transport",
        "Delayed salary or sudden loss of income",
        "Urgent travel for family or safety reasons",
        "Phone, SIM, wallet, ATM, or account access problem",
        "Important bill that prevents disconnection or serious penalty",
        "Not an emergency: sale, luho, food delivery craving, or random investment offer"
      ]
    }$$::jsonb,
    $${
      "title":"Linawin kung ano ang totoong emergency",
      "body":"Kung lahat ay emergency, mabilis mauubos ang fund. Mag-decide na agad kung para saan ang pera.",
      "step_number":1,
      "items":[
        "Medical need, gamot, checkup, o pamasahe papuntang hospital",
        "Delayed salary o biglang pagkawala ng income",
        "Urgent na biyahe dahil sa family o safety reason",
        "Phone, SIM, wallet, ATM, o account access problem",
        "Important bill na puwedeng magdulot ng disconnection o malaking penalty",
        "Hindi emergency: sale, luho, food delivery craving, o random investment offer"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-fund-starter-checklist'),
    'step',
    4,
    $${
      "title":"Compute your bare-minimum week",
      "body":"Do not start with a scary number. Start by knowing how much one basic survival week costs for you or your household.",
      "step_number":2,
      "items":[
        "Food and drinking water",
        "Transport to work, school, hospital, or important offices",
        "Medicine, hygiene, and basic household needs",
        "Load or internet data for work, school, banking, or emergency contact",
        "Minimum bill payments that prevent disconnection or account problems"
      ],
      "sample":"One-week minimum = food + transport + medicine/basic needs + load/data + urgent bills."
    }$$::jsonb,
    $${
      "title":"Kuwentahin ang bare-minimum week mo",
      "body":"Huwag magsimula sa nakakatakot na malaking number. Alamin muna kung magkano ang isang basic survival week para sa iyo o household mo.",
      "step_number":2,
      "items":[
        "Pagkain at inuming tubig",
        "Pamasahe papuntang work, school, hospital, o important offices",
        "Gamot, hygiene, at basic household needs",
        "Load o internet data para sa work, school, banking, o emergency contact",
        "Minimum bill payments para maiwasan ang disconnection o account problems"
      ],
      "sample":"One-week minimum = pagkain + pamasahe + gamot/basic needs + load/data + urgent bills."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-fund-starter-checklist'),
    'step',
    5,
    $${
      "title":"Choose a starter target that feels possible",
      "body":"The 3-6 months target is useful, but many people stop because it feels impossible. Start with a smaller checkpoint, then build upward.",
      "step_number":3,
      "items":[
        "First checkpoint: ₱500 or ₱1,000",
        "Next checkpoint: one week of bare-minimum expenses",
        "Next checkpoint: one month of bare-minimum expenses",
        "Longer-term goal: 3-6 months of necessary expenses, adjusted to your situation",
        "If income is irregular, focus first on one emergency week"
      ]
    }$$::jsonb,
    $${
      "title":"Pumili ng starter target na kaya mong simulan",
      "body":"Useful ang 3-6 months target, pero maraming humihinto dahil parang imposible. Magsimula sa mas maliit na checkpoint, saka dahan-dahang taasan.",
      "step_number":3,
      "items":[
        "First checkpoint: ₱500 o ₱1,000",
        "Next checkpoint: isang linggo ng bare-minimum expenses",
        "Next checkpoint: isang buwan ng bare-minimum expenses",
        "Longer-term goal: 3-6 months ng necessary expenses, depende sa sitwasyon mo",
        "Kung irregular ang income, unahin muna ang one emergency week"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-fund-starter-checklist'),
    'step',
    6,
    $${
      "title":"Decide where to keep it",
      "body":"Emergency money should be safe enough, separate enough, and accessible enough. Do not optimize only for interest. Optimize for being able to use it during a real problem.",
      "step_number":4,
      "items":[
        "Keep a small cash amount for transport, medicine, or no-signal situations",
        "Keep most of the fund in a separate savings or basic deposit account if possible",
        "Check fees, maintaining balance, dormancy rules, and access limits",
        "Remember that PDIC deposit insurance applies to covered bank deposits, subject to PDIC rules",
        "Avoid keeping everything in one phone app if losing your phone would block access"
      ]
    }$$::jsonb,
    $${
      "title":"Piliin kung saan ito ilalagay",
      "body":"Ang emergency money dapat safe enough, hiwalay enough, at accessible enough. Huwag interest lang ang habulin. Mas mahalaga na magamit ito kapag may totoong problema.",
      "step_number":4,
      "items":[
        "Magtabi ng maliit na cash para sa pamasahe, gamot, o no-signal situations",
        "Ilagay ang malaking parte sa separate savings o basic deposit account kung posible",
        "I-check ang fees, maintaining balance, dormancy rules, at access limits",
        "Tandaan na ang PDIC deposit insurance ay para sa covered bank deposits, subject sa PDIC rules",
        "Iwasang ilagay lahat sa iisang phone app kung mawawala ang access kapag nawala ang phone"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-fund-starter-checklist'),
    'step',
    7,
    $${
      "title":"Make the first deposit boring and repeatable",
      "body":"The best emergency fund plan is one you can repeat. A small automatic habit beats a big plan that only happens once.",
      "step_number":5,
      "items":[
        "Choose a fixed amount per payday, even ₱20, ₱50, or ₱100",
        "Move the money before optional spending if possible",
        "Use a separate label, envelope, jar, or account name",
        "If you use part of the fund, refill it before adding new goals",
        "Review the amount when income, rent, bills, or family needs change"
      ]
    }$$::jsonb,
    $${
      "title":"Gawing boring at repeatable ang unang hulog",
      "body":"Ang best emergency fund plan ay iyong nauulit. Mas okay ang maliit na habit kaysa malaking plano na isang beses lang nangyayari.",
      "step_number":5,
      "items":[
        "Pumili ng fixed amount kada payday, kahit ₱20, ₱50, o ₱100",
        "Ilipat ang pera bago optional spending kung kaya",
        "Gumamit ng separate label, envelope, jar, o account name",
        "Kung may nagamit sa fund, i-refill muna bago magdagdag ng bagong goals",
        "I-review ang amount kapag nagbago ang income, rent, bills, o family needs"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-fund-starter-checklist'),
    'mistake',
    8,
    $${
      "title":"Common mistakes that make emergency funds fail",
      "body":"Most people do not fail because they are lazy. They fail because the system is too hard, too vague, or too easy to spend.",
      "items":[
        "Waiting until you can save a big amount before starting",
        "Mixing emergency money with daily spending money",
        "Using the fund for non-emergency wants",
        "Putting the fund somewhere hard to access during weekends, holidays, or no internet",
        "Keeping all access in one phone, one SIM, or one app",
        "Investing emergency money in risky or locked products"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes kaya nauubos ang emergency fund",
      "body":"Hindi dahil tamad ang karamihan. Madalas, masyadong mahirap, malabo, o madaling gastusin ang system.",
      "items":[
        "Naghihintay muna ng malaking amount bago magsimula",
        "Hinahalo ang emergency money sa daily spending money",
        "Ginagamit ang fund sa non-emergency wants",
        "Inilalagay ang fund sa mahirap ma-access kapag weekend, holiday, o walang internet",
        "Lahat ng access nasa iisang phone, iisang SIM, o iisang app",
        "Ini-invest ang emergency money sa risky o locked products"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-fund-starter-checklist'),
    'tip',
    9,
    $${
      "title":"Simple starter plan",
      "body":"Use this if you do not know where to start.",
      "sample":"This payday, I will save ₱____ for emergency only. My first target is ₱____. I will keep it in ____. I can use it only for medical needs, income delay, urgent travel, phone/SIM/wallet/account access problems, or important bills that cannot wait."
    }$$::jsonb,
    $${
      "title":"Simple starter plan",
      "body":"Gamitin ito kung hindi mo alam kung saan magsisimula.",
      "sample":"Ngayong payday, magtatabi ako ng ₱____ para sa emergency lang. Ang first target ko ay ₱____. Ilalagay ko ito sa ____. Gagamitin ko lang ito para sa medical needs, income delay, urgent travel, phone/SIM/wallet/account access problems, o important bills na hindi makapaghintay."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-fund-starter-checklist'),
    'tip',
    10,
    $${
      "title":"Emergency fund checklist",
      "body":"Before calling your fund ready, check if it can actually help during a stressful day.",
      "items":[
        "Starter target written down",
        "Bare-minimum weekly expenses estimated",
        "Separate place for emergency money chosen",
        "Small cash backup prepared if possible",
        "Bank or e-wallet access tested",
        "Fees and withdrawal limits checked",
        "Trusted contact knows where emergency info is kept",
        "Refill rule decided after using the fund"
      ]
    }$$::jsonb,
    $${
      "title":"Emergency fund checklist",
      "body":"Bago sabihing ready na ang fund, i-check kung makakatulong talaga ito sa stressful na araw.",
      "items":[
        "Nakasulat ang starter target",
        "Na-estimate ang bare-minimum weekly expenses",
        "May hiwalay na lalagyan o account para sa emergency money",
        "May maliit na cash backup kung kaya",
        "Na-test ang bank o e-wallet access",
        "Na-check ang fees at withdrawal limits",
        "May trusted contact na alam kung saan nakatago ang emergency info",
        "May refill rule pagkatapos gamitin ang fund"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-fund-starter-checklist'),
    'related',
    11,
    $${
      "title":"Related guides",
      "body":"Use these next depending on what makes emergencies harder for you.",
      "items":[
        "Payday Budget Simple Split: if you are often short before payday",
        "Monthly Budget Checklist for Families: if household expenses are hard to track",
        "First Bank Account Checklist: if you need a safer place for savings",
        "Lost ATM or Debit Card First Steps: if access to your emergency money is blocked",
        "Loan App Harassment Evidence Checklist: if debt collectors are pressuring you"
      ]
    }$$::jsonb,
    $${
      "title":"Related guides",
      "body":"Gamitin ang guides na ito depende sa nagpapahirap sa emergencies mo.",
      "items":[
        "Payday Budget Simple Split: kung madalas kulang bago payday",
        "Monthly Budget Checklist for Families: kung mahirap i-track ang household expenses",
        "First Bank Account Checklist: kung kailangan ng mas safe na lalagyan ng savings",
        "Lost ATM or Debit Card First Steps: kung blocked ang access sa emergency money",
        "Loan App Harassment Evidence Checklist: kung pini-pressure ka ng debt collectors"
      ]
    }$$::jsonb
  );
