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
  'phone-stolen-first-hour',
  (select id from public.categories where slug = 'digital-safety'),
  'First hour checklist when your phone is stolen',
  'First hour checklist kapag nanakaw ang phone',
  'Secure SIM access, OTPs, money apps, email, sessions, and device proof before replacing the phone.',
  'I-secure muna ang SIM access, OTPs, money apps, email, sessions, at device proof bago palitan ang phone.',
  true,
  true,
  true,
  6,
  'katamtaman',
  '15-60 minuto',
  'Libre, maliban sa call, pamasahe, SIM replacement, affidavit, o data',
  array[
    'stolen phone',
    'lost phone',
    'nanakaw phone',
    'nawala cellphone',
    'lost sim',
    'otp',
    'gcash',
    'maya',
    'bank',
    'imei',
    'find my device',
    'digital safety',
    'emergency'
  ],
  'stolen phone lost phone phone stolen stolen cellphone lost cellphone nanakaw phone nawala phone nawala cellphone lost sim sim stolen otp sim access gcash maya bank banking app e-wallet email password logged in sessions find my device find my iphone apple google android imei ntc block phone block sim device proof affidavit of loss police blotter phone theft first hour emergency',
  'nanakaw phone nawala phone nawala cellphone stolen phone lost phone phone stolen lost sim nanakaw sim otp sim access gcash maya bank banking app e-wallet email password logged in sessions find my device find my iphone apple google android imei ntc block phone block sim device proof affidavit of loss police blotter unang oras emergency',
  $$[
    {"title":"Lost or stolen SIM, phone, or device","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/900006457043-My-SIM-phone-got-lost-deactivated-damaged-What-should-I-do"},
    {"title":"IMEI","publisher":"Freedom of Information Philippines / NTC","url":"https://www.foi.gov.ph/agencies/ntc/imei/"},
    {"title":"NTC Regional Offices Citizens Charter","publisher":"National Telecommunications Commission","url":"https://ntc.gov.ph/wp-content/uploads/2025/CITIZENS_CHARTER/6-11-REGIONAL-OFFICES-CCT-03312025.pdf"},
    {"title":"Find, secure, or erase a lost Android device","publisher":"Google Android Help","url":"https://support.google.com/android/answer/6160491?hl=en"},
    {"title":"Mark a device as lost in Find My on iPhone","publisher":"Apple Support","url":"https://support.apple.com/en-in/guide/iphone/-iph7cc193cfc/ios"},
    {"title":"Temporary Disconnection for Lost SIM/Phone FAQs","publisher":"Globe Help & Support","url":"https://www.globe.com.ph/help/postpaid/lost-sim-phone"}
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
  where slug = 'phone-stolen-first-hour'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'what_to_know',
    1,
    $${
      "title":"The first hour is about protecting access before replacing the phone",
      "body":"A stolen phone can expose OTPs, SIM access, e-wallets, banking apps, email, social accounts, saved sessions, photos, contacts, and saved cards. Your first job is not to buy a new phone. Your first job is to stop access and prepare proof.",
      "items":[
        "Prioritize personal safety before the device",
        "Secure SIM and OTP access because many accounts depend on them",
        "Lock money apps and linked cards before more transactions happen",
        "Secure email because it can reset passwords",
        "Prepare IMEI, proof, and ticket numbers for official follow-up"
      ]
    }$$::jsonb,
    $${
      "title":"Ang unang oras ay tungkol sa pagprotekta ng access bago palitan ang phone",
      "body":"Kapag nanakaw ang phone, puwedeng ma-expose ang OTPs, SIM access, e-wallets, banking apps, email, social accounts, saved sessions, photos, contacts, at saved cards. Hindi pagbili ng bagong phone ang unang trabaho. Ang unang trabaho ay pigilan ang access at maghanda ng proof.",
      "items":[
        "Unahin ang personal safety bago ang device",
        "I-secure ang SIM at OTP access dahil maraming accounts ang nakadepende roon",
        "I-lock ang money apps at linked cards bago may madagdag na transactions",
        "I-secure ang email dahil ginagamit ito sa password reset",
        "Ihanda ang IMEI, proof, at ticket numbers para sa official follow-up"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'warning',
    2,
    $${
      "title":"START HERE: prioritize safety, OTP access, and account security",
      "body":"Do not chase thieves, do not arrange meetups with strangers claiming they found the phone, and do not risk your safety to recover the device. Move from a safe place using a trusted device. Protect SIM/OTP access, money apps, email, and logged-in sessions first.",
      "severity":"high",
      "items":[
        "Do not confront anyone who may have the phone",
        "Do not meet strangers alone because they claim they found it",
        "Do not post full phone number, OTP screenshots, ID, or account details publicly",
        "Do not click recovery links from comments, SMS, DMs, or ads",
        "Use official support routes for telco, e-wallet, bank, Apple, Google, or NTC concerns"
      ]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: safety, OTP access, at account security",
      "body":"Huwag habulin ang magnanakaw, huwag makipag-meet sa strangers na nagsasabing nakita nila ang phone, at huwag isugal ang safety para mabawi ang device. Kumilos mula sa safe na lugar gamit ang trusted device. Unahin ang SIM/OTP access, money apps, email, at logged-in sessions.",
      "severity":"high",
      "items":[
        "Huwag komprontahin ang taong posibleng may hawak ng phone",
        "Huwag makipagkita mag-isa sa strangers dahil lang sinasabi nilang nakita nila ito",
        "Huwag i-post publicly ang full phone number, OTP screenshots, ID, o account details",
        "Huwag mag-click ng recovery links mula sa comments, SMS, DMs, o ads",
        "Official support routes lang ang gamitin para sa telco, e-wallet, bank, Apple, Google, o NTC concerns"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'step',
    3,
    $${
      "title":"First 5 minutes: use a trusted device and list exposed accounts",
      "body":"Borrow a trusted phone or computer if possible. Write down what the stolen phone could access so you do not forget important accounts while panicking.",
      "step_number":1,
      "items":[
        "SIM number used for OTP",
        "GCash, Maya, banking apps, and saved cards",
        "Primary email used for password resets",
        "Facebook, Messenger, social accounts, and work or school accounts",
        "Apple ID, Google account, Find My Device, or Find My iPhone access"
      ]
    }$$::jsonb,
    $${
      "title":"Unang 5 minuto: gumamit ng trusted device at ilista ang exposed accounts",
      "body":"Kung kaya, humiram ng trusted phone o computer. Isulat kung anong accounts ang posibleng mabuksan sa nanakaw na phone para walang makalimutan habang nagpapanic.",
      "step_number":1,
      "items":[
        "SIM number na ginagamit sa OTP",
        "GCash, Maya, banking apps, at saved cards",
        "Primary email na ginagamit sa password resets",
        "Facebook, Messenger, social accounts, at work o school accounts",
        "Apple ID, Google account, Find My Device, o Find My iPhone access"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'step',
    4,
    $${
      "title":"Protect SIM and OTP access first",
      "body":"Your SIM may still receive OTPs for e-wallets, banks, email, and social accounts. Ask your telco how to block or temporarily disconnect the lost SIM and what proof is needed for replacement. Use the lost SIM guide for deeper replacement details.",
      "step_number":2,
      "items":[
        "Call or visit your telco using official contact routes",
        "Ask how to block, bar, or temporarily disconnect the lost SIM",
        "Ask what proof is needed to replace or recover the number",
        "List accounts using that number for OTP",
        "Do not move every account randomly until you understand the telco process"
      ]
    }$$::jsonb,
    $${
      "title":"Unahin ang SIM at OTP access",
      "body":"Puwede pa ring makatanggap ng OTP ang SIM para sa e-wallets, banks, email, at social accounts. Itanong sa telco kung paano i-block o pansamantalang i-disconnect ang lost SIM at anong proof ang kailangan para sa replacement. Gamitin ang lost SIM guide para sa mas detalyadong replacement steps.",
      "step_number":2,
      "items":[
        "Tumawag o pumunta sa telco gamit ang official contact routes",
        "Itanong kung paano i-block, i-bar, o pansamantalang i-disconnect ang lost SIM",
        "Itanong kung anong proof ang kailangan para palitan o ma-recover ang number",
        "Ilista ang accounts na gumagamit ng number na iyon para sa OTP",
        "Huwag basta ilipat lahat ng accounts hangga't hindi malinaw ang telco process"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'step',
    5,
    $${
      "title":"Secure e-wallets, banking apps, saved cards, and payment apps",
      "body":"After SIM/OTP risk is being handled, reduce money movement. Use official app support, official help centers, or bank hotlines. Avoid random links from search results or comments.",
      "step_number":3,
      "items":[
        "Report lost/stolen phone or SIM to GCash, Maya, or bank support if money apps are exposed",
        "Freeze or block linked cards if your bank allows it",
        "Remove saved cards or payment links if you still have account access",
        "Save ticket numbers, emails, screenshots, and support reference numbers",
        "Use the GCash/Maya recovery guide if unauthorized access already happened"
      ]
    }$$::jsonb,
    $${
      "title":"I-secure ang e-wallets, banking apps, saved cards, at payment apps",
      "body":"Pagkatapos ma-handle ang SIM/OTP risk, bawasan ang galaw ng pera. Gumamit ng official app support, official help centers, o bank hotlines. Iwasan ang random links mula sa search results o comments.",
      "step_number":3,
      "items":[
        "I-report ang lost/stolen phone o SIM sa GCash, Maya, o bank support kung exposed ang money apps",
        "I-freeze o i-block ang linked cards kung kaya ng bank mo",
        "Tanggalin ang saved cards o payment links kung may account access ka pa",
        "I-save ang ticket numbers, emails, screenshots, at support reference numbers",
        "Gamitin ang GCash/Maya recovery guide kung may unauthorized access na nangyari"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'step',
    6,
    $${
      "title":"Secure email, social accounts, and logged-in sessions",
      "body":"Email can reset many accounts, so protect it early. From a clean device, change passwords and remove unknown logged-in sessions when available.",
      "step_number":4,
      "items":[
        "Change the password of the primary email used for recovery",
        "Remove unknown logged-in devices from email and social accounts",
        "Change passwords for Facebook, Messenger, work, school, and banking-related accounts",
        "Turn on two-step verification where possible after the SIM issue is controlled",
        "Do not reuse the same password across important accounts"
      ]
    }$$::jsonb,
    $${
      "title":"I-secure ang email, social accounts, at logged-in sessions",
      "body":"Kayang mag-reset ng maraming accounts ang email, kaya protektahan ito agad. Mula sa clean device, magpalit ng passwords at tanggalin ang unknown logged-in sessions kung available.",
      "step_number":4,
      "items":[
        "Palitan ang password ng primary email na ginagamit sa recovery",
        "Tanggalin ang unknown logged-in devices sa email at social accounts",
        "Palitan ang passwords ng Facebook, Messenger, work, school, at banking-related accounts",
        "I-on ang two-step verification kung possible pagkatapos ma-control ang SIM issue",
        "Huwag gumamit ng parehong password sa important accounts"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'step',
    7,
    $${
      "title":"Use Find My Device or Find My iPhone only if safe",
      "body":"Location tools can help you lock, mark as lost, or erase a device, but they should not push you into a risky confrontation. Use them from a safe place and coordinate with trusted people or authorities if there is a safety concern.",
      "step_number":5,
      "items":[
        "Use Google Find My Device for Android or Find My for iPhone if available",
        "Try lock, mark as lost, message display, or erase options if appropriate",
        "Do not go alone to a location shown by the app",
        "Do not arrange meetups with strangers claiming they found the phone",
        "If there is danger, prioritize safety and coordinate with trusted adults, security, or authorities"
      ]
    }$$::jsonb,
    $${
      "title":"Gamitin ang Find My Device o Find My iPhone kung safe lang",
      "body":"Makakatulong ang location tools para i-lock, i-mark as lost, o i-erase ang device, pero hindi ito dapat magtulak sa risky confrontation. Gamitin ito mula sa safe na lugar at makipag-coordinate sa trusted people o authorities kung may safety concern.",
      "step_number":5,
      "items":[
        "Gamitin ang Google Find My Device para sa Android o Find My para sa iPhone kung available",
        "Subukan ang lock, mark as lost, message display, o erase options kung appropriate",
        "Huwag pumunta mag-isa sa location na pinakita ng app",
        "Huwag makipag-meet sa strangers na nagsasabing nakita nila ang phone",
        "Kung may danger, unahin ang safety at makipag-coordinate sa trusted adults, security, o authorities"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'step',
    8,
    $${
      "title":"Prepare IMEI, proof of ownership, and report details",
      "body":"After access is protected, prepare proof for telco, NTC, employer, school, insurance, or police blotter needs. IMEI can be useful for device blocking follow-up, but do not assume every request will be resolved instantly.",
      "step_number":6,
      "items":[
        "IMEI from phone box, receipt, settings screenshot, or account device record",
        "Proof of ownership or purchase receipt if available",
        "Affidavit of loss if required by the telco or office",
        "Police blotter if needed for device, claim, employer, or school process",
        "Ticket numbers from telco, e-wallet, bank, Apple, Google, or NTC follow-up"
      ]
    }$$::jsonb,
    $${
      "title":"Ihanda ang IMEI, proof of ownership, at report details",
      "body":"Pagkatapos maprotektahan ang access, ihanda ang proof para sa telco, NTC, employer, school, insurance, o police blotter kung kailangan. Useful ang IMEI para sa device blocking follow-up, pero huwag asahang instant ang lahat ng request.",
      "step_number":6,
      "items":[
        "IMEI mula sa phone box, resibo, settings screenshot, o account device record",
        "Proof of ownership o purchase receipt kung available",
        "Affidavit of loss kung kailangan ng telco o office",
        "Police blotter kung kailangan sa device, claim, employer, o school process",
        "Ticket numbers mula sa telco, e-wallet, bank, Apple, Google, o NTC follow-up"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'mistake',
    9,
    $${
      "title":"Common mistakes after a stolen phone",
      "body":"Most damage gets worse when people panic, post too much information, or focus on replacing the phone before securing accounts.",
      "items":[
        "Buying a new phone before blocking SIM, OTP, and money access",
        "Posting full number, email, ID, screenshots, or ticket numbers publicly",
        "Clicking fake support links from comments or direct messages",
        "Forgetting that email access can reset many other accounts",
        "Deleting messages, reference numbers, or proof before reporting",
        "Ignoring logged-in sessions after changing passwords"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes pagkatapos manakaw ang phone",
      "body":"Mas lumalala ang damage kapag nagpapanic, sobra ang pinopost na information, o inuuna ang replacement phone bago i-secure ang accounts.",
      "items":[
        "Bumibili agad ng bagong phone bago i-block ang SIM, OTP, at money access",
        "Pinopost publicly ang full number, email, ID, screenshots, o ticket numbers",
        "Nagki-click ng fake support links mula sa comments o direct messages",
        "Nakakalimutang kayang mag-reset ng maraming accounts ang email access",
        "Binubura ang messages, reference numbers, o proof bago mag-report",
        "Hindi tinatanggal ang logged-in sessions pagkatapos magpalit ng passwords"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'warning',
    10,
    $${
      "title":"Fake recovery services, fake Apple/Google/GCash messages, and OTP traps",
      "body":"After a stolen phone, scammers may pretend to be support staff, telco agents, Apple or Google recovery teams, wallet recovery helpers, or people who found your phone. Official support should not ask for OTP, MPIN, password, backup codes, or remote access through private chat.",
      "severity":"high",
      "items":[
        "Recovery fee, processing fee, or unlocking fee",
        "OTP, MPIN, password, backup code, or screen-sharing request",
        "Shortened links or unofficial recovery forms",
        "Private messages claiming they can trace or unlock the phone",
        "Pressure to act before you verify the official channel"
      ]
    }$$::jsonb,
    $${
      "title":"Fake recovery services, fake Apple/Google/GCash messages, at OTP traps",
      "body":"Pagkatapos manakaw ang phone, may scammers na magpapanggap na support staff, telco agents, Apple o Google recovery teams, wallet recovery helpers, o taong nakakita raw ng phone mo. Hindi dapat humingi ang official support ng OTP, MPIN, password, backup codes, o remote access sa private chat.",
      "severity":"high",
      "items":[
        "Recovery fee, processing fee, o unlocking fee",
        "Hingi ng OTP, MPIN, password, backup code, o screen-sharing",
        "Shortened links o unofficial recovery forms",
        "Private messages na kaya raw i-trace o i-unlock ang phone",
        "Pressure na kumilos bago mo ma-verify ang official channel"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'tip',
    11,
    $${
      "title":"Sample message to telco, bank, e-wallet, or NTC",
      "body":"Keep messages short, factual, and specific. Do not include OTP, password, MPIN, or unnecessary ID numbers unless the official channel asks through a secure process.",
      "sample":"My phone was stolen today at around ____. I need to secure my SIM/OTP access and protect accounts linked to this number. Please tell me the official steps to block or replace the SIM, what documents are required, and how I can get a reference or ticket number. If this concern is about device blocking, I can provide IMEI and proof of ownership through your official process."
    }$$::jsonb,
    $${
      "title":"Sample message sa telco, bank, e-wallet, o NTC",
      "body":"Gawing maikli, factual, at specific ang message. Huwag ilagay ang OTP, password, MPIN, o unnecessary ID numbers maliban kung hiningi ng official channel sa secure process.",
      "sample":"Nanakaw po ang phone ko today bandang ____. Kailangan kong i-secure ang SIM/OTP access at protektahan ang accounts na linked sa number na ito. Paki-sabi po ng official steps para i-block o palitan ang SIM, anong documents ang kailangan, at paano makakuha ng reference o ticket number. Kung device blocking po ang concern, maibibigay ko ang IMEI at proof of ownership sa official process ninyo."
    }$$::jsonb
  );
