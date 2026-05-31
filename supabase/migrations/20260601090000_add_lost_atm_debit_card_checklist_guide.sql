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
  'lost-atm-debit-card-checklist',
  (select id from public.categories where slug = 'money'),
  'Lost ATM or debit card first steps',
  'Nawalang ATM o debit card: unang gagawin',
  'Block the card first, check transactions, prepare replacement proof, and avoid fake bank helpers.',
  'I-block muna ang card, i-check ang transactions, ihanda ang replacement proof, at umiwas sa fake bank helpers.',
  true,
  true,
  true,
  5,
  'madali',
  '10-30 minuto para mag-block at mag-check; depende sa bank ang card replacement',
  'May possible card replacement fee, pamasahe, printing, o call/data cost depende sa bank',
  array[
    'atm card',
    'debit card',
    'lost card',
    'bank',
    'unauthorized transaction',
    'card replacement',
    'money',
    'emergency',
    'scam'
  ],
  'lost atm card lost debit card stolen atm card stolen debit card block card freeze card lock card card replacement bank card missing atm captured card unauthorized transaction debit card fraud atm withdrawal bank hotline replacement fee affidavit of loss',
  'nawalang atm card nawalang debit card nanakaw atm card nanakaw debit card i-block card freeze card lock card palit card replacement bank card nawawala atm captured card unauthorized transaction debit card fraud atm withdrawal bank hotline replacement fee affidavit of loss',
  $$[
    {"title":"Lost or Stolen Debit Card FAQs","publisher":"BPI","url":"https://www.bpi.com.ph/personal/cards/debit-cards/lost-or-stolen-debit-card-faqs"},
    {"title":"Debit Card Security","publisher":"BDO Unibank","url":"https://www.bdo.com.ph/about-bdo/learn/stop-scam/debit-card-security"},
    {"title":"Card Issuance and Replacement: Lost Card","publisher":"Metrobank","url":"https://www.metrobank.com.ph/help/cards-and-payments/debit-cards/card-issuance-replacement?faq=i_lost_my_card_what_do_i_do"},
    {"title":"Bank Services and Requests: Lost ATM Card","publisher":"Security Bank","url":"https://www.securitybank.com/personal/accounts/bank-services/"},
    {"title":"How to File a Complaint Against a BSP-Supervised Institution","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/Inclusive%20Finance/How-to-file-a-complaint-with-BSP-CAM-Sep2025.pdf"}
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
  where slug = 'lost-atm-debit-card-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'lost-atm-debit-card-checklist'),
    'what_to_know',
    1,
    $${
      "title":"A lost ATM card is an account-access problem, not just a missing plastic card",
      "body":"Your ATM or debit card can be used for withdrawals, purchases, online payments, or account access depending on the bank and card type. The first goal is not replacement. The first goal is stopping possible use of the card.",
      "items":[
        "Block, lock, or freeze the card first if your bank allows it",
        "Check recent transactions before you forget the timeline",
        "Save proof of the block or report",
        "Prepare replacement requirements only after the card is secured",
        "Use official bank app, hotline, branch, or website only"
      ]
    }$$::jsonb,
    $${
      "title":"Ang nawalang ATM card ay account-access problem, hindi lang nawawalang plastic card",
      "body":"Puwedeng gamitin ang ATM o debit card sa withdrawals, purchases, online payments, o account access depende sa bank at card type. Hindi replacement ang unang goal. Ang unang goal ay pigilan ang posibleng paggamit ng card.",
      "items":[
        "I-block, i-lock, o i-freeze muna ang card kung available sa bank mo",
        "I-check ang recent transactions bago mo makalimutan ang timeline",
        "I-save ang proof ng block o report",
        "Ihanda ang replacement requirements pagkatapos ma-secure ang card",
        "Official bank app, hotline, branch, o website lang ang gamitin"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-atm-debit-card-checklist'),
    'warning',
    2,
    $${
      "title":"START HERE: block the card before asking strangers online",
      "body":"Do not post your card, account number, or transaction screenshots in public groups. Fake bank helpers may contact you and ask for OTP, PIN, card number, or remote access. Banks do not need your ATM PIN or OTP to help you report a lost card.",
      "severity":"high",
      "items":[
        "Do not share ATM PIN, OTP, password, full card number, or CVV",
        "Do not pay anyone promising faster card recovery or replacement",
        "Do not let someone screen-share or control your phone",
        "Do not use hotline numbers sent by strangers",
        "Do not delay reporting because you are embarrassed"
      ]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: i-block ang card bago magtanong sa strangers online",
      "body":"Huwag i-post ang card, account number, o transaction screenshots sa public groups. May fake bank helpers na puwedeng mag-message at humingi ng OTP, PIN, card number, o remote access. Hindi kailangan ng bank ang ATM PIN o OTP mo para tumulong sa lost card report.",
      "severity":"high",
      "items":[
        "Huwag i-share ang ATM PIN, OTP, password, full card number, o CVV",
        "Huwag magbayad sa nangangakong mas mabilis na card recovery o replacement",
        "Huwag magpa-screen-share o magpakontrol ng phone",
        "Huwag gumamit ng hotline numbers na pinadala ng strangers",
        "Huwag patagalin ang report dahil nahihiya ka"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-atm-debit-card-checklist'),
    'step',
    3,
    $${
      "title":"First 10 minutes: lock or report the card",
      "body":"Use the fastest official route available to you. Some banks allow card lock or permanent block in the app. Others require calling the hotline or visiting a branch.",
      "step_number":1,
      "items":[
        "Open your bank app and look for Card Control, Manage Cards, Lock Card, Freeze Card, or Block Card",
        "If app access is not available, call the official hotline from the bank website or card statement",
        "If nearby, go to a branch and ask to block the lost ATM or debit card",
        "Write down the time you reported the card",
        "Save confirmation, reference number, email, or screenshot"
      ]
    }$$::jsonb,
    $${
      "title":"Unang 10 minuto: i-lock o i-report ang card",
      "body":"Gamitin ang pinakamabilis na official route na available sa iyo. May banks na may card lock o permanent block sa app. May iba na kailangan hotline o branch.",
      "step_number":1,
      "items":[
        "Buksan ang bank app at hanapin ang Card Control, Manage Cards, Lock Card, Freeze Card, o Block Card",
        "Kung walang app access, tumawag sa official hotline mula sa bank website o card statement",
        "Kung malapit, pumunta sa branch at magpa-block ng lost ATM o debit card",
        "Isulat kung anong oras mo nireport ang card",
        "I-save ang confirmation, reference number, email, o screenshot"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-atm-debit-card-checklist'),
    'step',
    4,
    $${
      "title":"Check recent transactions immediately",
      "body":"After blocking or reporting, check whether money moved while the card was missing. This helps you separate a simple lost card from a possible unauthorized transaction case.",
      "step_number":2,
      "items":[
        "Check ATM withdrawals, debit purchases, online payments, and balance changes",
        "Take screenshots of suspicious transactions",
        "Write the date, time, amount, merchant, ATM location, or reference number",
        "Check bank alerts, SMS, and email notifications",
        "Report suspicious transactions through official bank channels"
      ]
    }$$::jsonb,
    $${
      "title":"I-check agad ang recent transactions",
      "body":"Pagkatapos mag-block o mag-report, tingnan kung may gumalaw na pera habang nawawala ang card. Makakatulong ito para malaman kung lost card lang ba o possible unauthorized transaction case.",
      "step_number":2,
      "items":[
        "I-check ang ATM withdrawals, debit purchases, online payments, at balance changes",
        "I-screenshot ang suspicious transactions",
        "Isulat ang date, time, amount, merchant, ATM location, o reference number",
        "I-check ang bank alerts, SMS, at email notifications",
        "I-report ang suspicious transactions sa official bank channels"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-atm-debit-card-checklist'),
    'step',
    5,
    $${
      "title":"If the ATM captured your card",
      "body":"A captured card is not the same as a card lost in public, but you should still secure it. Do not accept help from people beside the machine. Contact your bank or the ATM owner through official channels.",
      "step_number":3,
      "items":[
        "Do not leave your PIN or account details with security guards or strangers",
        "Take note of the ATM location, bank, date, and time",
        "Call your bank immediately if the ATM belongs to another bank",
        "Ask if the card should be blocked and replaced",
        "Keep the incident reference number"
      ]
    }$$::jsonb,
    $${
      "title":"Kung kinain ng ATM ang card",
      "body":"Hindi pareho ang captured card at card na nawala sa public place, pero kailangan pa rin itong i-secure. Huwag tumanggap ng tulong mula sa taong nasa tabi ng machine. Kontakin ang bank mo o ATM owner gamit ang official channels.",
      "step_number":3,
      "items":[
        "Huwag iwan ang PIN o account details sa guard o strangers",
        "I-note ang ATM location, bank, date, at time",
        "Tumawag agad sa bank mo kung ibang bank ang ATM",
        "Itanong kung dapat i-block at palitan ang card",
        "Itabi ang incident reference number"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-atm-debit-card-checklist'),
    'step',
    6,
    $${
      "title":"Prepare replacement requirements",
      "body":"Replacement rules differ by bank. Usually, you need valid ID, account details, branch visit or app request, and a possible replacement fee. Some banks may ask for a signed form or affidavit depending on the situation.",
      "step_number":4,
      "items":[
        "Valid ID or IDs accepted by your bank",
        "Account number or enough account details for verification",
        "Lost card report or reference number",
        "Replacement fee if your bank charges one",
        "Branch appointment or pick-up branch if required",
        "Affidavit of loss only if your bank asks for it"
      ]
    }$$::jsonb,
    $${
      "title":"Ihanda ang replacement requirements",
      "body":"Magkakaiba ang replacement rules ng bawat bank. Kadalasan kailangan ng valid ID, account details, branch visit o app request, at possible replacement fee. May banks na puwedeng humingi ng signed form o affidavit depende sa situation.",
      "step_number":4,
      "items":[
        "Valid ID o IDs na tinatanggap ng bank mo",
        "Account number o sapat na account details para ma-verify ka",
        "Lost card report o reference number",
        "Replacement fee kung may charge ang bank",
        "Branch appointment o pick-up branch kung required",
        "Affidavit of loss kung hinihingi lang ng bank mo"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-atm-debit-card-checklist'),
    'mistake',
    7,
    $${
      "title":"Common mistakes after losing an ATM card",
      "body":"These mistakes can turn a simple lost card into a bigger money or identity problem.",
      "items":[
        "Looking for the card for hours before blocking it",
        "Posting card photos, account details, or full transaction screenshots online",
        "Calling a hotline from a random comment or search ad",
        "Assuming the account is safe because the PIN was not written on the card",
        "Ignoring small suspicious transactions",
        "Throwing away the report or reference number"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes pagkatapos mawalan ng ATM card",
      "body":"Puwedeng lumaki ang simple lost card problem kapag nagawa ang mga ito.",
      "items":[
        "Ilang oras munang hinahanap ang card bago i-block",
        "Nagpo-post online ng card photos, account details, o full transaction screenshots",
        "Tumatawag sa hotline mula sa random comment o search ad",
        "Iniisip na safe ang account dahil hindi nakasulat ang PIN sa card",
        "Binabalewala ang maliliit na suspicious transactions",
        "Tinatapon ang report o reference number"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-atm-debit-card-checklist'),
    'warning',
    8,
    $${
      "title":"Escalate if the bank response is unclear or unauthorized transactions appear",
      "body":"Start with your bank's official customer service or Financial Consumer Protection Assistance Mechanism. If the issue is unresolved or the response is unclear, BSP says financial consumers may escalate eligible complaints through the BSP Consumer Assistance Mechanism.",
      "severity":"medium",
      "items":[
        "Keep your bank ticket or reference number",
        "Keep screenshots, transaction details, and bank replies",
        "Do not send PIN, password, full card number, or unnecessary IDs to public channels",
        "Use BSP only after first reporting to the bank when applicable",
        "For scams or fraud, consider reporting to proper law enforcement agencies too"
      ]
    }$$::jsonb,
    $${
      "title":"Mag-escalate kung malabo ang bank response o may unauthorized transactions",
      "body":"Magsimula sa official customer service o Financial Consumer Protection Assistance Mechanism ng bank. Kung hindi naresolba o malabo ang sagot, ayon sa BSP, maaaring i-escalate ng financial consumers ang eligible complaints sa BSP Consumer Assistance Mechanism.",
      "severity":"medium",
      "items":[
        "Itabi ang bank ticket o reference number",
        "Itabi ang screenshots, transaction details, at bank replies",
        "Huwag mag-send ng PIN, password, full card number, o unnecessary IDs sa public channels",
        "Gamitin ang BSP pagkatapos munang mag-report sa bank kung applicable",
        "Kung scam o fraud, isaalang-alang din ang pag-report sa proper law enforcement agencies"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-atm-debit-card-checklist'),
    'tip',
    9,
    $${
      "title":"Sample message to your bank",
      "body":"Use a clear message. Do not include your PIN, OTP, password, or full card number.",
      "sample":"Hello. I need to report a lost ATM/debit card linked to my account. Please block or confirm the card is blocked. The last time I had the card was [date/time/location]. I have checked recent transactions and saw [none / these suspicious transactions]. Please advise the replacement process, required documents, fees, and reference number for this report."
    }$$::jsonb,
    $${
      "title":"Sample message sa bank",
      "body":"Gumamit ng malinaw na message. Huwag isama ang PIN, OTP, password, o full card number.",
      "sample":"Hello. Magre-report po ako ng lost ATM/debit card na linked sa account ko. Paki-block po o paki-confirm kung blocked na ang card. Huling hawak ko po ang card noong [date/time/location]. Na-check ko na ang recent transactions at may nakita akong [wala / itong suspicious transactions]. Paki-advise po ang replacement process, required documents, fees, at reference number ng report na ito."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-atm-debit-card-checklist'),
    'tip',
    10,
    $${
      "title":"Prevention checklist after replacement",
      "body":"Use the replacement as a reset point. Make the new card harder to misuse.",
      "items":[
        "Change your PIN after receiving and activating the new card",
        "Do not use birthday, phone number, or repeated digits as PIN",
        "Turn on app alerts, SMS alerts, or email alerts if available",
        "Set withdrawal, purchase, or online limits if your bank supports it",
        "Store official hotline numbers from the bank website",
        "Keep a separate emergency cash or backup payment option"
      ]
    }$$::jsonb,
    $${
      "title":"Prevention checklist pagkatapos ng replacement",
      "body":"Gawing reset point ang replacement. Siguraduhing mas mahirap ma-misuse ang bagong card.",
      "items":[
        "Palitan ang PIN pagkatapos ma-receive at ma-activate ang bagong card",
        "Huwag gamitin ang birthday, phone number, o paulit-ulit na digits bilang PIN",
        "I-on ang app alerts, SMS alerts, o email alerts kung available",
        "Mag-set ng withdrawal, purchase, o online limits kung supported ng bank",
        "I-save ang official hotline numbers mula sa bank website",
        "Magtabi ng separate emergency cash o backup payment option"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-atm-debit-card-checklist'),
    'related',
    11,
    $${
      "title":"Related guides",
      "body":"Use these guides if the lost card is part of a wider emergency.",
      "items":[
        "Lost Wallet First Steps: use this if IDs, cards, cash, and transport money were lost together",
        "Phishing Link Checklist: use this if fake bank support or a suspicious link contacted you",
        "Wrong-Send GCash Checklist: use this if money was sent to the wrong account while solving the emergency",
        "Payday Budget Simple Split: use this if card replacement or lost cash creates a shortfall"
      ]
    }$$::jsonb,
    $${
      "title":"Related guides",
      "body":"Gamitin ang guides na ito kung mas malawak ang emergency kaysa lost card lang.",
      "items":[
        "Lost Wallet First Steps: kung sabay nawala ang IDs, cards, cash, at pamasahe",
        "Phishing Link Checklist: kung may fake bank support o suspicious link na kumontak sa iyo",
        "Wrong-Send GCash Checklist: kung may maling padala habang inaayos ang emergency",
        "Payday Budget Simple Split: kung nagdulot ng shortfall ang card replacement o nawalang cash"
      ]
    }$$::jsonb
  );
