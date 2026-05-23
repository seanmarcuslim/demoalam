-- Add DSWD Sustainable Livelihood Program guide.
-- Goal: explain SLP as capacity-building and livelihood support, not guaranteed cash grant.

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
  'sustainable-livelihood-program-checklist',
  (select id from public.categories where slug = 'money'),
  'DSWD Sustainable Livelihood Program checklist',
  'DSWD Sustainable Livelihood Program checklist',
  'Know when SLP may fit your livelihood need, what tracks exist, and how to avoid fake grant posts.',
  'Alamin kung kailan bagay ang SLP sa livelihood need mo, anong tracks ang meron, at paano umiwas sa fake grant posts.',
  true,
  false,
  true,
  7,
  'katamtaman',
  '30-60 minuto magtanong',
  'Libre magtanong',
  array[
    'dswd',
    'sustainable livelihood program',
    'slp',
    'livelihood assistance',
    'seed capital',
    'microenterprise',
    'employment facilitation',
    'skills training',
    'cash for building livelihood assets',
    '4ps',
    'ofw',
    'financial assistance',
    'negosyo',
    'kabuhayan'
  ],
  'dswd sustainable livelihood program slp livelihood assistance seed capital microenterprise employment facilitation skills training cbla 4ps ofw',
  'dswd sustainable livelihood program slp livelihood assistance seed capital microenterprise employment facilitation skills training cbla 4ps ofw negosyo kabuhayan',
  '[
    {"title":"Sustainable Livelihood Program not just about cash, but long-term preparedness","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswds-sustainable-livelihood-program-not-just-about-cash-but-long-term-preparedness-slp-head/"},
    {"title":"DSWD chief commits cash, livelihood aid for repatriated OFWs","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-chief-commits-to-provide-cash-livelihood-aid-for-repatriated-ofws/"},
    {"title":"Sustainable Livelihood Program","publisher":"DSWD Field Office CAR","url":"https://car.dswd.gov.ph/programs-services/core-programs/sustainable-livelihood-program/"},
    {"title":"Sustainable Livelihood Program","publisher":"DSWD Field Office NCR","url":"https://ncr.dswd.gov.ph/sustainable-livelihood-program/"},
    {"title":"4Ps beneficiaries receive employment assistance through SLP","publisher":"DSWD Field Office IV-A","url":"https://fo4a.dswd.gov.ph/2026/02/4ps-beneficiaries-in-quezon-receive-employment-assistance-from-dswd/"}
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
  where slug = 'sustainable-livelihood-program-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'sustainable-livelihood-program-checklist'),
    'what_to_know',
    1,
    '{"title":"SLP is livelihood support, not instant cash ayuda","body":"DSWD describes the Sustainable Livelihood Program or SLP as a capacity-building program for poor, vulnerable, and marginalized households and communities. It can support livelihood through skills, employment facilitation, seed capital, or community/group enterprise help. It is not a guaranteed cash grant for anyone who fills out a random form.","items":["SLP may support microenterprise or employment tracks","Some support may be seed capital, training, employment assistance, or Cash-for-Building Livelihood Assets","Program fit depends on assessment, target groups, local rollout, and available tracks","4Ps households and other vulnerable groups may be prioritized in some contexts","Never pay someone promising instant livelihood grant approval"]}'::jsonb,
    '{"title":"Ang SLP ay livelihood support, hindi instant cash ayuda","body":"Ayon sa DSWD, ang Sustainable Livelihood Program o SLP ay capacity-building program para sa poor, vulnerable, at marginalized households and communities. Maaari itong tumulong sa livelihood sa pamamagitan ng skills, employment facilitation, seed capital, o community/group enterprise support. Hindi ito guaranteed cash grant para sa kahit sinong sasagot ng random form.","items":["Maaaring may microenterprise o employment tracks ang SLP","May support na seed capital, training, employment assistance, o Cash-for-Building Livelihood Assets","Depende sa assessment, target groups, local rollout, at available tracks ang program fit","Maaaring ma-prioritize ang 4Ps households at ibang vulnerable groups sa ilang context","Huwag magbayad sa taong nangangako ng instant livelihood grant approval"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'sustainable-livelihood-program-checklist'),
    'step',
    2,
    '{"title":"Identify what kind of livelihood help you actually need","body":"Before asking for SLP, be clear about your need. This helps the office match you to the right track or tell you if another program is more appropriate.","step_number":1,"items":["Start-up or expansion capital for a small livelihood","Tools, raw materials, or common service facilities","Skills training or technical-vocational training","Employment requirements or job facilitation support","Community/group livelihood project","Recovery support after displacement, repatriation, or crisis"]}'::jsonb,
    '{"title":"Alamin kung anong livelihood help talaga ang kailangan","body":"Bago magtanong tungkol sa SLP, linawin muna ang kailangan mo. Mas madali kang maitapat ng office sa tamang track o masabing ibang program ang mas bagay.","step_number":1,"items":["Start-up o expansion capital para sa maliit na kabuhayan","Tools, raw materials, o common service facilities","Skills training o technical-vocational training","Employment requirements o job facilitation support","Community/group livelihood project","Recovery support pagkatapos ng displacement, repatriation, o crisis"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'sustainable-livelihood-program-checklist'),
    'step',
    3,
    '{"title":"Check which SLP track or local rollout is active","body":"SLP availability can depend on the DSWD Field Office, LGU partnership, target beneficiaries, and current program rollout. Ask the office what track is active before preparing a long list of documents.","step_number":2,"items":["Microenterprise Development Track","Employment Facilitation Track","Seed Capital Fund","Skills Training Fund","Cash-for-Building Livelihood Assets or CBLA","Special rollout for 4Ps, OFWs, disaster-affected families, PWDs, or other target groups"]}'::jsonb,
    '{"title":"Suriin kung aling SLP track o local rollout ang active","body":"Depende sa DSWD Field Office, LGU partnership, target beneficiaries, at current program rollout ang SLP availability. Itanong muna sa office kung anong track ang active bago maghanda ng mahabang listahan ng documents.","step_number":2,"items":["Microenterprise Development Track","Employment Facilitation Track","Seed Capital Fund","Skills Training Fund","Cash-for-Building Livelihood Assets o CBLA","Special rollout para sa 4Ps, OFWs, disaster-affected families, PWDs, o ibang target groups"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'sustainable-livelihood-program-checklist'),
    'step',
    4,
    '{"title":"Prepare a simple livelihood profile","body":"You do not need a fancy business plan before asking, but you should be ready to explain your household situation, livelihood idea, skills, and what support you need.","step_number":3,"items":["Valid ID and contact details","Address and household situation","Current income source or livelihood experience","Simple livelihood idea or employment goal","Skills, training, tools, or materials you already have","Estimated support needed and why","Group or association details if applying as a group"]}'::jsonb,
    '{"title":"Maghanda ng simpleng livelihood profile","body":"Hindi kailangan ng sobrang fancy business plan bago magtanong, pero dapat kaya mong ipaliwanag ang household situation, livelihood idea, skills, at anong support ang kailangan mo.","step_number":3,"items":["Valid ID at contact details","Address at household situation","Current income source o livelihood experience","Simpleng livelihood idea o employment goal","Skills, training, tools, o materials na meron ka na","Estimated support na kailangan at bakit","Group o association details kung group ang magtatanong"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'sustainable-livelihood-program-checklist'),
    'tip',
    5,
    '{"title":"Ask if SLP is the right program for your case","body":"A direct question helps avoid wrong expectations. SLP may not be the right program if the need is immediate medical, burial, education, or disaster cash aid.","sample":"Hello po. Magtatanong lang po tungkol sa DSWD Sustainable Livelihood Program. Ang kailangan po namin ay [livelihood capital/tools/training/employment support] para sa [short situation]. May active SLP track po ba sa [city/province], sino po ang official contact, at ano po ang requirements or assessment process?"}'::jsonb,
    '{"title":"Itanong kung SLP ba ang tamang program sa case mo","body":"Mas iwas maling expectation kapag direct ang tanong. Maaaring hindi SLP ang tamang program kung immediate medical, burial, education, o disaster cash aid ang kailangan.","sample":"Hello po. Magtatanong lang po tungkol sa DSWD Sustainable Livelihood Program. Ang kailangan po namin ay [livelihood capital/tools/training/employment support] para sa [short situation]. May active SLP track po ba sa [city/province], sino po ang official contact, at ano po ang requirements or assessment process?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'sustainable-livelihood-program-checklist'),
    'warning',
    6,
    '{"title":"Avoid fake livelihood grant posts","body":"Scammers often use livelihood grant language because people need capital. Be careful with posts promising guaranteed DSWD grants, instant capital, or payout approval after paying fees.","severity":"high","items":["Processing fee, slot fee, membership fee, or seminar fee before assessment","Guaranteed approval or sure grant","Random form asking for full IDs, selfies, bank login, e-wallet login, OTP, or password","No official DSWD Field Office, LGU, or partner organization named","Private account collecting documents or money","Promise of cash with no assessment, training, project, or follow-up requirement"]}'::jsonb,
    '{"title":"Iwasan ang fake livelihood grant posts","body":"Madalas gamitin ng scammers ang livelihood grant language dahil maraming nangangailangan ng puhunan. Mag-ingat sa posts na nangangako ng guaranteed DSWD grant, instant capital, o payout approval pagkatapos magbayad.","severity":"high","items":["Processing fee, slot fee, membership fee, o seminar fee bago assessment","Guaranteed approval o sure grant","Random form na humihingi ng full IDs, selfies, bank login, e-wallet login, OTP, o password","Walang official DSWD Field Office, LGU, o partner organization na nakapangalan","Private account ang nangongolekta ng documents o pera","Pangakong cash pero walang assessment, training, project, o follow-up requirement"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'sustainable-livelihood-program-checklist'),
    'mistake',
    7,
    '{"title":"Asking for capital without explaining the livelihood plan","body":"Even a simple plan is better than saying kailangan ko po ng puhunan. Explain what you can do, what market or job you are targeting, what tools or training are missing, and how the support can help income become more stable."}'::jsonb,
    '{"title":"Humihingi ng puhunan pero walang livelihood plan","body":"Mas malinaw kahit simpleng plano kaysa basta sabihing kailangan ko po ng puhunan. Ipaliwanag kung ano ang kaya mong gawin, anong market o trabaho ang target mo, anong tools o training ang kulang, at paano makakatulong ang support para maging mas stable ang income."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'sustainable-livelihood-program-checklist'),
    'tip',
    8,
    '{"title":"Keep assessment and livelihood proof","body":"Save official instructions, assessment schedules, training details, documents submitted, and receipts. Livelihood programs often involve follow-up, monitoring, or proof that support was used properly.","items":["Official DSWD/LGU/partner announcement","Assessment schedule and office contacted","Requirements submitted","Training or orientation details","Livelihood plan or group information","Receipts, photos, or proof of tools/materials if support is approved","Follow-up or monitoring contact"]}'::jsonb,
    '{"title":"I-save ang assessment at livelihood proof","body":"Itago ang official instructions, assessment schedules, training details, documents na ipinasa, at resibo. Madalas may follow-up, monitoring, o proof of use sa livelihood programs.","items":["Official DSWD/LGU/partner announcement","Assessment schedule at office na kinontak","Requirements na ipinasa","Training o orientation details","Livelihood plan o group information","Receipts, photos, o proof ng tools/materials kung approved ang support","Follow-up o monitoring contact"]}'::jsonb
  );
