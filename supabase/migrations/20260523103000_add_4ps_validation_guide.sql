-- Add 4Ps validation explainer guide.
-- Goal: prevent fake registration scams and explain CBMS/validation-based inclusion.

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
  published_at
)
values (
  'four-ps-validation-checklist',
  (select id from public.categories where slug = 'gov'),
  '4Ps validation checklist before trusting registration posts',
  '4Ps validation checklist bago maniwala sa registration posts',
  'Understand CBMS-based validation, real 4Ps contacts, and fake registration red flags.',
  'Intindihin ang CBMS-based validation, tamang 4Ps contacts, at fake registration red flags.',
  true,
  true,
  true,
  7,
  'katamtaman',
  '30 minuto mag-verify',
  'Libre magtanong',
  array[
    'dswd',
    '4ps',
    'pantawid pamilya',
    'pantawid pamilyang pilipino program',
    'cbms',
    'psa',
    'conditional cash transfer',
    'lifeline rate',
    'financial assistance',
    'gobyerno',
    'ayuda'
  ],
  'dswd 4ps pantawid pamilya pantawid pamilyang pilipino program cbms psa validation verification conditional cash transfer lifeline rate',
  'dswd 4ps pantawid pamilya pantawid pamilyang pilipino program cbms psa validation verification conditional cash transfer lifeline rate gobyerno ayuda',
  '[
    {"title":"DSWD to register 493,000 families as new 4Ps beneficiaries after validation, verification process","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-to-register-493000-families-as-new-4ps-beneficiaries-after-validation-verification-process/"},
    {"title":"Pantawid Pamilyang Pilipino Program overview","publisher":"DSWD Field Office I","url":"https://fo1.dswd.gov.ph/programs/poverty-reduction-programs/pantawid-pamilyang-pilipino-program/"},
    {"title":"Automatic lifeline rate enrollment for qualified 4Ps households","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-doe-erc-institutionalize-automatic-lifeline-rate-enrollment-for-qualified-4ps-households/"},
    {"title":"DSWD warns public against fake recruitment for 4Ps","publisher":"DSWD Field Office III","url":"https://fo3.dswd.gov.ph/2022/05/dswd-warns-public-against-fake-recruitment-for-4ps/"},
    {"title":"4Ps families graduate through SWDI assessment","publisher":"DSWD","url":"https://www.dswd.gov.ph/over-1-6m-filipino-families-rise-from-poverty-through-dswds-4ps/"}
  ]'::jsonb,
  now()
)
on conflict (slug) do update set
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
  published_at = coalesce(public.guides.published_at, excluded.published_at),
  updated_at = now();

delete from public.guide_sections
where guide_id = (
  select id
  from public.guides
  where slug = 'four-ps-validation-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'four-ps-validation-checklist'),
    'what_to_know',
    1,
    '{"title":"4Ps is not ordinary open registration","body":"The Pantawid Pamilyang Pilipino Program or 4Ps is a conditional cash transfer and human development program for qualified poor households. DSWD announced that around 493,000 new families would be registered after validation and verification from the 2026 CBMS list from PSA. This means people should be careful with random posts claiming instant 4Ps registration.","items":["4Ps is based on household assessment and official validation","New beneficiaries can come from CBMS/PSA data and DSWD verification","It is not guaranteed just because someone fills out a random online form","Do not pay anyone promising inclusion","Do not give cash card numbers, OTPs, PINs, or account details"]}'::jsonb,
    '{"title":"Ang 4Ps ay hindi ordinary open registration","body":"Ang Pantawid Pamilyang Pilipino Program o 4Ps ay conditional cash transfer at human development program para sa qualified poor households. Inanunsyo ng DSWD na nasa 493,000 bagong pamilya ang ireregister pagkatapos ng validation at verification mula sa 2026 CBMS list ng PSA. Ibig sabihin, mag-ingat sa random posts na nangangako ng instant 4Ps registration.","items":["Ang 4Ps ay batay sa household assessment at official validation","Ang bagong beneficiaries ay maaaring manggaling sa CBMS/PSA data at DSWD verification","Hindi guaranteed dahil lang may sinagutang random online form","Huwag magbayad sa taong nangangakong maisasama kayo","Huwag magbigay ng cash card number, OTP, PIN, o account details"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'four-ps-validation-checklist'),
    'step',
    2,
    '{"title":"Verify if your household is part of official validation","body":"If there is a 4Ps announcement in your area, confirm whether it is an official DSWD, LGU, or City/Municipal Link activity. Do this before submitting documents or going to a venue.","step_number":1,"items":["Check the official DSWD national or Field Office page","Ask the city/municipal social welfare office","Ask the official 4Ps City/Municipal Link if available","Check barangay announcements only if they match DSWD/LGU instructions","Confirm the date, venue, required proof, and contact person"]}'::jsonb,
    '{"title":"I-verify kung kasama ang household sa official validation","body":"Kapag may 4Ps announcement sa lugar ninyo, kumpirmahin kung official DSWD, LGU, o City/Municipal Link activity ito. Gawin ito bago magpasa ng documents o pumunta sa venue.","step_number":1,"items":["Tingnan ang official DSWD national o Field Office page","Magtanong sa city/municipal social welfare office","Magtanong sa official 4Ps City/Municipal Link kung meron","I-check ang barangay announcements kung tugma sa DSWD/LGU instructions","Kumpirmahin ang date, venue, required proof, at contact person"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'four-ps-validation-checklist'),
    'step',
    3,
    '{"title":"Prepare household information safely","body":"If your household is asked to validate, prepare basic household proof. Submit only through official channels. Do not upload sensitive documents to links that cannot be verified.","step_number":2,"items":["Valid ID of parent or household representative","Complete address and contact number","Household member details if requested","Children school details if applicable","Health center or pregnancy details if applicable","Any official notice or instruction received","Do not send cash card number, PIN, OTP, or bank/e-wallet login"]}'::jsonb,
    '{"title":"Ihanda nang safe ang household information","body":"Kung pinapavalidate ang household ninyo, maghanda ng basic household proof. Sa official channels lang mag-submit. Huwag mag-upload ng sensitive documents sa links na hindi ma-verify.","step_number":2,"items":["Valid ID ng parent o household representative","Kumpletong address at contact number","Household member details kung hinihingi","School details ng bata kung applicable","Health center o pregnancy details kung applicable","Official notice o instruction kung meron","Huwag magpadala ng cash card number, PIN, OTP, o bank/e-wallet login"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'four-ps-validation-checklist'),
    'step',
    4,
    '{"title":"Understand the conditions if selected","body":"4Ps is not only cash support. It is linked to health, education, family development, and household monitoring. Beneficiaries may need to comply with school attendance, health checkups, Family Development Sessions, and program rules.","step_number":3,"items":["Children school attendance requirements","Health checkups, immunization, prenatal or postnatal care where applicable","Family Development Sessions","Updating household information when required","Following payout and grievance instructions from official links or municipal links"]}'::jsonb,
    '{"title":"Intindihin ang conditions kapag selected","body":"Ang 4Ps ay hindi lang cash support. Konektado ito sa health, education, family development, at household monitoring. Maaaring kailangang sumunod sa school attendance, health checkups, Family Development Sessions, at program rules.","step_number":3,"items":["School attendance requirements ng mga bata","Health checkups, immunization, prenatal o postnatal care kung applicable","Family Development Sessions","Pag-update ng household information kapag hinihingi","Pagsunod sa payout at grievance instructions mula sa official links o municipal links"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'four-ps-validation-checklist'),
    'tip',
    5,
    '{"title":"Ask about validation, not instant application","body":"Use a question that forces the office to answer through official process, not rumors.","sample":"Hello po. Magtatanong lang po tungkol sa 4Ps validation. May official DSWD/CBMS-based validation po ba sa [barangay/city]? Paano po malalaman kung kasama ang household namin sa potential list, sino po ang official contact, at anong documents lang po ang kailangang dalhin?"}'::jsonb,
    '{"title":"Validation ang itanong, hindi instant application","body":"Gumamit ng tanong na magpapasagot sa office batay sa official process, hindi chismis.","sample":"Hello po. Magtatanong lang po tungkol sa 4Ps validation. May official DSWD/CBMS-based validation po ba sa [barangay/city]? Paano po malalaman kung kasama ang household namin sa potential list, sino po ang official contact, at anong documents lang po ang kailangang dalhin?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'four-ps-validation-checklist'),
    'warning',
    6,
    '{"title":"Red flags of fake 4Ps registration","body":"DSWD has warned the public before against fake recruitment or enlistment activities for 4Ps. Be careful when someone claims they can include your household for a fee or asks for sensitive information.","severity":"high","items":["Processing fee, slot fee, or fixer fee","Guaranteed inclusion or sure payout","Random online form asking for IDs, birth certificates, selfies, or cash card numbers","Someone asking for OTP, PIN, password, bank login, or e-wallet login","Person wearing a vest or claiming to be DSWD but cannot be verified through official office","Pressure to submit immediately without official DSWD/LGU announcement"]}'::jsonb,
    '{"title":"Red flags ng fake 4Ps registration","body":"Nagbabala na ang DSWD laban sa fake recruitment o enlistment activities para sa 4Ps. Mag-ingat kapag may nagsasabing kaya niyang isama ang household ninyo kapalit ng bayad o humihingi ng sensitive information.","severity":"high","items":["Processing fee, slot fee, o fixer fee","Guaranteed inclusion o sure payout","Random online form na humihingi ng IDs, birth certificate, selfie, o cash card number","May humihingi ng OTP, PIN, password, bank login, o e-wallet login","Taong naka-vest o nagpapakilalang DSWD pero hindi ma-verify sa official office","Pinapamadali kayong mag-submit kahit walang official DSWD/LGU announcement"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'four-ps-validation-checklist'),
    'tip',
    7,
    '{"title":"If already a 4Ps household, ask about related support","body":"Qualified 4Ps households may also be linked to other support, such as automatic lifeline rate enrollment for eligible electricity consumers under DSWD, DOE, and ERC policy. Ask only through official channels and check if your household is eligible.","sample":"4Ps household po kami. Pwede po bang malaman kung eligible kami sa lifeline rate subsidy o ibang complementary support, at saan po ang official process para ma-check ito?"}'::jsonb,
    '{"title":"Kung 4Ps household na, itanong ang related support","body":"Ang qualified 4Ps households ay maaaring konektado rin sa ibang support, tulad ng automatic lifeline rate enrollment para sa eligible electricity consumers sa ilalim ng DSWD, DOE, at ERC policy. Sa official channels lang magtanong at i-check kung eligible ang household ninyo.","sample":"4Ps household po kami. Pwede po bang malaman kung eligible kami sa lifeline rate subsidy o ibang complementary support, at saan po ang official process para ma-check ito?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'four-ps-validation-checklist'),
    'mistake',
    8,
    '{"title":"Thinking one Facebook post means you are selected","body":"A post can announce validation in an area, but it does not always mean every household is included. Verify through DSWD, LGU, or the City/Municipal Link before preparing sensitive documents or traveling."}'::jsonb,
    '{"title":"Iniisip na selected na dahil may Facebook post","body":"Maaaring may post tungkol sa validation sa isang lugar, pero hindi ibig sabihin lahat ng household ay kasama. I-verify muna sa DSWD, LGU, o City/Municipal Link bago maghanda ng sensitive documents o bumiyahe."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'four-ps-validation-checklist'),
    'tip',
    9,
    '{"title":"Keep a clean validation record","body":"Save only official instructions and proof of official contact. This makes follow-up easier and protects your household from rumor-based instructions.","items":["Official DSWD/LGU announcement screenshot","Date and venue of validation","Name or office of person contacted","Documents actually required","Reference number, stub, or acknowledgement if given","Grievance or helpdesk contact if available"]}'::jsonb,
    '{"title":"Magtabi ng malinis na validation record","body":"Official instructions at proof of official contact lang ang itabi. Mas madali itong gamitin sa follow-up at mas ligtas kaysa sumunod sa chismis.","items":["Screenshot ng official DSWD/LGU announcement","Date at venue ng validation","Pangalan o office ng nakausap","Documents na talagang required","Reference number, stub, o acknowledgement kung meron","Grievance o helpdesk contact kung available"]}'::jsonb
  );
