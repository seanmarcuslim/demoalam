update public.guides
set
  title_en = 'First bank account checklist',
  title_fil = 'First bank account checklist',
  tagline_en = 'Choose a bank account for payroll, savings, or daily money without surprises from fees, balance rules, or card scams.',
  tagline_fil = 'Pumili ng bank account para sa payroll, savings, o daily money nang hindi nabibigla sa fees, balance rules, o card scams.',
  read_time_min = 7,
  estimated_time = '1-2 oras',
  estimated_cost = '0-3000 pesos',
  difficulty = 'madali',
  is_featured = true,
  is_urgent = false,
  tags = array[
    'bank',
    'bank account',
    'basic deposit account',
    'savings',
    'payroll',
    'debit card',
    'atm',
    'pdic',
    'bsp',
    'first job',
    'money safety'
  ],
  keywords_en = 'bank account first time open savings payroll debit card atm basic deposit account bda no maintaining balance dormancy fees initial deposit valid id online banking mobile banking pdic bsp deposit insurance scam card pin otp phishing',
  keywords_fil = 'bank account unang beses open savings payroll debit card atm basic deposit account bda walang maintaining balance dormancy fees initial deposit valid id online banking mobile banking pdic bsp deposit insurance scam card pin otp phishing pera sweldo',
  official_sources = '[
    {"title":"Financial Products and Services - Deposits","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/Pages/InclusiveFinance/FinancialProductsServices.aspx"},
    {"title":"List of Banks Offering Basic Deposit Accounts","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/banking/BDA.pdf"},
    {"title":"Philippine Deposit Insurance System at a Glance","publisher":"Philippine Deposit Insurance Corporation","url":"https://www.pdic.gov.ph/public-policy"},
    {"title":"New maximum deposit insurance coverage of P1 Million takes effect","publisher":"Philippine Deposit Insurance Corporation","url":"https://www.pdic.gov.ph/files/ccd/PR-038-25%20New%20maximum%20deposit%20insurance%20coverage%20of%20P1%20Million%20takes%20effect%20on%20March%2015.pdf"}
  ]'::jsonb,
  updated_at = now()
where slug = 'bank-account-first-time';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'bank-account-first-time'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'what_to_know',
    1,
    $${
      "title":"Your first account should match how you will use money",
      "body":"A bank account is not only for saving. It may be for payroll, allowance, online payments, emergency money, remittances, or proving financial history later. The safest first account is not always the one with the prettiest app. It is the one with clear fees, easy access, useful customer support, and rules you can actually follow.",
      "items":[
        "Payroll accounts are often guided by your employer",
        "Savings accounts may have maintaining balance rules",
        "Basic Deposit Accounts may have low opening amount and simpler requirements",
        "Debit cards and online banking need strong PIN, password, and OTP habits",
        "PDIC deposit insurance protects eligible bank deposits up to the current coverage limit per depositor, per bank"
      ]
    }$$::jsonb,
    $${
      "title":"Dapat tugma sa gamit mo ang unang bank account",
      "body":"Hindi lang para sa ipon ang bank account. Puwede itong para sa payroll, allowance, online payments, emergency money, remittances, o proof ng financial history sa future. Hindi laging pinaka-safe ang account na may pinakamagandang app. Ang mas mahalaga ay malinaw ang fees, madaling gamitin, maayos ang support, at kaya mong sundin ang rules.",
      "items":[
        "Payroll accounts ay madalas guided ng employer",
        "Savings accounts ay puwedeng may maintaining balance rules",
        "Basic Deposit Accounts ay maaaring mababa ang opening amount at mas simple ang requirements",
        "Debit cards at online banking kailangan ng maingat na PIN, password, at OTP habits",
        "Ang PDIC deposit insurance ay proteksyon sa eligible bank deposits hanggang sa current coverage limit per depositor, per bank"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'warning',
    2,
    $${
      "title":"Do not open or use an account through a stranger",
      "body":"A bank account can be misused for scams, fake jobs, money mule activity, unauthorized loans, or identity misuse. Never let another person control your account, card, PIN, OTP, mobile banking, or SIM linked to the account.",
      "severity":"high",
      "items":[
        "Do not sell, rent, or lend your bank account",
        "Do not give your ATM card and PIN to another person",
        "Do not share OTP, password, or mobile banking access",
        "Do not open an account because a stranger promises easy income",
        "Do not click bank login links from SMS, chat, email, ads, or comments"
      ]
    }$$::jsonb,
    $${
      "title":"Huwag mag-open o gumamit ng account through stranger",
      "body":"Puwedeng magamit ang bank account sa scams, fake jobs, money mule activity, unauthorized loans, o identity misuse. Huwag hayaang ibang tao ang may control ng account, card, PIN, OTP, mobile banking, o SIM na linked sa account.",
      "severity":"high",
      "items":[
        "Huwag ibenta, iparenta, o ipahiram ang bank account",
        "Huwag ibigay ang ATM card at PIN sa ibang tao",
        "Huwag mag-share ng OTP, password, o mobile banking access",
        "Huwag mag-open ng account dahil may stranger na nangakong easy income",
        "Huwag mag-click ng bank login links mula sa SMS, chat, email, ads, o comments"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'step',
    3,
    $${
      "title":"Decide the account purpose first",
      "body":"Before choosing a bank, write why you need the account. The purpose affects the right account type, branch, fees, and documents.",
      "step_number":1,
      "items":[
        "Payroll or first job salary",
        "Emergency savings",
        "Allowance or student money",
        "Online payments and debit card use",
        "Receiving remittance or family support",
        "Simple starter account with low opening amount"
      ]
    }$$::jsonb,
    $${
      "title":"Alamin muna ang purpose ng account",
      "body":"Bago pumili ng bank, isulat kung bakit mo kailangan ang account. Nakakaapekto ang purpose sa tamang account type, branch, fees, at documents.",
      "step_number":1,
      "items":[
        "Payroll o unang sweldo",
        "Emergency savings",
        "Allowance o student money",
        "Online payments at debit card use",
        "Pagtanggap ng remittance o support ng pamilya",
        "Simple starter account na mababa ang opening amount"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'step',
    4,
    $${
      "title":"Ask the fee and balance questions before opening",
      "body":"Many first-time account holders get surprised later because they did not ask about balance rules, card fees, transfer fees, or dormancy. Ask before signing or submitting.",
      "step_number":2,
      "items":[
        "How much is the opening amount?",
        "Is there a maintaining balance?",
        "Is there a dormancy fee if I stop using the account?",
        "Is the ATM or debit card free or paid?",
        "Are online transfers, withdrawals, or balance inquiries charged?",
        "What happens if my balance goes below the required amount?"
      ]
    }$$::jsonb,
    $${
      "title":"Itanong muna ang fees at balance rules",
      "body":"Maraming first-time account holders ang nagugulat later dahil hindi natanong ang balance rules, card fees, transfer fees, o dormancy. Magtanong bago pumirma o mag-submit.",
      "step_number":2,
      "items":[
        "Magkano ang opening amount?",
        "May maintaining balance ba?",
        "May dormancy fee ba kung hindi ko magamit ang account?",
        "Libre ba o may bayad ang ATM/debit card?",
        "May charge ba ang online transfers, withdrawals, o balance inquiry?",
        "Ano ang mangyayari kung bumaba sa required balance ang account?"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'step',
    5,
    $${
      "title":"Prepare documents and contact details",
      "body":"Requirements differ by bank and account type, but having clean details prevents delays. If you lack traditional IDs, ask about Basic Deposit Account options and accepted identification.",
      "step_number":3,
      "items":[
        "Valid ID or accepted alternative identification",
        "Current address and contact number",
        "Email you can access",
        "Initial deposit if required",
        "Employer payroll instructions if this is for work",
        "Emergency contact if the bank asks for one"
      ]
    }$$::jsonb,
    $${
      "title":"Ihanda ang documents at contact details",
      "body":"Nag-iiba ang requirements depende sa bank at account type, pero nakakaiwas sa delay ang malinis na details. Kung kulang ka sa traditional IDs, itanong ang Basic Deposit Account options at accepted identification.",
      "step_number":3,
      "items":[
        "Valid ID o accepted alternative identification",
        "Current address at contact number",
        "Email na naa-access mo",
        "Initial deposit kung required",
        "Employer payroll instructions kung para ito sa work",
        "Emergency contact kung hinihingi ng bank"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'step',
    6,
    $${
      "title":"Secure online banking before using the account heavily",
      "body":"The account is not fully ready until you can protect and recover access. Set it up while you still have time, not during an emergency.",
      "step_number":4,
      "items":[
        "Create a strong password that is not reused",
        "Use a PIN that is not your birthday or repeated digits",
        "Keep your registered SIM active and secure",
        "Turn on app notifications if available",
        "Save official hotline and support channels",
        "Know how to lock card, report fraud, or reset access"
      ]
    }$$::jsonb,
    $${
      "title":"I-secure ang online banking bago gamitin nang todo",
      "body":"Hindi pa fully ready ang account hangga't hindi mo kayang protektahan at i-recover ang access. Ayusin ito habang may oras ka pa, hindi kapag emergency na.",
      "step_number":4,
      "items":[
        "Gumawa ng strong password na hindi reused",
        "Gumamit ng PIN na hindi birthday o paulit-ulit na digits",
        "Panatilihing active at secure ang registered SIM",
        "I-on ang app notifications kung available",
        "I-save ang official hotline at support channels",
        "Alamin paano mag-lock ng card, mag-report ng fraud, o mag-reset ng access"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'mistake',
    7,
    $${
      "title":"Common mistakes of first-time account holders",
      "body":"These mistakes are normal, but they can cost money, access, or safety if ignored.",
      "items":[
        "Opening an account without asking maintaining balance",
        "Choosing an account only because friends use it",
        "Using one account for savings, spending, and risky online transactions",
        "Letting someone else keep the ATM card",
        "Using birthday as PIN",
        "Ignoring small fees until the balance is drained",
        "Not saving official support channels before a problem happens"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang pagkakamali ng first-time account holders",
      "body":"Normal ang mistakes na ito, pero puwede silang maging gastos, access problem, o safety risk kapag binalewala.",
      "items":[
        "Nag-open ng account nang hindi nagtatanong ng maintaining balance",
        "Pumili ng account dahil lang ginagamit ng friends",
        "Isang account lang ang gamit para sa savings, spending, at risky online transactions",
        "Ipinapahawak sa ibang tao ang ATM card",
        "Birthday ang ginawang PIN",
        "Hindi pinapansin ang small fees hanggang lumiit ang balance",
        "Hindi nag-save ng official support channels bago magkaroon ng problema"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'tip',
    8,
    $${
      "title":"Checklist before choosing an account",
      "body":"Use this before opening or accepting a payroll account.",
      "items":[
        "I know if this is for payroll, savings, or daily spending",
        "I asked the opening amount",
        "I asked the maintaining balance",
        "I asked about dormancy, card, withdrawal, and transfer fees",
        "I know if online banking is available",
        "I know how to report a lost card or unauthorized transaction",
        "I checked if a Basic Deposit Account is better for my situation",
        "I will not share OTP, PIN, password, or account access"
      ]
    }$$::jsonb,
    $${
      "title":"Checklist bago pumili ng account",
      "body":"Gamitin ito bago mag-open o tumanggap ng payroll account.",
      "items":[
        "Alam ko kung para ito sa payroll, savings, o daily spending",
        "Naitanong ko ang opening amount",
        "Naitanong ko ang maintaining balance",
        "Naitanong ko ang dormancy, card, withdrawal, at transfer fees",
        "Alam ko kung may online banking",
        "Alam ko paano mag-report ng lost card o unauthorized transaction",
        "Na-check ko kung mas bagay sa akin ang Basic Deposit Account",
        "Hindi ako magsha-share ng OTP, PIN, password, o account access"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'tip',
    9,
    $${
      "title":"Sample questions at the branch or chat support",
      "body":"Ask these before signing up.",
      "sample":"Hi, I am opening my first bank account. Can you confirm the opening amount, maintaining balance, dormancy fee, ATM/debit card fee, online banking access, and how to report unauthorized transactions? Is there a Basic Deposit Account option if I want a simpler starter account?"
    }$$::jsonb,
    $${
      "title":"Sample questions sa branch o chat support",
      "body":"Itanong ito bago mag-sign up.",
      "sample":"Hi po, mag-o-open po ako ng first bank account. Paki-confirm po ang opening amount, maintaining balance, dormancy fee, ATM/debit card fee, online banking access, at paano mag-report ng unauthorized transactions. May Basic Deposit Account option po ba kung simple starter account ang gusto ko?"
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'tip',
    10,
    $${
      "title":"What to expect",
      "body":"Opening can be quick if your ID, phone number, email, and initial deposit are ready. Payroll accounts may follow employer instructions. Some banks allow simple starter accounts, while others require higher balances or more documents. The best account is the one you understand enough to maintain safely."
    }$$::jsonb,
    $${
      "title":"Ano ang aasahan",
      "body":"Puwedeng mabilis ang opening kung ready ang ID, phone number, email, at initial deposit. Ang payroll account ay puwedeng sumunod sa instructions ng employer. May banks na may simple starter accounts, may iba namang mas mataas ang balance o mas maraming documents. Ang best account ay yung naiintindihan mo at kaya mong i-maintain nang safe."
    }$$::jsonb
  );
