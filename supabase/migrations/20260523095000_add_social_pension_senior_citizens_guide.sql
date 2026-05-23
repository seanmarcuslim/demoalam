-- Add DSWD Social Pension guide for indigent senior citizens.
-- Goal: help families verify eligibility, documents, payout path, and scam risks.

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
  'social-pension-indigent-senior-citizens',
  (select id from public.categories where slug = 'gov'),
  'Social pension checklist for indigent senior citizens',
  'Social pension checklist para sa indigent senior citizens',
  'Check who may qualify, what proof to prepare, and how to avoid fake pension registration links.',
  'Suriin kung sino ang maaaring qualified, anong proof ang ihahanda, at paano umiwas sa fake pension registration links.',
  true,
  false,
  true,
  7,
  'katamtaman',
  '30-60 minuto',
  'Libre magtanong',
  array[
    'dswd',
    'social pension',
    'senior citizen',
    'indigent senior citizen',
    'osca',
    'pension',
    'financial assistance',
    'gobyerno',
    'matanda',
    'senior'
  ],
  'dswd social pension indigent senior citizens osca lswdo mswdo quarterly payout stipend government assistance',
  'dswd social pension indigent senior citizen osca lswdo mswdo quarterly payout stipend gobyerno tulong senior pensyon',
  '[
    {"title":"Guidelines and qualifications for Social Pension of Indigent Senior Citizens","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-reiterates-guidelines-qualifications-for-social-pension-of-indigent-senior-citizens/"},
    {"title":"Social Pension Program for Indigent Senior Citizens","publisher":"DSWD Program Management Bureau","url":"https://pmb.dswd.gov.ph/social-pension-program-for-indigent-senior-citizens/"},
    {"title":"Expanded Senior Citizens Act of 2010","publisher":"Official Gazette","url":"https://www.officialgazette.gov.ph/2010/02/15/republic-act-no-9994/"}
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
  where slug = 'social-pension-indigent-senior-citizens'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'social-pension-indigent-senior-citizens'),
    'what_to_know',
    1,
    '{"title":"Social pension is for indigent senior citizens","body":"The DSWD Social Pension Program supports qualified indigent senior citizens. It is not automatic for every senior citizen. Eligibility is checked through local offices and DSWD validation, so families should prepare proof and ask the correct office instead of trusting random registration posts.","items":["Usually coordinated through OSCA, city/municipal social welfare office, LGU, and DSWD Field Office","DSWD sources state a Php1,000 monthly stipend, often released quarterly","Inclusion may depend on validation, waitlist status, and available program records","Never pay someone promising faster inclusion"]}'::jsonb,
    '{"title":"Ang social pension ay para sa indigent senior citizens","body":"Ang DSWD Social Pension Program ay para sa qualified indigent senior citizens. Hindi ito automatic para sa lahat ng senior citizen. Dumadaan ito sa local offices at DSWD validation, kaya mas safe na maghanda ng proof at magtanong sa tamang office kaysa maniwala sa random registration posts.","items":["Madalas coordinated sa OSCA, city/municipal social welfare office, LGU, at DSWD Field Office","Ayon sa DSWD sources, Php1,000 monthly stipend ito at kadalasang nire-release quarterly","Ang inclusion ay maaaring depende sa validation, waitlist status, at available program records","Huwag magbayad sa taong nangangakong mapapabilis ang inclusion"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'social-pension-indigent-senior-citizens'),
    'step',
    2,
    '{"title":"Check the basic qualification signals","body":"Use these as first-screening questions before traveling. The final answer still depends on official validation and local records.","step_number":1,"items":["Is the person 60 years old or above?","Is the person frail, sickly, with disability, or without stable support?","Does the person have no regular income or adequate family support?","Does the person have no pension from SSS, GSIS, PVAO, or similar pension source?","Is the senior listed or known by the barangay, OSCA, or local social welfare office?"]}'::jsonb,
    '{"title":"Suriin muna ang basic qualification signals","body":"Gamitin ito bilang first-screening questions bago bumiyahe. Ang final answer ay depende pa rin sa official validation at local records.","step_number":1,"items":["60 years old pataas ba ang senior?","Frail, sickly, may disability, o walang stable support ba siya?","Wala ba siyang regular income o sapat na family support?","Wala ba siyang pension mula sa SSS, GSIS, PVAO, o katulad na pension source?","Kilala o listed ba siya sa barangay, OSCA, o local social welfare office?"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'social-pension-indigent-senior-citizens'),
    'step',
    3,
    '{"title":"Prepare proof before asking OSCA or MSWDO","body":"Requirements can vary by locality, but these are useful documents to prepare before asking about inclusion, validation, or waitlist status.","step_number":2,"items":["Senior citizen ID or valid ID","Birthdate proof if ID is unclear","Barangay certificate or proof of residence if requested","Contact number and full address","Proof that the senior has no pension or stable income if requested","Medical note, disability proof, or situation details if relevant","Representative ID and authorization if a family member will ask"]}'::jsonb,
    '{"title":"Ihanda ang proof bago magtanong sa OSCA o MSWDO","body":"Nag-iiba ang requirements depende sa lugar, pero ito ang useful ihanda bago magtanong tungkol sa inclusion, validation, o waitlist status.","step_number":2,"items":["Senior citizen ID o valid ID","Proof ng birthdate kung hindi malinaw sa ID","Barangay certificate o proof of residence kung hinihingi","Contact number at kumpletong address","Proof na walang pension o stable income kung hinihingi","Medical note, disability proof, o situation details kung relevant","ID ng representative at authorization kung kapamilya ang magtatanong"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'social-pension-indigent-senior-citizens'),
    'step',
    4,
    '{"title":"Ask the correct local office first","body":"For most families, the practical first stop is not a random online form. Ask the OSCA, city or municipal social welfare office, barangay, or DSWD Field Office for the official validation process in your area.","step_number":3,"items":["Office of Senior Citizens Affairs or OSCA","City/Municipal Social Welfare and Development Office","Barangay office for local record or referral","DSWD Field Office covering your region","Official LGU or DSWD page for payout announcements"]}'::jsonb,
    '{"title":"Sa tamang local office muna magtanong","body":"Para sa karamihan ng pamilya, hindi random online form ang unang pupuntahan. Magtanong sa OSCA, city o municipal social welfare office, barangay, o DSWD Field Office para sa official validation process sa lugar ninyo.","step_number":3,"items":["Office of Senior Citizens Affairs o OSCA","City/Municipal Social Welfare and Development Office","Barangay office para sa local record o referral","DSWD Field Office na sakop ang region ninyo","Official LGU o DSWD page para sa payout announcements"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'social-pension-indigent-senior-citizens'),
    'tip',
    5,
    '{"title":"Ask about validation, not guaranteed approval","body":"A clearer question helps the office give a useful answer. Ask about requirements, validation schedule, waitlist status, and official payout process.","sample":"Hello po. May senior citizen po kami na 60+ at walang regular pension/income. Pwede po bang malaman kung paano ang validation for DSWD Social Pension, anong requirements ang kailangan, at saan po pwedeng i-check kung nasa listahan o waitlist siya?"}'::jsonb,
    '{"title":"Validation ang itanong, hindi guaranteed approval","body":"Mas helpful ang sagot ng office kapag malinaw ang tanong. Itanong ang requirements, validation schedule, waitlist status, at official payout process.","sample":"Hello po. May senior citizen po kami na 60+ at walang regular pension/income. Pwede po bang malaman kung paano ang validation for DSWD Social Pension, anong requirements ang kailangan, at saan po pwedeng i-check kung nasa listahan o waitlist siya?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'social-pension-indigent-senior-citizens'),
    'warning',
    6,
    '{"title":"Avoid fake pension registration links","body":"Be careful with posts or messages promising fast approval, payout slots, or pension registration through random links. Social pension validation should be checked through official local offices or DSWD/LGU channels.","severity":"high","items":["Processing fee or slot reservation fee","Random form asking for full IDs, bank details, or selfies","Promise of guaranteed inclusion","Someone asking for OTP, PIN, password, or e-wallet login","Payout schedule that cannot be verified by OSCA, LGU, or DSWD"]}'::jsonb,
    '{"title":"Iwasan ang fake pension registration links","body":"Mag-ingat sa posts o messages na nangangako ng fast approval, payout slots, o pension registration sa random links. Ang social pension validation ay dapat i-check sa official local offices o DSWD/LGU channels.","severity":"high","items":["Processing fee o slot reservation fee","Random form na humihingi ng full IDs, bank details, o selfies","Pangakong guaranteed ang inclusion","May humihingi ng OTP, PIN, password, o e-wallet login","Payout schedule na hindi ma-verify sa OSCA, LGU, o DSWD"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'social-pension-indigent-senior-citizens'),
    'mistake',
    7,
    '{"title":"Assuming every senior automatically receives it","body":"The program is for qualified indigent senior citizens. A senior citizen ID alone does not always mean the person is already included in the payout list. Ask for validation status and requirements instead of assuming automatic approval."}'::jsonb,
    '{"title":"Iniisip na automatic ito sa lahat ng senior","body":"Ang program ay para sa qualified indigent senior citizens. Ang senior citizen ID lang ay hindi laging ibig sabihin kasama na agad sa payout list. Itanong ang validation status at requirements imbes na mag-assume ng automatic approval."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'social-pension-indigent-senior-citizens'),
    'mistake',
    8,
    '{"title":"Not keeping payout and follow-up records","body":"Keep a simple record of every office contacted, requirements submitted, payout announcement, and reference number. This helps families follow up without relying on rumors.","items":["Date and office contacted","Name or position of person who answered, if given","Requirements submitted","Validation or waitlist instruction","Payout schedule or announcement source","Reference number, stub, or acknowledgement if given"]}'::jsonb,
    '{"title":"Hindi nagtatabi ng payout at follow-up records","body":"Magtabi ng simpleng record ng bawat office na kinontak, requirements na ipinasa, payout announcement, at reference number. Mas madali itong gamitin sa follow-up kaysa umasa sa chismis.","items":["Date at office na kinontak","Pangalan o position ng sumagot kung ibinigay","Requirements na ipinasa","Validation o waitlist instruction","Payout schedule o source ng announcement","Reference number, stub, o acknowledgement kung meron"]}'::jsonb
  );
