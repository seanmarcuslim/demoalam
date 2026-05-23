update public.guides
set
  slug = 'national-id-problems-checklist',
  title_en = 'National ID problems checklist',
  title_fil = 'National ID problems checklist',
  tagline_en = 'Know what to do if your PhilID is delayed, your TRN is missing, or your ePhilID/Digital National ID is not accepted.',
  tagline_fil = 'Alamin ang gagawin kapag delayed ang PhilID, nawawala ang TRN, o hindi tinatanggap ang ePhilID/Digital National ID.',
  read_time_min = 7,
  estimated_time = '15-60 minuto',
  estimated_cost = 'Libre maliban sa printing, pamasahe, o affidavit kung kailangan',
  difficulty = 'katamtaman',
  is_featured = true,
  is_urgent = false,
  tags = array['national id', 'philsys', 'philid', 'ephilid', 'digital national id', 'trn', 'valid id', 'psa', 'identity'],
  keywords_en = 'national id philsys philid ephilid digital national id trn transaction reference number delayed delivery not found tracker not accepted valid id psa registration slip lost transaction slip phlpost verify',
  keywords_fil = 'national id philsys philid ephilid digital national id trn transaction reference number delayed delivery hindi makita tracker hindi tinatanggap valid id psa registration slip nawawalang transaction slip phlpost verify',
  official_sources = $$[
    {"title":"Frequently Asked Questions","publisher":"Philippine Identification System","url":"https://philsys.gov.ph/faq-frequently-asked-questions/"},
    {"title":"Public Advisory: Tracking of the National ID and Required Information for Concerns","publisher":"Philippine Identification System","url":"https://philsys.gov.ph/wp-content/uploads/2024/05/Public-Advisory-Tracking-of-the-National-ID-and-the-Required-Information-for-Processing-of-Concerns.pdf"},
    {"title":"National ID as a reliable, easy-to-authenticate valid ID","publisher":"Philippine Identification System","url":"https://philsys.gov.ph/national-id-a-reliable-easy-to-authenticate-valid-id-for-filipinos-government-and-private-institutions/"},
    {"title":"National ID delivery tracking","publisher":"PHLPost","url":"https://tracking.phlpost.gov.ph/"}
  ]$$::jsonb,
  updated_at = now()
where slug in ('fast-valid-id', 'national-id-problems-checklist');

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'national-id-problems-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'national-id-problems-checklist'),
    'what_to_know',
    1,
    $${
      "title":"National ID problems usually need the right route, not a fixer",
      "body":"Many people panic when the physical PhilID is delayed, the tracker says not found, the transaction slip is missing, or an office refuses the ePhilID. Start by identifying the exact problem. The answer is different for delivery tracking, ePhilID availability, Digital National ID access, lost TRN, data correction, or non-acceptance.",
      "items":["The physical card may take time, but ePhilID or Digital National ID may help while waiting","Your Transaction Reference Number or TRN is important for tracking and some concerns","Not found in tracking does not always mean your registration failed","Some concerns should go through PhilSys/PSA official channels, not random online helpers","Never pay someone promising faster release, correction, or guaranteed approval"]
    }$$::jsonb,
    $${
      "title":"Sa National ID problems, tamang route ang kailangan, hindi fixer",
      "body":"Maraming nagpapanic kapag delayed ang physical PhilID, not found sa tracker, nawawala ang transaction slip, o ayaw tanggapin ang ePhilID. Unahin munang alamin ang exact problem. Magkaiba ang sagot sa delivery tracking, ePhilID availability, Digital National ID access, lost TRN, data correction, at non-acceptance.",
      "items":["Puwedeng matagalan ang physical card, pero makakatulong ang ePhilID o Digital National ID habang naghihintay","Mahalaga ang Transaction Reference Number o TRN sa tracking at ilang concern","Hindi laging ibig sabihin ng not found sa tracking ay failed ang registration","May concerns na dapat idaan sa PhilSys/PSA official channels, hindi sa random online helpers","Huwag magbayad sa nangangakong mapapabilis ang release, correction, o approval"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'national-id-problems-checklist'),
    'warning',
    2,
    $${
      "title":"START HERE: do not post your TRN, QR code, full ID details, or birthdate online",
      "body":"When asking for help, protect your identity details. Your National ID concern is about identity, so oversharing can create identity misuse risk.",
      "severity":"high",
      "items":["Do not post your full TRN or registration slip publicly","Do not upload clear photos of your PhilID, ePhilID, QR code, or Digital National ID","Do not send birthdate, address, full name, and ID details to private-message helpers","Do not pay processing fees to unofficial pages or fixers","Use official PhilSys, PSA, PHLPost, or office channels only"]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: huwag i-post online ang TRN, QR code, full ID details, o birthdate",
      "body":"Kapag humihingi ng tulong, protektahan ang identity details mo. Identity concern ang National ID, kaya delikado kapag sobra ang personal information na nilalabas.",
      "severity":"high",
      "items":["Huwag i-post publicly ang full TRN o registration slip","Huwag mag-upload ng malinaw na photo ng PhilID, ePhilID, QR code, o Digital National ID","Huwag magpadala ng birthdate, address, full name, at ID details sa private-message helpers","Huwag magbayad ng processing fee sa unofficial pages o fixers","Official PhilSys, PSA, PHLPost, o office channels lang ang gamitin"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'national-id-problems-checklist'),
    'step',
    3,
    $${
      "title":"Identify your exact National ID problem first",
      "body":"Do not travel immediately. First classify the problem so you know which proof, channel, or office you need.",
      "step_number":1,
      "items":["Physical PhilID has not arrived","PHLPost tracking says not found or no movement","You lost your transaction slip or TRN","You need ePhilID or Digital National ID while waiting","An office, bank, school, or service refuses to accept ePhilID or Digital National ID","Your information has an error or needs updating"]
    }$$::jsonb,
    $${
      "title":"Alamin muna ang exact National ID problem mo",
      "body":"Huwag agad bumiyahe. I-classify muna ang problema para alam mo kung anong proof, channel, o office ang kailangan.",
      "step_number":1,
      "items":["Hindi pa dumadating ang physical PhilID","Not found o walang galaw sa PHLPost tracking","Nawala ang transaction slip o TRN","Kailangan mo ng ePhilID o Digital National ID habang naghihintay","Ayaw tanggapin ng office, bank, school, o service ang ePhilID o Digital National ID","May mali sa information o kailangan itong i-update"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'national-id-problems-checklist'),
    'step',
    4,
    $${
      "title":"If the physical card is delayed, check tracking and alternatives",
      "body":"Use your TRN to check delivery status through the official tracking route. If the physical card is not available yet, check whether ePhilID or Digital National ID can help for your transaction.",
      "step_number":2,
      "items":["Prepare your transaction slip or TRN","Check official PHLPost tracking for delivery status","If tracking is not found, wait and recheck later before assuming registration failed","Ask PhilSys/PSA official channels about ePhilID or Digital National ID options","For urgent transactions, ask the receiving office if ePhilID or Digital National ID is accepted"]
    }$$::jsonb,
    $${
      "title":"Kung delayed ang physical card, i-check ang tracking at alternatives",
      "body":"Gamitin ang TRN para i-check ang delivery status sa official tracking route. Kung wala pa ang physical card, alamin kung puwedeng makatulong ang ePhilID o Digital National ID sa transaction mo.",
      "step_number":2,
      "items":["Ihanda ang transaction slip o TRN","I-check ang official PHLPost tracking para sa delivery status","Kung not found sa tracking, mag-recheck muna later bago isipin na failed ang registration","Magtanong sa official PhilSys/PSA channels tungkol sa ePhilID o Digital National ID options","Kung urgent ang transaction, itanong sa receiving office kung tinatanggap ang ePhilID o Digital National ID"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'national-id-problems-checklist'),
    'step',
    5,
    $${
      "title":"If your TRN or transaction slip is missing",
      "body":"Do not guess your TRN or ask random pages to find it. Prepare identity details and contact official PhilSys channels or visit a registration center for guidance.",
      "step_number":3,
      "items":["List where and when you registered, if remembered","Prepare full name, birthdate, sex, and registration center details for official verification","Use official PhilSys contact channels only","Bring available IDs or proof if visiting a registration center","Do not send your full identity details to unofficial Facebook pages or private helpers"]
    }$$::jsonb,
    $${
      "title":"Kung nawawala ang TRN o transaction slip",
      "body":"Huwag manghula ng TRN o magpatulong sa random pages para hanapin ito. Ihanda ang identity details at official PhilSys channels o registration center ang lapitan.",
      "step_number":3,
      "items":["Ilista kung saan at kailan ka nag-register kung naaalala","Ihanda ang full name, birthdate, sex, at registration center details para sa official verification","Official PhilSys contact channels lang ang gamitin","Magdala ng available IDs o proof kung pupunta sa registration center","Huwag ipadala ang full identity details sa unofficial Facebook pages o private helpers"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'national-id-problems-checklist'),
    'step',
    6,
    $${
      "title":"If ePhilID or Digital National ID is not accepted",
      "body":"Stay calm and ask for the exact reason in writing or through the official customer service channel. Do not argue with frontliners. Ask whether they can verify the QR code or check their updated ID acceptance policy.",
      "step_number":4,
      "items":["Ask: What exact policy says this is not accepted?","Ask if they can verify the QR code using the official verification route","Ask for a supervisor or official customer service channel calmly","Record the branch, date, transaction type, and reason given","Report repeated refusal through official PhilSys/PSA channels when appropriate"]
    }$$::jsonb,
    $${
      "title":"Kung hindi tinatanggap ang ePhilID o Digital National ID",
      "body":"Kumalma at itanong ang exact reason, preferably in writing o sa official customer service channel. Huwag makipag-away sa frontliners. Itanong kung kaya nilang i-verify ang QR code o i-check ang updated ID acceptance policy nila.",
      "step_number":4,
      "items":["Itanong: Anong exact policy ang nagsasabing hindi ito accepted?","Itanong kung kaya nilang i-verify ang QR code gamit ang official verification route","Humingi ng supervisor o official customer service channel nang mahinahon","I-record ang branch, date, transaction type, at reason na sinabi","I-report sa official PhilSys/PSA channels kung paulit-ulit na refusal at appropriate"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'national-id-problems-checklist'),
    'mistake',
    7,
    $${
      "title":"Common mistakes with National ID problems",
      "body":"Most problems get worse when people expose personal information or pay unofficial helpers.",
      "items":["Posting the full transaction slip online","Sending ID photos to strangers who say they can track or release it faster","Assuming not found in tracking means registration failed","Printing or editing fake-looking versions instead of using official ePhilID/Digital National ID routes","Arguing with frontliners without asking for the exact policy or escalation channel","Paying for a faster National ID release"]
    }$$::jsonb,
    $${
      "title":"Karaniwang pagkakamali sa National ID problems",
      "body":"Mas lumalala ang problema kapag nilalabas ang personal information o nagbabayad sa unofficial helpers.",
      "items":["Pinopost ang buong transaction slip online","Nagpapadala ng ID photos sa strangers na kaya raw i-track o pabilisin ang release","Iniisip agad na failed ang registration kapag not found sa tracking","Gumagawa o nag-eedit ng fake-looking versions imbes na official ePhilID/Digital National ID routes","Nakikipag-away sa frontliners nang hindi hinihingi ang exact policy o escalation channel","Nagbabayad para raw mapabilis ang National ID release"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'national-id-problems-checklist'),
    'warning',
    8,
    $${
      "title":"Watch for fake National ID assistance pages",
      "body":"Scammers may use National ID delays to collect personal data or money. They may promise faster release, replacement, correction, or tracking if you send ID photos or pay a fee.",
      "severity":"high",
      "items":["Claims of guaranteed fast release","Requests for full TRN, birthdate, address, selfie, or ID photo through private chat","Payment request for tracking, correction, release, or appointment","Unofficial shortened links or copied government logos","Pressure to act before checking official PhilSys or PSA channels"]
    }$$::jsonb,
    $${
      "title":"Mag-ingat sa fake National ID assistance pages",
      "body":"Ginagamit ng scammers ang delay ng National ID para mangolekta ng personal data o pera. Puwede silang mangako ng faster release, replacement, correction, o tracking kapalit ng ID photos o bayad.",
      "severity":"high",
      "items":["Guaranteed fast release daw","Hinihingi ang full TRN, birthdate, address, selfie, o ID photo sa private chat","May bayad daw para sa tracking, correction, release, o appointment","Unofficial shortened links o kinopyang government logos","Pinapamadali kang kumilos bago mag-check sa official PhilSys o PSA channels"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'national-id-problems-checklist'),
    'tip',
    9,
    $${
      "title":"Checklist before contacting PhilSys, PSA, PHLPost, or an office",
      "body":"Prepare only what is needed and avoid oversharing in public channels.",
      "items":["Transaction slip or TRN, if available","Date and place of registration, if remembered","Screenshots of official tracker result, with sensitive details covered if sharing publicly","Valid contact number and email you can access","Branch, office, or company name if reporting non-acceptance","Exact question you need answered before traveling"]
    }$$::jsonb,
    $${
      "title":"Checklist bago mag-contact sa PhilSys, PSA, PHLPost, o office",
      "body":"Ihanda lang ang kailangan at iwasan ang oversharing sa public channels.",
      "items":["Transaction slip o TRN kung available","Date at lugar ng registration kung naaalala","Screenshots ng official tracker result, pero takpan ang sensitive details kung public sharing","Valid contact number at email na naa-access mo","Branch, office, o company name kung magre-report ng non-acceptance","Exact question na kailangan mong masagot bago bumiyahe"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'national-id-problems-checklist'),
    'tip',
    10,
    $${
      "title":"Sample message for National ID concerns",
      "body":"Keep the message specific. Do not include full ID photos, OTPs, passwords, or unnecessary personal data in normal chat.",
      "sample":"I registered for PhilSys on ____ at ____. My concern is: delayed physical PhilID / missing TRN / ePhilID not accepted / tracker not found. What official steps should I follow, what documents are required, and which official channel should I use for follow-up?"
    }$$::jsonb,
    $${
      "title":"Sample message para sa National ID concerns",
      "body":"Gawing specific ang message. Huwag magpadala ng full ID photos, OTP, password, o hindi kailangang personal data sa normal chat.",
      "sample":"Nag-register po ako sa PhilSys noong ____ sa ____. Ang concern ko po ay: delayed physical PhilID / nawawalang TRN / hindi tinanggap ang ePhilID / not found sa tracker. Ano po ang official steps, anong documents ang kailangan, at aling official channel ang dapat gamitin sa follow-up?"
    }$$::jsonb
  );
