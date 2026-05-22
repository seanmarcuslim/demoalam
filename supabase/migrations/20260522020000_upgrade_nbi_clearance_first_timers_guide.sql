update public.guides
set
  title_en = 'NBI clearance checklist for first-time jobseekers',
  title_fil = 'NBI clearance checklist para sa first-time jobseekers',
  tagline_en = 'Use the right portal, prepare proof, and avoid paying when you may qualify for the first-time jobseeker benefit.',
  tagline_fil = 'Gamitin ang tamang portal, ihanda ang proof, at iwasang magbayad kung qualified ka sa first-time jobseeker benefit.',
  estimated_cost = '₱0-₱200',
  tags = array['nbi', 'clearance', 'valid id', 'first job', 'requirements', 'first time job seeker', 'barangay certificate', 'ra 11261'],
  keywords_en = 'nbi clearance first time job seeker first job barangay certificate appointment reference number hit ra 11261 valid id',
  keywords_fil = 'nbi clearance first time job seeker unang trabaho barangay certificate appointment reference number hit ra 11261 valid id libre bayad',
  official_sources = '[
    {"title":"NBI Clearance Online Services","publisher":"National Bureau of Investigation","url":"https://clearance.nbi.gov.ph/"},
    {"title":"NBI Clearance First Time Jobseekers","publisher":"National Bureau of Investigation","url":"https://firsttimejobseekers.nbi.gov.ph/"},
    {"title":"Republic Act No. 11261","publisher":"Supreme Court E-Library","url":"https://elibrary.judiciary.gov.ph/thebookshelf/showdocs/2/87437"}
  ]'::jsonb,
  updated_at = now()
where slug = 'nbi-clearance-first-timers';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'nbi-clearance-first-timers'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'nbi-clearance-first-timers'),
    'what_to_know',
    1,
    '{"title":"First-time jobseekers may have a different path","body":"If this is for your first job, check the first-time jobseeker option before using the regular paid NBI clearance path. RA 11261 created fee benefits for qualified first-time jobseekers, but you still need proper proof and an appointment process."}'::jsonb,
    '{"title":"May ibang path para sa first-time jobseekers","body":"Kung para ito sa unang trabaho mo, i-check muna ang first-time jobseeker option bago gumamit ng regular paid NBI clearance path. Sa RA 11261, may fee benefits ang qualified first-time jobseekers, pero kailangan pa rin ng tamang proof at appointment process."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'nbi-clearance-first-timers'),
    'warning',
    2,
    '{"title":"Do not pay first if you are trying to use the first-time jobseeker benefit","body":"Many applicants get confused between the regular NBI clearance path and the first-time jobseeker path. Before paying, confirm if you qualify, prepare the barangay certification or required proof, and use the correct official portal or instructions.","severity":"high"}'::jsonb,
    '{"title":"Huwag agad magbayad kung gagamitin mo ang first-time jobseeker benefit","body":"Maraming applicants ang nalilito sa regular NBI clearance path at first-time jobseeker path. Bago magbayad, i-confirm kung qualified ka, ihanda ang barangay certification o required proof, at gamitin ang tamang official portal o instructions.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'nbi-clearance-first-timers'),
    'step',
    3,
    '{"title":"Choose the right official portal","body":"For regular applicants, use the official NBI clearance site. If you are a first-time jobseeker, check the first-time jobseeker portal or NBI instructions before creating or using an account.","step_number":1,"items":["Regular NBI clearance portal","First-time jobseeker portal if qualified","Your own active email and mobile number","Accurate full name, birthday, and address","Saved reference number or appointment details"]}'::jsonb,
    '{"title":"Piliin ang tamang official portal","body":"Para sa regular applicants, gamitin ang official NBI clearance site. Kung first-time jobseeker ka, i-check ang first-time jobseeker portal o NBI instructions bago gumawa o gumamit ng account.","step_number":1,"items":["Regular NBI clearance portal","First-time jobseeker portal kung qualified","Sariling active email at mobile number","Tamang full name, birthday, at address","Saved reference number o appointment details"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'nbi-clearance-first-timers'),
    'step',
    4,
    '{"title":"Prepare documents before your appointment","body":"Bring IDs and proof that match your online record. For first-time jobseeker benefit, bring the required barangay certification or proof requested under the official process.","step_number":2,"items":["Valid ID or supporting ID","Printed or saved reference number","Appointment confirmation","Barangay certification or first-time jobseeker proof if applicable","Pen and extra photocopies if available"]}'::jsonb,
    '{"title":"Ihanda ang documents bago ang appointment","body":"Magdala ng IDs at proof na tugma sa online record mo. Para sa first-time jobseeker benefit, dalhin ang required barangay certification o proof na hinihingi sa official process.","step_number":2,"items":["Valid ID o supporting ID","Printed o saved reference number","Appointment confirmation","Barangay certification o first-time jobseeker proof kung applicable","Ballpen at extra photocopies kung meron"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'nbi-clearance-first-timers'),
    'step',
    5,
    '{"title":"Expect possible extra processing if you get a hit","body":"A hit means your name may need additional checking. It does not automatically mean you did something wrong. Ask when to return or how to claim the clearance, and keep your reference details.","step_number":3,"items":["Ask if your application has a hit","Ask the release or return date","Keep the receipt or reference number","Do not pay unofficial fixers for faster release"]}'::jsonb,
    '{"title":"Asahan ang posibleng extra processing kapag may hit","body":"Ang hit ay ibig sabihin kailangan pang i-check ang pangalan mo. Hindi ibig sabihin nito na may kasalanan ka agad. Itanong kung kailan babalik o paano kukunin ang clearance, at itago ang reference details.","step_number":3,"items":["Itanong kung may hit ang application","Itanong ang release o return date","Itago ang receipt o reference number","Huwag magbayad sa unofficial fixer para mapabilis"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'nbi-clearance-first-timers'),
    'tip',
    6,
    '{"title":"Ask this before paying","body":"If you are unsure which path applies, ask clearly before you pay or submit.","sample":"Hello po. First-time jobseeker po ako and I need NBI clearance for employment. Should I use the first-time jobseeker portal or regular NBI clearance portal, and what barangay certification or proof should I bring to avoid paying the regular fee if I qualify?"}'::jsonb,
    '{"title":"Itanong ito bago magbayad","body":"Kung hindi ka sure kung aling path ang applicable, magtanong nang malinaw bago magbayad o mag-submit.","sample":"Hello po. First-time jobseeker po ako and kailangan ko ng NBI clearance for employment. Dapat po ba first-time jobseeker portal o regular NBI clearance portal ang gamitin ko, at anong barangay certification o proof ang dadalhin para hindi ako magbayad ng regular fee kung qualified ako?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'nbi-clearance-first-timers'),
    'mistake',
    7,
    '{"title":"Using random appointment websites instead of official NBI links","body":"Some search results look official but are only third-party guide pages. Open the official NBI portal yourself and avoid giving personal details, OTPs, or payments through random links."}'::jsonb,
    '{"title":"Gumagamit ng random appointment websites imbes na official NBI links","body":"May search results na mukhang official pero third-party guide pages lang. Ikaw mismo ang magbukas ng official NBI portal at iwasang magbigay ng personal details, OTP, o bayad sa random links."}'::jsonb
  );
