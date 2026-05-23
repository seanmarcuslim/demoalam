-- Add DSWD Walang Gutom Program guide.
-- Goal: explain food credits, validation, redemption, and fake registration risks.

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
  'walang-gutom-food-credits-checklist',
  (select id from public.categories where slug = 'gov'),
  'Walang Gutom food credits checklist',
  'Walang Gutom food credits checklist',
  'Know how DSWD food credits, EBT cards, accredited stores, and validation work before trusting registration posts.',
  'Alamin kung paano gumagana ang DSWD food credits, EBT card, accredited stores, at validation bago maniwala sa registration posts.',
  true,
  false,
  true,
  7,
  'katamtaman',
  '30-60 minuto magtanong',
  'Libre magtanong',
  array[
    'dswd',
    'walang gutom',
    'food stamp',
    'food credits',
    'ebt card',
    'food assistance',
    'financial assistance',
    'nutrition',
    'gobyerno',
    'ayuda',
    'pagkain'
  ],
  'dswd walang gutom food stamp program food credits ebt card accredited stores food poor household nutrition assistance ayuda',
  'dswd walang gutom food stamp program food credits ebt card accredited stores food poor household pagkain ayuda gobyerno nutrition assistance',
  '[
    {"title":"Walang Gutom Program","publisher":"DSWD","url":"https://www.dswd.gov.ph/walang-gutom-program/"},
    {"title":"Walang Gutom reaches 600,000 beneficiaries in 2nd year rollout","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-walang-gutom-program-reaches-600000-beneficiaries-in-2nd-year-rollout/"},
    {"title":"600,000 na ang mga benepisyaryo ng DSWD Walang Gutom Program","publisher":"DSWD","url":"https://www.dswd.gov.ph/600000-na-ang-mga-benepisyaryo-ng-department-of-social-welfare-and-development-dswd-walang-gutom-program-wgp/"},
    {"title":"Walang Gutom Program beneficiaries and food assistance updates","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-intensifying-efforts-to-assist-walang-gutom-beneficiaries-amid-energy-emergency-rising-commodities/"}
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
  where slug = 'walang-gutom-food-credits-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'walang-gutom-food-credits-checklist'),
    'what_to_know',
    1,
    '{"title":"Walang Gutom is food assistance, not ordinary cash ayuda","body":"DSWD describes the Walang Gutom Program as the national food stamp or food credits program for food-poor families. Beneficiaries use Electronic Benefit Transfer cards or food credits to buy selected nutritious food from accredited stores or merchants. Do not treat every viral post as an open application or cash payout.","items":["Food credits are meant for selected nutritious food items","Redemption is through accredited stores or merchants","Beneficiaries are validated through official program processes","Availability depends on rollout, area, and official beneficiary lists","Never pay someone promising an EBT card or guaranteed slot"]}'::jsonb,
    '{"title":"Ang Walang Gutom ay food assistance, hindi ordinary cash ayuda","body":"Ayon sa DSWD, ang Walang Gutom Program ay food stamp o food credits program para sa food-poor families. Gumagamit ang beneficiaries ng Electronic Benefit Transfer card o food credits para makabili ng selected nutritious food sa accredited stores o merchants. Huwag ituring ang bawat viral post bilang open application o cash payout.","items":["Ang food credits ay para sa selected nutritious food items","Ang redemption ay sa accredited stores o merchants","Ang beneficiaries ay validated sa official program process","Depende sa rollout, lugar, at official beneficiary list ang availability","Huwag magbayad sa taong nangangako ng EBT card o guaranteed slot"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'walang-gutom-food-credits-checklist'),
    'step',
    2,
    '{"title":"Check if the program is active in your area","body":"Before submitting anything, verify whether Walang Gutom validation, registration, card distribution, or redemption is active in your city, municipality, province, or barangay.","step_number":1,"items":["Official DSWD national page","DSWD Field Office page for your region","Official LGU page or social welfare office announcement","Barangay or city/municipal social welfare office","Actual schedule for validation, card distribution, or redemption"]}'::jsonb,
    '{"title":"Suriin kung active ang program sa lugar ninyo","body":"Bago magpasa ng kahit ano, i-verify muna kung may active Walang Gutom validation, registration, card distribution, o redemption sa city, municipality, province, o barangay ninyo.","step_number":1,"items":["Official DSWD national page","DSWD Field Office page ng region ninyo","Official LGU page o social welfare office announcement","Barangay o city/municipal social welfare office","Aktwal na schedule ng validation, card distribution, o redemption"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'walang-gutom-food-credits-checklist'),
    'step',
    3,
    '{"title":"Prepare household proof before asking","body":"The program focuses on households, so prepare information that helps official offices verify identity, residence, and household situation. Do not upload these to random links.","step_number":2,"items":["Valid ID of household representative","Complete address and contact number","Household member details if requested","Proof of residence or barangay record if requested","Any official notice, text, stub, or card information if already selected","Photos or copies kept only for official submission channels"]}'::jsonb,
    '{"title":"Ihanda ang household proof bago magtanong","body":"Household ang focus ng program, kaya maghanda ng impormasyon na makakatulong sa official offices na ma-verify ang identity, residence, at household situation. Huwag i-upload ang mga ito sa random links.","step_number":2,"items":["Valid ID ng household representative","Kumpletong address at contact number","Household member details kung hinihingi","Proof of residence o barangay record kung hinihingi","Official notice, text, stub, o card information kung selected na","Photos o copies na itatabi lang para sa official submission channels"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'walang-gutom-food-credits-checklist'),
    'step',
    4,
    '{"title":"Understand EBT card and redemption basics","body":"DSWD updates describe beneficiaries using food credits through EBT cards in accredited partner retailers. Ask where the card can be used, what items are allowed, and the redemption period before traveling.","step_number":3,"items":["Is there an EBT card, RBGI card, USSC card, or other official redemption method?","Which accredited store or merchant can accept it?","What food items are allowed?","What is the redemption date range?","What ID or proof must be brought during redemption?","What should you do if the card is lost, not working, or has no balance?"]}'::jsonb,
    '{"title":"Intindihin ang EBT card at redemption basics","body":"Ayon sa DSWD updates, gumagamit ang beneficiaries ng food credits sa pamamagitan ng EBT cards sa accredited partner retailers. Itanong muna kung saan magagamit ang card, anong items ang allowed, at kailan ang redemption period bago bumiyahe.","step_number":3,"items":["May EBT card, RBGI card, USSC card, o ibang official redemption method ba?","Aling accredited store o merchant ang tumatanggap nito?","Anong food items ang allowed?","Ano ang redemption date range?","Anong ID o proof ang kailangang dalhin sa redemption?","Ano ang gagawin kung nawala, hindi gumana, o walang balance ang card?"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'walang-gutom-food-credits-checklist'),
    'tip',
    5,
    '{"title":"Ask a direct verification question","body":"A clear question helps you avoid fake forms and wrong offices.","sample":"Hello po. Magtatanong lang po tungkol sa DSWD Walang Gutom Program. Active po ba ang validation, EBT card distribution, o redemption sa [barangay/city/province]? Paano po malalaman kung kasama ang household namin, saan po ang official list o schedule, at aling accredited store po ang pwedeng puntahan?"}'::jsonb,
    '{"title":"Magtanong ng direct verification question","body":"Mas makakaiwas ka sa fake forms at maling office kapag malinaw ang tanong.","sample":"Hello po. Magtatanong lang po tungkol sa DSWD Walang Gutom Program. Active po ba ang validation, EBT card distribution, o redemption sa [barangay/city/province]? Paano po malalaman kung kasama ang household namin, saan po ang official list o schedule, at aling accredited store po ang pwedeng puntahan?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'walang-gutom-food-credits-checklist'),
    'warning',
    6,
    '{"title":"Avoid fake Walang Gutom registration and payout posts","body":"The program uses official validation and redemption channels. Be careful with posts promising instant inclusion, cash payout, or EBT card release through random forms.","severity":"high","items":["Processing fee or card release fee","Guaranteed slot or sure inclusion","Random Google Form asking for full IDs, bank details, or selfies","OTP, PIN, password, bank login, or e-wallet login request","Payout schedule that cannot be verified by DSWD, LGU, or official program page","Someone offering to sell or rent an EBT card"]}'::jsonb,
    '{"title":"Iwasan ang fake Walang Gutom registration at payout posts","body":"Gumagamit ang program ng official validation at redemption channels. Mag-ingat sa posts na nangangako ng instant inclusion, cash payout, o EBT card release sa random forms.","severity":"high","items":["Processing fee o card release fee","Guaranteed slot o sure inclusion","Random Google Form na humihingi ng full IDs, bank details, o selfies","Hinihinging OTP, PIN, password, bank login, o e-wallet login","Payout schedule na hindi ma-verify sa DSWD, LGU, o official program page","May nagbebenta o nagpaparenta ng EBT card"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'walang-gutom-food-credits-checklist'),
    'mistake',
    7,
    '{"title":"Thinking food credits can be used anywhere","body":"Food credits are not the same as cash. They may be used only through official redemption methods and accredited merchants, and only for allowed food items or program rules."}'::jsonb,
    '{"title":"Iniisip na pwedeng gamitin kahit saan ang food credits","body":"Hindi pareho ang food credits at cash. Maaari lang itong magamit sa official redemption method at accredited merchants, at para lang sa allowed food items o program rules."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'walang-gutom-food-credits-checklist'),
    'tip',
    8,
    '{"title":"Keep redemption proof and schedule screenshots","body":"Save official announcements, card details, store name, redemption period, and receipts. This helps if there is a card issue, missed schedule, or confusion at the store.","items":["Official announcement or text message","Card or reference details, if available","Accredited store or merchant name","Redemption date range","Receipt or proof after redemption","Name of office or person contacted, if given"]}'::jsonb,
    '{"title":"I-save ang redemption proof at schedule screenshots","body":"Itago ang official announcements, card details, store name, redemption period, at resibo. Makakatulong ito kapag may card issue, missed schedule, o kalituhan sa store.","items":["Official announcement o text message","Card o reference details kung meron","Accredited store o merchant name","Redemption date range","Resibo o proof pagkatapos ng redemption","Pangalan ng office o taong nakausap kung ibinigay"]}'::jsonb
  );
