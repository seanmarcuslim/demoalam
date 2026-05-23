update public.guides
set
  title_en = 'Lost wallet first steps',
  title_fil = 'Unang gagawin kapag nawala ang wallet',
  tagline_en = 'Freeze cards and protect IDs before replacing everything.',
  tagline_fil = 'I-freeze muna ang cards at protektahan ang IDs bago palitan lahat.',
  read_time_min = 7,
  estimated_time = '30-90 minuto',
  estimated_cost = 'Depende sa affidavit at replacement',
  difficulty = 'katamtaman',
  is_urgent = true,
  keywords_en = 'lost wallet stolen wallet missing wallet atm card credit card debit card id valid id affidavit of loss driver license national id philid bank gcash maya sim otp',
  keywords_fil = 'nawala wallet nanakaw wallet nawawalang wallet atm card credit card debit card id valid id affidavit of loss driver license national id philid bank gcash maya sim otp',
  official_sources = '[
    {"title":"BSP common scams and fraud guidance","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/SitePages/FinancialStability/BSPVerifier.aspx"},
    {"title":"LTO Citizens Charter - Duplicate Driver''s License / Student Permit","publisher":"Land Transportation Office","url":"https://lto.gov.ph/wp-content/uploads/2023/09/LTO-CITIZENS-CHARTER_2023_0905.pdf"},
    {"title":"PhilSys Frequently Asked Questions","publisher":"Philippine Identification System","url":"https://philsys.gov.ph/faq/"}
  ]'::jsonb,
  updated_at = now()
where slug = 'lost-wallet-first-steps';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'lost-wallet-first-steps'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'lost-wallet-first-steps'),
    'what_to_know',
    1,
    '{"title":"A lost wallet is not just lost cash","body":"Losing a wallet can affect money access, IDs, transportation, work or school entry, and time. Do not try to replace every item immediately. First protect anything that can be used for payments, withdrawals, identity misuse, or OTP/account recovery.","items":["Money and cards are usually most urgent","SIM and phone number matter if cards or e-wallets use OTP","Some IDs are more urgent than others","Transport money and proof of identity can become immediate problems","Affidavit of loss may be needed for some replacements"]}'::jsonb,
    '{"title":"Hindi lang cash ang nawawala kapag nawala ang wallet","body":"Kapag nawala ang wallet, apektado ang access sa pera, IDs, pamasahe, work o school entry, at oras. Huwag agad palitan lahat. Unahin ang anumang puwedeng gamitin sa payments, withdrawals, identity misuse, o OTP/account recovery.","items":["Pera at cards ang kadalasang pinaka-urgent","Mahalaga ang SIM at phone number kung cards o e-wallets ay gumagamit ng OTP","May IDs na mas urgent kaysa iba","Puwedeng maging immediate problem ang pamasahe at proof of identity","Maaaring kailanganin ang affidavit of loss sa ilang replacement"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-wallet-first-steps'),
    'warning',
    2,
    '{"title":"START HERE: freeze cards before replacing IDs","body":"If ATM, debit, credit, or prepaid cards were inside the wallet, contact your bank or app first. Check recent transactions and freeze or block cards where possible before traveling to replace IDs.","severity":"high","items":["Check recent bank, card, and e-wallet transactions","Freeze or block ATM, debit, credit, or prepaid cards","Change app PINs if card details were saved in apps","Save reference numbers from bank support","Keep a simple list of missing cards and IDs"]}'::jsonb,
    '{"title":"UNAHIN ITO: i-freeze muna ang cards bago magpalit ng IDs","body":"Kung may ATM, debit, credit, o prepaid cards sa wallet, unahin ang bank o app. I-check ang recent transactions at i-freeze o i-block ang cards kung kaya bago bumiyahe para magpalit ng IDs.","severity":"high","items":["I-check ang recent bank, card, at e-wallet transactions","I-freeze o i-block ang ATM, debit, credit, o prepaid cards","Palitan ang app PINs kung may saved card details sa apps","I-save ang reference numbers mula sa bank support","Gumawa ng simpleng listahan ng nawawalang cards at IDs"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-wallet-first-steps'),
    'step',
    3,
    '{"title":"First 30 minutes: secure money and account access","body":"Stay still for a few minutes and list what was inside. Then protect anything connected to money. This avoids wasting time replacing low-priority items while someone may still use your cards.","step_number":1,"items":["Look at bank, card, and e-wallet transaction history","Block cards through official app, hotline, or branch channel","If your phone/SIM is also missing, treat OTP recovery as urgent","Message a trusted person if you need emergency fare or a backup ID photo","Write down support reference numbers"]}'::jsonb,
    '{"title":"Unang 30 minuto: i-secure ang pera at account access","body":"Huminto muna ng ilang minuto at ilista kung ano ang laman. Pagkatapos, protektahan ang konektado sa pera. Maiiwasan nitong mauna ang low-priority replacements habang may posibilidad na magamit pa ang cards.","step_number":1,"items":["Tingnan ang bank, card, at e-wallet transaction history","I-block ang cards gamit ang official app, hotline, o branch channel","Kung phone/SIM din ang nawala, urgent ang OTP recovery","Mag-message sa trusted person kung kailangan ng emergency pamasahe o backup ID photo","Isulat ang support reference numbers"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-wallet-first-steps'),
    'step',
    4,
    '{"title":"Use this priority order before traveling","body":"After money access is protected, decide what to replace first. Do not spend the whole day replacing a low-priority card if a bank card, driver''s license, or school/company ID is what you need tomorrow.","step_number":2,"items":["1. ATM, debit, credit, prepaid cards, and e-wallet-linked cards","2. SIM or phone number if OTP access is affected","3. Driver''s License, National ID, or other primary ID","4. Company or school ID needed for entry","5. Secondary cards, receipts, loyalty cards, and non-urgent items"]}'::jsonb,
    '{"title":"Gamitin ang priority order bago bumiyahe","body":"Pagkatapos ma-protect ang money access, magdesisyon kung ano ang unang papalitan. Huwag ubusin ang araw sa low-priority card kung bank card, driver''s license, o school/company ID ang kailangan mo bukas.","step_number":2,"items":["1. ATM, debit, credit, prepaid cards, at e-wallet-linked cards","2. SIM o phone number kung apektado ang OTP access","3. Driver''s License, National ID, o ibang primary ID","4. Company o school ID na kailangan sa entry","5. Secondary cards, resibo, loyalty cards, at non-urgent items"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-wallet-first-steps'),
    'step',
    5,
    '{"title":"Prepare replacement proof before going to offices","body":"Many replacements need proof, forms, or an affidavit of loss. Prepare copies first so you do not waste fare going back and forth.","step_number":3,"items":["Backup ID or clear photo of an ID","Affidavit of loss if required by the office or bank","Photocopies or digital copies of available IDs","Card/account reference numbers, not passwords or PINs","Emergency cash or fare","Proof of SIM ownership if OTP number is affected"]}'::jsonb,
    '{"title":"Ihanda ang replacement proof bago pumunta sa offices","body":"Maraming replacement ang nangangailangan ng proof, forms, o affidavit of loss. Maghanda muna ng copies para hindi sayang ang pamasahe sa pabalik-balik.","step_number":3,"items":["Backup ID o malinaw na photo ng ID","Affidavit of loss kung hinihingi ng office o bank","Photocopies o digital copies ng available IDs","Card/account reference numbers, hindi passwords o PINs","Emergency cash o pamasahe","Proof of SIM ownership kung apektado ang OTP number"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-wallet-first-steps'),
    'mistake',
    6,
    '{"title":"Common mistakes after losing a wallet","body":"Panic makes people expose too much information or fix the wrong problem first. Keep details private and prioritize access risk.","items":["Posting full name, ID numbers, card numbers, address, or birthdate publicly","Uploading photos of IDs to random lost-and-found pages","Replacing low-priority cards before blocking bank cards","Trusting fake wallet-found helpers who ask for fees or OTPs","Forgetting that SIM/OTP recovery may affect bank and e-wallet access","Not checking transactions again after a few hours"]}'::jsonb,
    '{"title":"Karaniwang pagkakamali pagkatapos mawala ang wallet","body":"Dahil sa panic, minsan sobra ang naibibigay na information o mali ang nauuna. Panatilihing private ang details at unahin ang access risk.","items":["Pinopost publicly ang full name, ID numbers, card numbers, address, o birthdate","Ina-upload ang photos ng IDs sa random lost-and-found pages","Pinapalitan muna ang low-priority cards bago i-block ang bank cards","Nagtitiwala sa fake wallet-found helpers na humihingi ng fee o OTP","Nakakalimutang ang SIM/OTP recovery ay puwedeng makaapekto sa bank at e-wallet access","Hindi ulit tinitingnan ang transactions pagkalipas ng ilang oras"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-wallet-first-steps'),
    'warning',
    7,
    '{"title":"Watch for phishing after posting about a lost wallet","body":"Scammers may claim they found your wallet or can help recover cards. Real helpers do not need OTPs, PINs, passwords, full card numbers, or payment before returning an item.","severity":"high","items":["Message says they found your wallet but asks for verification fee","They ask for OTP, PIN, password, or bank/e-wallet login","They ask you to click a tracking or claim link","They want your full ID number, full card number, or selfie with ID","They pressure you to send money before meeting in a safe public place"]}'::jsonb,
    '{"title":"Mag-ingat sa phishing pagkatapos mag-post tungkol sa nawawalang wallet","body":"May scammers na magsasabing nahanap nila ang wallet mo o kaya nilang tumulong sa recovery. Hindi kailangan ng totoong helper ang OTP, PIN, password, full card number, o bayad bago ibalik ang item.","severity":"high","items":["Sinasabing nahanap ang wallet pero may verification fee","Hinihingi ang OTP, PIN, password, o bank/e-wallet login","Pinapa-click ka ng tracking o claim link","Hinihingi ang full ID number, full card number, o selfie with ID","Pinapamadali kang magpadala ng pera bago magkita sa safe public place"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-wallet-first-steps'),
    'tip',
    8,
    '{"title":"Sample questions to ask before replacing items","body":"Use direct questions so the office, bank, school, or employer tells you the exact requirement before you travel.","sample":"My wallet was lost today. I need to block or replace my card/ID. Can you confirm the exact requirements, fees, affidavit needs, and whether I can temporarily freeze the account while replacing my IDs?"}'::jsonb,
    '{"title":"Sample questions bago magpa-replace","body":"Diretsong tanong ang gamitin para sabihin ng office, bank, school, o employer ang exact requirement bago ka bumiyahe.","sample":"Nawala po ang wallet ko today. Kailangan kong i-block o palitan ang card/ID. Puwede po bang i-confirm ang exact requirements, fees, kailangan bang affidavit, at kung puwede munang i-freeze ang account habang nagpapalit ako ng IDs?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'lost-wallet-first-steps'),
    'tip',
    9,
    '{"title":"Prevention after you recover","body":"Once the emergency is done, reduce the damage next time by carrying fewer sensitive items and keeping backup proof safely.","items":["Do not carry every ID every day","Keep clear digital copies in a secure folder","Keep an emergency contact card without sensitive numbers","Separate one backup card from your main wallet","Store bank and telco hotlines somewhere outside the wallet","Do not keep PINs or passwords inside the wallet"]}'::jsonb,
    '{"title":"Prevention pagkatapos maayos ang emergency","body":"Kapag tapos na ang urgent steps, bawasan ang damage sa susunod sa pamamagitan ng mas kaunting sensitive items at secure backup proof.","items":["Huwag dalhin lahat ng ID araw-araw","Magtabi ng malinaw na digital copies sa secure folder","Maglagay ng emergency contact card na walang sensitive numbers","Ihiwalay ang isang backup card sa main wallet","Itago ang bank at telco hotlines sa lugar na hindi kasama sa wallet","Huwag maglagay ng PINs o passwords sa wallet"]}'::jsonb
  );
