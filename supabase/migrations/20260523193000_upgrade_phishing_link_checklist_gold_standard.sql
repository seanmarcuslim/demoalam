update public.guides
set
  title_en = 'Phishing link checklist before entering OTPs',
  title_fil = 'Phishing link checklist bago maglagay ng OTP',
  tagline_en = 'Pause, verify the link, and protect your account before entering OTP, MPIN, password, or ID details.',
  tagline_fil = 'Huminto muna, i-verify ang link, at protektahan ang account bago maglagay ng OTP, MPIN, password, o ID details.',
  read_time_min = 6,
  estimated_time = '5-30 minuto',
  estimated_cost = 'Libre',
  difficulty = 'madali',
  is_urgent = true,
  tags = array['phishing', 'scam', 'link', 'otp', 'password', 'mpin', 'fake login', 'smishing', 'vishing', 'online safety', 'gcash', 'maya', 'bank'],
  keywords_en = 'phishing scam link otp password mpin pin fake login smishing vishing online safety gcash maya bank account takeover suspicious message text sms email fake support device registration unauthorized transaction',
  keywords_fil = 'phishing scam link otp password mpin pin fake login smishing vishing online safety gcash maya bank account takeover kahina hinalang message text sms email fake support device registration unauthorized transaction',
  official_sources = '[
    {"title":"Threats to Security and Privacy","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/threats-security-privacy/"},
    {"title":"Preventive Data Privacy Practices Against Smishing","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/npc-phe-bulletin-no-21-preventive-data-privacy-practices-against-smishing/"},
    {"title":"How can I protect my GCash account?","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/19578518834457-How-can-I-protect-my-GCash-account"},
    {"title":"Report a scam","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/4413295284377-I-think-I-was-scammed-What-do-I-do"},
    {"title":"Report unauthorized transactions in my GCash account","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/4416637093145-Report-unauthorized-transactions-in-my-GCash-account"}
  ]'::jsonb,
  updated_at = now()
where slug = 'phishing-link-checklist';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'phishing-link-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'what_to_know',
    1,
    '{"title":"Phishing is designed to rush you","body":"Phishing messages copy banks, e-wallets, delivery companies, job recruiters, government pages, or support agents. The goal is to make you enter OTP, MPIN, password, card details, or ID information on a fake page before you can think clearly.","items":["The page may look professional and still be fake","A real brand name inside a link does not make it official","OTP, MPIN, and password are account keys, not verification codes for strangers","Pressure, prizes, threats, and account-lock warnings are common tactics","The safest route is opening the official app or website yourself"]}'::jsonb,
    '{"title":"Ginagawa ang phishing para mapamadali ka","body":"Ginagaya ng phishing messages ang banks, e-wallets, delivery companies, job recruiters, government pages, o support agents. Ang goal ay mailagay mo ang OTP, MPIN, password, card details, o ID information sa fake page bago ka makapag-isip nang malinaw.","items":["Puwedeng professional tingnan ang page pero fake pa rin","Hindi official ang link dahil may brand name lang sa loob","Ang OTP, MPIN, at password ay susi ng account, hindi verification code para sa strangers","Common tactic ang pressure, prizes, threats, at account-lock warnings","Pinaka-safe ang ikaw mismo ang magbukas ng official app o website"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'warning',
    2,
    '{"title":"START HERE: do not enter OTP, MPIN, or password from a sent link","body":"If the link came from SMS, chat, email, comment, ad, or a stranger, stop. Do not type anything yet. Open the official app or official website yourself and check if the same issue appears there.","severity":"high","items":["Do not enter OTP, MPIN, password, card number, or CVV","Do not upload ID or selfie with ID through an unknown link","Do not reply with screenshots of account pages","Do not screen-share with someone claiming to help","Do not pay a recovery, verification, or processing fee"]}'::jsonb,
    '{"title":"UNAHIN ITO: huwag maglagay ng OTP, MPIN, o password mula sa pinadalang link","body":"Kung ang link ay galing sa SMS, chat, email, comment, ad, o stranger, huminto. Huwag munang mag-type ng kahit ano. Buksan mo mismo ang official app o official website at tingnan kung nandoon din ang parehong issue.","severity":"high","items":["Huwag maglagay ng OTP, MPIN, password, card number, o CVV","Huwag mag-upload ng ID o selfie with ID sa unknown link","Huwag mag-reply ng screenshots ng account pages","Huwag mag-screen-share sa taong nagkukunwaring tutulong","Huwag magbayad ng recovery, verification, o processing fee"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'step',
    3,
    '{"title":"First 30 seconds: check why you are being rushed","body":"Most phishing works because the message makes you panic or feel lucky. Before tapping, identify the pressure tactic.","step_number":1,"items":["Threat: your account will close or be blocked","Prize: you won money, ayuda, job, refund, or discount","Problem: failed delivery, suspicious login, unpaid fee, or verification issue","Secrecy: do not tell anyone or reply only to this agent","Speed: act now, limited time, or final warning"]}'::jsonb,
    '{"title":"Unang 30 segundo: i-check kung bakit ka minamadali","body":"Madalas gumagana ang phishing dahil pinapapanic ka o pinaparamdam na swerte ka. Bago mag-tap, alamin muna ang pressure tactic.","step_number":1,"items":["Threat: ma-close o ma-block daw ang account","Prize: nanalo raw ng pera, ayuda, trabaho, refund, o discount","Problem: failed delivery, suspicious login, unpaid fee, o verification issue","Secrecy: huwag sabihin sa iba o dito lang daw mag-reply","Speed: act now, limited time, o final warning"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'step',
    4,
    '{"title":"Inspect the link without trusting the design","body":"A fake page can copy logos, colors, and customer support language. Judge the link source and domain, not the design.","step_number":2,"items":["Misspelled brand names or extra words around the brand","Shortened links that hide the destination","Random numbers, symbols, or strange subdomains","HTTP on pages asking for login or payment details","Link came from comments, DMs, group chats, or sponsored ads"]}'::jsonb,
    '{"title":"Suriin ang link, huwag ang design ang pagkatiwalaan","body":"Kayang kopyahin ng fake page ang logos, colors, at customer support language. Ang i-check ay saan galing ang link at ano ang domain, hindi ang ganda ng design.","step_number":2,"items":["Maling spelling ng brand o may dagdag na words sa paligid ng brand","Shortened links na tinatago ang destination","Random numbers, symbols, o kakaibang subdomains","HTTP sa page na humihingi ng login o payment details","Link galing sa comments, DMs, group chats, o sponsored ads"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'step',
    5,
    '{"title":"Use the safe route instead","body":"If the message might be real, verify through a route you control. Do not let the suspicious message choose the website for you.","step_number":3,"items":["Open the official app directly","Type the official website yourself","Use the Help Center inside the official app","Search for official support only from the company website or app","If still unsure, ask support: Is this message/link from you?"]}'::jsonb,
    '{"title":"Gamitin ang safe route imbes na link","body":"Kung posibleng totoo ang message, i-verify gamit ang route na ikaw ang may control. Huwag hayaang ang suspicious message ang pumili ng website para sa iyo.","step_number":3,"items":["Buksan mismo ang official app","I-type mismo ang official website","Gamitin ang Help Center sa loob ng official app","Hanapin ang official support mula lang sa company website o app","Kung hindi sigurado, itanong sa support: Sa inyo po ba galing itong message/link?"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'step',
    6,
    '{"title":"If you already clicked but did not enter details","body":"Clicking alone is not always the same as losing the account, but treat it seriously. Close the page and secure the device if anything downloaded.","step_number":4,"items":["Close the page immediately","Do not allow notifications, installs, permissions, or profile downloads","Clear suspicious downloads if any","Run device security checks if your phone has them","Watch for new messages, logins, or unauthorized transactions"]}'::jsonb,
    '{"title":"Kung na-click mo na pero wala ka pang nilagay","body":"Hindi laging ibig sabihin ng pag-click ay nawala na ang account, pero seryosohin pa rin. Isara ang page at i-secure ang device kung may na-download.","step_number":4,"items":["Isara agad ang page","Huwag payagan ang notifications, installs, permissions, o profile downloads","Burahin ang suspicious downloads kung meron","Mag-run ng device security checks kung meron ang phone","Bantayan ang new messages, logins, o unauthorized transactions"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'step',
    7,
    '{"title":"If you entered OTP, MPIN, password, or card details","body":"Act like the account may be exposed. Secure access first, then report through official channels. Do not argue with the scammer or wait for them to reply.","step_number":5,"items":["Change password or MPIN from the official app or website","Log out other devices if available","Freeze cards or account access if money is involved","Report unauthorized transactions immediately through official support","Save screenshots, links, sender details, timestamps, and ticket numbers"]}'::jsonb,
    '{"title":"Kung nakapaglagay ka ng OTP, MPIN, password, o card details","body":"Ituring na exposed ang account. I-secure muna ang access, pagkatapos mag-report sa official channels. Huwag makipagtalo sa scammer o maghintay ng reply nila.","step_number":5,"items":["Palitan ang password o MPIN gamit ang official app o website","I-log out ang ibang devices kung available","I-freeze ang cards o account access kung may pera involved","I-report agad ang unauthorized transactions sa official support","I-save ang screenshots, links, sender details, timestamps, at ticket numbers"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'mistake',
    8,
    '{"title":"Common mistakes that help scammers","body":"These mistakes usually happen because the victim is scared, embarrassed, or rushed. Slow down and use official channels only.","items":["Trusting the page because the logo and colors look real","Entering OTP because the page says it is only for verification","Sending screenshots that show account, card, or personal details","Asking help from random comments or private messages","Paying a recovery fee to someone claiming to be support","Deleting evidence before reporting"]}'::jsonb,
    '{"title":"Karaniwang pagkakamali na nakakatulong sa scammers","body":"Nangyayari ito dahil takot, nahihiya, o minamadali ang biktima. Huminto muna at official channels lang ang gamitin.","items":["Nagtitiwala dahil mukhang real ang logo at colors","Naglalagay ng OTP dahil verification lang daw","Nagpapadala ng screenshots na may account, card, o personal details","Humihingi ng tulong sa random comments o private messages","Nagbabayad ng recovery fee sa nagkukunwaring support","Binubura ang ebidensya bago mag-report"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'warning',
    9,
    '{"title":"Scammers may contact you again after the first attempt","body":"Once you reply or enter details, scammers may pretend to be recovery agents, investigators, bank staff, e-wallet support, or government helpers. Official support will not ask for OTP, MPIN, password, or remote access through private chat.","severity":"high","items":["Recovery fee or processing fee","OTP, MPIN, password, backup code, or screen-sharing request","Another link to verify the first scam","Threats that your account will be permanently closed","Instructions to hide the conversation from family or bank staff"]}'::jsonb,
    '{"title":"Puwede ka pang kontakin ulit ng scammers pagkatapos ng unang attempt","body":"Kapag nag-reply ka o nakapaglagay ng details, puwedeng magpanggap silang recovery agents, investigators, bank staff, e-wallet support, o government helpers. Hindi dapat humingi ang official support ng OTP, MPIN, password, o remote access sa private chat.","severity":"high","items":["Recovery fee o processing fee","Hingi ng OTP, MPIN, password, backup code, o screen-sharing","Panibagong link para i-verify ang unang scam","Threat na permanenteng ma-close ang account","Instruction na itago ang usapan sa pamilya o bank staff"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'tip',
    10,
    '{"title":"Use this 10-second question","body":"Ask this before entering anything on a page.","sample":"Did I open this page myself from the official app or website, or did someone bring me here through SMS, chat, email, comment, ad, or a shortened link?"}'::jsonb,
    '{"title":"Gamitin itong 10-second question","body":"Itanong ito bago maglagay ng kahit anong details sa page.","sample":"Ako ba mismo ang nagbukas ng page mula sa official app o website, o may nagdala sa akin dito gamit ang SMS, chat, email, comment, ad, o shortened link?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phishing-link-checklist'),
    'tip',
    11,
    '{"title":"Sample report message","body":"Keep your report factual. Do not include OTP, MPIN, password, or full card details in normal chat.","sample":"I received a suspicious link claiming to be from ____ on ____ at ____. I clicked / did not click it. I entered / did not enter details. Please confirm if this is official and advise how to secure my account. I can provide screenshots and transaction reference numbers through your official secure process."}'::jsonb,
    '{"title":"Sample report message","body":"Gawing factual ang report. Huwag ilagay ang OTP, MPIN, password, o full card details sa normal chat.","sample":"Nakatanggap po ako ng suspicious link na nagpapanggap na galing sa ____ noong ____ at ____. Na-click ko / hindi ko na-click. Nakapaglagay ako / hindi ako nakapaglagay ng details. Paki-confirm po kung official ito at ano ang steps para ma-secure ang account ko. May screenshots at transaction reference numbers po ako na puwedeng ibigay sa official secure process ninyo."}'::jsonb
  );
