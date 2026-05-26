update public.guides
set
  title_en = 'GCash scam checklist before sending money or OTP',
  title_fil = 'GCash scam checklist bago magpadala ng pera o OTP',
  tagline_en = 'Check fake support, wrong-send risk, device registration, OTP/MPIN requests, and recovery scams before you act.',
  tagline_fil = 'I-check ang fake support, maling send risk, device registration, OTP/MPIN requests, at recovery scams bago kumilos.',
  read_time_min = 7,
  estimated_time = '5-20 minuto',
  estimated_cost = 'Libre',
  difficulty = 'madali',
  is_urgent = true,
  tags = array[
    'gcash',
    'scam',
    'money',
    'otp',
    'mpin',
    'wrong send',
    'fake support',
    'device registration',
    'account secure',
    'unauthorized transaction',
    'phishing'
  ],
  keywords_en = 'gcash scam money otp mpin fake support wrong send wrong number account secure device registration unauthorized transaction phishing fake seller refund recovery fee qr code express send send money account takeover gigi help center',
  keywords_fil = 'gcash scam pera otp mpin fake support maling send maling number account secure device registration unauthorized transaction phishing fake seller refund recovery fee qr code express send send money account takeover gigi help center',
  official_sources = '[
    {"title":"How can I protect my GCash account?","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/19578518834457-How-can-I-protect-my-GCash-account"},
    {"title":"Report a scam","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/fil/articles/4413295284377-Report-a-scam"},
    {"title":"Report unauthorized transactions in my GCash account","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/4416637093145-Report-unauthorized-transactions-in-my-GCash-account"},
    {"title":"Sent money to wrong number","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/30244972048409-Sent-money-to-wrong-number"},
    {"title":"Report someone trying to register their device to my account","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/36349842359193-Report-someone-trying-to-register-their-device-to-my-account"},
    {"title":"Lost or stolen SIM, phone, or device","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/900006457043-Report-lost-or-stolen-phone-or-SIM"}
  ]'::jsonb,
  updated_at = now()
where slug = 'gcash-scam-red-flags';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'gcash-scam-red-flags'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'what_to_know',
    1,
    $${
      "title":"GCash scams usually try to move you before you verify",
      "body":"Scammers use fake sellers, fake buyers, fake relatives, fake support, refund promises, job offers, loan releases, device registration messages, and edited receipts. The goal is simple: make you send money, reveal OTP/MPIN, approve account access, or trust a fake recovery helper before you check the official route.",
      "items":[
        "GCash says it will not ask for your MPIN or OTP",
        "GCash says it will not send links through SMS or email for account access",
        "Send Money is fast, so wrong-send or scam losses can be hard to reverse",
        "Fake support and fake recovery helpers often appear after the first scam",
        "Device registration or Account Secure messages should be treated seriously if you did not request them"
      ]
    }$$::jsonb,
    $${
      "title":"GCash scams madalas kang pinapakilos bago ka makapag-verify",
      "body":"Gumagamit ang scammers ng fake sellers, fake buyers, fake relatives, fake support, refund promises, job offers, loan releases, device registration messages, at edited receipts. Simple ang goal: mapadala ka ng pera, OTP/MPIN, mapa-approve ng account access, o mapagtiwala sa fake recovery helper bago mo ma-check ang official route.",
      "items":[
        "Sinasabi ng GCash na hindi sila hihingi ng MPIN o OTP",
        "Sinasabi ng GCash na hindi sila magpapadala ng links sa SMS o email para sa account access",
        "Mabilis ang Send Money, kaya mahirap ma-reverse ang maling send o scam loss",
        "Madalas lumalabas ang fake support at fake recovery helpers pagkatapos ng unang scam",
        "Seryosohin ang device registration o Account Secure messages kung hindi ikaw ang nag-request"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'warning',
    2,
    $${
      "title":"START HERE: OTP, MPIN, and device registration are account keys",
      "body":"Do not share OTP, MPIN, password, backup code, screen-sharing access, or device registration approval with anyone. If someone says they need these to refund, verify, unlock, recover, or protect your account, stop and use the GCash app or official Help Center instead.",
      "severity":"high",
      "items":[
        "OTP or MPIN request",
        "Screen-sharing or remote access request",
        "Link to login, verify, refund, unlock, or claim money",
        "Account Secure or device registration request you did not start",
        "Processing fee, recovery fee, refund fee, or insurance fee",
        "Pressure to hide the conversation from family, bank, or support"
      ]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: account keys ang OTP, MPIN, at device registration",
      "body":"Huwag ibigay ang OTP, MPIN, password, backup code, screen-sharing access, o device registration approval sa kahit sino. Kung sinasabi nilang kailangan ito para mag-refund, verify, unlock, recover, o protect ng account, huminto at gamitin ang GCash app o official Help Center.",
      "severity":"high",
      "items":[
        "Hingi ng OTP o MPIN",
        "Hingi ng screen-sharing o remote access",
        "Link para mag-login, verify, refund, unlock, o claim ng pera",
        "Account Secure o device registration request na hindi ikaw ang nagsimula",
        "Processing fee, recovery fee, refund fee, o insurance fee",
        "Pinapasekreto ang usapan sa family, bank, o support"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'step',
    3,
    $${
      "title":"Before sending: verify the person, reason, and account details",
      "body":"Treat every send-money request as final until proven otherwise. Verify outside the same chat before sending, especially if the request is urgent, emotional, or linked to a prize, job, loan, refund, delivery, or family emergency.",
      "step_number":1,
      "items":[
        "Call the person using a saved number, not the chat that requested money",
        "Compare account name, number, amount, and exact reason",
        "Ask one detail only the real person or seller should know",
        "Check the seller or merchant through an official page or known channel",
        "Do not trust edited receipts, screenshots, or profile pictures alone",
        "Do not send if the person refuses a basic verification check"
      ]
    }$$::jsonb,
    $${
      "title":"Bago magpadala: i-verify ang tao, dahilan, at account details",
      "body":"Ituring na final ang bawat send-money request hangga't hindi nabe-verify. Mag-verify sa labas ng parehong chat bago magpadala, lalo na kung urgent, emotional, o konektado sa prize, trabaho, loan, refund, delivery, o family emergency.",
      "step_number":1,
      "items":[
        "Tawagan ang tao gamit ang saved number, hindi ang chat na humihingi ng pera",
        "I-compare ang account name, number, amount, at exact reason",
        "Magtanong ng isang detail na dapat alam lang ng totoong tao o seller",
        "I-check ang seller o merchant sa official page o kilalang channel",
        "Huwag umasa sa edited receipts, screenshots, o profile pictures lang",
        "Huwag magpadala kung ayaw pumayag sa basic verification check"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'step',
    4,
    $${
      "title":"Separate wrong-send, scam, and unauthorized transaction cases",
      "body":"The next step depends on what happened. Do not use the wrong report path if the case is actually a scam, wrong number, or unauthorized account activity.",
      "step_number":2,
      "items":[
        "Wrong number: you sent to the wrong person or old/inactive number",
        "Scam: someone tricked you into sending money",
        "Unauthorized transaction: money moved without your permission",
        "Device registration attempt: someone tried to register a phone to your account",
        "Lost SIM/phone: someone may access OTP, messages, or your GCash app",
        "Fake support: someone offers recovery or refund outside official support"
      ]
    }$$::jsonb,
    $${
      "title":"Paghiwalayin ang wrong-send, scam, at unauthorized transaction cases",
      "body":"Depende sa nangyari ang next step. Huwag maling report path ang gamitin kung ang case ay scam, maling number, o unauthorized account activity.",
      "step_number":2,
      "items":[
        "Wrong number: ikaw ang nag-send sa maling tao o old/inactive number",
        "Scam: may nanloko sa iyo para magpadala ng pera",
        "Unauthorized transaction: may gumalaw ng pera nang walang permiso mo",
        "Device registration attempt: may nagtangkang mag-register ng phone sa account mo",
        "Lost SIM/phone: puwedeng ma-access ang OTP, messages, o GCash app mo",
        "Fake support: may nag-aalok ng recovery o refund sa labas ng official support"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'step',
    5,
    $${
      "title":"If you already sent money",
      "body":"Move fast, but stay factual. Save evidence first, then report through official routes. GCash Help Center says scam reports should be filed with details and screenshots, and scam cases should also be reported to authorities such as PNP or NBI.",
      "step_number":3,
      "items":[
        "Screenshot the chat, profile, number, QR, links, receipts, and transaction details",
        "Do not delete the conversation before saving evidence",
        "Report through the GCash app or official Help Center",
        "Report the scammer to proper authorities when applicable",
        "Block the scammer after preserving evidence",
        "Do not pay a recovery helper promising guaranteed refund"
      ]
    }$$::jsonb,
    $${
      "title":"Kung nakapagpadala ka na ng pera",
      "body":"Kumilos agad, pero factual. I-save muna ang ebidensya, pagkatapos mag-report sa official routes. Sinasabi ng GCash Help Center na mag-file ng scam report gamit ang details at screenshots, at i-report din ang scam sa authorities tulad ng PNP o NBI.",
      "step_number":3,
      "items":[
        "I-screenshot ang chat, profile, number, QR, links, receipts, at transaction details",
        "Huwag burahin ang usapan bago mag-save ng evidence",
        "Mag-report sa GCash app o official Help Center",
        "I-report ang scammer sa tamang authorities kung applicable",
        "I-block ang scammer pagkatapos ma-save ang evidence",
        "Huwag magbayad sa recovery helper na nangangako ng guaranteed refund"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'step',
    6,
    $${
      "title":"If you received OTP, Account Secure, or device registration messages",
      "body":"If you did not start the action, treat it as a possible account takeover attempt. Ignore unsolicited OTPs, never share them, change your MPIN if needed, and report suspicious device registration attempts through official GCash support.",
      "step_number":4,
      "items":[
        "Do not share the OTP with anyone",
        "Do not approve device registration you did not start",
        "Change MPIN from the official app if you suspect exposure",
        "Check if your SIM or phone is still secure",
        "Report suspicious device registration or Account Secure messages",
        "If your phone or SIM is lost, report it immediately through GCash lost SIM/phone support"
      ]
    }$$::jsonb,
    $${
      "title":"Kung may OTP, Account Secure, o device registration messages",
      "body":"Kung hindi ikaw ang nagsimula, ituring itong possible account takeover attempt. I-ignore ang unsolicited OTPs, huwag ibigay kahit kanino, palitan ang MPIN kung kailangan, at i-report ang suspicious device registration sa official GCash support.",
      "step_number":4,
      "items":[
        "Huwag ibigay ang OTP kahit kanino",
        "Huwag i-approve ang device registration na hindi ikaw ang nagsimula",
        "Palitan ang MPIN sa official app kung posibleng exposed",
        "I-check kung secure pa ang SIM o phone mo",
        "I-report ang suspicious device registration o Account Secure messages",
        "Kung nawala ang phone o SIM, i-report agad sa GCash lost SIM/phone support"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'mistake',
    7,
    $${
      "title":"Common mistakes that make GCash losses worse",
      "body":"Most damage grows when people panic, hide the incident, or trust another unofficial helper after the first scam.",
      "items":[
        "Sending a second payment to fix the first problem",
        "Paying a recovery, refund, processing, or insurance fee",
        "Posting full transaction details publicly",
        "Deleting chat before saving evidence",
        "Believing edited screenshots or fake receipts",
        "Trusting comments or DMs claiming they can recover funds",
        "Waiting too long before reporting unauthorized transactions"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes na nagpapalala ng GCash losses",
      "body":"Mas lumalaki ang damage kapag nagpapanic, tinatago ang nangyari, o nagtitiwala ulit sa unofficial helper pagkatapos ng unang scam.",
      "items":[
        "Nagpapadala ng pangalawang bayad para ayusin daw ang unang problema",
        "Nagbabayad ng recovery, refund, processing, o insurance fee",
        "Pinopost publicly ang full transaction details",
        "Binubura ang chat bago mag-save ng evidence",
        "Naniniwala sa edited screenshots o fake receipts",
        "Nagtitiwala sa comments o DMs na kaya raw i-recover ang funds",
        "Masyadong matagal bago mag-report ng unauthorized transactions"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'warning',
    8,
    $${
      "title":"Wrong-send does not always mean easy refund",
      "body":"GCash Help Center says Send Money transfers happen in real time, and reversal for wrong-send cases is limited. This is why checking the recipient before sending matters more than hoping for reversal after.",
      "severity":"medium",
      "items":[
        "Double-check recipient number and account name before confirming",
        "Send a small test amount only when appropriate",
        "Do not rush because someone says the deal will expire",
        "If wrong-send happens, follow the official Help Center path",
        "Do not harass the recipient or post private details publicly"
      ]
    }$$::jsonb,
    $${
      "title":"Hindi laging madaling ma-refund ang maling send",
      "body":"Sinasabi ng GCash Help Center na real-time ang Send Money transfers, at limitado ang reversal sa wrong-send cases. Kaya mas mahalaga ang pag-check ng recipient bago mag-send kaysa umasa sa reversal pagkatapos.",
      "severity":"medium",
      "items":[
        "I-double check ang recipient number at account name bago mag-confirm",
        "Mag-send muna ng maliit na test amount kung appropriate",
        "Huwag magpadali dahil may nagsasabing mawawala ang deal",
        "Kung wrong-send ang nangyari, sundin ang official Help Center path",
        "Huwag i-harass ang recipient o mag-post ng private details publicly"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'tip',
    9,
    $${
      "title":"GCash safety checklist",
      "body":"Use this before sending money or responding to support/recovery messages.",
      "items":[
        "I verified the person outside the same chat",
        "I checked account name, number, amount, and reason",
        "I did not click login, refund, unlock, or claim links",
        "I did not share OTP, MPIN, password, or backup code",
        "I did not approve unknown device registration",
        "I saved evidence before reporting",
        "I used only the GCash app or official Help Center for support",
        "I did not pay recovery or processing fees"
      ]
    }$$::jsonb,
    $${
      "title":"GCash safety checklist",
      "body":"Gamitin ito bago magpadala ng pera o sumagot sa support/recovery messages.",
      "items":[
        "Na-verify ko ang tao sa labas ng parehong chat",
        "Na-check ko ang account name, number, amount, at reason",
        "Hindi ako nag-click ng login, refund, unlock, o claim links",
        "Hindi ako nag-share ng OTP, MPIN, password, o backup code",
        "Hindi ako nag-approve ng unknown device registration",
        "Na-save ko ang evidence bago mag-report",
        "GCash app o official Help Center lang ang ginamit ko for support",
        "Hindi ako nagbayad ng recovery o processing fees"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'tip',
    10,
    $${
      "title":"Sample verification message before sending money",
      "body":"A real person or merchant should not be offended by basic safety checks.",
      "sample":"Before I send, please confirm the exact amount, reason, GCash name/number, and one detail from our previous transaction or conversation. I will verify through your official page or saved number first."
    }$$::jsonb,
    $${
      "title":"Sample verification message bago magpadala",
      "body":"Hindi dapat ma-offend ang totoong tao o merchant sa basic safety check.",
      "sample":"Bago po ako mag-send, paki-confirm ang exact amount, reason, GCash name/number, at isang detail mula sa previous transaction o conversation natin. I-ve-verify ko rin muna sa official page o saved number ninyo."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-scam-red-flags'),
    'tip',
    11,
    $${
      "title":"Sample scam report note",
      "body":"Keep the report factual. Do not include OTP, MPIN, password, or full private details in ordinary public posts.",
      "sample":"I believe I was scammed through GCash on ____ at ____. Amount: ____. Recipient name/number shown: ____. I have screenshots of the chat, transaction receipt, profile/link, and timeline. Please advise the official reporting process and any account security steps I should take."
    }$$::jsonb,
    $${
      "title":"Sample scam report note",
      "body":"Gawing factual ang report. Huwag ilagay ang OTP, MPIN, password, o full private details sa ordinary public posts.",
      "sample":"Naniniwala po akong na-scam ako through GCash noong ____ at ____. Amount: ____. Recipient name/number shown: ____. May screenshots po ako ng chat, transaction receipt, profile/link, at timeline. Paki-advise po ang official reporting process at account security steps na dapat kong gawin."
    }$$::jsonb
  );
