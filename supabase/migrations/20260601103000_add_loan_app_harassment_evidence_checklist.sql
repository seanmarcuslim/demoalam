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
  'loan-app-harassment-evidence-checklist',
  (select id from public.categories where slug = 'money'),
  'Checklist ng ebidensya sa loan app harassment',
  'Loan app harassment evidence checklist',
  'Save proof, separate debt from abuse, verify the lender, and report harassment through the right channel.',
  'Mag-save ng ebidensya, paghiwalayin ang utang at pangha-harass, i-verify ang lender, at mag-report sa tamang channel.',
  true,
  true,
  true,
  6,
  'katamtaman',
  '20-45 minuto para mag-ipon ng ebidensya; depende sa agency ang complaint timeline',
  'Libre, maliban sa printing, pamasahe, tawag, o internet data kung kailangan',
  array[
    'loan app',
    'online lending',
    'harassment',
    'debt collection',
    'utang',
    'ola',
    'sec',
    'data privacy',
    'money',
    'digital safety'
  ],
  'loan app harassment online lending harassment ola harassment debt collection harassment collection threats public shaming contact list harassment abusive collection sec complaint npc complaint data privacy lender verification unfair debt collection loan app complaint lending app complaint',
  'loan app harassment online lending harassment ola harassment pangha harass pangha-harass sa utang paniningil debt collection harassment collection threats public shaming contact list harassment abusive collection sec complaint npc complaint data privacy lender verification unfair debt collection reklamo loan app lending app reklamo',
  $$[
    {"title":"Public Advisory on Online Lending Platforms","publisher":"DICT, National Privacy Commission, and Securities and Exchange Commission","url":"https://privacy.gov.ph/wp-content/uploads/2026/03/DICT-NPC-SEC-Public-Advisory-on-Online-Lending-Platforms.pdf"},
    {"title":"Advisory for Online Lending Platforms Borrowers","publisher":"Securities and Exchange Commission","url":"https://www.sec.gov.ph/wp-content/uploads/2023/10/2023advisory_For-Online-Lending-Platforms-Borrowers.pdf"},
    {"title":"List of Recorded Online Lending Platforms","publisher":"Securities and Exchange Commission","url":"https://www.sec.gov.ph/lending-companies-and-financing-companies-2/list-of-recorded-online-lending-platforms/"},
    {"title":"Online lenders barred from harvesting borrowers phone and social-media contact list","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/online-lenders-barred-from-harvesting-borrowers-phone-and-social-media-contact-list-says-privacy-commission/"},
    {"title":"File a Complaint","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/file-a-complaint-2/"},
    {"title":"SEC i-Message Portal","publisher":"Securities and Exchange Commission","url":"https://imessage.sec.gov.ph/"}
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
  where slug = 'loan-app-harassment-evidence-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'loan-app-harassment-evidence-checklist'),
    'what_to_know',
    1,
    $${
      "title":"Debt and harassment are separate issues",
      "body":"If you borrowed money, the debt issue still needs to be handled honestly. But harassment, threats, public shaming, contact-list messaging, fake legal threats, and misuse of personal data are separate problems. Do not panic, do not disappear, and do not let abusive messages push you into another risky loan.",
      "items":[
        "Separate the amount you owe from the way collectors are treating you",
        "Keep evidence before blocking or deleting messages",
        "Verify if the lender or online lending platform is recorded with the SEC",
        "Use official complaint channels for abusive collection and data privacy concerns",
        "This guide is not legal advice; it helps you organize facts and next steps"
      ]
    }$$::jsonb,
    $${
      "title":"Magkaiba ang utang at pangha-harass",
      "body":"Kung umutang ka, kailangan pa ring harapin nang maayos ang debt issue. Pero hiwalay na problema ang harassment, threats, public shaming, pag-message sa contact list, fake legal threats, at misuse ng personal data. Huwag mag-panic, huwag magtago, at huwag hayaang itulak ka ng abusive messages sa panibagong risky loan.",
      "items":[
        "Paghiwalayin ang amount na utang mo at ang paraan ng paniningil nila",
        "Mag-save ng ebidensya bago mag-block o mag-delete ng messages",
        "I-verify kung recorded sa SEC ang lender o online lending platform",
        "Gamitin ang official complaint channels para sa abusive collection at data privacy concerns",
        "Hindi ito legal advice; guide lang ito para maayos ang facts at next steps"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-app-harassment-evidence-checklist'),
    'warning',
    2,
    $${
      "title":"START HERE: do not send more money because of threats",
      "body":"Collectors or fake collectors may use shame, fear, fake warrants, fake police threats, edited images, or messages to your contacts to force quick payment. Slow down. Save proof first, verify the lender, and pay only through official channels if payment is truly due.",
      "severity":"high",
      "items":[
        "Do not pay a personal wallet or random collector account without official proof",
        "Do not send OTP, MPIN, bank login, or ID selfies through chat",
        "Do not borrow from another risky app just to stop harassment today",
        "Do not delete threats before saving proof",
        "If there are threats of violence or serious danger, prioritize personal safety and contact proper authorities"
      ]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: huwag magpadala ulit ng pera dahil lang sa threats",
      "body":"Puwedeng gumamit ang collectors o fake collectors ng hiya, takot, fake warrant, fake police threat, edited images, o messages sa contacts mo para mapilit kang magbayad agad. Huminto muna. Mag-save ng proof, i-verify ang lender, at magbayad lang sa official channels kung totoong due ang payment.",
      "severity":"high",
      "items":[
        "Huwag magbayad sa personal wallet o random collector account nang walang official proof",
        "Huwag mag-send ng OTP, MPIN, bank login, o ID selfies sa chat",
        "Huwag umutang sa panibagong risky app para lang tumigil ang harassment ngayong araw",
        "Huwag burahin ang threats bago ma-save ang proof",
        "Kung may threats of violence o seryosong panganib, unahin ang personal safety at kontakin ang tamang awtoridad"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-app-harassment-evidence-checklist'),
    'step',
    3,
    $${
      "title":"First 15 minutes: collect evidence cleanly",
      "body":"A vague complaint is easier to ignore. A complaint with dates, screenshots, app names, numbers, and exact messages is stronger.",
      "step_number":1,
      "items":[
        "Screenshot threats, insults, fake legal claims, or public shaming messages",
        "Include sender number, profile name, date, time, and full conversation context",
        "Save proof if they contacted your relatives, employer, classmates, or contacts",
        "Save loan agreement, payment receipts, disbursement proof, and app screenshots",
        "Do not edit screenshots except to make a separate redacted copy for safe sharing"
      ]
    }$$::jsonb,
    $${
      "title":"Unang 15 minuto: ayusin ang ebidensya",
      "body":"Mas madaling balewalain ang malabong reklamo. Mas matibay ang complaint na may dates, screenshots, app name, numbers, at exact messages.",
      "step_number":1,
      "items":[
        "I-screenshot ang threats, insults, fake legal claims, o public shaming messages",
        "Isama ang sender number, profile name, date, time, at full conversation context",
        "I-save ang proof kung kinontak nila ang relatives, employer, classmates, o contacts mo",
        "I-save ang loan agreement, payment receipts, disbursement proof, at app screenshots",
        "Huwag i-edit ang screenshots maliban kung gagawa ka ng separate redacted copy para safe i-share"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-app-harassment-evidence-checklist'),
    'step',
    4,
    $${
      "title":"Verify the lender and app identity",
      "body":"The app name shown on your phone may be different from the company behind it. Check the lender, financing company, and online lending platform against official SEC records before deciding where to report.",
      "step_number":2,
      "items":[
        "Look for the company name in the loan agreement or app profile",
        "Check if the lending or financing company is registered with the SEC",
        "Check if the online lending platform is recorded with the SEC",
        "Save screenshots if the app hides its company name or uses many names",
        "If you cannot identify the company, include that fact in your report"
      ]
    }$$::jsonb,
    $${
      "title":"I-verify ang lender at app identity",
      "body":"Puwedeng iba ang app name sa phone mo at iba ang company sa likod nito. I-check ang lender, financing company, at online lending platform sa official SEC records bago pumili kung saan magre-report.",
      "step_number":2,
      "items":[
        "Hanapin ang company name sa loan agreement o app profile",
        "I-check kung registered sa SEC ang lending o financing company",
        "I-check kung recorded sa SEC ang online lending platform",
        "I-save ang screenshots kung tinatago ng app ang company name o gumagamit ng maraming pangalan",
        "Kung hindi mo ma-identify ang company, isama iyon sa report"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-app-harassment-evidence-checklist'),
    'step',
    5,
    $${
      "title":"Separate the right complaint path",
      "body":"Different agencies handle different parts of the problem. You may need more than one path if the issue includes abusive collection, personal data misuse, threats, or scam behavior.",
      "step_number":3,
      "items":[
        "SEC: unfair debt collection, lending or financing company concerns, recorded online lending platform concerns",
        "NPC: misuse of personal data, contact-list harvesting, unauthorized disclosure, public shaming using personal data",
        "PNP Anti-Cybercrime or NBI Cybercrime: threats, fraud, identity misuse, cyber harassment, or serious online abuse",
        "DICT Cyber Hotline: cyber-related assistance route listed in the public advisory",
        "Barangay or local authorities: immediate safety concerns or threats in your area"
      ]
    }$$::jsonb,
    $${
      "title":"Paghiwalayin ang tamang complaint path",
      "body":"Iba-iba ang hawak ng bawat agency. Puwedeng kailangan ng higit sa isang path kung may abusive collection, misuse ng personal data, threats, o scam behavior.",
      "step_number":3,
      "items":[
        "SEC: unfair debt collection, lending o financing company concerns, recorded online lending platform concerns",
        "NPC: misuse ng personal data, contact-list harvesting, unauthorized disclosure, public shaming gamit ang personal data",
        "PNP Anti-Cybercrime o NBI Cybercrime: threats, fraud, identity misuse, cyber harassment, o seryosong online abuse",
        "DICT Cyber Hotline: cyber-related assistance route na nasa public advisory",
        "Barangay o local authorities: immediate safety concerns o threats sa lugar mo"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-app-harassment-evidence-checklist'),
    'step',
    6,
    $${
      "title":"Send one calm written response, then keep records",
      "body":"If it is safe to respond, use a short message that asks for official computation and tells them to stop contacting unrelated people. Do not argue all day.",
      "step_number":4,
      "items":[
        "Ask for the official loan account, principal, fees, interest, penalties, and payment channel",
        "Ask them to communicate through official channels only",
        "Tell them not to contact people who are not guarantors or authorized contacts",
        "Do not admit to amounts you cannot verify",
        "Save the sent message and any reply"
      ]
    }$$::jsonb,
    $${
      "title":"Magpadala ng isang kalmadong written response, pagkatapos i-save ang records",
      "body":"Kung safe mag-reply, gumamit ng short message na humihingi ng official computation at nagsasabing huwag kontakin ang unrelated people. Huwag makipagtalo buong araw.",
      "step_number":4,
      "items":[
        "Humingi ng official loan account, principal, fees, interest, penalties, at payment channel",
        "Sabihin na official channels lang ang gamitin sa communication",
        "Sabihin na huwag kontakin ang taong hindi guarantor o authorized contact",
        "Huwag umamin sa amount na hindi mo pa nave-verify",
        "I-save ang sent message at reply"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-app-harassment-evidence-checklist'),
    'mistake',
    7,
    $${
      "title":"Common mistakes when harassment starts",
      "body":"These reactions are understandable, but they can weaken your complaint or create new problems.",
      "items":[
        "Deleting messages before saving proof",
        "Posting unredacted IDs, loan details, phone numbers, or family names publicly",
        "Paying a random collector without official receipt or account verification",
        "Borrowing from another loan app to silence the first one",
        "Sending angry threats back to collectors",
        "Reporting only I am harassed without dates, screenshots, app names, or specific acts"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes kapag nagsimula ang harassment",
      "body":"Naiintindihan ang ganitong reactions, pero puwede nitong pahinain ang complaint o gumawa ng panibagong problema.",
      "items":[
        "Binubura ang messages bago mag-save ng proof",
        "Nagpo-post sa public ng unredacted IDs, loan details, phone numbers, o pangalan ng family",
        "Nagbabayad sa random collector nang walang official receipt o account verification",
        "Umutang sa ibang loan app para patahimikin ang una",
        "Nagpapadala rin ng galit na threats sa collectors",
        "Nagre-report lang ng hina-harass ako pero walang dates, screenshots, app names, o specific na ginawa nila"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-app-harassment-evidence-checklist'),
    'warning',
    8,
    $${
      "title":"Red flags that need stronger action",
      "body":"Some collection behavior is more serious than ordinary payment reminders. Save proof and consider reporting quickly when these appear.",
      "severity":"high",
      "items":[
        "Threats of violence, arrest, public humiliation, or harm to family",
        "Messages sent to your contacts who are not guarantors",
        "Posting or threatening to post your face, ID, debt, or edited images",
        "Fake police, fake court, fake barangay, or fake lawyer documents",
        "Demands for payment to personal wallets or accounts not shown in the loan agreement",
        "Use of your photos, contacts, or personal data outside the loan purpose"
      ]
    }$$::jsonb,
    $${
      "title":"Red flags na kailangan ng mas seryosong action",
      "body":"May collection behavior na mas seryoso kaysa ordinary payment reminders. Mag-save ng proof at pag-isipang mag-report agad kapag lumabas ito.",
      "severity":"high",
      "items":[
        "Threats of violence, arrest, public humiliation, o harm sa family",
        "Messages sa contacts mo na hindi guarantors",
        "Pag-post o threat na i-post ang mukha, ID, utang, o edited images mo",
        "Fake police, fake court, fake barangay, o fake lawyer documents",
        "Demand na magbayad sa personal wallets o accounts na wala sa loan agreement",
        "Paggamit ng photos, contacts, o personal data mo outside the loan purpose"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-app-harassment-evidence-checklist'),
    'tip',
    9,
    $${
      "title":"Sample message to collector or lender",
      "body":"Use this only if it is safe to respond. Keep it short and factual.",
      "sample":"Please send the official account name, company name, loan reference number, principal, fees, interest, penalties, total amount due, and official payment channel. Please communicate with me only through official channels and do not contact people who are not guarantors or authorized contacts. I am saving all messages for proper documentation."
    }$$::jsonb,
    $${
      "title":"Sample message sa collector o lender",
      "body":"Gamitin lang ito kung safe mag-reply. Panatilihing maikli at factual.",
      "sample":"Paki-send po ang official account name, company name, loan reference number, principal, fees, interest, penalties, total amount due, at official payment channel. Sa official channels lang po makipag-communicate sa akin at huwag kontakin ang mga taong hindi guarantor o authorized contacts. Sine-save ko po ang lahat ng messages para sa proper documentation."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-app-harassment-evidence-checklist'),
    'tip',
    10,
    $${
      "title":"Complaint evidence checklist",
      "body":"Prepare this before filing so your report is clear and specific.",
      "items":[
        "App name, company name, website, social media page, and collector number",
        "Loan agreement, disclosure statement, repayment schedule, and receipts",
        "Screenshots of threats, shaming, contact-list messages, or fake legal claims",
        "Dates, times, sender numbers, and names shown in messages",
        "Proof that unrelated contacts were messaged, if applicable",
        "Your calm written request for official computation or proper communication",
        "Any ticket numbers from SEC, NPC, telco, police, or other agencies"
      ]
    }$$::jsonb,
    $${
      "title":"Complaint evidence checklist",
      "body":"Ihanda ito bago mag-file para malinaw at specific ang report mo.",
      "items":[
        "App name, company name, website, social media page, at collector number",
        "Loan agreement, disclosure statement, repayment schedule, at receipts",
        "Screenshots ng threats, shaming, contact-list messages, o fake legal claims",
        "Dates, times, sender numbers, at names na nasa messages",
        "Proof na minessage ang unrelated contacts, kung applicable",
        "Kalmadong written request mo para sa official computation o proper communication",
        "Ticket numbers mula sa SEC, NPC, telco, police, o ibang agencies"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-app-harassment-evidence-checklist'),
    'related',
    11,
    $${
      "title":"Related guides",
      "body":"Use these guides if your loan issue connects to borrowing decisions, payday shortfall, privacy, or clear messages.",
      "items":[
        "Online Loan Red Flags Before Borrowing: use this before taking another loan",
        "Payday Budget Simple Split: use this if you are short before payday",
        "Everyday Rights Philippines Checklist: use this for data privacy and consumer-rights basics",
        "Office Help Message Checklist: use this to write clear support or complaint messages"
      ]
    }$$::jsonb,
    $${
      "title":"Related guides",
      "body":"Gamitin ang guides na ito kung connected ang loan issue mo sa borrowing decision, payday shortfall, privacy, o malinaw na messaging.",
      "items":[
        "Online Loan Red Flags Before Borrowing: bago kumuha ng panibagong loan",
        "Payday Budget Simple Split: kung kulang bago payday",
        "Everyday Rights Philippines Checklist: para sa data privacy at consumer-rights basics",
        "Office Help Message Checklist: para sa malinaw na support o complaint messages"
      ]
    }$$::jsonb
  );
