-- Upgrade DSWD AICS as the anchor government financial aid guide.
-- Goal: explain active crisis assistance clearly without promising approval.

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
  'dswd-aics-assistance-checklist',
  (select id from public.categories where slug = 'gov'),
  'DSWD AICS checklist for crisis financial assistance',
  'DSWD AICS checklist para sa financial assistance',
  'Know what AICS may cover, what to prepare, how Guarantee Letters work, and how to avoid fake assistance posts.',
  'Alamin kung ano ang pwedeng saklaw ng AICS, ano ang ihahanda, paano gumagana ang Guarantee Letter, at paano umiwas sa fake assistance posts.',
  true,
  false,
  true,
  8,
  'katamtaman',
  '30-60 minuto',
  'Libre magtanong',
  array[
    'dswd',
    'aics',
    'financial assistance',
    'medical assistance',
    'burial assistance',
    'transportation assistance',
    'education assistance',
    'food assistance',
    'guarantee letter',
    'akap',
    'crisis',
    'ayuda',
    'gobyerno'
  ],
  'dswd aics financial assistance medical burial transportation education food crisis guarantee letter akap ayuda social worker',
  'dswd aics financial assistance medical burial transportation education food crisis guarantee letter akap ayuda gobyerno social worker tulong',
  '[
    {"title":"Assistance to Individuals in Crisis Situation","publisher":"DSWD","url":"https://www.dswd.gov.ph/assistance-to-individuals-in-crisis-situation/"},
    {"title":"AICS serves former AKAP clients under 2026 budget","publisher":"DSWD","url":"https://www.dswd.gov.ph/with-defunded-akap-out-aics-to-serve-its-3-6m-clients-with-php63-b-budget-for-2026-dswd-cip-official/"},
    {"title":"DSWD starts 2026 with AICS aid releases","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-starts-year-with-more-than-14k-beneficiaries-of-aics-disbursing-over-php361m/"},
    {"title":"AICS Services","publisher":"DSWD Crisis Intervention Program","url":"https://aics.dswd.gov.ph/services/"},
    {"title":"AICS/AKAP FAQs","publisher":"DSWD Crisis Intervention Program","url":"https://crisis-intervention.dswd.gov.ph/about-us/faqs/"}
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
  where slug = 'dswd-aics-assistance-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'what_to_know',
    1,
    '{"title":"AICS is crisis assistance, not guaranteed ayuda","body":"DSWD AICS is for individuals and families in crisis. It may help with urgent needs such as medical, burial, transportation, education, food, or other support after assessment by a social worker. The safest mindset is: prepare proof, ask the right office, and never pay anyone promising guaranteed approval.","items":["Assessment is required","Requirements may vary by case and field office","Help can be cash, material assistance, referral, or Guarantee Letter","Approval and amount depend on the assessed need and available guidelines"]}'::jsonb,
    '{"title":"Ang AICS ay crisis assistance, hindi guaranteed ayuda","body":"Ang DSWD AICS ay para sa indibidwal o pamilyang may crisis. Maaari itong tumulong sa urgent needs tulad ng medical, burial, transportation, education, food, o ibang support pagkatapos ng assessment ng social worker. Pinaka-safe na mindset: maghanda ng proof, magtanong sa tamang office, at huwag magbayad sa kahit sinong nangangako ng guaranteed approval.","items":["Kailangan ng assessment","Maaaring mag-iba ang requirements depende sa case at field office","Pwedeng cash, material assistance, referral, o Guarantee Letter ang tulong","Depende sa assessed need at guidelines ang approval at halaga"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'step',
    2,
    '{"title":"Identify your exact crisis need first","body":"Do not start with a vague request for ayuda. Write down the exact problem so the office can tell you which requirements apply.","step_number":1,"items":["Medical bill, medicine, procedure, or hospital need","Burial or funeral expense","Transportation need because of crisis","Education-related crisis expense","Food or non-food urgent need","Other crisis support that needs assessment"]}'::jsonb,
    '{"title":"Alamin muna ang eksaktong crisis need","body":"Huwag magsimula sa malabong request na ayuda lang. Isulat ang eksaktong problema para masabi ng office kung aling requirements ang applicable.","step_number":1,"items":["Medical bill, gamot, procedure, o hospital need","Burial o funeral expense","Transportation need dahil sa crisis","Education-related crisis expense","Food o non-food urgent need","Ibang crisis support na kailangan ng assessment"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'step',
    3,
    '{"title":"Use this priority order before traveling","body":"Many people waste money going to the wrong office with incomplete proof. Secure the most important documents first, then verify the receiving office or online instructions.","step_number":2,"items":["Valid ID or supporting ID of client/representative","Proof of crisis: bill, prescription, death certificate, school billing, travel need, or referral","Contact number and complete address","Photocopies or clear phone scans","Name and location of the DSWD Field Office, CIU, or official channel handling your area"]}'::jsonb,
    '{"title":"Gamitin ang priority order bago bumiyahe","body":"Maraming nasasayang ang pamasahe dahil maling office ang napuntahan o kulang ang proof. Unahin ang pinaka-importanteng documents, tapos i-verify ang receiving office o official instructions.","step_number":2,"items":["Valid ID o supporting ID ng client/representative","Proof ng crisis: bill, reseta, death certificate, school billing, travel need, o referral","Contact number at kumpletong address","Photocopies o malinaw na phone scans","Pangalan at lokasyon ng DSWD Field Office, CIU, o official channel sa area mo"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'step',
    4,
    '{"title":"Know the common assistance paths","body":"Use this as a sorting guide. The exact documents still depend on DSWD assessment and current field office instructions.","step_number":3,"items":["Medical: hospital bill, prescription, medical certificate, treatment request, or laboratory request","Burial: death certificate, funeral contract or bill, claimant ID, and relationship proof if requested","Transportation: proof of emergency travel need, destination, ID, and contact details","Education: proof of enrollment, billing, school expense, or crisis affecting schooling","Food or non-food: proof of crisis, household details, and local referral if available"]}'::jsonb,
    '{"title":"Alamin ang common assistance paths","body":"Gamitin ito bilang sorting guide. Depende pa rin sa DSWD assessment at current field office instructions ang eksaktong documents.","step_number":3,"items":["Medical: hospital bill, reseta, medical certificate, treatment request, o laboratory request","Burial: death certificate, funeral contract o bill, claimant ID, at proof of relationship kung hinihingi","Transportation: proof ng emergency travel need, destination, ID, at contact details","Education: proof of enrollment, billing, school expense, o crisis na nakaapekto sa pag-aaral","Food o non-food: proof ng crisis, household details, at local referral kung meron"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'tip',
    5,
    '{"title":"Understand cash assistance vs Guarantee Letter","body":"Some AICS help may be given as direct aid, while some may be handled through a Guarantee Letter to a partner hospital, pharmacy, funeral service, transport provider, or other service provider. A Guarantee Letter helps ensure the assistance is used for the approved purpose.","items":["Ask whether your case may use cash aid, referral, or Guarantee Letter","Ask which partner provider can accept the letter","Keep copies or photos of all documents submitted","Do not pay anyone to prepare or release a Guarantee Letter"]}'::jsonb,
    '{"title":"Intindihin ang cash assistance vs Guarantee Letter","body":"May AICS help na maaaring direct aid, at may ibang maaaring dumaan sa Guarantee Letter para sa partner hospital, pharmacy, funeral service, transport provider, o ibang service provider. Nakakatulong ang Guarantee Letter para mapunta ang assistance sa approved purpose.","items":["Itanong kung cash aid, referral, o Guarantee Letter ang posibleng path ng case mo","Itanong kung aling partner provider ang tumatanggap ng letter","Magtabi ng kopya o photo ng lahat ng ipinasa","Huwag magbayad sa kahit sino para gumawa o maglabas ng Guarantee Letter"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'warning',
    6,
    '{"title":"AKAP-related posts can be confusing in 2026","body":"DSWD has said that former AKAP clients may be served through AICS under the 2026 AICS budget, subject to crisis assessment. Treat viral AKAP or ayuda posts carefully. Verify through official DSWD channels before submitting documents or personal details.","severity":"high","items":["Do not assume an old AKAP post is still valid","Do not pay processing fees","Do not send OTP, passwords, bank login, or e-wallet login","Do not upload IDs to random forms","Ask the DSWD Field Office or official page for current instructions"]}'::jsonb,
    '{"title":"Nakakalito ang ilang AKAP-related posts sa 2026","body":"Sinabi ng DSWD na maaaring ma-serve sa AICS ang dating AKAP clients sa ilalim ng 2026 AICS budget, pero subject pa rin ito sa crisis assessment. Mag-ingat sa viral AKAP o ayuda posts. Mag-verify muna sa official DSWD channels bago magpasa ng documents o personal details.","severity":"high","items":["Huwag agad maniwala na valid pa ang lumang AKAP post","Huwag magbayad ng processing fee","Huwag magbigay ng OTP, password, bank login, o e-wallet login","Huwag mag-upload ng IDs sa random forms","Magtanong sa DSWD Field Office o official page para sa current instructions"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'mistake',
    7,
    '{"title":"Going to DSWD with only a story and no proof","body":"A real crisis still needs proof for assessment. Bring documents that show what happened, how much is needed, who is affected, and how you can be contacted.","items":["No ID or unclear identity details","No bill, prescription, certificate, referral, or proof of expense","No contact number or complete address","Only screenshots from unofficial pages","No photocopies or backup copies"]}'::jsonb,
    '{"title":"Pumupunta sa DSWD na kwento lang ang dala","body":"Kahit totoong crisis, kailangan pa rin ng proof para ma-assess. Magdala ng documents na nagpapakita kung ano ang nangyari, magkano ang kailangan, sino ang affected, at paano ka makokontak.","items":["Walang ID o malabo ang identity details","Walang bill, reseta, certificate, referral, o proof of expense","Walang contact number o kumpletong address","Screenshots lang mula sa unofficial pages","Walang photocopy o backup copy"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'tip',
    8,
    '{"title":"Ask one clear question before lining up","body":"A clear message helps you avoid the wrong line, wrong office, or incomplete documents.","sample":"Hello po. Magtatanong lang po sana tungkol sa DSWD AICS. Kailangan po namin ng tulong para sa [medical/burial/transportation/education/food] dahil sa [short reason]. Ano po ang current requirements, saan po ang official submission, at kailangan po ba ng appointment o referral?"}'::jsonb,
    '{"title":"Magtanong ng isang malinaw na tanong bago pumila","body":"Mas makakaiwas ka sa maling pila, maling office, o kulang na documents kapag malinaw ang tanong mo.","sample":"Hello po. Magtatanong lang po sana tungkol sa DSWD AICS. Kailangan po namin ng tulong para sa [medical/burial/transportation/education/food] dahil sa [short reason]. Ano po ang current requirements, saan po ang official submission, at kailangan po ba ng appointment o referral?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'warning',
    9,
    '{"title":"Red flags of fake assistance pages and fixers","body":"AICS is assessed through official channels. Be careful with people or pages promising instant approval, guaranteed slots, priority numbers, or document processing for a fee.","severity":"high","items":["Guaranteed approval or sure payout","Processing fee, reservation fee, or fixer fee","OTP, MPIN, password, or bank/e-wallet login request","Random shortened link or personal Google Form asking for IDs","Pressure to submit today without official memo","Someone claiming they can bypass assessment"]}'::jsonb,
    '{"title":"Red flags ng fake assistance pages at fixers","body":"Ina-assess ang AICS sa official channels. Mag-ingat sa tao o page na nangangako ng instant approval, guaranteed slot, priority number, o document processing kapalit ng bayad.","severity":"high","items":["Guaranteed approval o sure payout","Processing fee, reservation fee, o fixer fee","Hinihinging OTP, MPIN, password, o bank/e-wallet login","Random shortened link o personal Google Form na humihingi ng IDs","Pinapamadali kang mag-submit ngayon kahit walang official memo","May nagsasabing kaya niyang i-bypass ang assessment"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-aics-assistance-checklist'),
    'tip',
    10,
    '{"title":"Save your application trail","body":"Keep a small record of every official office, page, or person you contacted. This helps if you need to follow up or prove that you followed official instructions.","items":["Date and time of inquiry","Office or official page contacted","Name or position of person who answered, if given","Requirements list received","Reference number, ticket, or queue number","Photos of submitted documents and receipts"]}'::jsonb,
    '{"title":"I-save ang application trail mo","body":"Magtabi ng record ng bawat official office, page, o taong nakausap mo. Makakatulong ito kung kailangan mong mag-follow up o ipakita na official instructions ang sinunod mo.","items":["Date at oras ng inquiry","Office o official page na kinontak","Pangalan o position ng sumagot kung ibinigay","Requirements list na natanggap","Reference number, ticket, o queue number","Photos ng submitted documents at receipts"]}'::jsonb
  );
