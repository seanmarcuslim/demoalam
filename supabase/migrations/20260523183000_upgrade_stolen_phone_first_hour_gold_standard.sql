update public.guides
set
  title_en = 'First hour checklist when your phone is stolen',
  title_fil = 'First hour checklist kapag nanakaw ang phone',
  tagline_en = 'Freeze e-wallets, SIM access, email, banking apps, and logged-in devices before replacing the phone.',
  tagline_fil = 'I-freeze ang e-wallets, SIM access, email, banking apps, at logged-in devices bago palitan ang phone.',
  estimated_time = '15-60 minuto',
  estimated_cost = 'Depende sa SIM/device replacement',
  difficulty = 'mahirap',
  keywords_en = 'stolen phone lost phone lost sim gcash maya bank otp sim replacement imei ntc block account email password first hour emergency',
  keywords_fil = 'nanakaw phone nawala cellphone lost sim gcash maya bank otp sim replacement imei ntc block account email password unang oras emergency',
  official_sources = '[
    {"title":"Lost or stolen SIM, phone, or device","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/900006457043-Report-lost-or-stolen-GCash-registered-phone-or-SIM"},
    {"title":"Loss / Stolen Cellphone","publisher":"National Telecommunications Commission","url":"https://ntc.gov.ph/loss-stolen-cellphone/"},
    {"title":"How to register and unregister your phone to use GCash","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/36302878095385-I-want-to-use-GCash-on-another-phone-or-device"}
  ]'::jsonb,
  updated_at = now()
where slug = 'phone-stolen-first-hour';

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
    '{"title":"The first hour is about blocking access, not replacing the phone","body":"A stolen phone can expose OTPs, e-wallets, bank apps, email, social accounts, photos, contacts, and saved sessions. Your goal is to stop access first. Buying a replacement phone can wait until money apps, SIM, email, and logged-in devices are secured.","items":["Protect money apps first","Recover or block the SIM because OTPs go there","Secure email because it resets passwords","Remove logged-in devices when possible","Prepare IMEI and proof for telco or NTC follow-up"]}'::jsonb,
    '{"title":"Ang unang oras ay tungkol sa pag-block ng access, hindi pagpalit ng phone","body":"Kapag nanakaw ang phone, puwedeng ma-expose ang OTP, e-wallets, bank apps, email, social accounts, photos, contacts, at saved sessions. Ang goal mo muna ay pigilan ang access. Puwedeng mahuli ang pagbili ng replacement phone hanggang secured ang money apps, SIM, email, at logged-in devices.","items":["Unahin ang money apps","I-recover o i-block ang SIM dahil doon pumapasok ang OTP","I-secure ang email dahil ginagamit ito sa password reset","Tanggalin ang logged-in devices kung kaya","Ihanda ang IMEI at proof para sa telco o NTC follow-up"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'warning',
    2,
    '{"title":"START HERE: freeze money and OTP access first","body":"If you can borrow a trusted device, use it now. Do not wait until tomorrow. Freeze or report e-wallets and banking apps, protect the SIM or old number, and secure the email used for password resets.","severity":"high","items":["GCash/Maya and bank apps","SIM or old mobile number used for OTP","Primary email account","Facebook, Messenger, and other logged-in accounts","Any app with saved cards or wallet balance"]}'::jsonb,
    '{"title":"UNAHIN ITO: i-freeze muna ang pera at OTP access","body":"Kung makakahiram ka ng trusted device, gamitin mo na ngayon. Huwag nang hintayin bukas. I-freeze o i-report ang e-wallets at banking apps, protektahan ang SIM o old number, at i-secure ang email na ginagamit sa password reset.","severity":"high","items":["GCash/Maya at bank apps","SIM o old mobile number na ginagamit sa OTP","Primary email account","Facebook, Messenger, at ibang logged-in accounts","Anumang app na may saved cards o wallet balance"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'step',
    3,
    '{"title":"First 15 minutes: stop money movement","body":"Do the fastest blocks first. Use official apps, official help centers, or bank hotlines. Avoid random links from search results or comments.","step_number":1,"items":["Use a spare or trusted phone","Open GCash/Maya/bank official app or official support page","Report lost/stolen phone or SIM","Save ticket numbers, emails, or screenshots of official confirmation","If bank cards are linked, freeze cards or contact the bank"]}'::jsonb,
    '{"title":"Unang 15 minuto: pigilan muna ang galaw ng pera","body":"Unahin ang pinakamabilis na blocks. Gumamit ng official apps, official help centers, o bank hotlines. Iwasan ang random links mula sa search results o comments.","step_number":1,"items":["Gumamit ng spare o trusted phone","Buksan ang official app o official support page ng GCash/Maya/bank","I-report ang lost/stolen phone o SIM","I-save ang ticket numbers, emails, o screenshots ng official confirmation","Kung may linked bank cards, i-freeze ang cards o kontakin ang bank"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'step',
    4,
    '{"title":"15-30 minutes: protect the SIM and email","body":"Your old number may still receive OTPs. Ask your telco how to block the lost SIM and recover the number. At the same time, secure the email account used for password resets.","step_number":2,"items":["Call or visit your telco for lost SIM instructions","Prepare valid ID and affidavit of loss if required","List accounts using the lost number for OTP","Change primary email password from a clean device","Remove unknown logged-in devices from email and social accounts"]}'::jsonb,
    '{"title":"15-30 minuto: protektahan ang SIM at email","body":"Puwede pa ring makatanggap ng OTP ang old number mo. Itanong sa telco kung paano i-block ang lost SIM at ma-recover ang number. Kasabay nito, i-secure ang email na ginagamit sa password resets.","step_number":2,"items":["Tumawag o pumunta sa telco para sa lost SIM instructions","Maghanda ng valid ID at affidavit of loss kung kailangan","Ilista ang accounts na gumagamit ng lost number para sa OTP","Palitan ang primary email password gamit ang clean device","Tanggalin ang unknown logged-in devices sa email at social accounts"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'step',
    5,
    '{"title":"30-60 minutes: prepare reports and device proof","body":"After blocking access, prepare proof for telco, NTC, police report if needed, or insurance/warranty claims. IMEI is useful for device blocking follow-up.","step_number":3,"items":["IMEI from phone box, receipt, settings screenshot, or account record","Proof of ownership or purchase receipt if available","Affidavit of loss if required","Police blotter if needed for device, claim, or employer process","Ticket numbers from e-wallet, bank, telco, or email support"]}'::jsonb,
    '{"title":"30-60 minuto: ihanda ang reports at device proof","body":"Pagkatapos i-block ang access, ihanda ang proof para sa telco, NTC, police report kung kailangan, o insurance/warranty claims. Useful ang IMEI para sa device blocking follow-up.","step_number":3,"items":["IMEI mula sa phone box, resibo, settings screenshot, o account record","Proof of ownership o purchase receipt kung meron","Affidavit of loss kung kailangan","Police blotter kung kailangan sa device, claim, o employer process","Ticket numbers mula sa e-wallet, bank, telco, o email support"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'mistake',
    6,
    '{"title":"Common mistakes that make the damage worse","body":"Most losses become worse when people panic, post too much personal information, or trust fake recovery helpers.","items":["Buying a new phone before blocking accounts","Posting your full number, email, ID, or screenshots publicly","Clicking fake support links from comments or direct messages","Trusting someone who says they can recover funds for a fee","Forgetting that email access can reset many other accounts","Ignoring logged-in devices after changing passwords"]}'::jsonb,
    '{"title":"Karaniwang pagkakamali na nagpapalala ng damage","body":"Mas lumalala ang loss kapag nagpapanic, sobra ang pinopost na personal information, o nagtitiwala sa fake recovery helpers.","items":["Bumibili agad ng bagong phone bago i-block ang accounts","Pinopost publicly ang full number, email, ID, o screenshots","Nagki-click ng fake support links mula sa comments o direct messages","Nagtitiwala sa taong kaya raw i-recover ang funds kapalit ng fee","Nakakalimutang ang email access ay kayang mag-reset ng maraming accounts","Hindi tinatanggal ang logged-in devices pagkatapos magpalit ng passwords"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'warning',
    7,
    '{"title":"Watch for fake recovery helpers and OTP traps","body":"After you post or ask for help, scammers may pretend to be support staff, telco agents, or wallet recovery helpers. Real support should not ask for OTP, MPIN, password, or login codes through private chat.","severity":"high","items":["OTP, MPIN, password, or backup code request","Processing fee or recovery fee","Shortened links or unofficial forms","Someone asking you to screen-share your account","Pressure to act before you verify the official channel"]}'::jsonb,
    '{"title":"Mag-ingat sa fake recovery helpers at OTP traps","body":"Pagkatapos mong mag-post o humingi ng tulong, may scammers na magpapanggap na support staff, telco agent, o wallet recovery helper. Hindi dapat humingi ang real support ng OTP, MPIN, password, o login codes sa private chat.","severity":"high","items":["Hinihinging OTP, MPIN, password, o backup code","Processing fee o recovery fee","Shortened links o unofficial forms","May nagpapa-screen-share ng account","Pinapamadali kang kumilos bago mo ma-verify ang official channel"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'tip',
    8,
    '{"title":"Sample message to telco, bank, or e-wallet support","body":"Keep the message short and factual. Do not include OTPs, passwords, or unnecessary ID numbers unless the official channel specifically asks through a secure process.","sample":"My phone and SIM were stolen today. I need to block the SIM/account and secure OTP access. What exact steps and documents do you require? My reference number is ____."}'::jsonb,
    '{"title":"Sample message sa telco, bank, o e-wallet support","body":"Gawing maikli at factual ang message. Huwag ilagay ang OTP, password, o hindi kailangang ID numbers maliban kung hiningi mismo ng official channel sa secure process.","sample":"Nanakaw po ang phone at SIM ko today. Kailangan kong i-block ang SIM/account at i-secure ang OTP access. Ano pong exact steps at documents ang kailangan ninyo? Ang reference number ko ay ____."}'::jsonb
  );
