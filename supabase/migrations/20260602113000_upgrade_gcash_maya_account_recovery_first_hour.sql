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
  'gcash-maya-account-recovery-first-hour',
  (select id from public.categories where slug = 'digital-safety'),
  'First hour checklist for hacked GCash or Maya accounts',
  'Mga unang dapat gawin kapag na-compromise ang GCash o Maya',
  'Secure your SIM, email, passwords, and e-wallet access before panicking or trying to recover funds.',
  'Unahing i-secure ang SIM, email, passwords, at e-wallet access bago habulin ang pera.',
  true,
  true,
  true,
  6,
  'katamtaman',
  '10-60 minuto para ma-secure ang access at makapag-report',
  'Libre, maliban sa call, pamasahe, printing, o internet data',
  array[
    'gcash',
    'maya',
    'account recovery',
    'hacked account',
    'unauthorized transaction',
    'otp',
    'mpin',
    'sim',
    'e-wallet',
    'digital safety',
    'scam'
  ],
  'hacked gcash gcash hacked gcash account recovery maya account recovery maya hacked compromised e-wallet unauthorized transaction otp hacked otp scam mpin changed password changed sim compromised ewallet locked account locked suspicious login device registration account takeover stolen phone lost sim phishing gcash hacked philippines maya hacked philippines',
  'hacked gcash gcash hacked gcash account recovery maya account recovery maya hacked compromised e-wallet unauthorized transaction otp hacked otp scam mpin changed password changed sim compromised ewallet locked account locked kahina hinalang login device registration account takeover nanakaw phone nawala sim phishing gcash hacked philippines maya hacked philippines',
  $$[
    {"title":"How can I protect my GCash account?","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/19578518834457-How-can-I-protect-my-GCash-account"},
    {"title":"I noticed unauthorized transactions in my GCash account. What do I do?","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/4416637093145-I-noticed-unauthorized-transactions-in-my-GCash-account-What-do-I-do"},
    {"title":"Lost or stolen SIM, phone, or device","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/900006457043-What-should-I"},
    {"title":"Contact Us","publisher":"Maya","url":"https://www.maya.ph/contact-us"},
    {"title":"Preventive Data Privacy Practices Against Smishing","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/npc-phe-bulletin-no-21-preventive-data-privacy-practices-against-smishing/"}
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
  where slug = 'gcash-maya-account-recovery-first-hour'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'gcash-maya-account-recovery-first-hour'),
    'what_to_know',
    1,
    $${
      "title":"Protect access first before investigating missing funds",
      "body":"When an e-wallet may be compromised, the first goal is to stop more access. Do not start by arguing with strangers, posting screenshots, or chasing every transaction. Secure the SIM, email, passwords, MPIN, linked devices, and official support record first.",
      "items":[
        "A compromised e-wallet can involve SIM, email, device, password, MPIN, or phishing access",
        "Money recovery is not guaranteed, but fast reporting and evidence can help the official review",
        "A fake recovery helper can create a second loss if you share OTP, MPIN, password, or screenshots",
        "Use official GCash or Maya support routes only",
        "Save timestamps, reference numbers, screenshots, and ticket numbers before details disappear"
      ]
    }$$::jsonb,
    $${
      "title":"Access muna ang i-secure, bago habulin ang pera",
      "body":"Kapag posibleng na-compromise ang e-wallet, ang unang goal ay pigilan ang dagdag na access. Huwag magsimula sa pakikipagtalo sa strangers, pag-post ng screenshots, o paghabol sa bawat transaction. I-secure muna ang SIM, email, passwords, MPIN, linked devices, at official support record.",
      "items":[
        "Puwedeng manggaling ang compromise sa SIM, email, device, password, MPIN, o phishing access",
        "Hindi guaranteed ang money recovery, pero makakatulong ang mabilis na report at maayos na ebidensya sa official review",
        "Puwedeng magdulot ng pangalawang loss ang fake recovery helper kung magbibigay ka ng OTP, MPIN, password, o screenshots",
        "Official GCash o Maya support routes lang ang gamitin",
        "I-save ang timestamps, reference numbers, screenshots, at ticket numbers bago mawala ang details"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-maya-account-recovery-first-hour'),
    'warning',
    2,
    $${
      "title":"START HERE: secure access before reviewing missing transactions",
      "body":"If someone may control your account, every minute matters. Do not reply to private messages claiming they can recover funds. Do not pay a recovery fee. Use a trusted device, open official support, and block further access first.",
      "severity":"high",
      "items":[
        "Do not share OTP, MPIN, password, backup code, or selfie verification",
        "Do not screen-share with anyone claiming to be support",
        "Do not send full screenshots showing account numbers or personal details",
        "Do not click recovery links from comments, SMS, DMs, or ads",
        "Do not wait for the scammer to explain what happened"
      ]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: i-secure ang access bago habulin ang pera",
      "body":"Kung may ibang taong posibleng may control sa account mo, mahalaga ang bawat minuto. Huwag mag-reply sa private messages na nagsasabing kaya nilang i-recover ang pera. Huwag magbayad ng recovery fee. Gumamit ng trusted device, buksan ang official support, at pigilan muna ang dagdag na access.",
      "severity":"high",
      "items":[
        "Huwag ibigay ang OTP, MPIN, password, backup code, o selfie verification",
        "Huwag mag-screen-share sa kahit sinong nagpapanggap na support",
        "Huwag mag-send ng full screenshots na may account numbers o personal details",
        "Huwag mag-click ng recovery links mula sa comments, SMS, DMs, o ads",
        "Huwag hintayin ang scammer na magpaliwanag kung ano ang nangyari"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-maya-account-recovery-first-hour'),
    'step',
    3,
    $${
      "title":"First 5 minutes: secure SIM, email, password, and MPIN",
      "body":"Start with the access points that allow password resets, OTP approvals, and account changes. If your phone or SIM is missing, move faster and use a trusted device.",
      "step_number":1,
      "items":[
        "Check whether your SIM or phone is still in your control",
        "Change email password if your e-wallet uses that email for recovery",
        "Change e-wallet password or MPIN from the official app if you still have access",
        "Turn on or review security settings available inside the official app",
        "If SIM or phone is lost, contact the telco and use the lost SIM guide next"
      ]
    }$$::jsonb,
    $${
      "title":"Unang 5 minuto: i-secure ang SIM, email, password, at MPIN",
      "body":"Unahin ang access points na ginagamit sa password reset, OTP approval, at account changes. Kung nawawala ang phone o SIM, mas bilisan at gumamit ng trusted device.",
      "step_number":1,
      "items":[
        "I-check kung hawak mo pa ang SIM o phone",
        "Palitan ang email password kung ginagamit iyon sa e-wallet recovery",
        "Palitan ang e-wallet password o MPIN sa official app kung may access ka pa",
        "I-review o i-on ang security settings na available sa official app",
        "Kung nawala ang SIM o phone, kontakin ang telco at gamitin ang lost SIM guide pagkatapos"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-maya-account-recovery-first-hour'),
    'step',
    4,
    $${
      "title":"Lock down e-wallets, linked bank accounts, and cards",
      "body":"If there are unauthorized transactions or suspicious account changes, reduce what the attacker can still use. Prioritize linked money sources and payment tools.",
      "step_number":2,
      "items":[
        "Report suspicious GCash or Maya activity through official support",
        "Freeze or block linked bank cards if your bank allows it",
        "Remove or disable saved cards and payment links if still accessible",
        "Check whether loans, cash-in, transfers, or card payments were triggered",
        "Save official ticket numbers and confirmation messages"
      ]
    }$$::jsonb,
    $${
      "title":"I-lock down ang e-wallets, linked bank accounts, at cards",
      "body":"Kung may unauthorized transactions o kahina-hinalang account changes, bawasan ang puwedeng magamit ng attacker. Unahin ang linked money sources at payment tools.",
      "step_number":2,
      "items":[
        "I-report ang suspicious GCash o Maya activity sa official support",
        "I-freeze o i-block ang linked bank cards kung available sa bank mo",
        "Tanggalin o i-disable ang saved cards at payment links kung may access ka pa",
        "I-check kung may loans, cash-in, transfers, o card payments na na-trigger",
        "I-save ang official ticket numbers at confirmation messages"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-maya-account-recovery-first-hour'),
    'step',
    5,
    $${
      "title":"Check devices, sessions, permissions, and suspicious downloads",
      "body":"Account compromise is sometimes connected to a logged-in device, fake app, phishing page, or suspicious permission. Do a quick device check after securing money access.",
      "step_number":3,
      "items":[
        "Log out other sessions if the app or account allows it",
        "Remove suspicious apps or downloads you do not recognize",
        "Review app permissions for SMS, notifications, contacts, and storage",
        "Check email inbox rules, forwarding, and recovery details if available",
        "Avoid using a device that may still be infected or controlled"
      ]
    }$$::jsonb,
    $${
      "title":"I-check ang devices, sessions, permissions, at suspicious downloads",
      "body":"Minsan connected ang account compromise sa logged-in device, fake app, phishing page, o suspicious permission. Gumawa ng quick device check pagkatapos ma-secure ang money access.",
      "step_number":3,
      "items":[
        "I-log out ang ibang sessions kung kaya ng app o account",
        "Tanggalin ang suspicious apps o downloads na hindi mo kilala",
        "I-review ang app permissions para sa SMS, notifications, contacts, at storage",
        "I-check ang email inbox rules, forwarding, at recovery details kung available",
        "Iwasang gumamit ng device na posibleng infected o controlled pa rin"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-maya-account-recovery-first-hour'),
    'step',
    6,
    $${
      "title":"Collect evidence before details disappear",
      "body":"Keep evidence factual and organized. Do not edit screenshots in a way that removes time, sender, reference number, or transaction context.",
      "step_number":4,
      "items":[
        "Screenshot transaction history, reference numbers, and suspicious messages",
        "Record dates, times, amounts, sender names, and phone numbers involved",
        "Save support ticket numbers and automated replies",
        "Keep phishing links or sender details without clicking them again",
        "Write a simple timeline of what you noticed first and what you already did"
      ]
    }$$::jsonb,
    $${
      "title":"Mag-ipon ng ebidensya bago mawala ang details",
      "body":"Gawing factual at maayos ang ebidensya. Huwag i-edit ang screenshots sa paraan na mawawala ang oras, sender, reference number, o transaction context.",
      "step_number":4,
      "items":[
        "I-screenshot ang transaction history, reference numbers, at suspicious messages",
        "Isulat ang dates, times, amounts, sender names, at phone numbers na involved",
        "I-save ang support ticket numbers at automated replies",
        "Itabi ang phishing links o sender details pero huwag i-click ulit",
        "Gumawa ng simpleng timeline kung ano ang una mong napansin at ano na ang ginawa mo"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-maya-account-recovery-first-hour'),
    'step',
    7,
    $${
      "title":"Report through official GCash or Maya support only",
      "body":"Use official app support, official help center pages, or verified contact channels. If the concern involves unauthorized transactions, say that clearly and include evidence through the official process.",
      "step_number":5,
      "items":[
        "Open support from inside the official app when possible",
        "Use the official GCash Help Center or Maya contact page",
        "State whether access was lost, MPIN changed, OTP shared, or transaction was unauthorized",
        "Attach evidence only through the official support process",
        "Keep the ticket number and follow-up using the same official channel"
      ]
    }$$::jsonb,
    $${
      "title":"Official GCash o Maya support lang ang pag-reportan",
      "body":"Gamitin ang official app support, official help center pages, o verified contact channels. Kung unauthorized transaction ang concern, sabihin iyon nang malinaw at magbigay ng ebidensya sa official process.",
      "step_number":5,
      "items":[
        "Buksan ang support mula sa loob ng official app kung kaya",
        "Gamitin ang official GCash Help Center o Maya contact page",
        "Sabihin kung nawala ang access, napalitan ang MPIN, naibigay ang OTP, o unauthorized ang transaction",
        "I-attach ang ebidensya sa official support process lang",
        "Itabi ang ticket number at mag-follow up sa parehong official channel"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-maya-account-recovery-first-hour'),
    'mistake',
    8,
    $${
      "title":"Common mistakes after an e-wallet compromise",
      "body":"These mistakes usually happen because the user is scared and rushing. Slow down enough to protect access and preserve evidence.",
      "items":[
        "Posting full screenshots with name, number, reference number, or account details",
        "Asking random Facebook commenters or private messages for recovery help",
        "Paying a recovery, processing, verification, or unlocking fee",
        "Changing numbers or deleting messages before saving evidence",
        "Focusing only on the lost money while SIM, email, and passwords remain exposed"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes pagkatapos ma-compromise ang e-wallet",
      "body":"Madalas nangyayari ang mistakes dahil takot at nagmamadali ang user. Huminto sandali para maprotektahan ang access at ma-save ang ebidensya.",
      "items":[
        "Pag-post ng full screenshots na may pangalan, number, reference number, o account details",
        "Paghingi ng recovery help sa random Facebook commenters o private messages",
        "Pagbayad ng recovery, processing, verification, o unlocking fee",
        "Pagpalit ng number o pagbura ng messages bago mag-save ng ebidensya",
        "Pag-focus lang sa nawalang pera habang exposed pa rin ang SIM, email, at passwords"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-maya-account-recovery-first-hour'),
    'warning',
    9,
    $${
      "title":"Watch for fake recovery services and impersonators",
      "body":"Scammers may contact you again after you post or report the issue. They may pretend to be GCash, Maya, bank staff, police, investigators, or refund agents. Official support should not ask for OTP, MPIN, password, or remote access through private chat.",
      "severity":"high",
      "items":[
        "They ask for OTP, MPIN, password, backup code, or screen-sharing",
        "They ask for a fee to unlock, verify, refund, or recover funds",
        "They send another link for recovery or identity verification",
        "They pressure you to hide the conversation from family or official support",
        "They claim your money will be returned instantly if you follow private instructions"
      ]
    }$$::jsonb,
    $${
      "title":"Mag-ingat sa fake recovery helpers pagkatapos mag-report",
      "body":"Puwede kang kontakin ulit ng scammers pagkatapos mong mag-post o mag-report. Maaari silang magpanggap na GCash, Maya, bank staff, pulis, investigator, o refund agent. Hindi dapat humingi ang official support ng OTP, MPIN, password, o remote access sa private chat.",
      "severity":"high",
      "items":[
        "Humihingi sila ng OTP, MPIN, password, backup code, o screen-sharing",
        "Humihingi sila ng fee para mag-unlock, mag-verify, mag-refund, o mag-recover ng funds",
        "Nagpapadala sila ng panibagong link para sa recovery o identity verification",
        "Pinipilit ka nilang itago ang usapan sa pamilya o official support",
        "Sinasabi nilang maibabalik agad ang pera kung susunod ka sa private instructions"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-maya-account-recovery-first-hour'),
    'tip',
    10,
    $${
      "title":"Checklist before you stop for the day",
      "body":"Before you sleep or stop following up, make sure the main access points are no longer open.",
      "items":[
        "SIM or phone risk reported or handled",
        "Email password changed and recovery details checked",
        "E-wallet password or MPIN changed if access is still available",
        "Linked cards or bank accounts frozen or reviewed",
        "Official support ticket saved",
        "Evidence folder prepared with screenshots and timeline"
      ]
    }$$::jsonb,
    $${
      "title":"Checklist bago tumigil o matulog",
      "body":"Bago ka matulog o tumigil muna sa follow-up, siguraduhing hindi na bukas ang main access points.",
      "items":[
        "Na-report o na-handle ang SIM o phone risk",
        "Napalitan ang email password at na-check ang recovery details",
        "Napalitan ang e-wallet password o MPIN kung may access pa",
        "Na-freeze o na-review ang linked cards o bank accounts",
        "Na-save ang official support ticket",
        "May evidence folder na may screenshots at timeline"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'gcash-maya-account-recovery-first-hour'),
    'tip',
    11,
    $${
      "title":"Sample report message",
      "body":"Keep your report short, factual, and complete. Do not include OTP, MPIN, password, or full card details in normal chat.",
      "sample":"Hello. I need help securing my GCash/Maya account. I noticed possible unauthorized access or transactions on ____ at around ____. I have already changed / cannot change my MPIN or password. My SIM and email are secured / may be compromised. Please advise the official steps to block further access and review the transactions. I can provide screenshots, reference numbers, and a timeline through your secure support process."
    }$$::jsonb,
    $${
      "title":"Sample report message",
      "body":"Gawing maikli, factual, at kumpleto ang report. Huwag isama ang OTP, MPIN, password, o full card details sa normal chat.",
      "sample":"Hello. Kailangan ko pong i-secure ang GCash/Maya account ko. May napansin po akong possible unauthorized access o transactions noong ____ bandang ____. Napalitan ko na / hindi ko mapalitan ang MPIN o password. Secure na / posibleng compromised ang SIM at email ko. Paki-advise po ng official steps para ma-block ang further access at ma-review ang transactions. May screenshots, reference numbers, at timeline po ako na puwedeng ibigay sa secure support process ninyo."
    }$$::jsonb
  );
