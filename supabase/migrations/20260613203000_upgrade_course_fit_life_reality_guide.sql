update public.guides
set
  tagline_en = 'Understand fit, cost, work reality, and daily life before choosing.',
  tagline_fil = 'Intindihin ang fit, gastos, work reality, at daily life bago pumili.',
  read_time_min = 9,
  estimated_time = '45-75 minuto para sa honest course reality check',
  keywords_en = keywords_en || ' daily work reality course lifestyle graduate life work tasks school fit future advantage course comparison',
  keywords_fil = keywords_fil || ' daily work reality buhay pagkatapos ng course trabaho ng graduate gawain sa trabaho bagay ba sa akin course comparison',
  updated_at = now()
where slug = 'choose-course-fit-checklist';

delete from public.guide_sections
where guide_id = (
  select id
  from public.guides
  where slug = 'choose-course-fit-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'choose-course-fit-checklist'),
    'what_to_know',
    1,
    $${
      "title":"A course is a future routine, not just a subject",
      "body":"A good course decision is not only about what you like in school. It is also about the daily work, money pressure, training path, people you will serve, and backup options that come after it. DemoAlam cannot choose your course for you. It can help you avoid choosing blind.",
      "items":[
        "Interest matters, but daily work reality matters too",
        "A course should be checked against cost, time, commute, and family situation",
        "Ask what graduates actually do during a normal workday",
        "Look for skills you can transfer if your first plan changes",
        "A wise choice gives you options, not just a nice course title"
      ]
    }$$::jsonb,
    $${
      "title":"Ang course ay future routine, hindi lang subject",
      "body":"Ang magandang course decision ay hindi lang tungkol sa gusto mong subject. Tungkol din ito sa araw-araw na trabaho, pressure sa pera, training path, taong pagsisilbihan mo, at backup options pagkatapos. Hindi pipili ang DemoAlam para sa iyo. Tutulungan ka nitong huwag pumili nang bulag.",
      "items":[
        "Mahalaga ang interest, pero mahalaga rin ang daily work reality",
        "I-check ang course laban sa gastos, oras, biyahe, at family situation",
        "Alamin kung ano talaga ang ginagawa ng graduates sa normal na workday",
        "Humanap ng skills na puwedeng ilipat kung magbago ang first plan mo",
        "Ang matalinong choice ay nagbibigay ng options, hindi lang magandang course title"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'choose-course-fit-checklist'),
    'warning',
    2,
    $${
      "title":"Do not choose from the fantasy version only",
      "body":"Every path has a brochure version and a real-life version. The risky choice is choosing from title, pressure, trend, or imagined salary without checking the ordinary days that come with it.",
      "severity":"medium",
      "items":[
        "Do not choose only because someone said there is money there",
        "Do not reject a path only because one person scared you",
        "Do not ignore tuition, commute, materials, board exam, certification, or training costs",
        "Do not assume college is the only path; check tech-voc and skills options too",
        "Do not enroll without knowing the first-year subjects and the first-job path"
      ]
    }$$::jsonb,
    $${
      "title":"Huwag pumili mula sa fantasy version lang",
      "body":"May brochure version at real-life version ang bawat path. Delikado kapag pumili ka dahil lang sa title, pressure, uso, o imagined salary nang hindi chine-check ang ordinaryong araw na kasama nito.",
      "severity":"medium",
      "items":[
        "Huwag pumili dahil lang may nagsabing malaki ang pera doon",
        "Huwag i-reject ang path dahil lang may isang nanakot sa iyo",
        "Huwag balewalain ang tuition, pamasahe, materials, board exam, certification, o training costs",
        "Huwag isipin na college lang ang path; i-check din ang tech-voc at skills options",
        "Huwag mag-enroll nang hindi alam ang first-year subjects at first-job path"
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
      "title":"Picture one normal week after this course",
      "body":"Do not only imagine graduation day. Imagine an ordinary week after the course. If that life feels completely unknown, collect more evidence before committing.",
      "step_number":2,
      "items":[
        "What time might the workday start and end?",
        "Will the work be mostly people-facing, computer-based, field-based, physical, creative, caregiving, or paperwork-heavy?",
        "What problems will people expect you to solve?",
        "Will you need a license, board exam, portfolio, certification, training, or equipment?",
        "Can you see yourself learning this work even when it becomes boring or difficult?"
      ]
    }$$::jsonb,
    $${
      "title":"I-picture ang isang normal na linggo pagkatapos ng course",
      "body":"Huwag graduation day lang ang isipin. I-picture ang ordinaryong linggo pagkatapos ng course. Kung hindi mo pa makita ang buhay na iyon, kailangan mo pang kumuha ng ebidensya bago mag-commit.",
      "step_number":2,
      "items":[
        "Anong oras kaya nagsisimula at natatapos ang workday?",
        "People-facing, computer-based, field-based, physical, creative, caregiving, o paperwork-heavy ba ang trabaho?",
        "Anong problema ang aasahan ng tao na kaya mong solusyonan?",
        "Kailangan ba ng license, board exam, portfolio, certification, training, o equipment?",
        "Kaya mo bang aralin ang trabahong ito kahit maging boring o mahirap?"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'choose-course-fit-checklist'),
    'step',
    5,
    $${
      "title":"Check the real cost of the path",
      "body":"The listed tuition is not the full cost. A course can become harder because of transport, materials, uniforms, tools, practicum, board exam review, internet, or unpaid training time.",
      "step_number":3,
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
      "step_number":3,
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
    6,
    $${
      "title":"Collect real-world proof before deciding",
      "body":"A stronger decision has evidence behind it. Try to collect at least two real-world signals before you enroll, shift, or commit.",
      "step_number":4,
      "items":[
        "Talk to one graduate, worker, teacher, guidance counselor, or senior student",
        "Watch or read about the actual tasks, not only the course description",
        "Check entry-level job posts and note repeated requirements",
        "Ask what people dislike about the field, not only what they like",
        "Look for a small trial: workshop, short course, online exercise, school org task, volunteer task, or interview"
      ]
    }$$::jsonb,
    $${
      "title":"Kumuha ng real-world proof bago magdesisyon",
      "body":"Mas matibay ang desisyon kapag may ebidensya. Subukan kumuha ng kahit dalawang real-world signals bago mag-enroll, mag-shift, o mag-commit.",
      "step_number":4,
      "items":[
        "Kausapin ang isang graduate, worker, teacher, guidance counselor, o senior student",
        "Manood o magbasa tungkol sa actual tasks, hindi course description lang",
        "Tingnan ang entry-level job posts at pansinin ang paulit-ulit na requirements",
        "Itanong kung ano ang ayaw ng tao sa field, hindi puro gusto lang",
        "Humanap ng small trial: workshop, short course, online exercise, school org task, volunteer task, o interview"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'choose-course-fit-checklist'),
    'tip',
    7,
    $${
      "title":"Use a 3-option life comparison",
      "body":"Do not decide from twenty vague dreams. Compare three realistic options side by side, including the life each path may create.",
      "sample":"Option A: _____. Cost: _____. Daily work after: _____. Why it fits me: _____. Biggest risk: _____. Aid or backup path: _____. Proof I still need: _____."
    }$$::jsonb,
    $${
      "title":"Gumamit ng 3-option life comparison",
      "body":"Huwag magdesisyon mula sa dalawampung malabong pangarap. I-compare ang tatlong realistic options side by side, kasama ang buhay na posibleng likhain ng bawat path.",
      "sample":"Option A: _____. Gastos: _____. Daily work pagkatapos: _____. Bakit bagay sa akin: _____. Pinakamalaking risk: _____. Aid o backup path: _____. Proof na kailangan ko pa: _____."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'choose-course-fit-checklist'),
    'related',
    8,
    $${
      "title":"Related guides",
      "body":"Use these next depending on what blocks your course decision.",
      "items":[
        "Student Financial Assistance Programs: if cost is the biggest blocker",
        "Student Cash-for-Work: if you need possible short-term student support",
        "First Job Requirements: if you want to understand work realities early",
        "Study Smarter When Behind: if confidence or workload is the blocker",
        "Resume Checklist With No Work Experience: if you need proof of skills"
      ]
    }$$::jsonb,
    $${
      "title":"Related guides",
      "body":"Gamitin ang mga ito depende sa humaharang sa course decision mo.",
      "items":[
        "Student Financial Assistance Programs: kung gastos ang biggest blocker",
        "Student Cash-for-Work: kung kailangan mo ng possible short-term student support",
        "First Job Requirements: kung gusto mong maintindihan ang work realities nang maaga",
        "Study Smarter Kapag Nahuhuli Ka Na: kung confidence o workload ang blocker",
        "Resume Checklist Kahit Walang Work Experience: kung kailangan mong ipakita ang skills"
      ]
    }$$::jsonb
  );
