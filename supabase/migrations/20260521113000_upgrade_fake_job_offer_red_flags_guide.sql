update public.guides
set
  title_en = 'Fake job offer checklist before you pay or send documents',
  title_fil = 'Fake job offer checklist bago magbayad o magpadala ng documents',
  tagline_en = 'Check recruiter identity, fees, contract, visa claims, and official channels before trusting an offer.',
  tagline_fil = 'I-check ang recruiter identity, fees, kontrata, visa claims, at official channels bago magtiwala sa offer.',
  keywords_en = 'fake job job scam illegal recruitment recruiter placement fee processing fee training fee ofw dmw poea contract visa',
  keywords_fil = 'fake job job scam illegal recruitment recruiter placement fee processing fee training fee trabaho ofw dmw poea kontrata visa',
  official_sources = '[
    {"title":"Identify an illegal recruiter","publisher":"Department of Migrant Workers / POEA Archive","url":"https://dmw.gov.ph/archives/poea/air/identify.html"},
    {"title":"Modus Operandi of Illegal Recruiters","publisher":"Department of Migrant Workers / POEA Archive","url":"https://dmw.gov.ph/archives/poea/air/modus.html"},
    {"title":"Tips to job applicants using the internet in job search","publisher":"Department of Migrant Workers / POEA Archive","url":"https://dmw.gov.ph/archives/poea/air/internetscams.html"}
  ]'::jsonb,
  updated_at = now()
where slug = 'fake-job-offer-red-flags';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'fake-job-offer-red-flags'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'fake-job-offer-red-flags'),
    'what_to_know',
    1,
    '{"title":"A job offer is not real just because it sounds urgent","body":"Scammers often use high salary, fast deployment, direct employer claims, tourist visa shortcuts, and processing fees to pressure applicants. Slow down before paying or sending documents."}'::jsonb,
    '{"title":"Hindi totoong trabaho agad porke urgent ang offer","body":"Madalas gumamit ang scammers ng mataas na sahod, mabilis na deployment, direct employer claims, tourist visa shortcut, at processing fees para ma-pressure ang applicants. Huminto muna bago magbayad o magpadala ng documents."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'fake-job-offer-red-flags'),
    'warning',
    2,
    '{"title":"Do not pay before verification","body":"Be careful when a recruiter asks for training fees, processing fees, reservation fees, medical fees, or deposits before any verified contract, official receipt, or confirmed licensed agency.","severity":"high"}'::jsonb,
    '{"title":"Huwag magbayad bago ma-verify","body":"Mag-ingat kapag may hinihinging training fee, processing fee, reservation fee, medical fee, o deposit bago magkaroon ng verified contract, official receipt, o confirmed licensed agency.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'fake-job-offer-red-flags'),
    'step',
    3,
    '{"title":"Verify who is recruiting you","body":"Ask for the full name of the recruiter, agency name, office address, license or authority details, employer name, and exact job order. A legitimate recruiter should not hide basic identity details.","step_number":1,"items":["Recruiter full name and ID","Agency or company name","Office address, not only chat account","License, authority, or registration details","Employer name and country or location","Exact job title and salary range"]}'::jsonb,
    '{"title":"I-verify kung sino ang nagre-recruit sa iyo","body":"Hingin ang buong pangalan ng recruiter, agency name, office address, license o authority details, employer name, at exact job order. Hindi dapat itinatago ng legit recruiter ang basic identity details.","step_number":1,"items":["Full name at ID ng recruiter","Agency o company name","Office address, hindi puro chat account","License, authority, o registration details","Employer name at bansa o location","Exact job title at salary range"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'fake-job-offer-red-flags'),
    'step',
    4,
    '{"title":"Watch for the classic red flags","body":"DMW/POEA materials warn against recruiters who promise fast overseas deployment, transact in malls or public places, use tourist or visit visas for work, ask applicants to recruit others, or cannot show a contract or working visa.","step_number":2,"items":["Fast deployment promise","Payment before clear contract","Meetup in mall, restaurant, or chat only","Tourist or visit visa for work","No employment contract or working visa","Recruiter asks you to bring more applicants"]}'::jsonb,
    '{"title":"Bantayan ang classic red flags","body":"Sa DMW/POEA materials, red flag ang recruiter na nangangako ng mabilis na abroad deployment, nakikipag-transact sa mall o public place, gumagamit ng tourist o visit visa para sa trabaho, pinapahanap ka ng ibang applicant, o walang maipakitang contract o working visa.","step_number":2,"items":["Pangakong mabilis na deployment","Bayad bago malinaw ang kontrata","Meetup sa mall, restaurant, o chat lang","Tourist o visit visa para sa work","Walang employment contract o working visa","Pinapahanap ka ng iba pang applicants"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'fake-job-offer-red-flags'),
    'step',
    5,
    '{"title":"Verify through official channels before sending documents","body":"Before sending passport, IDs, certificates, or money, check the agency or job offer through official government channels or the employer website you opened yourself, not through links sent by the recruiter.","step_number":3,"items":["Search official agency or employer website yourself","Do not rely only on screenshots","Call or email official contact details","Keep chat logs and payment requests","Do not send passport scans until verified"]}'::jsonb,
    '{"title":"Mag-verify sa official channels bago magpadala ng documents","body":"Bago magpadala ng passport, IDs, certificates, o pera, i-check ang agency o job offer gamit ang official government channels o employer website na ikaw mismo ang nagbukas, hindi link na pinadala ng recruiter.","step_number":3,"items":["Hanapin mismo ang official agency o employer website","Huwag umasa sa screenshots lang","Tumawag o mag-email sa official contact details","I-save ang chat logs at payment requests","Huwag mag-send ng passport scans hangga\u0027t hindi verified"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'fake-job-offer-red-flags'),
    'tip',
    6,
    '{"title":"Ask one direct verification question","body":"A scammer usually avoids clear verification. Ask for details you can check independently before you continue.","sample":"Can you send the agency license or registration details, exact employer name, official job order or vacancy link, complete office address, and the official receipt policy before I submit documents or payment?"}'::jsonb,
    '{"title":"Magtanong ng isang direct verification question","body":"Madalas umiwas ang scammer sa malinaw na verification. Humingi ng details na kaya mong i-check independently bago tumuloy.","sample":"Pwede po bang ipadala ang agency license o registration details, exact employer name, official job order o vacancy link, complete office address, at official receipt policy bago ako mag-submit ng documents o payment?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'fake-job-offer-red-flags'),
    'mistake',
    7,
    '{"title":"Trusting a job post because it has a logo","body":"Logos, fake IDs, edited certificates, and copied company names are easy to fake. Verify through official websites, phone numbers, offices, and government resources before acting."}'::jsonb,
    '{"title":"Nagtitiwala agad dahil may logo ang job post","body":"Madaling pekein ang logos, fake IDs, edited certificates, at copied company names. Mag-verify muna sa official websites, phone numbers, offices, at government resources bago kumilos."}'::jsonb
  );
