insert into public.guides (
  slug,
  category_id,
  title_en,
  title_fil,
  tagline_en,
  tagline_fil,
  is_featured,
  is_urgent,
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
  'student-financial-aid-philippines-checklist',
  (select id from public.categories where slug = 'education'),
  'Student financial assistance programs Filipinos often miss',
  'Student financial assistance na madalas hindi alam ng Filipinos',
  'Check CHED, TESDA, DSWD, LGU, and school aid before giving up or trusting random posts.',
  'I-check ang CHED, TESDA, DSWD, LGU, at school aid bago sumuko o maniwala sa random posts.',
  true,
  false,
  7,
  'katamtaman',
  '1-2 oras mag-check',
  'Libre magtanong',
  array[
    'student aid',
    'scholarship',
    'financial assistance',
    'ched',
    'unifast',
    'tesda',
    'dswd education assistance',
    'lgu scholarship',
    'school assistance',
    'edukasyon',
    'tulong estudyante',
    'ayuda estudyante'
  ],
  'student aid scholarship financial assistance ched unifast tes tesda dswd education assistance lgu scholarship school assistance tuition subsidy tertiary education tulong estudyante ayuda estudyante',
  'student aid scholarship financial assistance ched unifast tes tesda dswd education assistance lgu scholarship school assistance tuition subsidy tertiary education tulong estudyante ayuda estudyante edukasyon',
  '[
    {"title":"Unified Student Financial Assistance System for Tertiary Education","publisher":"CHED","url":"https://ched.gov.ph/unifast/"},
    {"title":"Tertiary Education Subsidy","publisher":"UniFAST","url":"https://www.unifast.gov.ph/tes.html"},
    {"title":"Scholarship and Student Assistance Programs","publisher":"TESDA","url":"https://tesda.gov.ph/About/TESDA/1279"},
    {"title":"Assistance to Individuals in Crisis Situation","publisher":"DSWD","url":"https://www.dswd.gov.ph/assistance-to-individuals-in-crisis-situation/"}
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
  where slug = 'student-financial-aid-philippines-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'what_to_know',
    1,
    '{"title":"Start with real offices, not viral posts","body":"Student aid in the Philippines can come from CHED-UniFAST, TESDA, DSWD AICS, LGUs, schools, and sometimes private foundations. The safest first step is to list which office actually covers your situation, then verify requirements directly."}'::jsonb,
    '{"title":"Magsimula sa totoong opisina, hindi sa viral post","body":"Ang student aid sa Pilipinas ay maaaring galing sa CHED-UniFAST, TESDA, DSWD AICS, LGU, school, at minsan private foundations. Pinaka-safe na unang step: alamin muna kung aling opisina ang sakop ng sitwasyon mo, tapos i-verify ang requirements diretso sa kanila."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'step',
    2,
    '{"title":"Check the right program bucket","body":"Do not search only for scholarship. Some help is called subsidy, grant-in-aid, training support, educational assistance, or student aid.","step_number":1,"items":["CHED-UniFAST for tertiary education subsidies and grants","TESDA for tech-voc scholarships or training support","DSWD AICS for education-related crisis assistance","LGU scholarship or educational assistance office","Your school registrar, guidance, student affairs, or financial aid office"]}'::jsonb,
    '{"title":"Hanapin ang tamang klase ng programa","body":"Huwag scholarship lang ang hanapin. Minsan ang tawag ay subsidy, grant-in-aid, training support, educational assistance, o student aid.","step_number":1,"items":["CHED-UniFAST para sa tertiary education subsidies at grants","TESDA para sa tech-voc scholarship o training support","DSWD AICS para sa education-related crisis assistance","LGU scholarship o educational assistance office","Registrar, guidance, student affairs, o financial aid office ng school"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'step',
    3,
    '{"title":"Decide which office to ask first","body":"Match your need to the office most likely to handle it. This prevents wasted messages, wrong lines, and fake pages pretending to process everything.","step_number":2,"items":["College tuition or tertiary subsidy: CHED-UniFAST or your school","Tech-voc training: TESDA or accredited training center","Crisis school expense: DSWD AICS or DSWD field office","City or provincial resident aid: LGU scholarship or education office","Unpaid school balance: registrar, student affairs, or financial aid office"]}'::jsonb,
    '{"title":"Piliin kung aling office ang unang tatanungin","body":"Itapat ang kailangan mo sa office na mas malamang may hawak nito. Iwas sayang message, maling pila, at fake pages na kunwari lahat kaya nilang i-process.","step_number":2,"items":["College tuition o tertiary subsidy: CHED-UniFAST o school mo","Tech-voc training: TESDA o accredited training center","Crisis school expense: DSWD AICS o DSWD field office","City o provincial resident aid: LGU scholarship o education office","Unpaid school balance: registrar, student affairs, o financial aid office"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'step',
    4,
    '{"title":"Do a quick eligibility check","body":"Before applying, check if your situation fits the program. This saves time and helps you ask the right office with the right proof.","step_number":3,"items":["Are you currently enrolled or accepted?","Are you college, tech-voc, senior high, or another school level?","Is your need tuition, unpaid balance, transport, food, books, training, or emergency school expense?","Are you a resident of a city, municipality, or province with student aid?","Do you have proof such as enrollment, billing, grades, ID, or indigency document?","Is the application posted by an official agency, LGU, school, or verified page?"]}'::jsonb,
    '{"title":"Mag-quick eligibility check muna","body":"Bago mag-apply, i-check kung pasok ang sitwasyon mo sa program. Makakatipid ito ng oras at mas malinaw mong matatanong ang tamang office na may tamang proof.","step_number":3,"items":["Currently enrolled o accepted ka ba?","College, tech-voc, senior high, o ibang school level ka ba?","Ang kailangan ba ay tuition, unpaid balance, pamasahe, pagkain, books, training, o emergency school expense?","Resident ka ba ng city, municipality, o province na may student aid?","May proof ka ba tulad ng enrollment, billing, grades, ID, o indigency document?","Official agency, LGU, school, o verified page ba ang nag-post ng application?"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'tip',
    5,
    '{"title":"Compare the main aid paths","body":"Use this as your first sorting tool. If one path does not fit, move to the next closest office instead of sending documents everywhere.","items":["CHED-UniFAST: best for college or tertiary subsidy; ask your school or CHED/UniFAST; usually needs enrollment and school records; watch for fake links using CHED names","TESDA: best for skills or tech-voc training; ask TESDA or accredited centers; usually needs ID and program requirements; watch for fake training fees","DSWD AICS: best for crisis school expense; ask DSWD or field office; usually needs proof of crisis and school expense; watch for fake ayuda pages","LGU scholarship: best for city or provincial resident aid; ask city hall, municipal hall, or LGU scholarship office; usually needs residency and school proof; watch for deadline changes","School aid: best for unpaid balance or school-specific support; ask registrar, student affairs, guidance, or financial aid office; usually needs enrollment and billing proof; watch for limited slots"]}'::jsonb,
    '{"title":"I-compare ang main aid paths","body":"Gamitin ito bilang unang sorting tool. Kapag hindi pasok ang isang path, lumipat sa mas tamang office imbes na kung saan-saan magpasa ng documents.","items":["CHED-UniFAST: para sa college o tertiary subsidy; magtanong sa school o CHED/UniFAST; madalas kailangan ang enrollment at school records; mag-ingat sa fake links na gumagamit ng pangalan ng CHED","TESDA: para sa skills o tech-voc training; magtanong sa TESDA o accredited centers; madalas kailangan ang ID at program requirements; mag-ingat sa fake training fees","DSWD AICS: para sa crisis school expense; magtanong sa DSWD o field office; madalas kailangan ang proof ng crisis at school expense; mag-ingat sa fake ayuda pages","LGU scholarship: para sa city o provincial resident aid; magtanong sa city hall, municipal hall, o LGU scholarship office; madalas kailangan ang residency at school proof; mag-ingat sa pabago-bagong deadline","School aid: para sa unpaid balance o school-specific support; magtanong sa registrar, student affairs, guidance, o financial aid office; madalas kailangan ang enrollment at billing proof; mag-ingat dahil limited ang slots"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'step',
    6,
    '{"title":"Prepare the usual proof before asking","body":"Requirements vary, but these documents are often requested. Having them ready makes it easier to ask a clear question and avoid repeated trips.","step_number":2,"items":["School ID or proof of enrollment","Certificate of registration or enrollment","Grades or transcript if available","Barangay certificate or certificate of indigency if requested","Parent or guardian ID when needed","Proof of billing, unpaid balance, or school-related expense","Contact number, address, and email"]}'::jsonb,
    '{"title":"Ihanda ang common proof bago magtanong","body":"Nag-iiba ang requirements, pero ito ang madalas hanapin. Kapag handa na, mas malinaw kang makakapagtanong at iwas balik-balik.","step_number":2,"items":["School ID o proof of enrollment","Certificate of registration o enrollment","Grades o transcript kung meron","Barangay certificate o certificate of indigency kung hinihingi","ID ng parent o guardian kung kailangan","Proof ng billing, balance, o school-related expense","Contact number, address, at email"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'step',
    7,
    '{"title":"Ask using one clear message","body":"Do not send a vague message like may ayuda po ba. Say your school level, location, need, and what document you already have.","step_number":3,"sample":"Hello po. Student po ako sa [school/program] at taga-[city/municipality]. Naghahanap po ako ng possible educational assistance para sa [tuition/books/transport/unpaid balance]. May open application po ba, ano po ang requirements, at saan po ang official submission?"}'::jsonb,
    '{"title":"Magtanong gamit ang isang malinaw na message","body":"Huwag basta mag-message ng may ayuda po ba. Sabihin ang school level, lugar, kailangan, at anong document ang meron ka na.","step_number":3,"sample":"Hello po. Student po ako sa [school/program] at taga-[city/municipality]. Naghahanap po ako ng possible educational assistance para sa [tuition/books/transport/unpaid balance]. May open application po ba, ano po ang requirements, at saan po ang official submission?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'warning',
    8,
    '{"title":"Fake scholarship posts often copy real program names","body":"Be careful when a post asks for processing fees, OTPs, passwords, bank login, or private documents through random links. Verify through the official agency, LGU, school office, or published contact details before submitting anything.","severity":"high","items":["Processing fee before assessment","OTP, password, bank login, or e-wallet login request","Shortened or random submission link","No official agency, school, or LGU page","Guaranteed approval promise","Extreme deadline pressure with no official memo"]}'::jsonb,
    '{"title":"Madalas ginagamit ng fake posts ang pangalan ng totoong programa","body":"Mag-ingat kapag may processing fee, OTP, password, bank login, o private documents na pinapasubmit sa random link. I-verify muna sa official agency, LGU, school office, o published contact details bago magpasa ng kahit ano.","severity":"high","items":["Processing fee bago ma-assess","Hinihinging OTP, password, bank login, o e-wallet login","Shortened o random submission link","Walang official agency, school, o LGU page","Guaranteed approval promise","Matinding deadline pressure pero walang official memo"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'mistake',
    9,
    '{"title":"Do not apply blindly to everything","body":"Some programs are for college, some for tech-voc, some for students in crisis, and some for residents of a specific city or province. Applying to the wrong program wastes time and can expose your documents to unsafe pages."}'::jsonb,
    '{"title":"Huwag basta apply sa lahat","body":"May program na para sa college, may para sa tech-voc, may para sa students in crisis, at may para lang sa residente ng isang city o province. Kapag mali ang program, sayang oras at mas delikado kung kung saan-saan napapasa ang documents mo."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'tip',
    10,
    '{"title":"Save proof before and after applying","body":"Keep screenshots and confirmation details in one folder. If there is a delay or issue, these are easier to show than trying to remember where you applied.","items":["Official post or memo","Requirements list","Deadline","Submission link or office address","Contact number or email","Confirmation receipt or reference number","Name of office or person contacted"]}'::jsonb,
    '{"title":"I-save ang proof bago at pagkatapos mag-apply","body":"Itago ang screenshots at confirmation details sa isang folder. Kapag may delay o issue, mas madaling ipakita ito kaysa alalahanin kung saan ka nag-apply.","items":["Official post o memo","Requirements list","Deadline","Submission link o office address","Contact number o email","Confirmation receipt o reference number","Pangalan ng office o taong nakausap"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'student-financial-aid-philippines-checklist'),
    'tip',
    11,
    '{"title":"Use three verification doors","body":"If you are unsure, verify through three doors: the agency website, your school office, and your LGU education or scholarship office. If all three do not recognize the offer, treat it as suspicious."}'::jsonb,
    '{"title":"Gamitin ang tatlong verification doors","body":"Kung hindi ka sigurado, mag-verify sa tatlong lugar: agency website, school office, at LGU education o scholarship office. Kung walang nakakakilala sa offer, ituring itong suspicious."}'::jsonb
  );
