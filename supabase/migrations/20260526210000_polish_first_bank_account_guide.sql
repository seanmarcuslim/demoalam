update public.guides
set
  title_en = 'First bank account: fees, payroll, and safety checklist',
  title_fil = 'Unang bank account: fees, payroll, at safety checklist',
  tagline_en = 'Choose your first account without surprises from maintaining balance, dormancy fees, ATM cards, online banking, or account-rental scams.',
  tagline_fil = 'Pumili ng unang account nang hindi nabibigla sa maintaining balance, dormancy fees, ATM card, online banking, o account-rental scams.',
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
    'maintaining balance',
    'dormancy fee',
    'pdic',
    'bsp',
    'first job',
    'money mule',
    'money safety'
  ],
  keywords_en = 'bank account first time open savings payroll debit card atm basic deposit account bda no maintaining balance no dormancy fee initial deposit valid id online banking mobile banking pdic bsp deposit insurance money mule account rental lend account scam card pin otp phishing first job salary sweldo',
  keywords_fil = 'bank account unang bank account unang beses open savings payroll debit card atm basic deposit account bda walang maintaining balance walang dormancy fee initial deposit valid id online banking mobile banking pdic bsp deposit insurance money mule account rental ipahiram account scam card pin otp phishing first job sweldo sahod',
  official_sources = '[
    {"title":"Financial Products and Services - Deposits","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/Pages/InclusiveFinance/FinancialProductsServices.aspx"},
    {"title":"List of Banks Offering Basic Deposit Accounts","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/banking/BDA.pdf"},
    {"title":"New maximum deposit insurance coverage of P1 Million takes effect","publisher":"Philippine Deposit Insurance Corporation","url":"https://www.pdic.gov.ph/files/ccd/PR-038-25%20New%20maximum%20deposit%20insurance%20coverage%20of%20P1%20Million%20takes%20effect%20on%20March%2015.pdf"},
    {"title":"Philippine Deposit Insurance System at a Glance","publisher":"Philippine Deposit Insurance Corporation","url":"https://www.pdic.gov.ph/public-policy"}
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
      "title":"Your first bank account should be easy to maintain, not just easy to open",
      "body":"A first bank account may be for payroll, allowance, savings, remittance, online payments, or emergency money. The best first account is the one you understand enough to keep safe: fees, maintaining balance, card rules, online banking access, and how to report a problem.",
      "items":[
        "Payroll accounts may follow employer instructions",
        "Savings accounts may have maintaining balance and dormancy rules",
        "Basic Deposit Accounts can be useful if you need a simpler starter account",
        "ATM/debit cards need PIN and card safety habits",
        "Online banking needs strong password, OTP, and SIM safety",
        "PDIC deposit insurance protects eligible deposits up to the current coverage limit per depositor, per bank"
      ]
    }$$::jsonb,
    $${
      "title":"Ang unang bank account dapat madaling i-maintain, hindi lang madaling buksan",
      "body":"Puwedeng para sa payroll, allowance, savings, remittance, online payments, o emergency money ang unang bank account. Ang best first account ay yung naiintindihan mo nang sapat para mapanatiling safe: fees, maintaining balance, card rules, online banking access, at paano mag-report kapag may problema.",
      "items":[
        "Ang payroll account ay puwedeng sumunod sa instructions ng employer",
        "Ang savings account ay puwedeng may maintaining balance at dormancy rules",
        "Puwedeng bagay ang Basic Deposit Account kung kailangan mo ng mas simpleng starter account",
        "Kailangan ng ATM/debit card ng maingat na PIN at card safety habits",
        "Kailangan ng online banking ng strong password, OTP, at SIM safety",
        "Ang PDIC deposit insurance ay proteksyon sa eligible deposits hanggang sa current coverage limit per depositor, per bank"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'warning',
    2,
    $${
      "title":"Never sell, rent, or lend your bank account",
      "body":"If someone offers money just to use your account, ATM card, online banking, payroll account, or SIM, stop. Your account can be used for scams, fake jobs, illegal money transfers, unauthorized loans, or money mule activity. You may be the one questioned later because the account is under your name.",
      "severity":"high",
      "items":[
        "Do not sell, rent, or lend your bank account",
        "Do not let another person keep your ATM card or PIN",
        "Do not receive money for strangers as a favor or side job",
        "Do not open an account because a stranger promises easy income",
        "Do not share OTP, password, mobile banking access, or registered SIM",
        "Do not click bank login links from SMS, chat, email, ads, or comments"
      ]
    }$$::jsonb,
    $${
      "title":"Huwag ibenta, iparenta, o ipahiram ang bank account",
      "body":"Kung may nag-aalok ng pera kapalit ng paggamit ng account, ATM card, online banking, payroll account, o SIM mo, huminto. Puwedeng magamit ang account mo sa scams, fake jobs, illegal money transfers, unauthorized loans, o money mule activity. Ikaw ang puwedeng ma-question later dahil pangalan mo ang nasa account.",
      "severity":"high",
      "items":[
        "Huwag ibenta, iparenta, o ipahiram ang bank account",
        "Huwag ipahawak sa iba ang ATM card o PIN",
        "Huwag tumanggap ng pera para sa strangers bilang favor o side job",
        "Huwag mag-open ng account dahil may stranger na nangangakong easy income",
        "Huwag mag-share ng OTP, password, mobile banking access, o registered SIM",
        "Huwag mag-click ng bank login links mula sa SMS, chat, email, ads, o comments"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'step',
    3,
    $${
      "title":"Choose the account by purpose",
      "body":"Before opening, write why you need the account. This decides what matters most: payroll access, low fees, savings discipline, nearby branches, ATM access, or online banking.",
      "step_number":1,
      "items":[
        "Payroll or first job salary",
        "Emergency savings",
        "Student allowance or family support",
        "Online payments and debit card use",
        "Receiving remittance",
        "Simple starter account with low opening amount",
        "Separate account for savings instead of daily spending"
      ]
    }$$::jsonb,
    $${
      "title":"Pumili ng account base sa purpose",
      "body":"Bago mag-open, isulat kung bakit mo kailangan ang account. Dito nakadepende kung ano ang pinakaimportante: payroll access, mababang fees, savings discipline, malapit na branch, ATM access, o online banking.",
      "step_number":1,
      "items":[
        "Payroll o unang sweldo",
        "Emergency savings",
        "Student allowance o support ng pamilya",
        "Online payments at debit card use",
        "Pagtanggap ng remittance",
        "Simple starter account na mababa ang opening amount",
        "Separate account para sa savings imbes na daily spending"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'step',
    4,
    $${
      "title":"Ask the fees before you submit anything",
      "body":"Many first-time users are surprised later because they did not ask about maintaining balance, dormancy, card fees, withdrawal fees, and transfer fees. Ask before signing up.",
      "step_number":2,
      "items":[
        "Opening amount or initial deposit",
        "Maintaining balance",
        "Dormancy fee or account inactivity rule",
        "ATM/debit card fee and replacement fee",
        "Withdrawal, balance inquiry, and transfer fees",
        "Online banking or mobile app access",
        "What happens if balance goes below the required amount"
      ]
    }$$::jsonb,
    $${
      "title":"Itanong ang fees bago mag-submit",
      "body":"Maraming first-time users ang nagugulat later dahil hindi natanong ang maintaining balance, dormancy, card fees, withdrawal fees, at transfer fees. Magtanong bago mag-sign up.",
      "step_number":2,
      "items":[
        "Opening amount o initial deposit",
        "Maintaining balance",
        "Dormancy fee o rule kapag inactive ang account",
        "ATM/debit card fee at replacement fee",
        "Withdrawal, balance inquiry, at transfer fees",
        "Online banking o mobile app access",
        "Ano ang mangyayari kung bumaba sa required balance"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'step',
    5,
    $${
      "title":"Check if a Basic Deposit Account fits you",
      "body":"BSP lists Basic Deposit Accounts offered by banks. These accounts are designed as simpler starter deposit accounts and may have low opening amount, no maintaining balance, no dormancy charges, and simpler identification requirements. Ask the bank if this option is available and fits your use case.",
      "step_number":3,
      "items":[
        "Ask if the bank offers a Basic Deposit Account",
        "Ask the opening amount",
        "Ask if there is no maintaining balance",
        "Ask if there are no dormancy charges",
        "Ask what identification is accepted",
        "Ask about account limits, ATM/debit card, and online banking access",
        "Compare it with payroll or regular savings account requirements"
      ]
    }$$::jsonb,
    $${
      "title":"I-check kung bagay sa iyo ang Basic Deposit Account",
      "body":"May listahan ang BSP ng Basic Deposit Accounts na ino-offer ng banks. Mas simpleng starter deposit accounts ito at maaaring may mababang opening amount, walang maintaining balance, walang dormancy charges, at mas simpleng identification requirements. Itanong sa bank kung available ito at bagay sa gamit mo.",
      "step_number":3,
      "items":[
        "Itanong kung may Basic Deposit Account ang bank",
        "Itanong ang opening amount",
        "Itanong kung walang maintaining balance",
        "Itanong kung walang dormancy charges",
        "Itanong kung anong identification ang tinatanggap",
        "Itanong ang account limits, ATM/debit card, at online banking access",
        "I-compare sa payroll o regular savings account requirements"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'step',
    6,
    $${
      "title":"Prepare clean documents and contact details",
      "body":"Requirements differ by bank and account type. Prepare clean information so you do not lose time at the branch or during online account opening.",
      "step_number":4,
      "items":[
        "Valid ID or accepted alternative identification",
        "Current address and contact number",
        "Email you can access",
        "Initial deposit if required",
        "Employer payroll instructions if this is for work",
        "Registered SIM that you control",
        "Emergency contact if the bank asks for one"
      ]
    }$$::jsonb,
    $${
      "title":"Ihanda ang malinaw na documents at contact details",
      "body":"Nag-iiba ang requirements depende sa bank at account type. Ihanda ang malinis na information para hindi masayang ang oras sa branch o online account opening.",
      "step_number":4,
      "items":[
        "Valid ID o accepted alternative identification",
        "Current address at contact number",
        "Email na naa-access mo",
        "Initial deposit kung required",
        "Employer payroll instructions kung para ito sa work",
        "Registered SIM na ikaw ang may control",
        "Emergency contact kung hinihingi ng bank"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'step',
    7,
    $${
      "title":"Secure the account before using it heavily",
      "body":"Your account is not fully ready until you can protect and recover access. Set this up before your first salary, emergency money, or large transfer arrives.",
      "step_number":5,
      "items":[
        "Create a strong password that is not reused",
        "Use a PIN that is not your birthday or repeated digits",
        "Keep the registered SIM active and secure",
        "Turn on app or SMS notifications if available",
        "Save the official hotline and support channels",
        "Know how to lock the card or report unauthorized transactions",
        "Do not store card photos, PIN, and passwords in an unsafe notes app"
      ]
    }$$::jsonb,
    $${
      "title":"I-secure ang account bago gamitin nang todo",
      "body":"Hindi pa fully ready ang account hangga't hindi mo kayang protektahan at i-recover ang access. Ayusin ito bago dumating ang unang sweldo, emergency money, o malaking transfer.",
      "step_number":5,
      "items":[
        "Gumawa ng strong password na hindi reused",
        "Gumamit ng PIN na hindi birthday o paulit-ulit na digits",
        "Panatilihing active at secure ang registered SIM",
        "I-on ang app o SMS notifications kung available",
        "I-save ang official hotline at support channels",
        "Alamin paano mag-lock ng card o mag-report ng unauthorized transactions",
        "Huwag itabi ang card photos, PIN, at passwords sa unsafe notes app"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'mistake',
    8,
    $${
      "title":"Common first-account mistakes",
      "body":"These mistakes are common because many people open an account only because school, work, or family tells them to. Slow down before your money gets trapped by fees or exposed to scams.",
      "items":[
        "Opening without asking about maintaining balance",
        "Ignoring dormancy or inactivity rules",
        "Using one account for savings, spending, payroll, and risky online payments",
        "Letting another person hold the ATM card",
        "Using birthday or repeated digits as PIN",
        "Clicking bank login links from messages",
        "Not saving official support channels before a problem happens"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes sa unang account",
      "body":"Common ito dahil maraming nag-o-open lang ng account dahil sabi ng school, work, o family. Huminto muna bago maipit sa fees ang pera o ma-expose sa scams ang account.",
      "items":[
        "Nag-open nang hindi nagtatanong ng maintaining balance",
        "Hindi pinapansin ang dormancy o inactivity rules",
        "Isang account lang para sa savings, spending, payroll, at risky online payments",
        "Ipinapahawak sa ibang tao ang ATM card",
        "Birthday o paulit-ulit na digits ang PIN",
        "Nagki-click ng bank login links mula sa messages",
        "Hindi nag-save ng official support channels bago magkaroon ng problema"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'tip',
    9,
    $${
      "title":"First account checklist",
      "body":"Use this before opening or accepting a payroll account.",
      "items":[
        "I know if this is for payroll, savings, remittance, or daily spending",
        "I asked the opening amount",
        "I asked the maintaining balance",
        "I asked about dormancy, card, withdrawal, and transfer fees",
        "I asked if a Basic Deposit Account is available",
        "I know how online banking and OTP will work",
        "I know how to report a lost card or unauthorized transaction",
        "I will not sell, rent, lend, or share account access"
      ]
    }$$::jsonb,
    $${
      "title":"First account checklist",
      "body":"Gamitin ito bago mag-open o tumanggap ng payroll account.",
      "items":[
        "Alam ko kung para ito sa payroll, savings, remittance, o daily spending",
        "Naitanong ko ang opening amount",
        "Naitanong ko ang maintaining balance",
        "Naitanong ko ang dormancy, card, withdrawal, at transfer fees",
        "Naitanong ko kung may Basic Deposit Account",
        "Alam ko kung paano gagana ang online banking at OTP",
        "Alam ko paano mag-report ng lost card o unauthorized transaction",
        "Hindi ko ibebenta, ipaparenta, ipapahiram, o ise-share ang account access"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'tip',
    10,
    $${
      "title":"Sample questions at the branch or chat support",
      "body":"Ask these before signing up.",
      "sample":"Hi, I am opening my first bank account. Can you confirm the opening amount, maintaining balance, dormancy fee, ATM/debit card fee, transfer fees, online banking access, and how to report unauthorized transactions? Do you have a Basic Deposit Account option if I want a simpler starter account?"
    }$$::jsonb,
    $${
      "title":"Sample questions sa branch o chat support",
      "body":"Itanong ito bago mag-sign up.",
      "sample":"Hi po, mag-o-open po ako ng unang bank account. Paki-confirm po ang opening amount, maintaining balance, dormancy fee, ATM/debit card fee, transfer fees, online banking access, at paano mag-report ng unauthorized transactions. May Basic Deposit Account option po ba kung simple starter account ang gusto ko?"
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'bank-account-first-time'),
    'tip',
    11,
    $${
      "title":"What to expect",
      "body":"Opening can be quick if your ID, phone number, email, and initial deposit are ready. Payroll accounts may follow employer instructions. Some starter accounts are simpler, while others require higher balances or more documents. The best account is the one you can maintain safely, understand clearly, and control yourself."
    }$$::jsonb,
    $${
      "title":"Ano ang aasahan",
      "body":"Puwedeng mabilis ang opening kung ready ang ID, phone number, email, at initial deposit. Ang payroll account ay puwedeng sumunod sa instructions ng employer. May starter accounts na mas simple, may iba namang mas mataas ang balance o mas maraming documents. Ang best account ay yung kaya mong i-maintain nang safe, naiintindihan mo nang malinaw, at ikaw ang may control."
    }$$::jsonb
  );
