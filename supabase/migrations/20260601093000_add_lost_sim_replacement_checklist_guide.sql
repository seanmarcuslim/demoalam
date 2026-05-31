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
  'lost-sim-replacement-checklist',
  (select id from public.categories where slug = 'digital-safety'),
  'Lost SIM replacement checklist before accounts get exposed',
  'Lost SIM replacement checklist bago ma-expose ang accounts',
  'Block the SIM, secure OTP-linked accounts, prepare proof of ownership, and avoid SIM-swap scams.',
  'I-block ang SIM, i-secure ang OTP-linked accounts, ihanda ang proof of ownership, at umiwas sa SIM-swap scams.',
  true,
  true,
  true,
  6,
  'katamtaman',
  '15-45 minuto para mag-report at mag-secure ng accounts; depende sa telco ang replacement',
  'Libre o may possible replacement, notarization, pamasahe, call, o data cost depende sa telco',
  array[
    'lost sim',
    'sim replacement',
    'sim swap',
    'otp',
    'mobile number',
    'phone stolen',
    'gcash',
    'bank',
    'digital safety',
    'account security'
  ],
  'lost sim sim replacement stolen sim lost phone replace sim same number sim swap otp mobile number phone stolen temporary deactivation block sim bar sim proof of ownership affidavit of loss valid id globe smart dito gcash bank account recovery two factor authentication 2fa',
  'nawalang sim sim replacement nanakaw sim nawalang phone palit sim same number sim swap otp mobile number block sim bar sim proof of ownership affidavit of loss valid id globe smart dito gcash bank account recovery two factor authentication 2fa',
  $$[
    {"title":"SIM Replacement for Wireless Account FAQs","publisher":"Globe Help & Support","url":"https://www.globe.com.ph/help/sim-replacement.html"},
    {"title":"Temporary Disconnection for Lost SIM/Phone FAQs","publisher":"Globe Help & Support","url":"https://www.globe.com.ph/help/postpaid/lost-sim-phone"},
    {"title":"How to Request a Smart Postpaid or Prepaid SIM Replacement","publisher":"Smart Help","url":"https://help.smart.com.ph/how-to-request-smart-postpaid-or-prepaid-sim-replacement/"},
    {"title":"SIM Registration","publisher":"DITO Telecommunity","url":"https://dito.ph/RegisterDITO"},
    {"title":"DITO Subscription Terms and Conditions","publisher":"DITO Telecommunity","url":"https://dito.ph/terms-and-conditions"},
    {"title":"SIM Registration Act FAQs","publisher":"National Telecommunications Commission","url":"https://region9.ntc.gov.ph/wp-content/uploads/2023/01/FAQs-for-SRA-_011823-0930.pdf"}
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
  where slug = 'lost-sim-replacement-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'lost-sim-replacement-checklist'),
    'what_to_know',
    1,
    $${
      "title":"A lost SIM can expose accounts that use OTP",
      "body":"Losing a SIM is not only about losing signal. Your mobile number may be connected to bank OTPs, e-wallets, email recovery, social media, shopping apps, work accounts, and government logins. The first goal is to stop misuse of the number while you recover or replace it.",
      "items":[
        "Block or temporarily deactivate the lost SIM as soon as possible",
        "Secure banks, e-wallets, email, and important apps linked to the number",
        "Prepare proof that the number belongs to you",
        "Replacement rules differ by telco and account type",
        "Do not assume same-number replacement is guaranteed until the telco verifies you"
      ]
    }$$::jsonb,
    $${
      "title":"Puwedeng ma-expose ang OTP-linked accounts kapag nawala ang SIM",
      "body":"Hindi lang signal ang nawawala kapag nawala ang SIM. Puwedeng connected ang mobile number mo sa bank OTPs, e-wallets, email recovery, social media, shopping apps, work accounts, at government logins. Ang unang goal ay pigilan ang misuse ng number habang nire-recover o pinapalitan ito.",
      "items":[
        "I-block o ipa-temporary deactivate agad ang lost SIM kung posible",
        "I-secure ang banks, e-wallets, email, at important apps na linked sa number",
        "Ihanda ang proof na sa iyo ang number",
        "Magkakaiba ang replacement rules depende sa telco at account type",
        "Huwag umasa na guaranteed ang same-number replacement hangga't hindi ka verified ng telco"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-sim-replacement-checklist'),
    'warning',
    2,
    $${
      "title":"START HERE: secure OTP accounts before focusing only on replacement",
      "body":"If someone gets access to your SIM or convinces support to transfer your number, they may receive OTPs for accounts linked to that number. Do not wait for replacement before protecting money and login access.",
      "severity":"high",
      "items":[
        "Do not share OTP, MPIN, password, SIM serial number, or ID photos through random chats",
        "Do not pay anyone promising faster SIM replacement or number recovery",
        "Do not post your full number, IDs, or affidavit publicly",
        "Do not trust support accounts that contacted you first",
        "Use official telco app, hotline, store, website, or verified page only"
      ]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: i-secure ang OTP accounts bago replacement lang ang isipin",
      "body":"Kung may makagamit ng SIM mo o makapagpalipat ng number sa support, puwede silang makatanggap ng OTP para sa accounts na linked sa number na iyon. Huwag hintayin ang replacement bago protektahan ang pera at login access.",
      "severity":"high",
      "items":[
        "Huwag mag-share ng OTP, MPIN, password, SIM serial number, o ID photos sa random chats",
        "Huwag magbayad sa nangangakong mas mabilis na SIM replacement o number recovery",
        "Huwag i-post publicly ang full number, IDs, o affidavit",
        "Huwag magtiwala sa support accounts na sila ang unang nag-message sa iyo",
        "Official telco app, hotline, store, website, o verified page lang ang gamitin"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-sim-replacement-checklist'),
    'step',
    3,
    $${
      "title":"First 15 minutes: report the lost SIM",
      "body":"Use the fastest official route your telco provides. The exact process differs, but the goal is the same: prevent unauthorized use and start the replacement or recovery process.",
      "step_number":1,
      "items":[
        "Globe/TM: report through Globe Store, official Messenger route, or hotline options for lost phone/SIM",
        "Smart/TNT/Sun: visit a Smart Store for replacement; use official hotline or support if you need guidance first",
        "DITO: use official DITO app, help center, store, or official support channels and ask what recovery path applies",
        "Write down the time you reported the loss",
        "Save ticket numbers, support replies, and store instructions"
      ]
    }$$::jsonb,
    $${
      "title":"Unang 15 minuto: i-report ang lost SIM",
      "body":"Gamitin ang pinakamabilis na official route ng telco mo. Magkakaiba ang exact process, pero pareho ang goal: pigilan ang unauthorized use at simulan ang replacement o recovery process.",
      "step_number":1,
      "items":[
        "Globe/TM: mag-report sa Globe Store, official Messenger route, o hotline options para sa lost phone/SIM",
        "Smart/TNT/Sun: pumunta sa Smart Store para sa replacement; gumamit ng official hotline o support kung kailangan muna ng guidance",
        "DITO: gamitin ang official DITO app, help center, store, o official support channels at itanong kung anong recovery path ang applicable",
        "Isulat kung anong oras mo nireport ang loss",
        "I-save ang ticket numbers, support replies, at store instructions"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-sim-replacement-checklist'),
    'step',
    4,
    $${
      "title":"Secure money, email, and recovery accounts",
      "body":"Your SIM may be the key to other accounts. Secure the most important accounts before spending the whole day on replacement requirements.",
      "step_number":2,
      "items":[
        "Open banks and e-wallets and check for suspicious activity",
        "Change passwords for email and important accounts",
        "Remove the lost number from two-factor authentication if you have a backup method",
        "Add a temporary trusted recovery number or authenticator app where available",
        "Log out other devices if your phone was also lost or stolen"
      ]
    }$$::jsonb,
    $${
      "title":"I-secure ang pera, email, at recovery accounts",
      "body":"Puwedeng susi ang SIM mo sa ibang accounts. I-secure muna ang pinakamahalagang accounts bago ubusin ang buong araw sa replacement requirements.",
      "step_number":2,
      "items":[
        "Buksan ang banks at e-wallets at i-check kung may suspicious activity",
        "Palitan ang passwords ng email at important accounts",
        "Tanggalin muna ang lost number sa two-factor authentication kung may backup method ka",
        "Maglagay ng temporary trusted recovery number o authenticator app kung available",
        "I-log out ang ibang devices kung nawala o nanakaw din ang phone"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-sim-replacement-checklist'),
    'step',
    5,
    $${
      "title":"Prepare proof of ownership before going to the store",
      "body":"Telcos need to verify that you are the registered owner or authorized account holder. Requirements can change, so check official instructions first, then prepare more proof than the bare minimum.",
      "step_number":3,
      "items":[
        "Original valid government-issued ID",
        "SIM bed, eSIM voucher, GCash card, receipt, or proof of number ownership if available",
        "Affidavit of loss if required by your telco or situation",
        "Selfie or liveness check if required at the store",
        "Account details, recent load/promo history, or other verification details you can safely provide",
        "Authorization documents only if the telco allows representatives for your case"
      ]
    }$$::jsonb,
    $${
      "title":"Ihanda ang proof of ownership bago pumunta sa store",
      "body":"Kailangang ma-verify ng telco na ikaw ang registered owner o authorized account holder. Puwedeng magbago ang requirements, kaya i-check muna ang official instructions at maghanda ng mas kumpletong proof kaysa bare minimum.",
      "step_number":3,
      "items":[
        "Original valid government-issued ID",
        "SIM bed, eSIM voucher, GCash card, receipt, o proof of number ownership kung meron",
        "Affidavit of loss kung required ng telco o ng situation mo",
        "Selfie o liveness check kung required sa store",
        "Account details, recent load/promo history, o ibang verification details na safe ibigay",
        "Authorization documents kung pinapayagan ng telco ang representative sa case mo"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-sim-replacement-checklist'),
    'step',
    6,
    $${
      "title":"Ask the telco these exact questions",
      "body":"Replacement rules are not identical across telcos, prepaid, postpaid, eSIM, Home WiFi, and corporate accounts. Ask clear questions before paying, notarizing, or traveling again.",
      "step_number":4,
      "items":[
        "Can this number be replaced or transferred to a new SIM?",
        "Is the old SIM already barred or deactivated?",
        "What exact documents do I need for my account type?",
        "Is an affidavit of loss required for my case?",
        "How long before the replacement SIM can receive OTPs again?",
        "Will my load, promos, roaming, or eSIM profile be affected?"
      ]
    }$$::jsonb,
    $${
      "title":"Itanong ito mismo sa telco",
      "body":"Hindi pare-pareho ang replacement rules sa telcos, prepaid, postpaid, eSIM, Home WiFi, at corporate accounts. Magtanong nang malinaw bago magbayad, magpa-notaryo, o bumiyahe ulit.",
      "step_number":4,
      "items":[
        "Puwede bang ma-replace o ma-transfer ang number na ito sa bagong SIM?",
        "Na-bar o na-deactivate na ba ang old SIM?",
        "Ano ang exact documents na kailangan para sa account type ko?",
        "Required ba ang affidavit of loss sa case ko?",
        "Gaano katagal bago makatanggap ulit ng OTP ang replacement SIM?",
        "Maaapektuhan ba ang load, promos, roaming, o eSIM profile ko?"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-sim-replacement-checklist'),
    'mistake',
    7,
    $${
      "title":"Common mistakes that delay SIM recovery",
      "body":"Most delays happen because users focus only on getting a new SIM, not on proving ownership and protecting linked accounts.",
      "items":[
        "Going to the store without ID or proof of ownership",
        "Assuming another person can replace the SIM without authorization",
        "Ignoring e-wallets and banks linked to the lost number",
        "Using fake telco support pages from search ads or comments",
        "Posting the full mobile number and ID details publicly",
        "Throwing away the SIM bed, eSIM email, receipts, or old registration proof"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes na nagpapadelay sa SIM recovery",
      "body":"Madalas nade-delay dahil replacement SIM lang ang iniisip, hindi proof of ownership at protection ng linked accounts.",
      "items":[
        "Pumupunta sa store nang walang ID o proof of ownership",
        "Inaakalang puwedeng ibang tao ang mag-replace ng SIM kahit walang authorization",
        "Binabalewala ang e-wallets at banks na linked sa lost number",
        "Gumagamit ng fake telco support pages mula sa search ads o comments",
        "Nagpo-post publicly ng full mobile number at ID details",
        "Tinatapon ang SIM bed, eSIM email, receipts, o old registration proof"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-sim-replacement-checklist'),
    'warning',
    8,
    $${
      "title":"Watch for SIM-swap and recovery scams",
      "body":"SIM replacement is sensitive because control of a number can unlock other accounts. Be extra careful with people claiming they can process replacement remotely, bypass verification, or guarantee same-day OTP access.",
      "severity":"high",
      "items":[
        "Recovery fee or fixer fee",
        "Request for OTP, MPIN, password, ID selfie, or screen-sharing",
        "Promise to skip store verification",
        "Unofficial QR code, form, or private payment link",
        "Instructions to hide the conversation from telco staff, bank staff, or family"
      ]
    }$$::jsonb,
    $${
      "title":"Mag-ingat sa SIM-swap at recovery scams",
      "body":"Sensitive ang SIM replacement dahil kapag kontrolado ang number, puwedeng mabuksan ang ibang accounts. Mag-ingat sa nagsasabing kaya nilang i-process remotely, laktawan ang verification, o guaranteed ang same-day OTP access.",
      "severity":"high",
      "items":[
        "Recovery fee o fixer fee",
        "Hingi ng OTP, MPIN, password, ID selfie, o screen-sharing",
        "Pangakong puwedeng laktawan ang store verification",
        "Unofficial QR code, form, o private payment link",
        "Instruction na itago ang usapan sa telco staff, bank staff, o family"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-sim-replacement-checklist'),
    'tip',
    9,
    $${
      "title":"Sample message to telco support",
      "body":"Use this when asking through an official support channel. Do not include OTP, passwords, or unnecessary ID numbers in normal chat.",
      "sample":"Hello. I need to report a lost SIM/phone for mobile number [number]. Please confirm how to temporarily block or bar the SIM and what requirements I need for replacement or number recovery. I am the registered owner and can present valid ID and proof of ownership through your official verification process."
    }$$::jsonb,
    $${
      "title":"Sample message sa telco support",
      "body":"Gamitin ito kapag nagtatanong sa official support channel. Huwag isama ang OTP, passwords, o unnecessary ID numbers sa normal chat.",
      "sample":"Hello po. Magre-report po ako ng lost SIM/phone para sa mobile number [number]. Paki-confirm po kung paano ito ipa-temporary block o bar, at ano ang requirements para sa replacement o number recovery. Ako po ang registered owner at kaya kong mag-present ng valid ID at proof of ownership sa official verification process ninyo."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-sim-replacement-checklist'),
    'tip',
    10,
    $${
      "title":"After replacement: reconnect accounts safely",
      "body":"When the replacement SIM works, do not immediately relax. Check the accounts that depended on the old SIM and remove weak recovery paths.",
      "items":[
        "Test calls, SMS, mobile data, and OTP receiving",
        "Update banks, e-wallets, email, and government portals if needed",
        "Review recent login activity and unauthorized transactions",
        "Set stronger passwords and backup recovery options",
        "Keep proof of replacement and ticket numbers",
        "Store SIM bed, eSIM voucher, and official receipts safely"
      ]
    }$$::jsonb,
    $${
      "title":"Pagkatapos ng replacement: i-reconnect ang accounts nang safe",
      "body":"Kapag gumagana na ang replacement SIM, huwag agad kampante. I-check ang accounts na naka-depende sa old SIM at tanggalin ang mahihinang recovery paths.",
      "items":[
        "I-test ang calls, SMS, mobile data, at OTP receiving",
        "I-update ang banks, e-wallets, email, at government portals kung kailangan",
        "I-review ang recent login activity at unauthorized transactions",
        "Mag-set ng stronger passwords at backup recovery options",
        "Itabi ang proof of replacement at ticket numbers",
        "I-store nang maayos ang SIM bed, eSIM voucher, at official receipts"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-sim-replacement-checklist'),
    'related',
    11,
    $${
      "title":"Related guides",
      "body":"Use these guides if the lost SIM is connected to a wider security or money emergency.",
      "items":[
        "Stolen Phone First Hour: use this if the phone and SIM were lost together",
        "GCash/Maya Account Recovery First Hour: use this if e-wallet access may be exposed",
        "Phishing Link Checklist: use this if fake support or a suspicious link contacted you",
        "Lost Wallet First Steps: use this if IDs, cards, and SIM were lost together"
      ]
    }$$::jsonb,
    $${
      "title":"Related guides",
      "body":"Gamitin ang guides na ito kung connected ang lost SIM sa mas malaking security o money emergency.",
      "items":[
        "Stolen Phone First Hour: kung sabay nawala ang phone at SIM",
        "GCash/Maya Account Recovery First Hour: kung exposed ang e-wallet access",
        "Phishing Link Checklist: kung may fake support o suspicious link na kumontak sa iyo",
        "Lost Wallet First Steps: kung sabay nawala ang IDs, cards, at SIM"
      ]
    }$$::jsonb
  );
