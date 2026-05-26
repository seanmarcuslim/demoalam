-- Polish Walang Gutom guide copy and add a clearer expectations section.
-- Goal: make the guide feel less translated, clearer for Filipino users, and safer against fake payout posts.

update public.guides
set
  title_en = 'Walang Gutom food credits: what to check first',
  title_fil = 'Walang Gutom food credits: mga dapat i-check muna',
  tagline_en = 'Understand validation, EBT cards, accredited stores, allowed food items, and fake payout red flags before submitting details.',
  tagline_fil = 'Alamin muna ang validation, EBT card, accredited stores, allowed food items, at fake payout red flags bago magpasa ng details.',
  read_time_min = 8,
  estimated_time = '30-60 minuto para mag-verify',
  keywords_en = 'dswd walang gutom food stamp program food credits ebt card accredited stores food poor household nutrition assistance ayuda validation redemption fake registration payout',
  keywords_fil = 'dswd walang gutom food stamp program food credits ebt card accredited stores pagkain food poor household ayuda validation redemption fake registration payout benepisyaryo',
  updated_at = now()
where slug = 'walang-gutom-food-credits-checklist';

update public.guide_sections
set
  content_en = '{"title":"Walang Gutom is food assistance, not ordinary cash ayuda","body":"DSWD describes Walang Gutom as the national food stamp or food credits program for food-poor families. Beneficiaries may use Electronic Benefit Transfer cards or food credits to buy selected nutritious food from accredited stores or merchants. Do not treat every viral post as an open application or cash payout.","items":["Food credits are for selected food items, not general cash spending","Redemption is through official methods and accredited stores or merchants","Beneficiaries are validated through official program processes","Availability depends on rollout, area, and official beneficiary lists","Never pay someone promising an EBT card, food credits, or guaranteed slot"]}'::jsonb,
  content_fil = '{"title":"Ang Walang Gutom ay food assistance, hindi ordinary cash ayuda","body":"Ayon sa DSWD, ang Walang Gutom ay food stamp o food credits program para sa food-poor families. Maaaring gumamit ang beneficiaries ng Electronic Benefit Transfer card o food credits para makabili ng piling masustansyang pagkain sa accredited stores o merchants. Huwag ituring ang bawat viral post bilang open application o cash payout.","items":["Ang food credits ay para sa piling pagkain, hindi pang-general cash spending","Ang redemption ay dumadaan sa official method at accredited stores o merchants","Ang beneficiaries ay validated sa official program process","Depende sa rollout, lugar, at official beneficiary list ang availability","Huwag magbayad sa taong nangangako ng EBT card, food credits, o guaranteed slot"]}'::jsonb
where guide_id = (select id from public.guides where slug = 'walang-gutom-food-credits-checklist')
  and order_index = 1;

update public.guide_sections
set
  content_en = '{"title":"Ask this before submitting anything","body":"Use a specific question so the office can answer with the current process in your area.","sample":"Hello po. Magtatanong lang po tungkol sa DSWD Walang Gutom Program. Active po ba ang validation, EBT card distribution, or redemption sa [barangay/city/province]? Paano po malalaman kung kasama ang household namin, saan po ang official list or schedule, at aling accredited store po ang pwedeng puntahan?"}'::jsonb,
  content_fil = '{"title":"Ito ang itanong bago magpasa ng kahit ano","body":"Mas madaling makakuha ng tamang sagot kapag specific ang tanong mo tungkol sa current process sa lugar ninyo.","sample":"Hello po. Magtatanong lang po tungkol sa DSWD Walang Gutom Program. Active po ba ang validation, EBT card distribution, o redemption sa [barangay/city/province]? Paano po malalaman kung kasama ang household namin, saan po ang official list o schedule, at aling accredited store po ang pwedeng puntahan?"}'::jsonb
where guide_id = (select id from public.guides where slug = 'walang-gutom-food-credits-checklist')
  and order_index = 5;

update public.guide_sections
set
  content_en = '{"title":"Do not assume food credits work like cash","body":"Food credits are not the same as money you can spend anywhere. They may work only through official redemption methods, accredited merchants, approved food items, and current program rules.","items":["Do not expect withdrawal as cash unless an official source says so","Do not buy or rent another person''s card","Do not share card details with strangers","Ask what items are allowed before going to the store","Ask what to do if the card is lost, inactive, or has balance issues"]}'::jsonb,
  content_fil = '{"title":"Huwag isipin na parang cash ang food credits","body":"Hindi pareho ang food credits at perang pwedeng gastusin kahit saan. Maaari lang itong gumana sa official redemption method, accredited merchants, approved food items, at current program rules.","items":["Huwag umasa na pwedeng i-withdraw as cash kung walang official source","Huwag bumili o manghiram ng card ng iba","Huwag ibigay ang card details sa strangers","Itanong muna kung anong items ang allowed bago pumunta sa store","Itanong kung ano ang gagawin kapag nawala, inactive, o may balance issue ang card"]}'::jsonb
where guide_id = (select id from public.guides where slug = 'walang-gutom-food-credits-checklist')
  and order_index = 7;

delete from public.guide_sections
where guide_id = (select id from public.guides where slug = 'walang-gutom-food-credits-checklist')
  and order_index = 9;

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values (
  (select id from public.guides where slug = 'walang-gutom-food-credits-checklist'),
  'tip',
  9,
  '{"title":"What to expect before you travel","body":"Walang Gutom can look different depending on rollout area and current schedule. Before spending fare or missing work, verify the exact local instruction first.","items":["Validation may happen before card release or redemption","Some areas may have schedules while others may not be active yet","Accredited stores and allowed items can vary","Bring only the documents requested by official channels","Keep expectations realistic: validation does not always mean immediate redemption"]}'::jsonb,
  '{"title":"Ano ang aasahan bago bumiyahe","body":"Pwedeng magkaiba ang itsura ng Walang Gutom depende sa rollout area at current schedule. Bago gumastos sa pamasahe o umabsent sa trabaho, i-verify muna ang eksaktong local instruction.","items":["Maaaring may validation bago ang card release o redemption","May lugar na may schedule at may lugar na hindi pa active","Pwedeng mag-iba ang accredited stores at allowed items","Dalhin lang ang documents na hinihingi ng official channels","Maging realistic: ang validation ay hindi laging ibig sabihin immediate redemption"]}'::jsonb
);
