-- Polish 4Ps validation guide with 2026 DSWD validation flow and scam warnings.
-- Goal: clarify that 4Ps is CBMS/validation-based, not instant online registration.

update public.guides
set
  title_en = '4Ps validation: what to check before trusting registration posts',
  title_fil = '4Ps validation: mga dapat i-check bago maniwala sa registration posts',
  tagline_en = 'Understand CBMS-based validation, barangay posting, real 4Ps contacts, payout misinformation, and fake registration red flags.',
  tagline_fil = 'Intindihin ang CBMS-based validation, barangay posting, tamang 4Ps contacts, payout misinformation, at fake registration red flags.',
  read_time_min = 8,
  estimated_time = '30-60 min',
  estimated_cost = 'Official channels only',
  tags = array[
    'dswd',
    '4ps',
    'pantawid pamilya',
    'pantawid pamilyang pilipino program',
    'cbms',
    'psa',
    'philSys',
    'conditional cash transfer',
    'lifeline rate',
    'financial assistance',
    'fake registration',
    'payout schedule',
    'gobyerno',
    'ayuda'
  ],
  keywords_en = 'dswd 4ps pantawid pamilya pantawid pamilyang pilipino program cbms psa philsys validation verification barangay posting registration municipal link city link conditional cash transfer lifeline rate fake payout schedule',
  keywords_fil = 'dswd 4ps pantawid pamilya pantawid pamilyang pilipino program cbms psa philsys validation verification barangay posting registration municipal link city link conditional cash transfer lifeline rate fake payout schedule gobyerno ayuda',
  official_sources = '[
    {"title":"DSWD to register 493,000 families as new 4Ps beneficiaries after validation, verification process","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-to-register-493000-families-as-new-4ps-beneficiaries-after-validation-verification-process/"},
    {"title":"DSWD warns public against fake recruitment for 4Ps","publisher":"DSWD","url":"https://old.dswd.gov.ph/dswd-warns-public-against-fake-recruitment-for-4ps/"},
    {"title":"DSWD warns 4Ps beneficiaries vs fake Facebook post on payout schedule","publisher":"DSWD","url":"https://old.dswd.gov.ph/dswd-warns-4ps-beneficiaries-vs-fake-fb-post-on-payout-sched/"},
    {"title":"4Ps as investment in poor Filipino families","publisher":"DSWD","url":"https://www.dswd.gov.ph/4ps-an-investment-in-poor-pinoy-families-to-escape-poverty-dswd-chief/"},
    {"title":"Automatic lifeline rate enrollment for qualified 4Ps households","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-doe-erc-institutionalize-automatic-lifeline-rate-enrollment-for-qualified-4ps-households/"}
  ]'::jsonb,
  updated_at = now()
where slug = 'four-ps-validation-checklist';

update public.guide_sections
set
  content_en = '{"title":"4Ps is not ordinary open registration","body":"The Pantawid Pamilyang Pilipino Program or 4Ps is a conditional cash transfer and human development program for qualified poor households. DSWD said around 493,000 families from the 2026 CBMS list would go through validation and verification before registration. This means 4Ps is not something a fixer can instantly apply you into.","items":["4Ps is based on household assessment and official validation","Potential beneficiaries may come from CBMS/PSA data and DSWD verification","The CBMS list is not automatically the final 4Ps list","Registration follows validation, orientation, and program requirements","Do not pay anyone promising inclusion or faster approval"]}'::jsonb,
  content_fil = '{"title":"Ang 4Ps ay hindi ordinary open registration","body":"Ang Pantawid Pamilyang Pilipino Program o 4Ps ay conditional cash transfer at human development program para sa qualified poor households. Ayon sa DSWD, nasa 493,000 pamilya mula sa 2026 CBMS list ang dadaan muna sa validation at verification bago registration. Ibig sabihin, hindi ito program na kayang ipasok agad ng fixer.","items":["Ang 4Ps ay batay sa household assessment at official validation","Ang potential beneficiaries ay maaaring manggaling sa CBMS/PSA data at DSWD verification","Hindi automatic final 4Ps list ang CBMS list","May validation, orientation, at program requirements bago registration","Huwag magbayad sa taong nangangakong maisasama ka o mapapabilis ang approval"]}'::jsonb
where guide_id = (select id from public.guides where slug = 'four-ps-validation-checklist')
  and order_index = 1;

update public.guide_sections
set
  content_en = '{"title":"Know the usual validation flow","body":"DSWD described a process that may include pre-registration, registration proper, and post-registration. In pre-registration, prospective beneficiary lists may be posted in barangays for checking before final validation. Local implementation can vary, so verify the current instruction in your area.","step_number":1,"items":["Check if there is an official DSWD/LGU validation announcement","Ask if a barangay posting or list-checking period is part of the process","Verify through the City/Municipal Link, LGU social welfare office, or DSWD Field Office","Confirm the date, venue, required proof, and contact person","Remember: being on a preliminary list does not always mean final registration"]}'::jsonb,
  content_fil = '{"title":"Alamin ang karaniwang validation flow","body":"Ayon sa DSWD, maaaring may pre-registration, registration proper, at post-registration. Sa pre-registration, maaaring ipaskil sa barangay ang listahan ng prospective beneficiaries para ma-check bago final validation. Puwedeng mag-iba ang local implementation, kaya i-verify ang current instruction sa lugar ninyo.","step_number":1,"items":["I-check kung may official DSWD/LGU validation announcement","Itanong kung may barangay posting o list-checking period sa process","I-verify sa City/Municipal Link, LGU social welfare office, o DSWD Field Office","Kumpirmahin ang date, venue, required proof, at contact person","Tandaan: ang nasa preliminary list ay hindi laging final registration"]}'::jsonb
where guide_id = (select id from public.guides where slug = 'four-ps-validation-checklist')
  and order_index = 2;

update public.guide_sections
set
  content_en = '{"title":"Ask about validation, not instant application","body":"Use a question that forces the office to answer through the official process, not rumors or private messages.","sample":"Hello. I would like to ask about 4Ps validation in [barangay/city]. Is there an official DSWD/CBMS-based validation or barangay posting? How can our household verify if we are on the potential list, who is the official contact, and what documents should we bring?"}'::jsonb,
  content_fil = '{"title":"Validation ang itanong, hindi instant application","body":"Gumamit ng tanong na magpapasagot sa office batay sa official process, hindi chismis o private message.","sample":"Hello po. Magtatanong lang po tungkol sa 4Ps validation sa [barangay/city]. May official DSWD/CBMS-based validation o barangay posting po ba? Paano po malalaman kung kasama ang household namin sa potential list, sino po ang official contact, at anong documents ang kailangang dalhin?"}'::jsonb
where guide_id = (select id from public.guides where slug = 'four-ps-validation-checklist')
  and order_index = 5;

update public.guide_sections
set
  content_en = '{"title":"Red flags of fake 4Ps registration and payout posts","body":"DSWD has warned against fake 4Ps recruitment and fake payout schedule posts. Be careful when someone claims they can include your household for a fee, asks for cash card information, or posts public lists that cannot be verified through official channels.","severity":"high","items":["Processing fee, slot fee, or fixer fee","Guaranteed inclusion or sure payout","Random online form asking for IDs, birth certificates, selfies, cash card numbers, or account details","Person claiming to be DSWD but cannot be verified through an official office","Fake payout schedule, public beneficiary list, or screenshot-only announcement","Instructions to send OTP, PIN, password, bank login, or e-wallet login"]}'::jsonb,
  content_fil = '{"title":"Red flags ng fake 4Ps registration at payout posts","body":"Nagbabala ang DSWD laban sa fake 4Ps recruitment at fake payout schedule posts. Mag-ingat kapag may nagsasabing kaya niyang isama ang household ninyo kapalit ng bayad, humihingi ng cash card information, o nagpapakalat ng public list na hindi ma-verify sa official channels.","severity":"high","items":["Processing fee, slot fee, o fixer fee","Guaranteed inclusion o sure payout","Random online form na humihingi ng IDs, birth certificate, selfie, cash card number, o account details","Taong nagpapakilalang DSWD pero hindi ma-verify sa official office","Fake payout schedule, public beneficiary list, o screenshot-only announcement","Instruction na magpadala ng OTP, PIN, password, bank login, o e-wallet login"]}'::jsonb
where guide_id = (select id from public.guides where slug = 'four-ps-validation-checklist')
  and order_index = 6;

delete from public.guide_sections
where guide_id = (select id from public.guides where slug = 'four-ps-validation-checklist')
  and order_index = 10;

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values (
  (select id from public.guides where slug = 'four-ps-validation-checklist'),
  'tip',
  10,
  '{"title":"What to expect after validation","body":"If a household passes validation and registration, DSWD says beneficiaries may attend orientation, sign an oath of commitment, and receive next-step instructions through municipal or city links. Do not expect a random online post to be the final source of truth.","items":["Orientation may explain responsibilities and benefits","Households may need to understand health, education, and family development conditions","Municipal or city links may give next steps such as payroll account instructions","Official payout schedules should come through official 4Ps channels or verified local links","Keep records of announcements, contacts, and documents submitted"]}'::jsonb,
  '{"title":"Ano ang aasahan pagkatapos ng validation","body":"Kapag pumasa ang household sa validation at registration, ayon sa DSWD maaaring may orientation, oath of commitment, at next-step instructions mula sa municipal o city links. Huwag asahan na random online post ang final source of truth.","items":["Maaaring ipaliwanag sa orientation ang responsibilities at benefits","Kailangang maintindihan ng household ang health, education, at family development conditions","Municipal o city links ang maaaring magbigay ng next steps tulad ng payroll account instructions","Official 4Ps channels o verified local links dapat manggaling ang payout schedules","Itabi ang records ng announcements, contacts, at documents na ipinasa"]}'::jsonb
);
