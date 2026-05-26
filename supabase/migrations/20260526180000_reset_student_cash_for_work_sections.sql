-- Reset Student Cash-for-Work sections to remove live DB drift from older generic student-aid content.
-- Goal: make the guide coherent from top to bottom after Expo Web verification found mixed sections.

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'student-cash-for-work-dswd-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'what_to_know',
    1,
    '{"title":"These are rollout-based opportunities, not random online jobs","body":"DSWD student cash-for-work opportunities may appear through Tara Basa, KALAHI-CIDSS, DSWD-DOLE youth partnerships, schools, LGUs, SUCs, HEIs, DepEd, or community partners. They are useful, but not always open everywhere. Verify the official rollout before sending documents.","items":["Tara Basa may engage college students as tutors or youth development workers","Tara Basa can include cash-for-work, cash-for-training, tutorial sessions, and parenting/learning sessions","KALAHI-CIDSS cash-for-work may involve students or graduates in short-term work or community assignments","Availability depends on area, school, LGU, DSWD Field Office, and partner rollout","Never pay a recruitment, training, uniform, or slot fee"]}'::jsonb,
    '{"title":"Rollout-based opportunities ito, hindi random online jobs","body":"Ang DSWD student cash-for-work opportunities ay maaaring lumabas sa Tara Basa, KALAHI-CIDSS, DSWD-DOLE youth partnerships, schools, LGUs, SUCs, HEIs, DepEd, o community partners. Useful ito, pero hindi laging open sa lahat ng lugar. I-verify muna ang official rollout bago magpadala ng documents.","items":["Sa Tara Basa, maaaring maging tutors o youth development workers ang college students","Maaaring may cash-for-work, cash-for-training, tutorial sessions, at parenting/learning sessions sa Tara Basa","Sa KALAHI-CIDSS cash-for-work, maaaring magkaroon ng short-term work o community assignments ang students o graduates","Depende sa area, school, LGU, DSWD Field Office, at partner rollout ang availability","Huwag magbayad ng recruitment, training, uniform, o slot fee"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'step',
    2,
    '{"title":"Check which program and role are actually active","body":"Do not ask only if there is ayuda for students. Ask which specific program, partner, role, and schedule are active in your area or school.","step_number":1,"items":["Tara Basa tutor role for struggling or non-reader learners","Tara Basa youth development worker role for parent or guardian sessions","KALAHI-CIDSS cash-for-work with HEIs, SUCs, LGUs, or community partners","DSWD-DOLE youth cash-for-work partnership if announced locally","Partner school, LGU, or DSWD Field Office announcement for your area","Actual work days, training days, rate, payout method, and completion proof"]}'::jsonb,
    '{"title":"Suriin kung aling program at role ang totoong active","body":"Huwag lang magtanong kung may ayuda para sa estudyante. Itanong kung anong specific program, partner, role, at schedule ang active sa lugar o school mo.","step_number":1,"items":["Tara Basa tutor role para sa struggling o non-reader learners","Tara Basa youth development worker role para sa parent o guardian sessions","KALAHI-CIDSS cash-for-work with HEIs, SUCs, LGUs, o community partners","DSWD-DOLE youth cash-for-work partnership kung announced locally","Partner school, LGU, o DSWD Field Office announcement para sa area mo","Actual work days, training days, rate, payout method, at completion proof"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'step',
    3,
    '{"title":"Verify through the office that owns the rollout","body":"The safest path is to verify with the school, LGU, DSWD Field Office, or partner office actually handling the program. Do not rely only on screenshots or reposted links.","step_number":2,"items":["Student affairs, scholarship, registrar, guidance, or extension office of your school","Official LGU social welfare, education, or youth office","DSWD Field Office page for your region","Official Tara Basa, KALAHI-CIDSS, or DSWD-DOLE announcement","Named contact person or office, not a private account","Orientation venue, schedule, or official application channel"]}'::jsonb,
    '{"title":"Mag-verify sa office na may hawak ng rollout","body":"Pinaka-safe ang mag-verify sa school, LGU, DSWD Field Office, o partner office na totoong may hawak ng program. Huwag umasa sa screenshots o reposted links lang.","step_number":2,"items":["Student affairs, scholarship, registrar, guidance, o extension office ng school mo","Official LGU social welfare, education, o youth office","DSWD Field Office page ng region ninyo","Official Tara Basa, KALAHI-CIDSS, o DSWD-DOLE announcement","Named contact person o office, hindi private account","Orientation venue, schedule, o official application channel"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'step',
    4,
    '{"title":"Prepare student and work-readiness proof","body":"Requirements vary by program, but these are common documents to prepare before asking. Submit them only through official channels.","step_number":3,"items":["School ID or valid ID","Certificate of registration, enrollment, or graduation proof if applicable","Contact number and full address","Course, year level, or graduation details","Availability schedule","Parent or guardian consent if required","Resume or simple profile if the assignment is office-based","Bank, e-wallet, or payout details only if requested through an official process"]}'::jsonb,
    '{"title":"Ihanda ang student at work-readiness proof","body":"Nag-iiba ang requirements depende sa program, pero ito ang common ihanda bago magtanong. Sa official channels lang ito ipasa.","step_number":3,"items":["School ID o valid ID","Certificate of registration, enrollment, o graduation proof kung applicable","Contact number at kumpletong address","Course, year level, o graduation details","Availability schedule","Parent o guardian consent kung required","Resume o simple profile kung office-based ang assignment","Bank, e-wallet, o payout details kung official process lang ang humihingi"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'tip',
    5,
    '{"title":"Ask one direct verification question","body":"A clear question helps the office tell you if there is a real rollout, partner school, assignment type, and official application or orientation process.","sample":"Hello. I am a student/graduate from [school/course/year]. Is there an active DSWD student cash-for-work, Tara Basa, KALAHI-CIDSS, or DSWD-DOLE youth opportunity in [school/city/province]? Who is the official contact, what role is open, what are the requirements, how many work or training days are expected, and where is the official application or orientation?"}'::jsonb,
    '{"title":"Magtanong ng isang direct verification question","body":"Mas madaling masagot ng office kung may real rollout, partner school, assignment type, at official application o orientation process kapag malinaw ang tanong.","sample":"Hello po. Student/graduate po ako from [school/course/year]. May active DSWD student cash-for-work, Tara Basa, KALAHI-CIDSS, o DSWD-DOLE youth opportunity po ba sa [school/city/province]? Sino po ang official contact, anong role ang open, ano po ang requirements, ilang work o training days ang expected, at saan po ang official application o orientation?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'warning',
    6,
    '{"title":"Avoid fake student cash-for-work recruitment","body":"Scammers may copy real DSWD program names to collect fees or personal data. Be careful with posts promising guaranteed slots, easy payout, or paid training. Real cash-for-work should have a real partner, real task, and official process.","severity":"high","items":["Registration, training, uniform, or slot fee","Guaranteed selection or sure payout","Random form asking for full IDs, selfies, bank login, e-wallet login, OTP, or password","No named partner school, LGU, DSWD Field Office, or orientation venue","Private account collecting documents","Offer says no work, training, attendance, or output is needed but promises cash-for-work payout"]}'::jsonb,
    '{"title":"Iwasan ang fake student cash-for-work recruitment","body":"Minsan kinokopya ng scammers ang totoong DSWD program names para mangolekta ng fees o personal data. Mag-ingat sa posts na nangangako ng guaranteed slot, easy payout, o paid training. Ang totoong cash-for-work dapat may totoong partner, totoong task, at official process.","severity":"high","items":["Registration, training, uniform, o slot fee","Guaranteed selection o sure payout","Random form na humihingi ng full IDs, selfies, bank login, e-wallet login, OTP, o password","Walang named partner school, LGU, DSWD Field Office, o orientation venue","Private account ang nangongolekta ng documents","Sinasabing walang work, training, attendance, o output pero may cash-for-work payout"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'mistake',
    7,
    '{"title":"Assuming all student aid is a scholarship","body":"Some support is scholarship, some is subsidy, some is educational assistance, and some is cash-for-work. If work or service is required, ask what task, schedule, rate, and completion proof are expected.","items":["Ask if the program is scholarship, educational assistance, cash-for-work, or cash-for-training","Ask if attendance, tutoring, office work, community work, or reports are required","Ask how payout is computed and when it is released","Ask what proof of completion is needed"]}'::jsonb,
    '{"title":"Iniisip na lahat ng student aid ay scholarship","body":"May support na scholarship, may subsidy, may educational assistance, at may cash-for-work. Kapag may required work o service, itanong kung ano ang task, schedule, rate, at completion proof na kailangan.","items":["Itanong kung scholarship, educational assistance, cash-for-work, o cash-for-training ang program","Itanong kung may required attendance, tutoring, office work, community work, o reports","Itanong kung paano kino-compute ang payout at kailan ito nire-release","Itanong kung anong proof of completion ang kailangan"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'tip',
    8,
    '{"title":"Keep application and work proof","body":"Save official announcements, orientation details, assignment proof, attendance, payout instructions, and receipts. This protects you if there is confusion about work completion or payment.","items":["Official announcement or memo","Orientation date and venue","Name of partner school, LGU, or DSWD office","Requirements submitted","Work assignment and schedule","Attendance, accomplishment report, or completion proof","Payout instruction, reference, or receipt"]}'::jsonb,
    '{"title":"I-save ang application at work proof","body":"Itago ang official announcements, orientation details, assignment proof, attendance, payout instructions, at resibo. Proteksyon ito kapag may kalituhan sa work completion o payment.","items":["Official announcement o memo","Orientation date at venue","Pangalan ng partner school, LGU, o DSWD office","Requirements na ipinasa","Work assignment at schedule","Attendance, accomplishment report, o completion proof","Payout instruction, reference, o resibo"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-cash-for-work-dswd-checklist'),
    'tip',
    9,
    '{"title":"What to expect if selected","body":"These opportunities are not just payouts. You may need to attend orientation, complete training, render work or service days, submit attendance or accomplishment proof, and follow payout instructions from the partner office.","items":["Role assignment: tutor, youth development worker, office/community support, or other approved task","Training or orientation before deployment","Work/service schedule and attendance tracking","Accomplishment report or completion proof","Payout method, rate, and timing from official instructions","Financial literacy or additional sessions if included in the rollout"]}'::jsonb,
    '{"title":"Ano ang aasahan kung selected","body":"Hindi lang payout ang opportunities na ito. Maaaring kailangan mong umattend ng orientation, tapusin ang training, mag-render ng work o service days, magsumite ng attendance o accomplishment proof, at sundin ang payout instructions ng partner office.","items":["Role assignment: tutor, youth development worker, office/community support, o ibang approved task","Training o orientation bago deployment","Work/service schedule at attendance tracking","Accomplishment report o completion proof","Payout method, rate, at timing mula sa official instructions","Financial literacy o dagdag sessions kung kasama sa rollout"]}'::jsonb
  );
