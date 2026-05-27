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
  published_at,
  updated_at
)
values (
  'barangay-complaint-evidence-checklist',
  (select id from public.categories where slug = 'adulting'),
  'Barangay complaint message and evidence checklist',
  'Barangay complaint checklist bago magreklamo',
  'Prepare your facts, proof, and questions before filing a blotter, complaint, or barangay mediation concern.',
  'Ihanda ang facts, ebidensya, at tanong bago magpa-blotter, magreklamo, o humingi ng barangay mediation.',
  true,
  false,
  true,
  7,
  'katamtaman',
  '15-30 minuto maghanda',
  'Karaniwang libre magtanong; fees may vary by document request',
  array[
    'adulting',
    'barangay',
    'complaint',
    'blotter',
    'evidence',
    'katarungang pambarangay',
    'mediation',
    'conciliation',
    'neighbor dispute',
    'harassment',
    'paper trail',
    'barangay protection order',
    'vawc',
    'public safety'
  ],
  'barangay complaint blotter evidence mediation conciliation katarungang pambarangay neighbor dispute harassment threat noise boundary damage debt barangay protection order vawc paper trail screenshots witness date time location incident report lupon barangay captain kagawad complaint message',
  'barangay reklamo blotter ebidensya mediation conciliation katarungang pambarangay kapitbahay away harassment pagbabanta ingay boundary damage utang barangay protection order vawc paper trail screenshots witness petsa oras lugar incident report lupon barangay captain kagawad complaint message',
  '[
    {"title":"Republic Act No. 7160 - Local Government Code of 1991","publisher":"Supreme Court E-Library","url":"https://elibrary.judiciary.gov.ph/thebookshelf/showdocs/2/53542"},
    {"title":"Katarungang Pambarangay Handbook","publisher":"DILG Region 1 Library","url":"https://library.region1.dilg.gov.ph/view/book/285"},
    {"title":"DILG discussion on Katarungang Pambarangay and 8888 Citizens Complaint Hotline","publisher":"DILG Bantay Korapsyon","url":"https://bantaykorapsyon.dilg.gov.ph/reorientation-on-the-hotline-8888-citizens-complaint-center-and-the-katarungang-pambarangay-law/"},
    {"title":"Barangay Protection Order primer under RA 9262","publisher":"Philippine Commission on Women","url":"https://pcw.gov.ph/assets/files/2020/09/RA-9262.pdf"}
  ]'::jsonb,
  now(),
  now()
)
on conflict (slug) do update
set
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
  updated_at = now();

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'barangay-complaint-evidence-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'barangay-complaint-evidence-checklist'),
    'what_to_know',
    1,
    $${
      "title":"A barangay complaint works better when your facts are organized",
      "body":"Barangays may handle incident recording, community disputes, mediation, conciliation, or referrals depending on the situation. Before going, organize what happened, when, where, who was involved, what proof you have, and what help you are asking for. This guide is not legal advice; it helps you prepare a clear complaint trail.",
      "items":["A blotter records an incident; it does not automatically solve the problem","Some disputes may go through Katarungang Pambarangay mediation or conciliation","Some safety, violence, abuse, or emergency concerns should be escalated beyond ordinary mediation","Evidence and dates matter more than long emotional explanations","Ask the barangay what process applies to your specific concern"]
    }$$::jsonb,
    $${
      "title":"Mas maayos ang barangay complaint kapag organized ang facts",
      "body":"Depende sa sitwasyon, puwedeng tumulong ang barangay sa incident recording, community disputes, mediation, conciliation, o referral. Bago pumunta, ayusin muna kung ano ang nangyari, kailan, saan, sino ang involved, anong ebidensya ang meron ka, at anong tulong ang hinihingi mo. Hindi ito legal advice; guide ito para malinaw ang complaint trail mo.",
      "items":["Ang blotter ay record ng incident; hindi ito automatic na solusyon","May disputes na puwedeng dumaan sa Katarungang Pambarangay mediation o conciliation","May safety, violence, abuse, o emergency concerns na dapat i-escalate beyond ordinary mediation","Mas mahalaga ang ebidensya at dates kaysa mahabang emotional explanation","Itanong sa barangay kung anong process ang applicable sa concern mo"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'barangay-complaint-evidence-checklist'),
    'warning',
    2,
    $${
      "title":"START HERE: if there is immediate danger, do not treat it as a normal complaint",
      "body":"If there is active violence, a serious threat, abuse, stalking, child safety risk, medical emergency, fire, or crime in progress, prioritize safety and emergency help. Go to emergency responders, police, Women and Children Protection Desk, VAW desk, social welfare office, or trusted authorities as appropriate. Barangay mediation is not the first step when someone may be in danger.",
      "severity":"high",
      "items":["Move to a safe place if needed","Call emergency help if there is active danger","Do not meet the other party alone just to settle quickly","Do not post private evidence publicly if it can expose your address, child, ID, or medical details","Ask for a referral or protection process if safety is involved"]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: kung may immediate danger, huwag itong tratuhing ordinary complaint",
      "body":"Kung may ongoing violence, seryosong pagbabanta, abuse, stalking, risk sa bata, medical emergency, sunog, o crime in progress, unahin ang safety at emergency help. Lumapit sa emergency responders, police, Women and Children Protection Desk, VAW desk, social welfare office, o trusted authorities kung appropriate. Hindi unang step ang barangay mediation kung may posibleng panganib.",
      "severity":"high",
      "items":["Lumipat sa safe place kung kailangan","Tumawag ng emergency help kung may active danger","Huwag makipagkita mag-isa sa kabilang party para lang mabilis ma-settle","Huwag mag-post publicly ng private evidence kung exposed ang address, bata, ID, o medical details","Humingi ng referral o protection process kung safety ang involved"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'barangay-complaint-evidence-checklist'),
    'step',
    3,
    $${
      "title":"Write the incident in facts, not insults",
      "body":"A clear timeline helps the barangay understand the issue without guessing.",
      "step_number":1,
      "items":["Date and time of incident","Exact place or address area","People involved and their relation to you","What happened in simple sequence","What was said or done, if important","Whether it happened once or repeatedly","What help you are asking from the barangay"]
    }$$::jsonb,
    $${
      "title":"Isulat ang incident as facts, hindi insulto",
      "body":"Mas madaling maintindihan ng barangay ang concern kapag malinaw ang timeline.",
      "step_number":1,
      "items":["Petsa at oras ng incident","Exact place o area ng address","Mga taong involved at relasyon nila sa iyo","Ano ang nangyari in simple sequence","Ano ang sinabi o ginawa kung importante","Isang beses lang ba o paulit-ulit nang nangyayari","Anong tulong ang hinihingi mo sa barangay"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'barangay-complaint-evidence-checklist'),
    'step',
    4,
    $${
      "title":"Prepare evidence without editing the story",
      "body":"Bring proof that helps verify the incident. Keep originals safe and provide copies when possible.",
      "step_number":2,
      "items":["Screenshots with date, sender, and full context","Photos or videos, if safely taken","Receipts, contracts, letters, notices, or messages","Names and contact details of witnesses, if they are willing","Medical certificate, police report, or other official papers if already available","Previous barangay, police, office, or support-channel reference numbers"]
    }$$::jsonb,
    $${
      "title":"Ihanda ang ebidensya nang hindi ini-edit ang kwento",
      "body":"Magdala ng proof na makakatulong i-verify ang incident. Itago nang maayos ang originals at magbigay ng copies kung kaya.",
      "step_number":2,
      "items":["Screenshots na may date, sender, at full context","Photos o videos kung safe kunin","Receipts, contracts, letters, notices, o messages","Names at contact details ng witnesses kung willing sila","Medical certificate, police report, o ibang official papers kung meron na","Previous barangay, police, office, o support-channel reference numbers"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'barangay-complaint-evidence-checklist'),
    'step',
    5,
    $${
      "title":"Ask what process applies",
      "body":"Not every concern follows the same barangay process. Ask for the correct next step before assuming.",
      "step_number":3,
      "items":["Is this for blotter recording, mediation, conciliation, referral, or another process?","Do I need to fill out a complaint form?","Will there be a summons, schedule, or hearing?","What documents or IDs should I bring?","Can I get a copy, reference number, or receiving proof?","If this involves safety, where should I be referred next?"]
    }$$::jsonb,
    $${
      "title":"Itanong kung anong process ang applicable",
      "body":"Hindi pare-pareho ang barangay process sa lahat ng concern. Magtanong muna ng tamang next step bago mag-assume.",
      "step_number":3,
      "items":["Blotter recording ba ito, mediation, conciliation, referral, o ibang process?","Kailangan ko bang mag-fill out ng complaint form?","May summons, schedule, o hearing ba?","Anong documents o IDs ang dapat kong dalhin?","Puwede ba akong makahingi ng copy, reference number, o receiving proof?","Kung safety ang involved, saan dapat ako i-refer next?"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'barangay-complaint-evidence-checklist'),
    'mistake',
    6,
    $${
      "title":"Common mistakes before filing a barangay concern",
      "body":"These mistakes can weaken your record or create new problems.",
      "items":["Posting the full complaint publicly before asking the proper office","Editing screenshots in a way that removes context","Arriving with only a story and no dates, names, or proof","Using insults instead of facts","Expecting the barangay to solve criminal, emergency, or safety issues through ordinary mediation","Leaving without asking for a copy, reference number, or next step","Signing an agreement you do not understand just to end the meeting"]
    }$$::jsonb,
    $${
      "title":"Karaniwang pagkakamali bago mag-file sa barangay",
      "body":"Puwedeng humina ang record mo o madagdagan ang problema dahil sa mistakes na ito.",
      "items":["Pinopost publicly ang buong reklamo bago lumapit sa tamang office","Ini-edit ang screenshots hanggang nawawala ang context","Pumupunta na kwento lang ang dala, walang dates, names, o proof","Mas maraming insulto kaysa facts","Ina-expect na maresolba ng ordinary mediation ang criminal, emergency, o safety issue","Umaalis nang hindi humihingi ng copy, reference number, o next step","Pumipirma sa agreement na hindi naiintindihan para lang matapos ang meeting"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'barangay-complaint-evidence-checklist'),
    'tip',
    7,
    $${
      "title":"Evidence checklist",
      "body":"Use this before going to the barangay.",
      "items":["Short written timeline","Date, time, and location","Names of people involved","Screenshots or photos with context","Receipts, contracts, notices, or messages","Witness names if available and safe","IDs or proof of address if required","Specific help you are asking for","Questions about copy, schedule, reference number, and next step"]
    }$$::jsonb,
    $${
      "title":"Evidence checklist",
      "body":"Gamitin ito bago pumunta sa barangay.",
      "items":["Maikling written timeline","Petsa, oras, at location","Pangalan ng mga involved","Screenshots o photos na may context","Receipts, contracts, notices, o messages","Witness names kung available at safe","IDs o proof of address kung required","Specific na tulong na hinihingi mo","Tanong tungkol sa copy, schedule, reference number, at next step"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'barangay-complaint-evidence-checklist'),
    'tip',
    8,
    $${
      "title":"Sample message before going to the barangay",
      "body":"Use this to ask what to bring and where to go.",
      "sample":"Hello po. Magtatanong lang po sana ako tungkol sa barangay complaint/blotter for [short concern]. Nangyari po ito noong [date/time] sa [place]. Mayroon po akong [screenshots/photos/messages/witness/details]. Ano po ang tamang process: blotter, mediation, conciliation, or referral? Ano po ang documents na dapat kong dalhin, at puwede po ba akong makahingi ng copy or reference number after filing?"
    }$$::jsonb,
    $${
      "title":"Sample message bago pumunta sa barangay",
      "body":"Gamitin ito para itanong kung ano ang dadalhin at saan pupunta.",
      "sample":"Hello po. Magtatanong lang po sana ako tungkol sa barangay complaint/blotter for [short concern]. Nangyari po ito noong [date/time] sa [place]. Mayroon po akong [screenshots/photos/messages/witness/details]. Ano po ang tamang process: blotter, mediation, conciliation, or referral? Ano po ang documents na dapat kong dalhin, at puwede po ba akong makahingi ng copy or reference number after filing?"
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'barangay-complaint-evidence-checklist'),
    'tip',
    9,
    $${
      "title":"If you are asked to settle immediately",
      "body":"You can ask for time to read, understand, or get advice before signing anything.",
      "sample":"Salamat po. Bago po ako pumirma, puwede ko po bang basahin muna nang buo at humingi ng copy? Gusto ko lang po malinaw kung ano ang napagkasunduan, ano ang deadline, at ano ang mangyayari kung hindi masunod."
    }$$::jsonb,
    $${
      "title":"Kung pinapipirma ka agad sa settlement",
      "body":"Puwede kang humingi ng oras para basahin, maintindihan, o magtanong muna bago pumirma.",
      "sample":"Salamat po. Bago po ako pumirma, puwede ko po bang basahin muna nang buo at humingi ng copy? Gusto ko lang po malinaw kung ano ang napagkasunduan, ano ang deadline, at ano ang mangyayari kung hindi masunod."
    }$$::jsonb
  );
