-- Polish Emergency Cash Transfer / disaster cash aid guide.
-- Goal: clarify ECT triggers, validation, payout variation, and fake payout risks.

update public.guides
set
  title_en = 'Emergency cash transfer after disasters: what to check first',
  title_fil = 'Emergency cash transfer pagkatapos ng sakuna: mga dapat i-check muna',
  tagline_en = 'Check disaster coverage, validation, payout method, documents, and fake aid lists before sharing personal details.',
  tagline_fil = 'I-check muna ang disaster coverage, validation, payout method, documents, at fake aid lists bago magbigay ng personal details.',
  read_time_min = 8,
  estimated_time = '30-60 min',
  estimated_cost = 'Official channels only',
  tags = array[
    'dswd',
    'emergency cash transfer',
    'ect',
    'disaster aid',
    'calamity assistance',
    'cash assistance',
    'state of calamity',
    'hybrid payout',
    'typhoon',
    'flood',
    'fire',
    'earthquake',
    'evacuation',
    'gobyerno',
    'ayuda'
  ],
  keywords_en = 'dswd emergency cash transfer ect disaster aid calamity assistance cash assistance typhoon flood fire earthquake evacuation state of calamity validation payout hybrid landbank affected families damaged house livelihood recovery',
  keywords_fil = 'dswd emergency cash transfer ect disaster aid calamity assistance cash assistance bagyo baha sunog lindol evacuation state of calamity validation payout hybrid landbank affected families damaged house livelihood recovery ayuda gobyerno',
  official_sources = '[
    {"title":"Emergency Cash Transfer","publisher":"DSWD Disaster Response Management","url":"https://drm.dswd.gov.ph/emergency-cash-transfer/"},
    {"title":"DSWD disburses emergency cash assistance for typhoon-hit households in Central Visayas","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-disburses-php949-5m-in-emergency-cash-assistance-for-typhoon-hit-households-in-central-visayas/"},
    {"title":"DSWD XI rolls out ECT payout in Davao Region","publisher":"DSWD Field Office XI","url":"https://fo11.dswd.gov.ph/2026/05/dswd-xi-rolls-out-ect-payout-in-davao-region-over-100k-calamity-affected-families-to-receive-aid/"},
    {"title":"Emergency Cash Transfer for Basyang-affected families","publisher":"DSWD Field Office Caraga","url":"https://caraga.dswd.gov.ph/2026/02/dswd-caraga-begins-emergency-cash-transfer-for-basyang-affected-families-in-surigao-del-sur/"},
    {"title":"Operations Manual for Emergency Cash Transfer during disasters","publisher":"DSWD","url":"https://www.dswd.gov.ph/download/publications/operations_manual_for_the_implementation_of_the_emergency_cash_transfer_ect_during_disasters/02012022_ECT_OM_A4_print_FINAL.pdf"}
  ]'::jsonb,
  updated_at = now()
where slug = 'emergency-cash-transfer-disaster-aid-checklist';

update public.guide_sections
set
  content_en = '{"title":"ECT is post-disaster cash assistance, not open registration","body":"DSWD describes Emergency Cash Transfer or ECT as post-disaster unconditional cash assistance for disaster-affected families that need support between immediate relief and early recovery. It may be activated when disaster conditions require it, often after a State of Calamity and only when local markets or payout systems can support cash assistance.","items":["ECT is for disaster-affected families needing intervention","It is post-disaster support, not anticipatory cash before an event","It may be implemented with food packs, non-food items, cash-for-work, or other aid","Coverage, amount, and payout method vary by disaster and validated list","Never pay anyone promising guaranteed inclusion or faster payout"]}'::jsonb,
  content_fil = '{"title":"Ang ECT ay post-disaster cash assistance, hindi open registration","body":"Ayon sa DSWD, ang Emergency Cash Transfer o ECT ay post-disaster unconditional cash assistance para sa disaster-affected families na kailangan ng support sa pagitan ng immediate relief at early recovery. Maaari itong ma-activate kapag kailangan ng disaster conditions, madalas pagkatapos ng State of Calamity at kapag kaya na ng local markets o payout systems ang cash assistance.","items":["Ang ECT ay para sa disaster-affected families na kailangan ng intervention","Post-disaster support ito, hindi anticipatory cash bago ang event","Puwede itong isabay sa food packs, non-food items, cash-for-work, o ibang aid","Nag-iiba ang coverage, amount, at payout method depende sa disaster at validated list","Huwag magbayad sa taong nangangakong guaranteed inclusion o mas mabilis na payout"]}'::jsonb
where guide_id = (select id from public.guides where slug = 'emergency-cash-transfer-disaster-aid-checklist')
  and order_index = 1;

update public.guide_sections
set
  content_en = '{"title":"Confirm the disaster, area coverage, and aid type first","body":"Before traveling or submitting documents, verify whether ECT or another form of disaster assistance is actually active for your affected area. Some disasters receive relief goods, cash-for-work, AICS, ECT, shelter support, or a mix of support depending on the situation.","step_number":1,"items":["Official DSWD national or Field Office announcement","Official LGU or barangay announcement matching DSWD information","Covered disaster event: typhoon, flood, earthquake, fire, volcanic unrest, landslide, or evacuation","Affected barangay, municipality, city, or province list","Whether the assistance is ECT, cash-for-work, relief goods, shelter aid, AICS, or local aid","Payout date, venue, validation rules, and grievance process"]}'::jsonb,
  content_fil = '{"title":"Kumpirmahin muna ang disaster, covered area, at uri ng aid","body":"Bago bumiyahe o magpasa ng documents, i-verify kung active talaga ang ECT o ibang disaster assistance sa affected area ninyo. May disaster na relief goods, cash-for-work, AICS, ECT, shelter support, o kombinasyon ang support depende sa sitwasyon.","step_number":1,"items":["Official DSWD national o Field Office announcement","Official LGU o barangay announcement na tugma sa DSWD information","Covered disaster event: bagyo, baha, lindol, sunog, volcanic unrest, landslide, o evacuation","Affected barangay, municipality, city, o province list","Kung ECT, cash-for-work, relief goods, shelter aid, AICS, o local aid ang assistance","Payout date, venue, validation rules, at grievance process"]}'::jsonb
where guide_id = (select id from public.guides where slug = 'emergency-cash-transfer-disaster-aid-checklist')
  and order_index = 2;

update public.guide_sections
set
  content_en = '{"title":"Ask one clear verification question","body":"A clear question helps separate official payout instructions from rumor-based posts.","sample":"Hello. Our household was affected by [typhoon/flood/fire/earthquake/evacuation] in [barangay/city]. Is there an official DSWD Emergency Cash Transfer or disaster cash aid validation for our area? Where can we verify the beneficiary validation process, payout schedule, requirements, payout method, and grievance desk if our household is not on the list?"}'::jsonb,
  content_fil = '{"title":"Magtanong ng isang malinaw na verification question","body":"Mas madaling mahiwalay ang official payout instructions sa chismis kapag malinaw ang tanong.","sample":"Hello po. Affected po ang household namin ng [bagyo/baha/sunog/lindol/evacuation] sa [barangay/city]. May official DSWD Emergency Cash Transfer o disaster cash aid validation po ba para sa area namin? Saan po makikita ang beneficiary validation process, payout schedule, requirements, payout method, at grievance desk kung hindi kami nasa listahan?"}'::jsonb
where guide_id = (select id from public.guides where slug = 'emergency-cash-transfer-disaster-aid-checklist')
  and order_index = 5;

update public.guide_sections
set
  content_en = '{"title":"Avoid fake payout lists and disaster aid fixers","body":"Disasters create panic, and scammers use that panic. Be careful with posts claiming instant payout, guaranteed slots, priority numbers, or paid processing after typhoons, floods, fires, earthquakes, landslides, or evacuations.","severity":"high","items":["Processing fee, reservation fee, or fixer fee","Random payout list that cannot be verified by DSWD/LGU/barangay","Google Form asking for full IDs, selfies, bank details, or e-wallet login","OTP, PIN, password, or cash card number request","Someone selling claim stubs, queue numbers, or priority numbers","Pressure to submit immediately through a private account"]}'::jsonb,
  content_fil = '{"title":"Iwasan ang fake payout lists at disaster aid fixers","body":"Kapag may sakuna, maraming nagpapanic, at ginagamit ito ng scammers. Mag-ingat sa posts na nangangako ng instant payout, guaranteed slots, priority numbers, o paid processing pagkatapos ng bagyo, baha, sunog, lindol, landslide, o evacuation.","severity":"high","items":["Processing fee, reservation fee, o fixer fee","Random payout list na hindi ma-verify sa DSWD/LGU/barangay","Google Form na humihingi ng full IDs, selfies, bank details, o e-wallet login","Hinihinging OTP, PIN, password, o cash card number","May nagbebenta ng claim stub, queue number, o priority number","Pinapamadali kang mag-submit sa private account"]}'::jsonb
where guide_id = (select id from public.guides where slug = 'emergency-cash-transfer-disaster-aid-checklist')
  and order_index = 6;

delete from public.guide_sections
where guide_id = (select id from public.guides where slug = 'emergency-cash-transfer-disaster-aid-checklist')
  and order_index = 9;

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values (
  (select id from public.guides where slug = 'emergency-cash-transfer-disaster-aid-checklist'),
  'tip',
  9,
  '{"title":"What to expect during payout","body":"ECT payout can differ by disaster and region. Some areas use over-the-counter payout, digital payout, or a hybrid system with partner financial institutions. Amounts may also vary depending on damage, validated category, and official guidelines for that event.","items":["Bring the exact ID and proof required by the official announcement","Ask whether payout is over-the-counter, digital, or hybrid","Ask if damaged-house category, livelihood loss, or validated household list affects the amount","Expect crowd control, queue numbers, and verification steps at the venue","Keep claim slips, photos of official announcements, and receipts if given"]}'::jsonb,
  '{"title":"Ano ang aasahan sa payout","body":"Puwedeng mag-iba ang ECT payout depende sa disaster at region. May lugar na over-the-counter, digital, o hybrid system gamit ang partner financial institutions. Puwede ring mag-iba ang amount depende sa damage, validated category, at official guidelines para sa event.","items":["Dalhin ang eksaktong ID at proof na hinihingi ng official announcement","Itanong kung over-the-counter, digital, o hybrid ang payout","Itanong kung damaged-house category, livelihood loss, o validated household list ang basehan ng amount","Asahan ang crowd control, queue numbers, at verification steps sa venue","Itabi ang claim slips, photos ng official announcements, at resibo kung meron"]}'::jsonb
);
