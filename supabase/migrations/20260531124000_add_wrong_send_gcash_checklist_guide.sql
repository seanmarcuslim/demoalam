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
  'wrong-send-gcash-checklist',
  (select id from public.categories where slug = 'money'),
  'Wrong-send GCash checklist before you panic',
  'Wrong-send GCash checklist bago ka mag-panic',
  'Classify the transfer, save proof, contact the right channel, and avoid fake recovery helpers.',
  'Linawin ang transfer, itabi ang ebidensya, lumapit sa tamang channel, at umiwas sa fake recovery helpers.',
  true,
  true,
  true,
  5,
  'katamtaman',
  '10-30 minuto para mag-ipon ng proof; depende ang update sa GCash o receiving bank',
  'Libre, maliban sa internet data o tawag',
  array[
    'gcash',
    'wrong send',
    'maling send',
    'wrong number',
    'refund',
    'e-wallet',
    'money',
    'scam',
    'online safety',
    'bank transfer'
  ],
  'gcash wrong send wrong number wrong recipient sent money wrong account wrong bank account refund mistaken transfer express send send money ewallet wallet transaction reference receipt help center scam unauthorized transaction money recovery',
  'gcash wrong send maling send maling number maling recipient maling napadalhan maling account maling bank account refund nabawas pera express send send money ewallet wallet transaction reference resibo help center scam unauthorized transaction bawi pera',
  $$[
    {"title":"Sent money to wrong number","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/30244972048409-Sent-money-to-wrong-number"},
    {"title":"Sent money to the wrong bank account","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/30245311794969-Sent-money-to-the-wrong-bank-account"},
    {"title":"Report a scam","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/4413295284377-Report-a-scam"},
    {"title":"Report unauthorized transactions in my GCash account","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/4416637093145-I-noticed-unauthorized-transactions-in-my-GCash-account-What-do-I-do"},
    {"title":"Circular No. 1215 on disputed electronic fund transfers","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/Regulations/Published%20Issuances/Images/Circular_1215.pdf"}
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
  where slug = 'wrong-send-gcash-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'wrong-send-gcash-checklist'),
    'what_to_know',
    1,
    $${
      "title":"Wrong-send is different from scam or unauthorized transaction",
      "body":"A wrong-send usually means you personally confirmed a transfer to the wrong number, person, or bank account. That is different from a scam, where someone tricked you, and different from an unauthorized transaction, where money moved without your permission. Classifying the case correctly helps you choose the right next step.",
      "items":[
        "Wrong GCash number or recipient: you sent to the wrong person or old number",
        "Wrong bank account: you transferred from GCash to an incorrect bank account",
        "Scam: someone pressured or tricked you into sending money",
        "Unauthorized transaction: money moved from your account without your consent",
        "Refunds are not guaranteed, so move fast and keep proof"
      ]
    }$$::jsonb,
    $${
      "title":"Magkaiba ang wrong-send, scam, at unauthorized transaction",
      "body":"Ang wrong-send ay kadalasang ikaw mismo ang nag-confirm ng transfer sa maling number, tao, o bank account. Iba ito sa scam, kung saan niloko ka para magpadala, at iba rin sa unauthorized transaction, kung saan may gumalaw ng pera nang wala kang pahintulot. Kapag malinaw ang klase ng kaso, mas tama ang next step.",
      "items":[
        "Maling GCash number o recipient: nakapag-send ka sa maling tao o lumang number",
        "Maling bank account: nag-transfer ka mula GCash papunta sa maling bank account",
        "Scam: may nag-pressure o nanloko sa iyo para magpadala",
        "Unauthorized transaction: gumalaw ang pera sa account mo nang walang consent",
        "Hindi guaranteed ang refund, kaya kumilos agad at itabi ang ebidensya"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'wrong-send-gcash-checklist'),
    'warning',
    2,
    $${
      "title":"START HERE: do not pay anyone promising instant recovery",
      "body":"After a wrong-send, scammers may pretend they can recover your money if you pay a fee, send OTP, or give account details. Do not use random Facebook comments, private messages, or fake support pages. Use the GCash app Help Center and official channels only.",
      "severity":"high",
      "items":[
        "Do not send OTP, MPIN, password, or account screenshots",
        "Do not pay a recovery, verification, or processing fee",
        "Do not post the full recipient number, full name, or transaction details publicly",
        "Do not harass or threaten the recipient online",
        "Do not delete receipts, SMS, screenshots, or ticket numbers"
      ]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: huwag magbayad sa nangangakong mababawi agad ang pera",
      "body":"Pagkatapos ng wrong-send, may scammers na magpapanggap na kaya nilang ibalik ang pera kung magbabayad ka, magbibigay ng OTP, o magse-send ng account details. Huwag gumamit ng random Facebook comments, private messages, o fake support pages. GCash app Help Center at official channels lang ang gamitin.",
      "severity":"high",
      "items":[
        "Huwag mag-send ng OTP, MPIN, password, o account screenshots",
        "Huwag magbayad ng recovery, verification, o processing fee",
        "Huwag i-post publicly ang full recipient number, full name, o transaction details",
        "Huwag mang-harass o manakot ng recipient online",
        "Huwag burahin ang receipts, SMS, screenshots, o ticket numbers"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'wrong-send-gcash-checklist'),
    'step',
    3,
    $${
      "title":"First 5 minutes: save proof before doing anything else",
      "body":"Your strongest first move is proof. Save the transaction details while they are still easy to find.",
      "step_number":1,
      "items":[
        "Screenshot the successful transaction page",
        "Copy or screenshot the reference number",
        "Write the date, time, amount, and recipient number or account",
        "Save related SMS or app notifications",
        "Take note if the transfer was GCash-to-GCash, GCash-to-bank, cash-in, or scam-related"
      ]
    }$$::jsonb,
    $${
      "title":"Unang 5 minuto: itabi muna ang proof bago gumawa ng iba",
      "body":"Pinakamahalaga sa simula ang ebidensya. I-save ang transaction details habang madali pa itong makita.",
      "step_number":1,
      "items":[
        "I-screenshot ang successful transaction page",
        "Kopyahin o i-screenshot ang reference number",
        "Isulat ang date, time, amount, at recipient number o account",
        "I-save ang related SMS o app notifications",
        "I-note kung GCash-to-GCash, GCash-to-bank, cash-in, o scam-related ang nangyari"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'wrong-send-gcash-checklist'),
    'step',
    4,
    $${
      "title":"If you sent to the wrong GCash number",
      "body":"GCash says Send Money transfers are real-time. If the money went to the wrong person, the practical first step is to ask the recipient to return it. If the number is old or inactive, use the transaction help flow in the GCash app.",
      "step_number":2,
      "items":[
        "Open GCash Transactions",
        "Tap the Send Money transaction",
        "Use Get help and choose the wrong-number issue",
        "If you know the recipient, ask calmly for the money back",
        "Avoid public shaming because it can expose your own details and make recovery harder"
      ]
    }$$::jsonb,
    $${
      "title":"Kung maling GCash number ang napadalhan",
      "body":"Ayon sa GCash, real-time ang Send Money transfers. Kung maling tao ang napadalhan, practical na unang step ang mahinahong pag-request na ibalik ang pera. Kung luma o inactive ang number, gamitin ang transaction help flow sa GCash app.",
      "step_number":2,
      "items":[
        "Buksan ang GCash Transactions",
        "I-tap ang Send Money transaction",
        "Gamitin ang Get help at piliin ang wrong-number issue",
        "Kung kilala ang recipient, mahinahong hilingin na ibalik ang pera",
        "Iwasan ang public shaming dahil puwede nitong ilantad ang sarili mong details at pahirapin ang recovery"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'wrong-send-gcash-checklist'),
    'step',
    5,
    $${
      "title":"If you sent from GCash to the wrong bank account",
      "body":"Check first if the transfer failed or if you received an SMS saying there was no deduction. If the money was sent to an active account, GCash may try to help on a best-effort basis, but the final decision can depend on the receiving bank.",
      "step_number":3,
      "items":[
        "Check your GCash balance and transaction history",
        "Look for failed-transfer SMS or app notice",
        "Open the wrong bank transfer transaction",
        "Use Get help for wrong bank account",
        "Prepare for possible delays because another bank may need to respond"
      ]
    }$$::jsonb,
    $${
      "title":"Kung mula GCash papunta sa maling bank account",
      "body":"I-check muna kung failed ang transfer o kung may SMS na nagsasabing walang deduction. Kung napunta sa active account, maaaring tumulong ang GCash on a best-effort basis, pero puwedeng nakadepende ang final decision sa receiving bank.",
      "step_number":3,
      "items":[
        "I-check ang GCash balance at transaction history",
        "Hanapin kung may failed-transfer SMS o app notice",
        "Buksan ang maling bank transfer transaction",
        "Gamitin ang Get help para sa wrong bank account",
        "Maghanda sa possible delay dahil maaaring kailangan sumagot ng receiving bank"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'wrong-send-gcash-checklist'),
    'step',
    6,
    $${
      "title":"If someone tricked you, treat it as a scam case",
      "body":"If you sent money because of a fake seller, fake job, fake investment, fake support agent, or pressure message, do not label it as only a wrong-send. Report it as a scam and preserve evidence.",
      "step_number":4,
      "items":[
        "Save chat logs, profile links, payment requests, and screenshots",
        "Report through GCash support immediately",
        "Report the scammer to proper authorities when needed",
        "Block the scammer after saving evidence",
        "Do not send more money for refund, unlock, verification, or processing fees"
      ]
    }$$::jsonb,
    $${
      "title":"Kung naloko ka, scam case ito",
      "body":"Kung nagpadala ka dahil sa fake seller, fake job, fake investment, fake support agent, o pressure message, huwag itong ituring na wrong-send lang. I-report ito bilang scam at itabi ang ebidensya.",
      "step_number":4,
      "items":[
        "I-save ang chat logs, profile links, payment requests, at screenshots",
        "I-report agad sa GCash support",
        "I-report sa proper authorities kung kailangan",
        "I-block ang scammer pagkatapos ma-save ang ebidensya",
        "Huwag magpadala ulit ng pera para sa refund, unlock, verification, o processing fee"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'wrong-send-gcash-checklist'),
    'step',
    7,
    $${
      "title":"If money moved without your permission",
      "body":"Unauthorized transaction is a different emergency. Secure your account first, then report through official support within the required period shown by GCash. Do not focus only on refund while the account may still be exposed.",
      "step_number":5,
      "items":[
        "Change your MPIN or password through the official app",
        "Check linked apps, subscriptions, and logged-in devices",
        "Report unauthorized transactions through GCash support",
        "Keep ticket numbers and support replies",
        "Do not share OTP, MPIN, or screen recordings with anyone claiming to help"
      ]
    }$$::jsonb,
    $${
      "title":"Kung gumalaw ang pera nang wala kang pahintulot",
      "body":"Ibang emergency ang unauthorized transaction. I-secure muna ang account, pagkatapos mag-report sa official support sa loob ng required period na nakasaad ng GCash. Huwag refund lang ang isipin kung exposed pa rin ang account.",
      "step_number":5,
      "items":[
        "Palitan ang MPIN o password gamit ang official app",
        "I-check ang linked apps, subscriptions, at logged-in devices",
        "I-report ang unauthorized transactions sa GCash support",
        "Itabi ang ticket numbers at support replies",
        "Huwag mag-share ng OTP, MPIN, o screen recordings sa nagkukunwaring tutulong"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'wrong-send-gcash-checklist'),
    'mistake',
    8,
    $${
      "title":"Common mistakes that make recovery harder",
      "body":"Most bad decisions happen in the first few minutes after panic. Slow down before posting, paying, or accusing.",
      "items":[
        "Posting the full number, name, amount, and reference number online",
        "Paying a recovery helper from comments or private messages",
        "Reporting the wrong case type to support",
        "Deleting screenshots after talking to the recipient",
        "Sending threats instead of a clear written request",
        "Waiting too long before contacting official support"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes na nagpapahirap sa recovery",
      "body":"Madalas nangyayari ang maling desisyon sa unang ilang minuto ng panic. Huminto muna bago mag-post, magbayad, o manisi.",
      "items":[
        "Pag-post ng full number, pangalan, amount, at reference number online",
        "Pagbayad sa recovery helper mula sa comments o private messages",
        "Maling case type ang nire-report sa support",
        "Pag-delete ng screenshots pagkatapos makausap ang recipient",
        "Pag-send ng threats imbes na malinaw na written request",
        "Masyadong matagal bago lumapit sa official support"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'wrong-send-gcash-checklist'),
    'tip',
    9,
    $${
      "title":"Sample message to recipient",
      "body":"Use a calm message if you know or can safely contact the recipient. Do not include OTP, MPIN, password, or unnecessary personal details.",
      "sample":"Hello po. I may have sent money to your GCash number by mistake on [date/time], amount [amount], reference [last few digits only]. Can you please check your transaction history? If received, may I request that you send it back to [your number]? I can provide proof through the official GCash support process if needed."
    }$$::jsonb,
    $${
      "title":"Sample message sa recipient",
      "body":"Gumamit ng mahinahong message kung kilala mo o safe mong makontak ang recipient. Huwag isama ang OTP, MPIN, password, o hindi kailangang personal details.",
      "sample":"Hello po. Mukhang nakapag-send po ako sa GCash number ninyo by mistake noong [date/time], amount [amount], reference [last few digits only]. Pwede po bang paki-check ang transaction history ninyo? Kung natanggap po, makiki-request po sana ako na ibalik sa [your number]. May proof po ako na puwedeng ibigay sa official GCash support process kung kailangan."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'wrong-send-gcash-checklist'),
    'tip',
    10,
    $${
      "title":"Checklist before contacting support",
      "body":"Prepare these before opening a support ticket so you can explain the case clearly.",
      "items":[
        "Transaction screenshot or receipt",
        "Reference number",
        "Date, time, amount, and transfer method",
        "Recipient number or bank account details shown in the receipt",
        "Short explanation of what happened",
        "Screenshots of scam messages if someone tricked you",
        "Ticket number after reporting"
      ]
    }$$::jsonb,
    $${
      "title":"Checklist bago mag-contact ng support",
      "body":"Ihanda ito bago mag-open ng support ticket para malinaw mong maipaliwanag ang kaso.",
      "items":[
        "Transaction screenshot o receipt",
        "Reference number",
        "Date, time, amount, at transfer method",
        "Recipient number o bank account details na nasa receipt",
        "Maikling explanation ng nangyari",
        "Screenshots ng scam messages kung may nanloko",
        "Ticket number pagkatapos mag-report"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'wrong-send-gcash-checklist'),
    'related',
    11,
    $${
      "title":"Related guides",
      "body":"Use these guides if the wrong-send happened with a scam, exposed account, lost wallet, or urgent cash problem.",
      "items":[
        "GCash Scam Red Flags: use this if someone pressured you to send money",
        "Phishing Link Checklist: use this if a link or fake support page was involved",
        "Lost Wallet First Steps: use this if cards, IDs, or account access may also be exposed",
        "Payday Budget Simple Split: use this if the wrong-send created an urgent cash shortfall"
      ]
    }$$::jsonb,
    $${
      "title":"Related guides",
      "body":"Gamitin ang guides na ito kung may scam, exposed account, nawawalang wallet, o urgent cash problem na kasama ang wrong-send.",
      "items":[
        "GCash Scam Red Flags: kung may nag-pressure sa iyo na magpadala",
        "Phishing Link Checklist: kung may link o fake support page na involved",
        "Lost Wallet First Steps: kung may cards, IDs, o account access na posibleng exposed",
        "Payday Budget Simple Split: kung nagdulot ang wrong-send ng urgent na kulang sa pera"
      ]
    }$$::jsonb
  );
