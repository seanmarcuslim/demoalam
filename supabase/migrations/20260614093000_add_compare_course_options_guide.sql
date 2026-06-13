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
  'compare-3-course-options-checklist',
  (select id from public.categories where slug = 'education'),
  'Compare 3 course options before deciding',
  'Ikumpara ang 3 course options bago magdesisyon',
  'Compare fit, cost, daily work, and backup paths before committing.',
  'Ikumpara ang fit, gastos, daily work, at backup paths bago mag-commit.',
  true,
  false,
  true,
  8,
  'katamtaman',
  '45-60 minuto para sa first comparison',
  'Libre; kailangan lang ng honest notes at konting research',
  array[
    'course',
    'college',
    'strand',
    'career',
    'student',
    'course comparison',
    'future advantage',
    'school decision',
    'backup path'
  ],
  'compare 3 course options course comparison college strand career path tuition scholarship work reality daily work backup path dream course practical course student decision future advantage',
  'ikumpara 3 course options course comparison college strand career path tuition scholarship realidad ng trabaho daily work backup path dream course practical course desisyon sa course future advantage',
  $$[
    {"title":"Unified Student Financial Assistance System for Tertiary Education","publisher":"CHED","url":"https://ched.gov.ph/unifast/"},
    {"title":"Scholarship and Student Assistance Programs","publisher":"TESDA","url":"https://tesda.gov.ph/About/TESDA/1279"},
    {"title":"PhilJobNet - Jobs and LMI Portal","publisher":"Department of Labor and Employment","url":"https://philjobnet.gov.ph/"}
  ]$$::jsonb,
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
where guide_id = (
  select id
  from public.guides
  where slug = 'compare-3-course-options-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'compare-3-course-options-checklist'),
    'what_to_know',
    1,
    $${
      "title":"Do not compare course names. Compare future routines.",
      "body":"A course title can sound impressive while the daily work, cost, or training path does not fit your life. Compare three realistic options side by side before you commit: your dream option, your practical option, and your backup option.",
      "items":[
        "Course choice is not only about interest",
        "A good option should survive questions about cost, work reality, and backup paths",
        "Three options are enough for a first serious comparison",
        "The goal is not certainty; the goal is a wiser next conversation"
      ]
    }$$::jsonb,
    $${
      "title":"Huwag course names lang ang ikumpara. Ikumpara ang future routines.",
      "body":"Puwedeng maganda pakinggan ang course title pero hindi bagay ang daily work, gastos, o training path sa buhay mo. Ikumpara muna ang tatlong realistic options bago mag-commit: dream option, practical option, at backup option.",
      "items":[
        "Hindi interest lang ang course choice",
        "Dapat kayanin ng magandang option ang tanong tungkol sa gastos, work reality, at backup paths",
        "Sapat na ang tatlong options para sa first serious comparison",
        "Hindi perfect certainty ang goal; mas matalinong next conversation ang goal"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'compare-3-course-options-checklist'),
    'warning',
    2,
    $${
      "title":"A dream course can still be a risky choice if the proof is weak",
      "body":"Do not reject your dream automatically. Just do not protect it from evidence. If a course cannot answer basic questions about cost, subjects, work tasks, and backup paths, you are not ready to commit yet.",
      "severity":"medium",
      "items":[
        "Do not choose only from prestige or imagined salary",
        "Do not choose only because your friends are choosing it",
        "Do not ignore commute, allowance, materials, practicum, or board exam costs",
        "Do not assume you know the job until you check real entry-level work"
      ]
    }$$::jsonb,
    $${
      "title":"Puwedeng risky pa rin ang dream course kung mahina ang proof",
      "body":"Huwag automatic i-reject ang dream mo. Pero huwag din itong itago sa ebidensya. Kung hindi masagot ng course ang basic questions tungkol sa gastos, subjects, work tasks, at backup paths, hindi ka pa ready mag-commit.",
      "severity":"medium",
      "items":[
        "Huwag pumili dahil lang sa prestige o imagined salary",
        "Huwag pumili dahil lang doon pupunta ang friends mo",
        "Huwag balewalain ang commute, allowance, materials, practicum, o board exam costs",
        "Huwag isiping alam mo na ang job hangga't hindi mo chine-check ang real entry-level work"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'compare-3-course-options-checklist'),
    'step',
    3,
    $${
      "title":"Pick three realistic options",
      "body":"Choose one option you want, one option that looks practical, and one backup path you could respect if the first two do not work.",
      "step_number":1,
      "items":[
        "Dream option: the course you keep thinking about",
        "Practical option: the course or training path that fits cost, access, or job timing better",
        "Backup option: a path that still builds useful skills if plans change",
        "Include TESDA or skills training if it honestly belongs in your options",
        "Write the school or training provider you are considering for each option"
      ]
    }$$::jsonb,
    $${
      "title":"Pumili ng tatlong realistic options",
      "body":"Pumili ng isang option na gusto mo, isang mukhang practical, at isang backup path na kaya mo pa ring respetuhin kung hindi matuloy ang unang dalawa.",
      "step_number":1,
      "items":[
        "Dream option: course na paulit-ulit mong naiisip",
        "Practical option: course o training path na mas bagay sa gastos, access, o timing ng trabaho",
        "Backup option: path na may useful skills pa rin kung magbago ang plano",
        "Isama ang TESDA o skills training kung honest na pasok ito sa options mo",
        "Isulat ang school o training provider na tinitingnan mo para sa bawat option"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'compare-3-course-options-checklist'),
    'step',
    4,
    $${
      "title":"Score each option using five life checks",
      "body":"Do not overcomplicate the comparison. Give each option a quick 1 to 5 score for the parts that will affect your real life.",
      "step_number":2,
      "items":[
        "Interest: can I stay curious when this becomes hard?",
        "Ability fit: do my current strengths or learning style match the workload?",
        "Cost and access: can my family and I realistically handle the expenses and commute?",
        "Work reality: do I understand what entry-level work looks like?",
        "Backup strength: will this path still give me useful skills if plans change?"
      ]
    }$$::jsonb,
    $${
      "title":"I-score ang bawat option gamit ang five life checks",
      "body":"Huwag gawing komplikado ang comparison. Bigyan ang bawat option ng quick 1 to 5 score sa mga bagay na makakaapekto sa totoong buhay mo.",
      "step_number":2,
      "items":[
        "Interest: kaya ko pa bang maging curious kapag humirap ito?",
        "Ability fit: bagay ba ang strengths o learning style ko sa workload?",
        "Gastos at access: kaya ba ng pamilya at sitwasyon ko ang expenses at biyahe?",
        "Work reality: naiintindihan ko ba ang entry-level work pagkatapos nito?",
        "Backup strength: may useful skills pa rin ba ito kung magbago ang plano?"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'compare-3-course-options-checklist'),
    'step',
    5,
    $${
      "title":"Find the weakest proof for each option",
      "body":"The most useful part of comparison is not the score. It is finding what you still do not know. That missing proof becomes your next action.",
      "step_number":3,
      "items":[
        "If cost is unclear, ask about tuition, fees, materials, transport, and aid",
        "If work reality is unclear, check job posts or talk to someone in the field",
        "If ability fit is unclear, try a small task, lesson, workshop, or sample activity",
        "If family pressure is high, prepare your comparison before the conversation",
        "If all options feel vague, do not commit yet; collect more proof first"
      ]
    }$$::jsonb,
    $${
      "title":"Hanapin ang pinakamahinang proof ng bawat option",
      "body":"Hindi score ang pinaka-useful sa comparison. Ang mahalaga ay malaman kung ano pa ang hindi mo alam. Iyon ang magiging next action mo.",
      "step_number":3,
      "items":[
        "Kung malabo ang gastos, itanong ang tuition, fees, materials, pamasahe, at aid",
        "Kung malabo ang work reality, mag-check ng job posts o kumausap ng tao sa field",
        "Kung malabo ang ability fit, subukan ang small task, lesson, workshop, o sample activity",
        "Kung malakas ang family pressure, ihanda ang comparison bago makipag-usap",
        "Kung lahat ng options ay vague, huwag muna mag-commit; kumuha muna ng proof"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'compare-3-course-options-checklist'),
    'step',
    6,
    $${
      "title":"Choose the next conversation, not the final answer",
      "body":"A good comparison should help you ask better questions. Bring it to a parent, teacher, guidance counselor, older student, graduate, or worker.",
      "step_number":4,
      "items":[
        "Ask: What am I missing about this course?",
        "Ask: What surprised you about the work after studying this?",
        "Ask: What would make this path risky for someone like me?",
        "Ask: Which option gives me the most useful skills even if plans change?",
        "Ask: What proof should I collect before enrollment?"
      ]
    }$$::jsonb,
    $${
      "title":"Piliin ang next conversation, hindi agad final answer",
      "body":"Dapat tulungan ka ng magandang comparison na magtanong nang mas maayos. Dalhin ito sa parent, teacher, guidance counselor, older student, graduate, o worker.",
      "step_number":4,
      "items":[
        "Itanong: Ano ang hindi ko pa nakikita tungkol sa course na ito?",
        "Itanong: Ano ang nakakagulat sa trabaho pagkatapos pag-aralan ito?",
        "Itanong: Ano ang magiging risky sa path na ito para sa tulad ko?",
        "Itanong: Aling option ang nagbibigay ng pinaka-useful skills kahit magbago ang plano?",
        "Itanong: Anong proof ang kailangan ko bago mag-enroll?"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'compare-3-course-options-checklist'),
    'tip',
    7,
    $${
      "title":"Use this simple comparison line",
      "body":"Copy this for each option. Keep it short enough that you can explain it in one conversation.",
      "sample":"Option: _____. Why I like it: _____. Real cost: _____. Normal work after: _____. Skills I will build: _____. Biggest risk: _____. Proof I still need: _____."
    }$$::jsonb,
    $${
      "title":"Gamitin ang simpleng comparison line na ito",
      "body":"Kopyahin ito para sa bawat option. Panatilihing maikli para kaya mong ipaliwanag sa isang usapan.",
      "sample":"Option: _____. Bakit ko gusto: _____. Totoong gastos: _____. Normal na trabaho pagkatapos: _____. Skills na mabubuo: _____. Pinakamalaking risk: _____. Proof na kailangan ko pa: _____."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'compare-3-course-options-checklist'),
    'related',
    8,
    $${
      "title":"Related guides",
      "body":"Use these if one part of your comparison is still weak.",
      "items":[
        "Choose a Course That Fits Your Life: if you need the bigger course reality check",
        "Student Financial Assistance Programs: if cost is the biggest blocker",
        "Study Smarter When Behind: if confidence or workload is the blocker",
        "First Job Requirements: if you want to understand work expectations early",
        "Resume Checklist With No Work Experience: if you need proof of skills"
      ]
    }$$::jsonb,
    $${
      "title":"Related guides",
      "body":"Gamitin ang mga ito kung may mahina pa sa comparison mo.",
      "items":[
        "Course Fit Checklist: kung kailangan mo ng mas malaking course reality check",
        "Student Financial Assistance Programs: kung gastos ang biggest blocker",
        "Study Smarter Kapag Nahuhuli Ka Na: kung confidence o workload ang blocker",
        "First Job Requirements: kung gusto mong maintindihan ang work expectations nang maaga",
        "Resume Checklist Kahit Walang Work Experience: kung kailangan mong magpakita ng skills"
      ]
    }$$::jsonb
  );
