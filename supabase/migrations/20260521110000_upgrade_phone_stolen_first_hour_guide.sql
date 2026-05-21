update public.guides
set
  title_en = 'First hour checklist when your phone is stolen',
  title_fil = 'First hour checklist kapag nanakaw ang phone',
  tagline_en = 'Block e-wallets, SIM access, email, banking apps, and logged-in devices before replacing the phone.',
  tagline_fil = 'I-block ang e-wallets, SIM access, email, banking apps, at logged-in devices bago palitan ang phone.',
  keywords_en = 'stolen phone lost phone lost sim gcash block account sim replacement imei ntc otp banking email password',
  keywords_fil = 'nanakaw phone nawala cellphone lost sim gcash block account sim replacement imei ntc otp bank email password',
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
    '{"title":"The first hour is about blocking access","body":"Do not focus on buying a new phone first. Secure the SIM, e-wallets, banking apps, email, and social accounts before someone uses OTPs or saved sessions."}'::jsonb,
    '{"title":"Ang unang oras ay tungkol sa pag-block ng access","body":"Huwag unahin ang pagbili ng bagong phone. I-secure muna ang SIM, e-wallets, banking apps, email, at social accounts bago may gumamit ng OTP o saved sessions."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'warning',
    2,
    '{"title":"Lock money apps first","body":"Use another device to lock e-wallets, banking apps, email, and social accounts as soon as possible.","severity":"high"}'::jsonb,
    '{"title":"I-lock muna ang money apps","body":"Gumamit ng ibang device para i-lock ang e-wallets, banking apps, email, at social accounts sa lalong madaling panahon.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'step',
    3,
    '{"title":"Block or secure your e-wallet immediately","body":"For GCash, use another phone with the GCash app, go to Help Center on the login screen, choose Lost SIM/Phone, and follow the steps to block the account. Do this before trying to recover funds.","step_number":1,"items":["Use a spare or trusted phone","Open the GCash app, not a random browser link","Use Help Center from the login screen","Choose Lost SIM/Phone","Save the ticket or email update"]}'::jsonb,
    '{"title":"I-block o i-secure agad ang e-wallet","body":"Para sa GCash, gumamit ng ibang phone na may GCash app, pumunta sa Help Center sa login screen, piliin ang Lost SIM/Phone, at sundin ang steps para ma-block ang account. Gawin ito bago mag-recover ng funds.","step_number":1,"items":["Gumamit ng spare o trusted phone","Buksan ang GCash app, hindi random browser link","Gamitin ang Help Center sa login screen","Piliin ang Lost SIM/Phone","I-save ang ticket o email update"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'step',
    4,
    '{"title":"Call your telco or visit a store for SIM replacement","body":"Ask how to block the lost SIM and replace it. Bring ID and prepare an affidavit of loss if your provider requires it. Recovering the old number is usually safer than moving accounts one by one.","step_number":2,"items":["Valid government ID","Affidavit of loss if required","Old mobile number","SIM card holder or proof if available","List of accounts using that number for OTP"]}'::jsonb,
    '{"title":"Tumawag sa telco o pumunta sa store para sa SIM replacement","body":"Itanong kung paano i-block ang lost SIM at palitan ito. Magdala ng ID at maghanda ng affidavit of loss kung kailangan ng provider. Mas safe kadalasan ang ma-recover ang old number kaysa ilipat isa-isa ang accounts.","step_number":2,"items":["Valid government ID","Affidavit of loss kung kailangan","Old mobile number","SIM card holder o proof kung meron","Listahan ng accounts na gumagamit ng number para sa OTP"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'step',
    5,
    '{"title":"Change passwords from a clean device","body":"Use a trusted phone or computer to change passwords for email, banking, e-wallets, Facebook, Messenger, and other accounts. Start with the email used for password resets.","step_number":3,"items":["Primary email password","E-wallet and bank app passwords or PINs","Facebook, Messenger, and social accounts","Remove unknown logged-in devices","Turn on 2-step verification where possible"]}'::jsonb,
    '{"title":"Palitan ang passwords gamit ang malinis na device","body":"Gumamit ng trusted phone o computer para palitan ang passwords ng email, banking, e-wallets, Facebook, Messenger, at ibang accounts. Unahin ang email na ginagamit sa password reset.","step_number":3,"items":["Primary email password","E-wallet at bank app passwords o PINs","Facebook, Messenger, at social accounts","Tanggalin ang unknown logged-in devices","I-on ang 2-step verification kung pwede"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'tip',
    6,
    '{"title":"Prepare the IMEI before asking NTC or telco for blocking","body":"NTC lost/stolen cellphone guidance asks for proof details such as IMEI. Look for it on the phone box, receipt, account device record, or screenshots you saved earlier.","sample":"My phone was stolen. I need to block the SIM and ask about IMEI blocking. What exact documents do you need from me?"}'::jsonb,
    '{"title":"Ihanda ang IMEI bago magtanong sa NTC o telco tungkol sa blocking","body":"Sa NTC lost/stolen cellphone guidance, kailangan ang proof details tulad ng IMEI. Hanapin ito sa phone box, resibo, account device record, o screenshots na na-save mo dati.","sample":"Nanakaw po ang phone ko. Kailangan kong i-block ang SIM at magtanong tungkol sa IMEI blocking. Anong exact documents po ang kailangan ninyo sa akin?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'phone-stolen-first-hour'),
    'mistake',
    7,
    '{"title":"Posting your number publicly to ask for help","body":"Do not post your lost number, OTP screenshots, email, or account details publicly. Message official support channels directly and keep ticket numbers private."}'::jsonb,
    '{"title":"Pinopost publicly ang number para humingi ng tulong","body":"Huwag i-post publicly ang lost number, OTP screenshots, email, o account details. Dumiretso sa official support channels at itago ang ticket numbers."}'::jsonb
  );
