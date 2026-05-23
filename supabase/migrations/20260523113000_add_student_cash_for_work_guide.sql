-- Add DSWD student cash-for-work guide.
-- Goal: explain Tara, Basa and KALAHI-CIDSS student CFW opportunities without implying open nationwide application.

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
  'student-cash-for-work-dswd-checklist',
  (select id from public.categories where slug = 'education'),
  'Student cash-for-work checklist through DSWD programs',
  'Student cash-for-work checklist sa DSWD programs',
  'Check Tara Basa, KALAHI-CIDSS, school partners, and LGU rollout before trusting recruitment posts.',
  'Suriin ang Tara Basa, KALAHI-CIDSS, school partners, at LGU rollout bago maniwala sa recruitment posts.',
  true,
  false,
  true,
  7,
  'katamtaman',
  '30-60 minuto magtanong',
  'Libre magtanong',
  array[
    'dswd',
    'student cash for work',
    'cash-for-work',
    'tara basa',
    'kalahi cidss',
    'college students',
    'graduates',
    'education assistance',
    'student aid',
    'work experience',
    'youth',
    'scholarship',
    'edukasyon'
  ],
  'dswd student cash for work cash-for-work tara basa kalahi cidss college students graduates education assistance student aid work experience youth',
  'dswd student cash for work cash-for-work tara basa kalahi cidss college students graduates education assistance student aid work experience kabataan edukasyon',
  '[
    {"title":"Over 7K college students, graduates to benefit from KALAHI-CIDSS cash-for-work in 2026","publisher":"DSWD","url":"https://www.dswd.gov.ph/over-7k-college-students-graduates-to-benefit-from-dswds-kalahi-cidss-cash-for-work-in-2026/"},
    {"title":"Tara Basa Tutoring Program","publisher":"DSWD","url":"https://www.dswd.gov.ph/tara-basa-tutoring-program/"},
    {"title":"Tara Basa targets 130k beneficiaries for 2026","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswds-tara-basa-program-expands-through-collab-with-lgus-academe-130k-beneficiaries-targeted-for-2026/"},
    {"title":"KALAHI-CIDSS cash-for-work with higher education institutions","publisher":"DSWD Field Office III","url":"https://fo3.dswd.gov.ph/kalahi-cidss/"},
    {"title":"DSWD and DOLE provide cash-for-work for youth beneficiaries","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-dole-provide-cash-for-work-program-for-3000-youth-beneficiaries/"}
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
  where slug = 'student-cash-for-work-dswd-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'what_to_know',
    1,
    '{"title":"These are rollout-based opportunities, not random online jobs","body":"DSWD student cash-for-work opportunities can appear through programs such as Tara, Basa and KALAHI-CIDSS partnerships with schools, LGUs, SUCs, HEIs, DepEd, DOLE, or community partners. They are useful, but not always open everywhere. Verify the official rollout before sending documents.","items":["Tara, Basa can involve college students as tutors or youth development workers","KALAHI-CIDSS CFW can involve students or graduates in short-term work or community/service assignments","Availability depends on area, school, LGU, DSWD Field Office, and partner rollout","Work may be paid based on program rules or prevailing rates","Never pay a recruitment, training, or slot fee"]}'::jsonb,
    '{"title":"Rollout-based opportunities ito, hindi random online jobs","body":"Ang DSWD student cash-for-work opportunities ay maaaring lumabas sa programs tulad ng Tara, Basa at KALAHI-CIDSS partnerships kasama ang schools, LGUs, SUCs, HEIs, DepEd, DOLE, o community partners. Useful ito, pero hindi laging open sa lahat ng lugar. I-verify muna ang official rollout bago magpadala ng documents.","items":["Sa Tara, Basa, maaaring maging tutors o youth development workers ang college students","Sa KALAHI-CIDSS CFW, maaaring magkaroon ng short-term work o community/service assignments ang students o graduates","Depende sa area, school, LGU, DSWD Field Office, at partner rollout ang availability","Maaaring bayaran ang work batay sa program rules o prevailing rates","Huwag magbayad ng recruitment, training, o slot fee"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'step',
    2,
    '{"title":"Check which program is actually active","body":"Do not ask only if there is ayuda for students. Ask which specific program is active: Tara, Basa, KALAHI-CIDSS cash-for-work, DOLE-DSWD youth partnership, or a local school/LGU rollout.","step_number":1,"items":["Tara, Basa tutoring or youth development worker opportunity","KALAHI-CIDSS cash-for-work with HEIs, SUCs, or community partners","DSWD-DOLE youth cash-for-work partnership if announced locally","LGU or school partner announcement connected to DSWD","Official DSWD Field Office post for your region"]}'::jsonb,
    '{"title":"Suriin kung aling program ang totoong active","body":"Huwag lang magtanong kung may ayuda para sa estudyante. Itanong kung anong specific program ang active: Tara, Basa, KALAHI-CIDSS cash-for-work, DOLE-DSWD youth partnership, o local school/LGU rollout.","step_number":1,"items":["Tara, Basa tutoring o youth development worker opportunity","KALAHI-CIDSS cash-for-work with HEIs, SUCs, o community partners","DSWD-DOLE youth cash-for-work partnership kung announced locally","LGU o school partner announcement na konektado sa DSWD","Official DSWD Field Office post ng region ninyo"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'step',
    3,
    '{"title":"Verify through school, LGU, or DSWD Field Office","body":"The safest path is to verify with the office that actually handles the rollout. Do not rely only on screenshots or reposted application links.","step_number":2,"items":["Student affairs, scholarship, registrar, guidance, or extension office of your school","Official LGU social welfare, education, or youth office","DSWD Field Office page for your region","Official Tara, Basa or KALAHI-CIDSS announcement","Named contact person or office, not a private account"]}'::jsonb,
    '{"title":"Mag-verify sa school, LGU, o DSWD Field Office","body":"Pinaka-safe na path ang mag-verify sa office na totoong may hawak ng rollout. Huwag umasa sa screenshots o reposted application links lang.","step_number":2,"items":["Student affairs, scholarship, registrar, guidance, o extension office ng school mo","Official LGU social welfare, education, o youth office","DSWD Field Office page ng region ninyo","Official Tara, Basa o KALAHI-CIDSS announcement","Named contact person o office, hindi private account"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'step',
    4,
    '{"title":"Prepare student and work-readiness proof","body":"Requirements vary by program, but these are common documents to prepare before asking. Submit them only through official channels.","step_number":3,"items":["School ID or valid ID","Certificate of registration, enrollment, or graduation proof if applicable","Contact number and full address","Course, year level, or graduation details","Availability schedule","Parent/guardian consent if required","Resume or simple profile if the assignment is office-based","Bank, e-wallet, or payout details only if requested through an official process"]}'::jsonb,
    '{"title":"Ihanda ang student at work-readiness proof","body":"Nag-iiba ang requirements depende sa program, pero ito ang common ihanda bago magtanong. Sa official channels lang ito ipasa.","step_number":3,"items":["School ID o valid ID","Certificate of registration, enrollment, o graduation proof kung applicable","Contact number at kumpletong address","Course, year level, o graduation details","Availability schedule","Parent/guardian consent kung required","Resume o simple profile kung office-based ang assignment","Bank, e-wallet, o payout details kung official process lang ang humihingi"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'tip',
    5,
    '{"title":"Ask one direct verification question","body":"A clear question helps the office tell you if there is a real rollout, partner school, assignment type, and official application process.","sample":"Hello po. Student/graduate po ako from [school/course/year]. May active DSWD student cash-for-work, Tara Basa, or KALAHI-CIDSS opportunity po ba sa [school/city/province]? Sino po ang official contact, ano po ang requirements, ano ang work assignment, at saan po ang official application or orientation?"}'::jsonb,
    '{"title":"Magtanong ng isang direct verification question","body":"Mas madaling masagot ng office kung may real rollout, partner school, assignment type, at official application process kapag malinaw ang tanong.","sample":"Hello po. Student/graduate po ako from [school/course/year]. May active DSWD student cash-for-work, Tara Basa, or KALAHI-CIDSS opportunity po ba sa [school/city/province]? Sino po ang official contact, ano po ang requirements, ano ang work assignment, at saan po ang official application or orientation?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'warning',
    6,
    '{"title":"Avoid fake student cash-for-work recruitment","body":"Scammers may copy real DSWD program names to collect fees or personal data. Be careful with posts promising guaranteed slots, easy payout, or paid training.","severity":"high","items":["Registration, training, uniform, or slot fee","Guaranteed selection or sure payout","Random form asking for full IDs, selfies, bank login, e-wallet login, OTP, or password","No named partner school, LGU, DSWD Field Office, or orientation venue","Private account collecting documents","Offer says no work needed but promises cash-for-work payout"]}'::jsonb,
    '{"title":"Iwasan ang fake student cash-for-work recruitment","body":"Minsan kinokopya ng scammers ang totoong DSWD program names para mangolekta ng fees o personal data. Mag-ingat sa posts na nangangako ng guaranteed slot, easy payout, o paid training.","severity":"high","items":["Registration, training, uniform, o slot fee","Guaranteed selection o sure payout","Random form na humihingi ng full IDs, selfies, bank login, e-wallet login, OTP, o password","Walang named partner school, LGU, DSWD Field Office, o orientation venue","Private account ang nangongolekta ng documents","Sinasabing walang work pero may cash-for-work payout"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'mistake',
    7,
    '{"title":"Assuming all student aid is a scholarship","body":"Some support is scholarship, some is subsidy, some is educational assistance, and some is cash-for-work. If work or service is required, ask what task, schedule, rate, and completion proof are expected."}'::jsonb,
    '{"title":"Iniisip na lahat ng student aid ay scholarship","body":"May support na scholarship, may subsidy, may educational assistance, at may cash-for-work. Kapag may required work o service, itanong kung ano ang task, schedule, rate, at completion proof na kailangan."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'tip',
    8,
    '{"title":"Keep application and work proof","body":"Save official announcements, orientation details, assignment proof, attendance, payout instructions, and receipts. This protects you if there is confusion about work completion or payment.","items":["Official announcement or memo","Orientation date and venue","Name of partner school, LGU, or DSWD office","Requirements submitted","Work assignment and schedule","Attendance, accomplishment report, or completion proof","Payout instruction, reference, or receipt"]}'::jsonb,
    '{"title":"I-save ang application at work proof","body":"Itago ang official announcements, orientation details, assignment proof, attendance, payout instructions, at resibo. Proteksyon ito kapag may kalituhan sa work completion o payment.","items":["Official announcement o memo","Orientation date at venue","Pangalan ng partner school, LGU, o DSWD office","Requirements na ipinasa","Work assignment at schedule","Attendance, accomplishment report, o completion proof","Payout instruction, reference, o resibo"]}'::jsonb
  );
