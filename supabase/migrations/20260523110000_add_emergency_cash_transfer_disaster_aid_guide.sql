-- Add DSWD Emergency Cash Transfer / disaster cash aid guide.
-- Goal: explain post-disaster validation, payout, documents, and fake payout risks.

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
  'emergency-cash-transfer-disaster-aid-checklist',
  (select id from public.categories where slug = 'emergency'),
  'Emergency cash transfer checklist after disasters',
  'Emergency cash transfer checklist pagkatapos ng sakuna',
  'Know how DSWD disaster cash aid is validated, when payouts happen, and how to avoid fake payout lists.',
  'Alamin kung paano vine-validate ang DSWD disaster cash aid, kailan may payout, at paano umiwas sa fake payout lists.',
  true,
  true,
  true,
  7,
  'katamtaman',
  '30-60 minuto mag-verify',
  'Libre magtanong',
  array[
    'dswd',
    'emergency cash transfer',
    'ect',
    'disaster aid',
    'calamity assistance',
    'cash assistance',
    'typhoon',
    'flood',
    'fire',
    'earthquake',
    'evacuation',
    'gobyerno',
    'ayuda'
  ],
  'dswd emergency cash transfer ect disaster aid calamity assistance cash assistance typhoon flood fire earthquake evacuation state of calamity',
  'dswd emergency cash transfer ect disaster aid calamity assistance cash assistance bagyo baha sunog lindol evacuation state of calamity ayuda gobyerno',
  '[
    {"title":"Emergency Cash Transfer","publisher":"DSWD Disaster Response Management","url":"https://drm.dswd.gov.ph/emergency-cash-transfer/"},
    {"title":"DSWD disburses emergency cash assistance for typhoon-hit households","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-disburses-php949-5m-in-emergency-cash-assistance-for-typhoon-hit-households-in-central-visayas/"},
    {"title":"DSWD releases ECT and cash-for-work to Mayon-affected families","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-releases-over-php73m-in-ect-php45m-in-cash-for-work-to-families-affected-by-mayon-unrest/"},
    {"title":"Operations Manual for Emergency Cash Transfer during disasters","publisher":"DSWD","url":"https://www.dswd.gov.ph/download/publications/operations_manual_for_the_implementation_of_the_emergency_cash_transfer_ect_during_disasters/02012022_ECT_OM_A4_print_FINAL.pdf"}
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
  where slug = 'emergency-cash-transfer-disaster-aid-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'emergency-cash-transfer-disaster-aid-checklist'),
    'what_to_know',
    1,
    '{"title":"ECT is post-disaster cash assistance, not open registration","body":"DSWD describes Emergency Cash Transfer or ECT as unconditional cash assistance for disaster-affected families that need support after disasters and emergencies. It is usually tied to official disaster response, validation, affected area lists, and operational payout schedules. It is not a random online cash registration form.","items":["ECT is for disaster-affected families needing intervention","It bridges immediate relief and early recovery support","It may help with food, medicine, repair, livelihood recovery, or urgent household needs","It depends on official disaster assessment, validation, and payout schedule","Never pay anyone promising guaranteed inclusion"]}'::jsonb,
    '{"title":"Ang ECT ay post-disaster cash assistance, hindi open registration","body":"Ayon sa DSWD, ang Emergency Cash Transfer o ECT ay unconditional cash assistance para sa disaster-affected families na kailangan ng support pagkatapos ng disasters at emergencies. Karaniwang konektado ito sa official disaster response, validation, affected area lists, at operational payout schedules. Hindi ito random online cash registration form.","items":["Ang ECT ay para sa disaster-affected families na kailangan ng intervention","Tumutulong itong mag-bridge mula immediate relief papunta sa early recovery support","Maaaring makatulong sa pagkain, gamot, repair, livelihood recovery, o urgent household needs","Depende ito sa official disaster assessment, validation, at payout schedule","Huwag magbayad sa taong nangangakong guaranteed ang inclusion"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-cash-transfer-disaster-aid-checklist'),
    'step',
    2,
    '{"title":"Confirm the disaster and area coverage first","body":"Before traveling or submitting documents, verify whether ECT or disaster cash assistance is actually active for your affected area. Some disasters receive relief goods, cash-for-work, ECT, or a mix of support depending on the situation.","step_number":1,"items":["Official DSWD national or Field Office announcement","Official LGU or barangay announcement matching DSWD information","Disaster event covered: typhoon, flood, earthquake, fire, volcanic unrest, or other emergency","Affected barangay, municipality, city, or province list","Payout date, venue, and beneficiary validation rules"]}'::jsonb,
    '{"title":"Kumpirmahin muna ang disaster at covered area","body":"Bago bumiyahe o magpasa ng documents, i-verify kung active talaga ang ECT o disaster cash assistance sa affected area ninyo. May disaster na relief goods, cash-for-work, ECT, o kombinasyon ang support depende sa sitwasyon.","step_number":1,"items":["Official DSWD national o Field Office announcement","Official LGU o barangay announcement na tugma sa DSWD information","Covered disaster event: bagyo, baha, lindol, sunog, volcanic unrest, o ibang emergency","Affected barangay, municipality, city, o province list","Payout date, venue, at beneficiary validation rules"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-cash-transfer-disaster-aid-checklist'),
    'step',
    3,
    '{"title":"Prepare proof that connects your household to the affected area","body":"Disaster cash aid usually needs validation. Prepare identity, residence, household, and damage or displacement proof. Submit only through official channels.","step_number":2,"items":["Valid ID of household representative","Complete address and contact number","Proof of residence or barangay certification if requested","Household details if requested","Evacuation center record, damage assessment, incident report, or local validation record if available","Photos of damage only if requested by official office","Any official stub, text, claim slip, or queue number"]}'::jsonb,
    '{"title":"Ihanda ang proof na konektado ang household sa affected area","body":"Karaniwang kailangan ng validation sa disaster cash aid. Ihanda ang identity, residence, household, at damage o displacement proof. Sa official channels lang mag-submit.","step_number":2,"items":["Valid ID ng household representative","Kumpletong address at contact number","Proof of residence o barangay certification kung hinihingi","Household details kung hinihingi","Evacuation center record, damage assessment, incident report, o local validation record kung meron","Photos ng damage kung hinihingi lang ng official office","Official stub, text, claim slip, o queue number kung meron"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-cash-transfer-disaster-aid-checklist'),
    'step',
    4,
    '{"title":"Ask where your name or household should be validated","body":"Do not assume a viral payout list is real. Ask the official local office how the beneficiary list is validated and where corrections or appeals can be raised.","step_number":3,"items":["Barangay disaster desk or social welfare contact","City/Municipal Social Welfare and Development Office","DSWD Field Office covering your region","Official payout venue and schedule","Grievance, correction, or appeal process if your household was affected but not listed"]}'::jsonb,
    '{"title":"Itanong kung saan vine-validate ang pangalan o household","body":"Huwag agad maniwala sa viral payout list. Itanong sa official local office kung paano vine-validate ang beneficiary list at saan pwedeng magpa-correct o mag-appeal.","step_number":3,"items":["Barangay disaster desk o social welfare contact","City/Municipal Social Welfare and Development Office","DSWD Field Office na sakop ang region ninyo","Official payout venue at schedule","Grievance, correction, o appeal process kung affected ang household pero wala sa listahan"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-cash-transfer-disaster-aid-checklist'),
    'tip',
    5,
    '{"title":"Ask one clear verification question","body":"A clear question helps separate official payout instructions from rumor-based posts.","sample":"Hello po. Affected po ang household namin ng [bagyo/baha/sunog/lindol/evacuation] sa [barangay/city]. May official DSWD Emergency Cash Transfer o disaster cash aid validation po ba para sa area namin? Saan po makikita ang official beneficiary validation process, payout schedule, requirements, at grievance desk kung hindi kami nasa listahan?"}'::jsonb,
    '{"title":"Magtanong ng isang malinaw na verification question","body":"Mas madaling mahiwalay ang official payout instructions sa chismis kapag malinaw ang tanong.","sample":"Hello po. Affected po ang household namin ng [bagyo/baha/sunog/lindol/evacuation] sa [barangay/city]. May official DSWD Emergency Cash Transfer o disaster cash aid validation po ba para sa area namin? Saan po makikita ang official beneficiary validation process, payout schedule, requirements, at grievance desk kung hindi kami nasa listahan?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-cash-transfer-disaster-aid-checklist'),
    'warning',
    6,
    '{"title":"Avoid fake payout lists and disaster aid fixers","body":"Disasters create panic, and scammers use that panic. Be careful with posts claiming instant payout, guaranteed slots, or paid processing after typhoons, floods, fires, earthquakes, or evacuations.","severity":"high","items":["Processing fee, reservation fee, or fixer fee","Random payout list that cannot be verified by DSWD/LGU/barangay","Google Form asking for full IDs, selfies, bank details, or e-wallet login","OTP, PIN, password, or cash card number request","Someone selling claim stubs or priority numbers","Pressure to submit immediately through a private account"]}'::jsonb,
    '{"title":"Iwasan ang fake payout lists at disaster aid fixers","body":"Kapag may sakuna, maraming nagpapanic, at ginagamit ito ng scammers. Mag-ingat sa posts na nangangako ng instant payout, guaranteed slots, o paid processing pagkatapos ng bagyo, baha, sunog, lindol, o evacuation.","severity":"high","items":["Processing fee, reservation fee, o fixer fee","Random payout list na hindi ma-verify sa DSWD/LGU/barangay","Google Form na humihingi ng full IDs, selfies, bank details, o e-wallet login","Hinihinging OTP, PIN, password, o cash card number","May nagbebenta ng claim stub o priority number","Pinapamadali kang mag-submit sa private account"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-cash-transfer-disaster-aid-checklist'),
    'mistake',
    7,
    '{"title":"Thinking all disaster help is ECT","body":"After a disaster, help may come as family food packs, non-food items, cash-for-work, AICS, ECT, shelter support, or local aid. Ask what type of assistance is active instead of assuming every payout is ECT."}'::jsonb,
    '{"title":"Iniisip na lahat ng disaster help ay ECT","body":"Pagkatapos ng sakuna, ang tulong ay maaaring family food packs, non-food items, cash-for-work, AICS, ECT, shelter support, o local aid. Itanong kung anong assistance ang active imbes na mag-assume na lahat ng payout ay ECT."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'emergency-cash-transfer-disaster-aid-checklist'),
    'tip',
    8,
    '{"title":"Keep a disaster assistance record","body":"Save official screenshots, validation details, payout schedule, documents submitted, and receipts. This helps with follow-up and protects you from false instructions.","items":["Official DSWD/LGU/barangay announcement","Date, venue, and office contacted","Name or position of person who answered, if given","Requirements list and documents submitted","Claim stub, queue number, or reference number if given","Photos of damage or evacuation proof if officially requested","Grievance desk or correction contact"]}'::jsonb,
    '{"title":"Magtabi ng disaster assistance record","body":"I-save ang official screenshots, validation details, payout schedule, documents na ipinasa, at resibo. Makakatulong ito sa follow-up at proteksyon laban sa maling instructions.","items":["Official DSWD/LGU/barangay announcement","Date, venue, at office na kinontak","Pangalan o position ng sumagot kung ibinigay","Requirements list at documents na ipinasa","Claim stub, queue number, o reference number kung meron","Photos ng damage o evacuation proof kung official na hinihingi","Grievance desk o correction contact"]}'::jsonb
  );
