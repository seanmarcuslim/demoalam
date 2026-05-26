update public.guides
set
  title_en = 'Salary short before payday: what to prioritize first',
  title_fil = 'Kulang ang sweldo bago payday: ano ang uunahin',
  tagline_en = 'Sort food, transport, bills, debt, and safer options before panic borrowing or installing a loan app.',
  tagline_fil = 'Ayusin muna ang pagkain, pamasahe, bills, utang, at safer options bago mag-panic borrow o mag-install ng loan app.',
  read_time_min = 7,
  estimated_time = '20-30 minuto',
  estimated_cost = 'Libre',
  difficulty = 'katamtaman',
  is_featured = true,
  is_urgent = true,
  tags = array[
    'money',
    'budget',
    'payday',
    'salary',
    'debt',
    'utang',
    'loan',
    'online lending',
    'emergency fund',
    'bills',
    'cash shortfall'
  ],
  keywords_en = 'salary short before payday payday budget petsa de peligro shortfall cash short money kulang sweldo sahod bills rent food transport debt utang loan online lending ola emergency fund payment extension installment due date collections',
  keywords_fil = 'kulang sweldo bago payday petsa de peligro sahod kulang pera shortfall cash short bills renta pagkain pamasahe utang loan online lending ola emergency fund payment extension installment due date paniningil',
  official_sources = '[
    {"title":"Financial Products and Services","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/Pages/InclusiveFinance/FinancialProductsServices.aspx"},
    {"title":"Financial Inclusion","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/SitePages/InclusiveFinance/InclusiveFinance.aspx"},
    {"title":"Advisory for Online Lending Platforms Borrowers","publisher":"Securities and Exchange Commission","url":"https://www.sec.gov.ph/wp-content/uploads/2023/10/2023advisory_For-Online-Lending-Platforms-Borrowers.pdf"},
    {"title":"Public Advisory on Online Lending Platforms","publisher":"DICT, NPC, and SEC","url":"https://privacy.gov.ph/wp-content/uploads/2026/03/DICT-NPC-SEC-Public-Advisory-on-Online-Lending-Platforms.pdf"},
    {"title":"Online lenders barred from harvesting borrowers phone and social-media contact list","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/online-lenders-barred-from-harvesting-borrowers-phone-and-social-media-contact-list-says-privacy-commission/"}
  ]'::jsonb,
  updated_at = now()
where slug = 'payday-budget-simple-split';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'payday-budget-simple-split'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'what_to_know',
    1,
    $${
      "title":"Being short before payday is a priority problem, not a character problem",
      "body":"When money is short, panic can make every expense feel equally urgent. It is not. The goal is to protect survival, work access, due dates, and account safety before borrowing. A small clear plan is better than hiding, guessing, or installing the first loan app that approves you.",
      "items":[
        "Food, medicine, and transport usually come before wants",
        "Some bills can be arranged, but ignored bills become heavier",
        "Debt should be handled through official options, not shame",
        "Loan apps can become dangerous if fees, due dates, and permissions are unclear",
        "The first step is knowing the exact shortfall, not blaming yourself"
      ]
    }$$::jsonb,
    $${
      "title":"Kapag kulang bago payday, priority problem ito, hindi character problem",
      "body":"Kapag kulang ang pera, parang lahat ng gastos urgent. Hindi pare-pareho ang priority. Ang goal ay protektahan ang pagkain, gamot, pamasahe, due dates, at account safety bago umutang. Mas mabuti ang maliit pero malinaw na plano kaysa magtago, manghula, o mag-install agad ng unang loan app na mag-a-approve.",
      "items":[
        "Mas nauuna kadalasan ang pagkain, gamot, at pamasahe kaysa wants",
        "May bills na puwedeng ipa-arrange, pero lumalala kapag iniiwasan",
        "Ang utang dapat asikasuhin sa official options, hindi sa hiya",
        "Delikado ang loan apps kapag malabo ang fees, due dates, at permissions",
        "Unang step ay alamin ang exact shortfall, hindi sisihin ang sarili"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'warning',
    2,
    $${
      "title":"Do not make a loan app your first move",
      "body":"Fast approval can feel like relief, but it can also start a debt cycle. Pause if the app asks for contacts, photos, files, social accounts, OTP, PIN, payroll login, or broad phone access.",
      "severity":"high",
      "items":[
        "Do not borrow before writing the exact amount you lack",
        "Do not borrow for non-essential spending while food or transport is not covered",
        "Do not install apps that demand contacts, photos, files, or social accounts",
        "Do not use a second loan to hide the first loan",
        "Do not send OTP, PIN, bank login, payroll login, or e-wallet login to anyone"
      ]
    }$$::jsonb,
    $${
      "title":"Huwag gawing unang move ang loan app",
      "body":"Nakakagaan tingnan ang fast approval, pero puwede rin itong magsimula ng debt cycle. Huminto kung humihingi ang app ng contacts, photos, files, social accounts, OTP, PIN, payroll login, o malawak na phone access.",
      "severity":"high",
      "items":[
        "Huwag umutang bago isulat ang exact amount na kulang",
        "Huwag umutang para sa non-essential spending kung kulang pa sa pagkain o pamasahe",
        "Huwag mag-install ng apps na humihingi ng contacts, photos, files, o social accounts",
        "Huwag gumamit ng second loan para itago ang unang loan",
        "Huwag magpadala ng OTP, PIN, bank login, payroll login, o e-wallet login sa kahit sino"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'step',
    3,
    $${
      "title":"Write the exact shortfall",
      "body":"Do not solve a guessed problem. List what money is left, what must be paid before next payday, and how much is truly missing.",
      "step_number":1,
      "items":[
        "Cash and e-wallet balance left",
        "Food and transport needed until payday",
        "Bills due before payday",
        "Debt payments already promised",
        "Medicine, school, or work expenses that cannot wait",
        "Exact amount missing after essentials"
      ]
    }$$::jsonb,
    $${
      "title":"Isulat ang exact shortfall",
      "body":"Huwag solusyonan ang problemang hinuhulaan lang. Ilahad kung magkano ang natira, ano ang kailangang bayaran bago payday, at magkano talaga ang kulang.",
      "step_number":1,
      "items":[
        "Natitirang cash at e-wallet balance",
        "Pagkain at pamasahe hanggang payday",
        "Bills na due bago payday",
        "Utang na napangakuang bayaran",
        "Gamot, school, o work expenses na hindi puwedeng ipagpaliban",
        "Exact amount na kulang pagkatapos ng essentials"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'step',
    4,
    $${
      "title":"Protect survival and work access first",
      "body":"If the money is very tight, protect the things that keep you safe and able to earn or study. Delay wants before risking food, medicine, or transport.",
      "step_number":2,
      "items":[
        "Food or groceries until payday",
        "Medicine or health needs",
        "Transport to work or school",
        "Load or internet only if needed for work, school, or urgent communication",
        "Rent or housing share if non-payment creates immediate risk",
        "Child, elder, or family support that cannot safely wait"
      ]
    }$$::jsonb,
    $${
      "title":"Unahin ang survival at access sa trabaho o school",
      "body":"Kung sobrang tight ang pera, protektahan muna ang kailangan para safe ka at makapasok sa trabaho o school. I-delay ang wants bago isugal ang pagkain, gamot, o pamasahe.",
      "step_number":2,
      "items":[
        "Pagkain o groceries hanggang payday",
        "Gamot o health needs",
        "Pamasahe papuntang work o school",
        "Load o internet kung kailangan sa work, school, o urgent communication",
        "Renta o share sa bahay kung delikado agad kapag hindi nabayaran",
        "Child, elder, o family support na hindi ligtas ipagpaliban"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'step',
    5,
    $${
      "title":"Rank bills by consequence, not by emotion",
      "body":"Some bills are embarrassing, but not all have the same consequence. Put the highest-risk due dates first, then ask for official options before the due date passes.",
      "step_number":3,
      "items":[
        "Could non-payment disconnect water, power, phone, or internet needed for work?",
        "Could it create late fees or penalties?",
        "Could it affect housing, school, or job access?",
        "Is there an official extension, installment, or partial payment option?",
        "Can a non-essential subscription or purchase be paused?",
        "Can you inform the creditor before the due date instead of hiding?"
      ]
    }$$::jsonb,
    $${
      "title":"I-rank ang bills base sa consequence, hindi emotion",
      "body":"May bills na nakakahiya, pero hindi pare-pareho ang consequence. Unahin ang may pinakamataas na risk, pagkatapos magtanong ng official options bago lumampas ang due date.",
      "step_number":3,
      "items":[
        "Madi-disconnect ba ang tubig, kuryente, phone, o internet na kailangan sa work?",
        "Magkakaroon ba ng late fees o penalties?",
        "Maaapektuhan ba ang bahay, school, o job access?",
        "May official extension, installment, o partial payment option ba?",
        "May non-essential subscription o purchase bang puwedeng i-pause?",
        "Puwede mo bang sabihan ang creditor bago due date imbes na magtago?"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'step',
    6,
    $${
      "title":"Ask for official arrangements before borrowing",
      "body":"Before taking a risky loan, ask the billing provider, lender, landlord, school, employer, or office for official options. Do it through official channels and save the reply.",
      "step_number":4,
      "items":[
        "Payment extension",
        "Installment or partial payment",
        "Penalty waiver or due date adjustment",
        "Salary advance only if official and clearly documented",
        "Family help with a clear repayment date",
        "Community, school, workplace, or government assistance if applicable"
      ]
    }$$::jsonb,
    $${
      "title":"Magtanong muna ng official arrangements bago umutang",
      "body":"Bago kumuha ng risky loan, magtanong muna sa billing provider, lender, landlord, school, employer, o office kung may official options. Sa official channels gawin at i-save ang reply.",
      "step_number":4,
      "items":[
        "Payment extension",
        "Installment o partial payment",
        "Penalty waiver o due date adjustment",
        "Salary advance kung official at malinaw ang documentation",
        "Tulong sa pamilya na may malinaw na repayment date",
        "Community, school, workplace, o government assistance kung applicable"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'step',
    7,
    $${
      "title":"If borrowing is unavoidable, make it small and documented",
      "body":"Borrowing may be necessary sometimes. The safer rule is to borrow only the real shortfall, understand the total repayment, and avoid lenders that use pressure or excessive data access.",
      "step_number":5,
      "items":[
        "Borrow only the amount needed for essentials",
        "Write total repayment, due date, and penalty",
        "Use official or trusted channels only",
        "Avoid lenders that threaten public shame or contact blasting",
        "Save screenshots of the agreement and payment channels",
        "Plan the next payday before accepting the loan"
      ]
    }$$::jsonb,
    $${
      "title":"Kung kailangan talagang umutang, gawing maliit at documented",
      "body":"May pagkakataong kailangan talaga umutang. Mas safe kung exact shortfall lang ang hihiramin, malinaw ang total repayment, at iiwasan ang lenders na gumagamit ng pressure o sobrang data access.",
      "step_number":5,
      "items":[
        "Manghiram lang ng kailangan para sa essentials",
        "Isulat ang total repayment, due date, at penalty",
        "Official o trusted channels lang gamitin",
        "Iwasan ang lenders na nananakot ng public shame o contact blasting",
        "I-save ang screenshots ng agreement at payment channels",
        "I-plano ang next payday bago tanggapin ang loan"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'mistake',
    8,
    $${
      "title":"Common mistakes when money is short",
      "body":"These mistakes usually happen because people feel ashamed, rushed, or exhausted. Slow down before the shortfall becomes a bigger problem.",
      "items":[
        "Borrowing before knowing the exact shortfall",
        "Paying the loudest collector first instead of the highest-risk need",
        "Skipping food or transport to protect non-essential spending",
        "Ignoring due dates until penalties appear",
        "Installing loan apps without checking permissions",
        "Using another loan to pay the first loan",
        "Deleting messages, receipts, or threats instead of saving evidence"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes kapag kulang ang pera",
      "body":"Madalas nangyayari ito dahil nahihiya, minamadali, o pagod na pagod ang tao. Huminto muna bago lumaki ang shortfall.",
      "items":[
        "Umutang bago malaman ang exact shortfall",
        "Binabayaran ang pinakamakulit na naniningil imbes na highest-risk need",
        "Tinitipid ang pagkain o pamasahe para maprotektahan ang non-essential spending",
        "Iniiwasan ang due dates hanggang lumabas ang penalties",
        "Nag-i-install ng loan apps nang hindi chine-check ang permissions",
        "Gumagamit ng panibagong loan para bayaran ang unang loan",
        "Binubura ang messages, receipts, o threats imbes na mag-save ng evidence"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'tip',
    9,
    $${
      "title":"Shortfall checklist",
      "body":"Use this before borrowing or delaying a payment.",
      "items":[
        "I know the exact amount missing",
        "Food, medicine, and transport are protected first",
        "I ranked bills by real consequence",
        "I asked for official extension or installment options",
        "I paused non-essential spending",
        "I checked safer help before loan apps",
        "If borrowing, I know total repayment and due date",
        "I did not give OTP, PIN, bank login, payroll login, or e-wallet login"
      ]
    }$$::jsonb,
    $${
      "title":"Shortfall checklist",
      "body":"Gamitin ito bago umutang o mag-delay ng payment.",
      "items":[
        "Alam ko ang exact amount na kulang",
        "Protektado muna ang pagkain, gamot, at pamasahe",
        "Na-rank ko ang bills base sa totoong consequence",
        "Nagtanong ako ng official extension o installment options",
        "Na-pause ko ang non-essential spending",
        "Na-check ko ang safer help bago loan apps",
        "Kung uutang, alam ko ang total repayment at due date",
        "Hindi ako nagbigay ng OTP, PIN, bank login, payroll login, o e-wallet login"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'tip',
    10,
    $${
      "title":"Sample message to ask for payment arrangement",
      "body":"Keep it short, respectful, and specific. Send only through official channels.",
      "sample":"Hello po. Short po ako before payday and I want to settle this properly. May official option po ba for partial payment, extension, installment, or adjusted due date? Please send the official process, amount, deadline, and payment channel so I can avoid penalties or wrong payments."
    }$$::jsonb,
    $${
      "title":"Sample message para magtanong ng payment arrangement",
      "body":"Gawing maikli, maayos, at specific. Sa official channels lang ipadala.",
      "sample":"Hello po. Short po ako before payday and gusto ko pong maayos ito nang tama. May official option po ba for partial payment, extension, installment, o adjusted due date? Paki-send po ang official process, amount, deadline, at payment channel para maiwasan ko ang penalties o maling payment."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'tip',
    11,
    $${
      "title":"What to expect",
      "body":"The first honest shortfall list may feel stressful, but it gives you control. You may discover that the problem is smaller than it felt, or that one bill needs an official arrangement. The win is not pretending everything is fine. The win is avoiding a rushed decision that makes next payday worse."
    }$$::jsonb,
    $${
      "title":"Ano ang aasahan",
      "body":"Puwedeng stressful ang unang honest shortfall list, pero binibigyan ka nito ng control. Baka makita mong mas maliit pala ang problem kaysa sa pakiramdam, o may isang bill lang na kailangan ng official arrangement. Hindi panalo ang magpanggap na okay lahat. Ang panalo ay umiwas sa rushed decision na magpapalala sa next payday."
    }$$::jsonb
  );
