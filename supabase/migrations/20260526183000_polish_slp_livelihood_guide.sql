-- Polish DSWD Sustainable Livelihood Program guide.
-- Goal: explain SLP tracks, modalities, social preparation, and anti-fake-grant guidance.

update public.guides
set
  title_en = 'DSWD livelihood support: how to check if SLP fits your case',
  title_fil = 'DSWD livelihood support: paano i-check kung bagay ang SLP sa case mo',
  tagline_en = 'Understand SLP tracks, seed capital, skills training, employment support, assessment, and fake livelihood grant red flags.',
  tagline_fil = 'Intindihin ang SLP tracks, seed capital, skills training, employment support, assessment, at red flags ng fake livelihood grants.',
  read_time_min = 8,
  estimated_time = '30-60 min',
  estimated_cost = 'Official channels only',
  tags = array[
    'dswd',
    'sustainable livelihood program',
    'slp',
    'livelihood assistance',
    'seed capital',
    'skills training fund',
    'employment assistance fund',
    'cash for building livelihood assets',
    'microenterprise',
    'employment facilitation',
    'social preparation',
    '4ps',
    'ofw',
    'financial assistance',
    'negosyo',
    'kabuhayan'
  ],
  keywords_en = 'dswd sustainable livelihood program slp livelihood assistance seed capital skills training fund employment assistance fund cash for building livelihood assets cbla cblaf microenterprise employment facilitation social preparation 4ps ofw negosyo',
  keywords_fil = 'dswd sustainable livelihood program slp livelihood assistance seed capital skills training fund employment assistance fund cash for building livelihood assets cbla cblaf microenterprise employment facilitation social preparation 4ps ofw negosyo kabuhayan',
  official_sources = '[
    {"title":"Sustainable Livelihood Program","publisher":"DSWD SLP","url":"https://livelihood.dswd.gov.ph/about"},
    {"title":"Sustainable Livelihood Program not just about cash, but long-term preparedness","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswds-sustainable-livelihood-program-not-just-about-cash-but-long-term-preparedness-slp-head/"},
    {"title":"DSWD livelihood program benefits vulnerable Filipinos","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-livelihood-program-benefits-235074-vulnerable-pinoys/"},
    {"title":"Sustainable Livelihood Program","publisher":"DSWD Field Office CAR","url":"https://car.dswd.gov.ph/programs-services/core-programs/sustainable-livelihood-program/"},
    {"title":"Sustainable Livelihood Program","publisher":"DSWD Field Office NCR","url":"https://ncr.dswd.gov.ph/sustainable-livelihood-program/"}
  ]'::jsonb,
  updated_at = now()
where slug = 'sustainable-livelihood-program-checklist';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'sustainable-livelihood-program-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'sustainable-livelihood-program-checklist'),
    'what_to_know',
    1,
    '{"title":"SLP is livelihood preparation and support, not instant cash ayuda","body":"DSWD describes the Sustainable Livelihood Program or SLP as a capability-building program for poor, vulnerable, and marginalized households and communities. It helps participants access skills, assets, employment support, and livelihood opportunities. DSWD has emphasized that SLP is not just about giving cash, but about long-term preparedness and sustainable income.","items":["SLP has Microenterprise Development and Employment Facilitation tracks","Support may include seed capital, skills training, employment assistance, or Cash-for-Building Livelihood Assets","Participants may need assessment, social preparation, training, monitoring, or follow-up","Program fit depends on target group, local rollout, and available track","Never pay anyone promising instant livelihood grant approval"]}'::jsonb,
    '{"title":"Ang SLP ay livelihood preparation at support, hindi instant cash ayuda","body":"Ayon sa DSWD, ang Sustainable Livelihood Program o SLP ay capability-building program para sa poor, vulnerable, at marginalized households and communities. Tinutulungan nito ang participants na magkaroon ng skills, assets, employment support, at livelihood opportunities. Nilinaw ng DSWD na ang SLP ay hindi lang cash, kundi long-term preparedness at sustainable income.","items":["May Microenterprise Development at Employment Facilitation tracks ang SLP","Maaaring may seed capital, skills training, employment assistance, o Cash-for-Building Livelihood Assets","Maaaring kailangan ng assessment, social preparation, training, monitoring, o follow-up","Depende sa target group, local rollout, at available track kung bagay ang program","Huwag magbayad sa taong nangangako ng instant livelihood grant approval"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'sustainable-livelihood-program-checklist'),
    'step',
    2,
    '{"title":"Identify what livelihood problem you are solving","body":"Before asking for SLP, be clear about your need. This helps the office match you to the right track or tell you if another program is more appropriate.","step_number":1,"items":["Starting or expanding a small livelihood","Tools, raw materials, or common service facilities","Skills training or technical-vocational training","Employment documents, medical exams, basic work tools, or early employment support","Community or group livelihood project","Recovery support after displacement, repatriation, disaster, or crisis"]}'::jsonb,
    '{"title":"Alamin kung anong livelihood problem ang inaayos mo","body":"Bago magtanong tungkol sa SLP, linawin muna ang kailangan mo. Mas madali kang maitapat ng office sa tamang track o masabing ibang program ang mas bagay.","step_number":1,"items":["Pagsisimula o pagpapalago ng maliit na kabuhayan","Tools, raw materials, o common service facilities","Skills training o technical-vocational training","Employment documents, medical exams, basic work tools, o early employment support","Community o group livelihood project","Recovery support pagkatapos ng displacement, repatriation, disaster, o crisis"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'sustainable-livelihood-program-checklist'),
    'step',
    3,
    '{"title":"Check which SLP track or modality is active","body":"SLP availability depends on the DSWD Field Office, LGU partnership, target beneficiaries, and current program rollout. Ask which track or modality is active before preparing a long list of documents.","step_number":2,"items":["Microenterprise Development Track for livelihood or small enterprise support","Employment Facilitation Track for employment-related preparation and support","Seed Capital Fund for eligible microenterprise needs","Skills Training Fund for technical or vocational capability-building","Employment Assistance Fund for work-related requirements and early employment support","Cash-for-Building Livelihood Assets for labor-intensive livelihood asset work"]}'::jsonb,
    '{"title":"Suriin kung aling SLP track o modality ang active","body":"Depende sa DSWD Field Office, LGU partnership, target beneficiaries, at current program rollout ang SLP availability. Itanong muna kung anong track o modality ang active bago maghanda ng mahabang listahan ng documents.","step_number":2,"items":["Microenterprise Development Track para sa livelihood o small enterprise support","Employment Facilitation Track para sa employment-related preparation at support","Seed Capital Fund para sa eligible microenterprise needs","Skills Training Fund para sa technical o vocational capability-building","Employment Assistance Fund para sa work-related requirements at early employment support","Cash-for-Building Livelihood Assets para sa labor-intensive livelihood asset work"]}'::jsonb
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
    '{"title":"Ask if SLP is the right program for your case","body":"A direct question helps avoid wrong expectations. SLP may not be the right program if the need is immediate medical, burial, education, or disaster cash aid.","sample":"Hello. I would like to ask about the DSWD Sustainable Livelihood Program. Our need is [livelihood capital/tools/training/employment support] for [short situation]. Is there an active SLP track in [city/province], who is the official contact, and what assessment or requirements should we prepare?"}'::jsonb,
    '{"title":"Itanong kung SLP ba ang tamang program sa case mo","body":"Mas iwas maling expectation kapag direct ang tanong. Maaaring hindi SLP ang tamang program kung immediate medical, burial, education, o disaster cash aid ang kailangan.","sample":"Hello po. Magtatanong lang po tungkol sa DSWD Sustainable Livelihood Program. Ang kailangan po namin ay [livelihood capital/tools/training/employment support] para sa [short situation]. May active SLP track po ba sa [city/province], sino po ang official contact, at anong assessment o requirements ang dapat ihanda?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'sustainable-livelihood-program-checklist'),
    'warning',
    6,
    '{"title":"Avoid fake livelihood grant posts","body":"Scammers often use livelihood grant language because people need capital. Be careful with posts promising guaranteed DSWD grants, instant capital, or payout approval after paying fees. Real livelihood support should have assessment, official rollout, and clear program requirements.","severity":"high","items":["Processing fee, slot fee, membership fee, or seminar fee before assessment","Guaranteed approval or sure grant","Random form asking for full IDs, selfies, bank login, e-wallet login, OTP, or password","No official DSWD Field Office, LGU, or partner organization named","Private account collecting documents or money","Promise of cash with no assessment, training, project, or follow-up requirement"]}'::jsonb,
    '{"title":"Iwasan ang fake livelihood grant posts","body":"Madalas gamitin ng scammers ang livelihood grant language dahil maraming nangangailangan ng puhunan. Mag-ingat sa posts na nangangako ng guaranteed DSWD grant, instant capital, o payout approval pagkatapos magbayad. Ang totoong livelihood support dapat may assessment, official rollout, at malinaw na program requirements.","severity":"high","items":["Processing fee, slot fee, membership fee, o seminar fee bago assessment","Guaranteed approval o sure grant","Random form na humihingi ng full IDs, selfies, bank login, e-wallet login, OTP, o password","Walang official DSWD Field Office, LGU, o partner organization na nakapangalan","Private account ang nangongolekta ng documents o pera","Pangakong cash pero walang assessment, training, project, o follow-up requirement"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'sustainable-livelihood-program-checklist'),
    'mistake',
    7,
    '{"title":"Asking for capital without explaining the livelihood plan","body":"Even a simple plan is better than saying I just need capital. Explain what you can do, what market or job you are targeting, what tools or training are missing, and how the support can help income become more stable.","items":["What livelihood or employment goal are you pursuing?","What skills or experience do you already have?","What exact support is missing?","How will the support help income or employability?","What proof can you show if the office asks for follow-up?"]}'::jsonb,
    '{"title":"Humihingi ng puhunan pero walang livelihood plan","body":"Mas malinaw kahit simpleng plano kaysa basta sabihing kailangan ko po ng puhunan. Ipaliwanag kung ano ang kaya mong gawin, anong market o trabaho ang target mo, anong tools o training ang kulang, at paano makakatulong ang support para maging mas stable ang income.","items":["Anong livelihood o employment goal ang tinatarget mo?","Anong skills o experience ang meron ka na?","Anong exact support ang kulang?","Paano makakatulong ang support sa income o employability?","Anong proof ang kaya mong ipakita kung may follow-up ang office?"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'sustainable-livelihood-program-checklist'),
    'tip',
    8,
    '{"title":"What to expect if assessed for SLP","body":"SLP can involve social preparation, capacity-building, training, project planning, follow-up, or monitoring. Treat it as a livelihood development process, not a one-time payout.","items":["Assessment may check household situation, vulnerability, skills, and program fit","You may be asked to join orientation, social preparation, or training","Support can be individual, group, employment-related, or enterprise-related","There may be monitoring or proof that support was used properly","Keep all official instructions, receipts, photos, and follow-up contacts"]}'::jsonb,
    '{"title":"Ano ang aasahan kung ma-assess para sa SLP","body":"Maaaring may social preparation, capacity-building, training, project planning, follow-up, o monitoring sa SLP. Ituring ito bilang livelihood development process, hindi one-time payout lang.","items":["Maaaring tingnan sa assessment ang household situation, vulnerability, skills, at program fit","Maaaring kailangan mong umattend ng orientation, social preparation, o training","Puwedeng individual, group, employment-related, o enterprise-related ang support","Maaaring may monitoring o proof na tama ang paggamit ng support","Itabi ang official instructions, resibo, photos, at follow-up contacts"]}'::jsonb
  );
