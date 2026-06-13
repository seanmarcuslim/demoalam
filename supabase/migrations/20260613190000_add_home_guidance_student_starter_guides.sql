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
values
  (
    'choose-course-fit-checklist',
    (select id from public.categories where slug = 'education'),
    'Choose a course that fits your life checklist',
    'Checklist sa pagpili ng course na bagay sa buhay mo',
    'Check cost, strengths, work reality, and backup paths before enrolling.',
    'I-check ang gastos, strengths, work reality, at backup paths bago mag-enroll.',
    true,
    false,
    true,
    7,
    'katamtaman',
    '30-60 minuto para sa first pass',
    'Libre; kailangan lang ng honest self-check at school/program research',
    array[
      'course',
      'college',
      'strand',
      'career',
      'student',
      'ched',
      'tesda',
      'scholarship',
      'future advantage',
      'school decision'
    ],
    'choose course college course strand career path program fit tuition scholarship tesda ched skills job reality parents pressure undecided student future work course decision',
    'pumili ng course anong course bagay na course college strand career path programa tuition scholarship tesda ched skills trabaho realidad pressure ng magulang undecided estudyante future work desisyon sa course',
    $$[
      {"title":"Unified Student Financial Assistance System for Tertiary Education","publisher":"CHED","url":"https://ched.gov.ph/unifast/"},
      {"title":"Scholarship and Student Assistance Programs","publisher":"TESDA","url":"https://tesda.gov.ph/About/TESDA/1279"},
      {"title":"PhilJobNet - Jobs and LMI Portal","publisher":"Department of Labor and Employment","url":"https://philjobnet.gov.ph/"}
    ]$$::jsonb,
    now(),
    now()
  ),
  (
    'study-smarter-when-behind-checklist',
    (select id from public.categories where slug = 'education'),
    'Study smarter when you feel behind checklist',
    'Study smarter kapag nahuhuli ka na checklist',
    'Turn panic into a small study plan you can actually finish this week.',
    'Gawing maliit at kayang tapusing study plan ang panic ngayong linggo.',
    true,
    false,
    true,
    6,
    'madali',
    '20-40 minuto para gumawa ng study reset plan',
    'Libre',
    array[
      'study',
      'student',
      'school',
      'exam',
      'review',
      'schedule',
      'study habits',
      'behind in school',
      'future advantage'
    ],
    'study smarter study plan behind in school exam review schedule cramming homework assignments grades student school focus time management study habits catch up overwhelmed',
    'study smarter study plan nahuhuli sa school exam review schedule cramming assignment grades estudyante focus time management study habits habol sa lesson overwhelmed',
    $$[]$$::jsonb,
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
  published_at = coalesce(public.guides.published_at, excluded.published_at),
  updated_at = now();

delete from public.guide_sections
where guide_id in (
  select id
  from public.guides
  where slug in (
    'choose-course-fit-checklist',
    'study-smarter-when-behind-checklist'
  )
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'choose-course-fit-checklist'),
    'what_to_know',
    1,
    $${
      "title":"A course is not only a subject you like",
      "body":"A good course decision balances interest, ability, cost, school access, family situation, and the kind of work you can realistically try after graduation. You do not need to know your whole future today. You need the next honest check.",
      "items":[
        "Interest matters, but it is not the only factor",
        "Check cost and aid before assuming a course is impossible",
        "Ask what graduates actually do after the course",
        "Look for skills you can use even if your first plan changes",
        "Avoid choosing only because of pressure, trend, or fear"
      ]
    }$$::jsonb,
    $${
      "title":"Hindi lang paboritong subject ang course",
      "body":"Ang magandang course decision ay balance ng interest, kakayahan, gastos, access sa school, family situation, at klase ng trabahong realistic mong masubukan after graduation. Hindi mo kailangang alam agad ang buong future mo ngayon. Kailangan mo muna ng honest na check.",
      "items":[
        "Mahalaga ang interest, pero hindi iyon lang ang factor",
        "I-check ang gastos at aid bago sabihing imposible ang course",
        "Alamin kung ano talaga ang ginagawa ng graduates pagkatapos",
        "Humanap ng skills na magagamit kahit magbago ang first plan mo",
        "Iwasang pumili dahil lang sa pressure, uso, o takot"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'choose-course-fit-checklist'),
    'warning',
    2,
    $${
      "title":"Do not let one loud opinion decide your path",
      "body":"Parents, friends, teachers, social media, and trends can all influence you. Listen, but do not outsource the decision. Your course affects your time, money, confidence, and early work options.",
      "severity":"medium",
      "items":[
        "Do not choose only because someone said there is money there",
        "Do not reject a path only because one person scared you",
        "Do not ignore tuition, commute, materials, board exam, or training costs",
        "Do not assume college is the only path; check tech-voc and skills options too",
        "Do not enroll without knowing the first-year subjects and requirements"
      ]
    }$$::jsonb,
    $${
      "title":"Huwag hayaang isang malakas na opinion ang magdesisyon",
      "body":"Puwede kang maimpluwensiyahan ng parents, friends, teachers, social media, at trends. Makinig, pero huwag ipasa sa iba ang buong decision. Apektado ng course ang oras, pera, confidence, at early work options mo.",
      "severity":"medium",
      "items":[
        "Huwag pumili dahil lang may nagsabing malaki ang pera doon",
        "Huwag i-reject ang path dahil lang may isang nanakot sa iyo",
        "Huwag balewalain ang tuition, pamasahe, materials, board exam, o training costs",
        "Huwag isipin na college lang ang path; i-check din ang tech-voc at skills options",
        "Huwag mag-enroll nang hindi alam ang first-year subjects at requirements"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'choose-course-fit-checklist'),
    'step',
    3,
    $${
      "title":"Write your honest fit signals",
      "body":"Before comparing schools, write what you know about yourself. The point is not to flatter yourself. The point is to avoid choosing blind.",
      "step_number":1,
      "items":[
        "Subjects or tasks you can tolerate even when they are hard",
        "Subjects or tasks that drain you quickly",
        "Skills people already ask you for help with",
        "Work settings you might handle: office, field, people-facing, technical, creative, caregiving, business, or public service",
        "Non-negotiables: budget, commute, family duties, health, schedule, or need to work while studying"
      ]
    }$$::jsonb,
    $${
      "title":"Isulat ang honest fit signals mo",
      "body":"Bago mag-compare ng schools, isulat muna ang alam mo tungkol sa sarili mo. Hindi ito para purihin ang sarili. Para hindi ka pumili nang bulag.",
      "step_number":1,
      "items":[
        "Subjects o tasks na kaya mong tiisin kahit mahirap",
        "Subjects o tasks na mabilis kang ma-drain",
        "Skills na hinihingan ka na ng tulong ng ibang tao",
        "Work settings na kaya mong subukan: office, field, people-facing, technical, creative, caregiving, business, o public service",
        "Non-negotiables: budget, commute, family duties, health, schedule, o kailangan magtrabaho habang nag-aaral"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'choose-course-fit-checklist'),
    'step',
    4,
    $${
      "title":"Check the real cost of the path",
      "body":"The listed tuition is not the full cost. A course can become harder because of transport, materials, uniforms, tools, practicum, board exam review, internet, or unpaid training time.",
      "step_number":2,
      "items":[
        "Tuition and school fees",
        "Transport, food, dorm, or boarding costs",
        "Uniforms, tools, lab fees, books, device, or internet needs",
        "Internship, practicum, OJT, board exam, or certification costs",
        "Possible aid: CHED-UniFAST, TESDA, LGU, school aid, or private scholarship"
      ]
    }$$::jsonb,
    $${
      "title":"I-check ang totoong gastos ng path",
      "body":"Hindi lang tuition ang gastos. Puwedeng pahirapan ng pamasahe, materials, uniform, tools, practicum, board exam review, internet, o unpaid training time ang course.",
      "step_number":2,
      "items":[
        "Tuition at school fees",
        "Pamasahe, pagkain, dorm, o boarding costs",
        "Uniforms, tools, lab fees, books, device, o internet needs",
        "Internship, practicum, OJT, board exam, o certification costs",
        "Possible aid: CHED-UniFAST, TESDA, LGU, school aid, o private scholarship"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'choose-course-fit-checklist'),
    'step',
    5,
    $${
      "title":"Ask what graduates actually do",
      "body":"A course title can sound impressive but lead to many different jobs. Ask about real graduate paths, not only the brochure version.",
      "step_number":3,
      "items":[
        "What entry-level jobs do graduates usually try first?",
        "Is a license, board exam, portfolio, certification, or training required?",
        "Can the skills transfer to another job if the first plan changes?",
        "What jobs are nearby, online, field-based, local, or abroad?",
        "Can you talk to one graduate, teacher, guidance counselor, or worker in that field?"
      ]
    }$$::jsonb,
    $${
      "title":"Alamin kung ano talaga ang ginagawa ng graduates",
      "body":"Puwedeng maganda pakinggan ang course title pero iba-iba ang puwedeng trabaho pagkatapos. Alamin ang totoong graduate paths, hindi brochure version lang.",
      "step_number":3,
      "items":[
        "Anong entry-level jobs ang karaniwang sinusubukan ng graduates?",
        "Kailangan ba ng license, board exam, portfolio, certification, o training?",
        "Transferable ba ang skills kung magbago ang first plan?",
        "Anong jobs ang nearby, online, field-based, local, o abroad?",
        "May graduate, teacher, guidance counselor, o worker ba sa field na puwede mong kausapin?"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'choose-course-fit-checklist'),
    'tip',
    6,
    $${
      "title":"Use a 3-option shortlist",
      "body":"Do not decide from twenty vague dreams. Compare three realistic options side by side.",
      "sample":"Option A: _____. Cost: _____. Why it fits me: _____. Biggest risk: _____. Aid or backup path: _____. First job or skill path after: _____."
    }$$::jsonb,
    $${
      "title":"Gumamit ng 3-option shortlist",
      "body":"Huwag magdesisyon mula sa dalawampung malabong pangarap. I-compare ang tatlong realistic options side by side.",
      "sample":"Option A: _____. Gastos: _____. Bakit bagay sa akin: _____. Pinakamalaking risk: _____. Aid o backup path: _____. First job o skill path pagkatapos: _____."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'choose-course-fit-checklist'),
    'related',
    7,
    $${
      "title":"Related guides",
      "body":"Use these next depending on what blocks your course decision.",
      "items":[
        "Student Financial Assistance Programs: if cost is the biggest blocker",
        "Student Cash-for-Work: if you need possible short-term student support",
        "First Job Requirements: if you want to understand work realities early",
        "Resume Checklist With No Work Experience: if you need proof of skills",
        "Fake Job Offer Red Flags: if someone promises a shortcut for a fee"
      ]
    }$$::jsonb,
    $${
      "title":"Related guides",
      "body":"Gamitin ang mga ito depende sa humaharang sa course decision mo.",
      "items":[
        "Student Financial Assistance Programs: kung gastos ang biggest blocker",
        "Student Cash-for-Work: kung kailangan mo ng possible short-term student support",
        "First Job Requirements: kung gusto mong maintindihan ang work realities nang maaga",
        "Resume Checklist Kahit Walang Work Experience: kung kailangan mong ipakita ang skills",
        "Fake Job Offer Red Flags: kung may nangangako ng shortcut kapalit ng bayad"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'study-smarter-when-behind-checklist'),
    'what_to_know',
    1,
    $${
      "title":"Feeling behind is a signal, not a sentence",
      "body":"When you are behind, the goal is not to fix your whole life in one night. The goal is to choose the next highest-impact task, reduce panic, and make one plan you can actually do.",
      "items":[
        "Start with what is due soonest and worth the most",
        "Separate studying from organizing; both matter",
        "A tiny finished plan beats a perfect plan you avoid",
        "Ask for help earlier than your pride wants",
        "If money, internet, commute, or family duties are blocking school, solve the blocker too"
      ]
    }$$::jsonb,
    $${
      "title":"Ang pakiramdam na nahuhuli ka ay signal, hindi sentensya",
      "body":"Kapag nahuhuli ka na, hindi goal na ayusin ang buong buhay sa isang gabi. Ang goal ay piliin ang pinaka-importanteng next task, bawasan ang panic, at gumawa ng planong kaya mong gawin.",
      "items":[
        "Unahin ang pinakamalapit ang deadline at pinakamalaki ang epekto",
        "Paghiwalayin ang studying at organizing; pareho silang mahalaga",
        "Mas okay ang maliit na planong natapos kaysa perfect plan na iniiwasan mo",
        "Humingi ng tulong nang mas maaga kaysa gusto ng pride mo",
        "Kung pera, internet, pamasahe, o family duties ang humaharang sa school, ayusin din ang blocker"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'study-smarter-when-behind-checklist'),
    'warning',
    2,
    $${
      "title":"Do not start by rewriting everything beautifully",
      "body":"Pretty notes can feel productive, but they may hide the real problem: you still do not know what to answer, submit, or practice. Start with active work.",
      "severity":"medium",
      "items":[
        "Do not spend the whole night designing notes",
        "Do not reread passively and call it review",
        "Do not open every subject at once",
        "Do not ignore the task with the nearest deadline",
        "Do not wait until you feel motivated before starting"
      ]
    }$$::jsonb,
    $${
      "title":"Huwag magsimula sa sobrang gandang notes",
      "body":"Nakakaramdam ng productivity ang magandang notes, pero puwede nitong itago ang totoong problema: hindi mo pa rin alam ang isasagot, ipapasa, o ipa-practice. Magsimula sa active work.",
      "severity":"medium",
      "items":[
        "Huwag ubusin ang buong gabi sa pag-design ng notes",
        "Huwag basta reread lang tapos tawaging review",
        "Huwag buksan lahat ng subject sabay-sabay",
        "Huwag balewalain ang task na pinakamalapit ang deadline",
        "Huwag hintayin ang motivation bago magsimula"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'study-smarter-when-behind-checklist'),
    'step',
    3,
    $${
      "title":"Make a panic dump list",
      "body":"Write every school task in one place first. Your brain relaxes when it stops carrying everything at once.",
      "step_number":1,
      "items":[
        "Quizzes, exams, assignments, projects, readings, reports, group work",
        "Deadline or exam date",
        "Estimated effort: small, medium, or heavy",
        "Impact: high grade impact, required to pass, or nice to improve",
        "Blocker: unclear instruction, no internet, no materials, groupmate issue, or no money"
      ]
    }$$::jsonb,
    $${
      "title":"Gumawa ng panic dump list",
      "body":"Isulat muna lahat ng school tasks sa iisang lugar. Mas kumakalma ang utak kapag hindi niya kailangang buhatin lahat sabay-sabay.",
      "step_number":1,
      "items":[
        "Quizzes, exams, assignments, projects, readings, reports, group work",
        "Deadline o exam date",
        "Estimated effort: small, medium, o heavy",
        "Impact: malaking epekto sa grade, required para pumasa, o nice to improve",
        "Blocker: malabong instruction, walang internet, walang materials, groupmate issue, o walang pera"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'study-smarter-when-behind-checklist'),
    'step',
    4,
    $${
      "title":"Pick the next three moves",
      "body":"Do not make a huge schedule first. Pick three moves that reduce the most risk this week.",
      "step_number":2,
      "items":[
        "One urgent task due soon",
        "One high-impact review topic",
        "One blocker to ask help for",
        "One small task you can finish in 20 minutes if you feel stuck",
        "One rest or sleep protection rule so you do not crash"
      ]
    }$$::jsonb,
    $${
      "title":"Piliin ang next three moves",
      "body":"Huwag munang gumawa ng malaking schedule. Pumili ng tatlong galaw na makakabawas ng pinakamalaking risk ngayong linggo.",
      "step_number":2,
      "items":[
        "Isang urgent task na malapit ang deadline",
        "Isang high-impact review topic",
        "Isang blocker na kailangan mong itanong",
        "Isang maliit na task na kaya mong tapusin sa 20 minutes kapag stuck ka",
        "Isang rest o sleep protection rule para hindi ka bumagsak sa pagod"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'study-smarter-when-behind-checklist'),
    'step',
    5,
    $${
      "title":"Use active recall before rereading",
      "body":"Before opening notes again, try answering what you remember. This shows what you actually know and what needs work.",
      "step_number":3,
      "items":[
        "Write 5 possible questions from the lesson",
        "Answer without looking first",
        "Check notes only after trying",
        "Mark what you missed",
        "Repeat the missed parts tomorrow, not only tonight"
      ]
    }$$::jsonb,
    $${
      "title":"Gamitin ang active recall bago rereading",
      "body":"Bago buksan ulit ang notes, subukan munang sagutin ang naaalala mo. Dito mo makikita kung ano talaga ang alam mo at ano ang kailangan pang ayusin.",
      "step_number":3,
      "items":[
        "Gumawa ng 5 possible questions mula sa lesson",
        "Sagutin muna nang hindi tumitingin",
        "I-check ang notes pagkatapos subukan",
        "Markahan ang mali o kulang",
        "Ulitin ang missed parts bukas, hindi ngayong gabi lang"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'study-smarter-when-behind-checklist'),
    'tip',
    6,
    $${
      "title":"Send one clear help message",
      "body":"If a blocker is stopping you, ask early. A clear question is easier to answer than a vague panic message.",
      "sample":"Hello po. Nahihirapan po ako sa [specific topic/task]. Ang naiintindihan ko po ay ____. Ang hindi ko po gets ay ____. Pwede po bang paki-confirm kung tama ang direction ko o kung ano ang dapat kong unahin?"
    }$$::jsonb,
    $${
      "title":"Mag-send ng isang malinaw na help message",
      "body":"Kung may blocker, magtanong nang maaga. Mas madaling sagutin ang malinaw na tanong kaysa vague na panic message.",
      "sample":"Hello po. Nahihirapan po ako sa [specific topic/task]. Ang naiintindihan ko po ay ____. Ang hindi ko po gets ay ____. Pwede po bang paki-confirm kung tama ang direction ko o kung ano ang dapat kong unahin?"
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'study-smarter-when-behind-checklist'),
    'related',
    7,
    $${
      "title":"Related guides",
      "body":"Use these if the study problem is connected to money, school support, or your next path.",
      "items":[
        "Student Financial Assistance Programs: if money is blocking school",
        "Student Cash-for-Work: if you need support while studying",
        "Choose a Course That Fits Your Life: if you are unsure why you are studying this path",
        "Resume Checklist With No Work Experience: if you need to turn school work into proof",
        "Emergency Fund Starter Checklist: if one family problem keeps disrupting school"
      ]
    }$$::jsonb,
    $${
      "title":"Related guides",
      "body":"Gamitin ang mga ito kung konektado sa pera, school support, o next path ang study problem.",
      "items":[
        "Student Financial Assistance Programs: kung pera ang humaharang sa school",
        "Student Cash-for-Work: kung kailangan ng support habang nag-aaral",
        "Choose a Course That Fits Your Life: kung hindi ka sigurado bakit ito ang path mo",
        "Resume Checklist Kahit Walang Work Experience: kung kailangan mong gawing proof ang school work",
        "Emergency Fund Starter Checklist: kung may family problem na paulit-ulit na gumugulo sa school"
      ]
    }$$::jsonb
  );
