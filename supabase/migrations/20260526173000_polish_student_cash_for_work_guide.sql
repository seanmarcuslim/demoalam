-- Polish DSWD student cash-for-work guide with 2026 Tara Basa and KALAHI-CIDSS context.
-- Goal: clarify rollout-based eligibility, work expectations, partner verification, and fake recruitment risks.

update public.guides
set
  title_en = 'Student cash-for-work: how to verify DSWD opportunities',
  title_fil = 'Student cash-for-work: paano i-check ang DSWD opportunities',
  tagline_en = 'Check Tara Basa, KALAHI-CIDSS, partner schools, work assignments, payout rules, and fake recruitment red flags.',
  tagline_fil = 'I-check ang Tara Basa, KALAHI-CIDSS, partner schools, work assignments, payout rules, at fake recruitment red flags.',
  read_time_min = 8,
  estimated_time = '30-60 min',
  estimated_cost = 'Official channels only',
  tags = array[
    'dswd',
    'student cash for work',
    'cash-for-work',
    'cash-for-training',
    'tara basa',
    'kalahi cidss',
    'college students',
    'graduates',
    'tutors',
    'youth development workers',
    'education assistance',
    'student aid',
    'work experience',
    'youth',
    'scholarship',
    'edukasyon'
  ],
  keywords_en = 'dswd student cash for work cash-for-work cash-for-training tara basa kalahi cidss college students graduates tutors youth development workers education assistance student aid work experience youth partner school lgu sucs heis deped dole',
  keywords_fil = 'dswd student cash for work cash-for-work cash-for-training tara basa kalahi cidss college students graduates tutors youth development workers education assistance student aid work experience kabataan edukasyon partner school lgu sucs heis deped dole',
  official_sources = '[
    {"title":"Tara Basa Tutoring Program","publisher":"DSWD","url":"https://www.dswd.gov.ph/tara-basa-tutoring-program/"},
    {"title":"Tara Basa expands through LGUs and academe; 130k beneficiaries targeted for 2026","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswds-tara-basa-program-expands-through-collab-with-lgus-academe-130k-beneficiaries-targeted-for-2026/"},
    {"title":"DSWD commences 4th year of Tara Basa implementation","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-commences-4th-year-of-tara-basa-tutoring-program-implementation-with-20-day-tutorial-parenting-sessions/"},
    {"title":"Cash-for-Work Program covers HEIs in Cordillera","publisher":"DSWD Field Office CAR","url":"https://car.dswd.gov.ph/2026/03/cash-for-work-program-covers-two-higher-education-institutions-in-cordillera/"},
    {"title":"DSWD and DOLE provide cash-for-work for youth beneficiaries","publisher":"DSWD","url":"https://www.dswd.gov.ph/dswd-dole-provide-cash-for-work-program-for-3000-youth-beneficiaries/"}
  ]'::jsonb,
  updated_at = now()
where slug = 'student-cash-for-work-dswd-checklist';

update public.guide_sections
set
  content_en = '{"title":"These are rollout-based opportunities, not random online jobs","body":"DSWD student cash-for-work opportunities may appear through Tara Basa, KALAHI-CIDSS, DSWD-DOLE youth partnerships, schools, LGUs, SUCs, HEIs, DepEd, or community partners. They are useful, but not always open everywhere. Verify the official rollout before sending documents.","items":["Tara Basa may engage college students as tutors or youth development workers","Tara Basa can include cash-for-work, cash-for-training, tutorial sessions, and parenting/learning sessions","KALAHI-CIDSS cash-for-work may involve students or graduates in short-term work or community assignments","Availability depends on area, school, LGU, DSWD Field Office, and partner rollout","Never pay a recruitment, training, uniform, or slot fee"]}'::jsonb,
  content_fil = '{"title":"Rollout-based opportunities ito, hindi random online jobs","body":"Ang DSWD student cash-for-work opportunities ay maaaring lumabas sa Tara Basa, KALAHI-CIDSS, DSWD-DOLE youth partnerships, schools, LGUs, SUCs, HEIs, DepEd, o community partners. Useful ito, pero hindi laging open sa lahat ng lugar. I-verify muna ang official rollout bago magpadala ng documents.","items":["Sa Tara Basa, maaaring maging tutors o youth development workers ang college students","Maaaring may cash-for-work, cash-for-training, tutorial sessions, at parenting/learning sessions sa Tara Basa","Sa KALAHI-CIDSS cash-for-work, maaaring magkaroon ng short-term work o community assignments ang students o graduates","Depende sa area, school, LGU, DSWD Field Office, at partner rollout ang availability","Huwag magbayad ng recruitment, training, uniform, o slot fee"]}'::jsonb
where guide_id = (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist')
  and order_index = 1;

update public.guide_sections
set
  content_en = '{"title":"Check which program and role are actually active","body":"Do not ask only if there is ayuda for students. Ask which specific program, partner, role, and schedule are active in your area or school.","step_number":1,"items":["Tara Basa tutor role for struggling or non-reader learners","Tara Basa youth development worker role for parent or guardian sessions","KALAHI-CIDSS cash-for-work with HEIs, SUCs, LGUs, or community partners","DSWD-DOLE youth cash-for-work partnership if announced locally","Partner school, LGU, or DSWD Field Office announcement for your area","Actual work days, training days, rate, payout method, and completion proof"]}'::jsonb,
  content_fil = '{"title":"Suriin kung aling program at role ang totoong active","body":"Huwag lang magtanong kung may ayuda para sa estudyante. Itanong kung anong specific program, partner, role, at schedule ang active sa lugar o school mo.","step_number":1,"items":["Tara Basa tutor role para sa struggling o non-reader learners","Tara Basa youth development worker role para sa parent o guardian sessions","KALAHI-CIDSS cash-for-work with HEIs, SUCs, LGUs, o community partners","DSWD-DOLE youth cash-for-work partnership kung announced locally","Partner school, LGU, o DSWD Field Office announcement para sa area mo","Actual work days, training days, rate, payout method, at completion proof"]}'::jsonb
where guide_id = (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist')
  and order_index = 2;

update public.guide_sections
set
  content_en = '{"title":"Ask one direct verification question","body":"A clear question helps the office tell you if there is a real rollout, partner school, assignment type, and official application or orientation process.","sample":"Hello. I am a student/graduate from [school/course/year]. Is there an active DSWD student cash-for-work, Tara Basa, KALAHI-CIDSS, or DSWD-DOLE youth opportunity in [school/city/province]? Who is the official contact, what role is open, what are the requirements, how many work or training days are expected, and where is the official application or orientation?"}'::jsonb,
  content_fil = '{"title":"Magtanong ng isang direct verification question","body":"Mas madaling masagot ng office kung may real rollout, partner school, assignment type, at official application o orientation process kapag malinaw ang tanong.","sample":"Hello po. Student/graduate po ako from [school/course/year]. May active DSWD student cash-for-work, Tara Basa, KALAHI-CIDSS, o DSWD-DOLE youth opportunity po ba sa [school/city/province]? Sino po ang official contact, anong role ang open, ano po ang requirements, ilang work o training days ang expected, at saan po ang official application o orientation?"}'::jsonb
where guide_id = (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist')
  and order_index = 5;

update public.guide_sections
set
  content_en = '{"title":"Avoid fake student cash-for-work recruitment","body":"Scammers may copy real DSWD program names to collect fees or personal data. Be careful with posts promising guaranteed slots, easy payout, or paid training. Real cash-for-work should have a real partner, real task, and official process.","severity":"high","items":["Registration, training, uniform, or slot fee","Guaranteed selection or sure payout","Random form asking for full IDs, selfies, bank login, e-wallet login, OTP, or password","No named partner school, LGU, DSWD Field Office, or orientation venue","Private account collecting documents","Offer says no work, training, attendance, or output is needed but promises cash-for-work payout"]}'::jsonb,
  content_fil = '{"title":"Iwasan ang fake student cash-for-work recruitment","body":"Minsan kinokopya ng scammers ang totoong DSWD program names para mangolekta ng fees o personal data. Mag-ingat sa posts na nangangako ng guaranteed slot, easy payout, o paid training. Ang totoong cash-for-work dapat may totoong partner, totoong task, at official process.","severity":"high","items":["Registration, training, uniform, o slot fee","Guaranteed selection o sure payout","Random form na humihingi ng full IDs, selfies, bank login, e-wallet login, OTP, o password","Walang named partner school, LGU, DSWD Field Office, o orientation venue","Private account ang nangongolekta ng documents","Sinasabing walang work, training, attendance, o output pero may cash-for-work payout"]}'::jsonb
where guide_id = (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist')
  and order_index = 6;

delete from public.guide_sections
where guide_id = (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist')
  and order_index = 9;

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values (
  (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
  'tip',
  9,
  '{"title":"What to expect if selected","body":"These opportunities are not just payouts. You may need to attend orientation, complete training, render work or service days, submit attendance or accomplishment proof, and follow payout instructions from the partner office.","items":["Role assignment: tutor, youth development worker, office/community support, or other approved task","Training or orientation before deployment","Work/service schedule and attendance tracking","Accomplishment report or completion proof","Payout method, rate, and timing from official instructions","Financial literacy or additional sessions if included in the rollout"]}'::jsonb,
  '{"title":"Ano ang aasahan kung selected","body":"Hindi lang payout ang opportunities na ito. Maaaring kailangan mong umattend ng orientation, tapusin ang training, mag-render ng work o service days, magsumite ng attendance o accomplishment proof, at sundin ang payout instructions ng partner office.","items":["Role assignment: tutor, youth development worker, office/community support, o ibang approved task","Training o orientation bago deployment","Work/service schedule at attendance tracking","Accomplishment report o completion proof","Payout method, rate, at timing mula sa official instructions","Financial literacy o dagdag sessions kung kasama sa rollout"]}'::jsonb
);
