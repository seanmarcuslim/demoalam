update public.guides
set
  title_en = 'First job interview answer checklist',
  title_fil = 'First job interview answer checklist',
  tagline_en = 'Prepare honest answers for common interview questions without memorizing fake scripts.',
  tagline_fil = 'Maghanda ng honest answers sa common interview questions nang hindi nagme-memorize ng fake scripts.',
  read_time_min = 7,
  estimated_time = '1 oras',
  estimated_cost = 'Libre',
  difficulty = 'katamtaman',
  is_featured = false,
  is_urgent = false,
  tags = array[
    'interview',
    'work',
    'job',
    'first job',
    'answers',
    'fresh graduate',
    'student',
    'philjobnet',
    'jobstart',
    'resume'
  ],
  keywords_en = 'interview answers first job fresh graduate no experience tell me about yourself strengths weakness why should we hire you salary expected availability job offer hr recruiter philjobnet jobstart practice',
  keywords_fil = 'interview answers unang trabaho first job fresh graduate walang experience tell me about yourself strengths weakness bakit ka namin ihahire expected salary availability job offer hr recruiter philjobnet jobstart practice',
  official_sources = '[
    {"title":"PhilJobNet - Jobs and LMI Portal","publisher":"Department of Labor and Employment","url":"https://philjobnet.gov.ph/"},
    {"title":"JobStart Philippines Program","publisher":"Department of Labor and Employment","url":"https://jobstart.philjobnet.gov.ph/index.aspx"},
    {"title":"Republic Act No. 11261 - First Time Jobseekers Assistance Act","publisher":"Official Gazette / Lawphil","url":"https://lawphil.net/statutes/repacts/ra2019/pdf/ra_11261_2019.pdf"}
  ]'::jsonb,
  updated_at = now()
where slug = 'job-interview-basic-answers';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'job-interview-basic-answers'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'job-interview-basic-answers'),
    'what_to_know',
    1,
    $${
      "title":"A good interview answer is honest, specific, and connected to the job",
      "body":"First-time applicants often panic because they think they need perfect English, dramatic confidence, or memorized answers. You do not. You need clear examples that show you can learn, communicate, follow instructions, solve simple problems, and be trusted at work.",
      "items":[
        "Do not memorize long scripts word for word",
        "Prepare stories from school, OJT, family duties, volunteer work, or projects",
        "Answer the question first, then add one example",
        "Connect your answer to the job requirements",
        "It is okay to pause for a few seconds before answering"
      ]
    }$$::jsonb,
    $${
      "title":"Ang magandang interview answer ay honest, specific, at connected sa job",
      "body":"Madalas napapanic ang first-time applicants dahil iniisip nilang kailangan ng perfect English, dramatic confidence, o memorized answers. Hindi. Kailangan mo ng malinaw na examples na nagpapakita na kaya mong matuto, makipag-usap, sumunod sa instructions, mag-solve ng simple problems, at pagkatiwalaan sa work.",
      "items":[
        "Huwag mag-memorize ng mahabang script word for word",
        "Maghanda ng stories mula sa school, OJT, family duties, volunteer work, o projects",
        "Sagutin muna ang tanong, tapos magdagdag ng isang example",
        "I-connect ang sagot sa job requirements",
        "Okay lang huminto ng ilang segundo bago sumagot"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'job-interview-basic-answers'),
    'warning',
    2,
    $${
      "title":"Do not pay for guaranteed interview answers or guaranteed hiring",
      "body":"No script can guarantee a job. Be careful with people who sell magic answers, fake certificates, fake employment records, or backdoor hiring. Real preparation improves your chances, but hiring still depends on role fit, company needs, and employer decisions.",
      "severity":"high",
      "items":[
        "Do not buy fake work experience",
        "Do not pay someone promising guaranteed hiring",
        "Do not send IDs or certificates to random recruiters without verifying the company",
        "Do not lie about skills you cannot demonstrate",
        "Do not share OTP, bank details, or payment before a legitimate job offer"
      ]
    }$$::jsonb,
    $${
      "title":"Huwag magbayad para sa guaranteed interview answers o guaranteed hiring",
      "body":"Walang script na makakagarantiya ng trabaho. Mag-ingat sa nagbebenta ng magic answers, fake certificates, fake employment records, o backdoor hiring. Nakakatulong ang real preparation, pero depende pa rin ang hiring sa role fit, company needs, at employer decision.",
      "severity":"high",
      "items":[
        "Huwag bumili ng fake work experience",
        "Huwag magbayad sa nangangakong guaranteed hiring",
        "Huwag mag-send ng IDs o certificates sa random recruiters nang hindi verified ang company",
        "Huwag magsinungaling sa skills na hindi mo kayang ipakita",
        "Huwag mag-share ng OTP, bank details, o payment bago ang legitimate job offer"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'job-interview-basic-answers'),
    'step',
    3,
    $${
      "title":"Prepare three real stories",
      "body":"You can reuse these stories for many interview questions. They do not need to be big achievements. They just need to be true and clear.",
      "step_number":1,
      "items":[
        "A learning story: a time you learned something difficult",
        "A responsibility story: a time people depended on you",
        "A problem-solving story: a time you fixed or improved something small",
        "A teamwork story if the job needs customer or team work",
        "A mistake story where you learned and corrected your behavior"
      ]
    }$$::jsonb,
    $${
      "title":"Maghanda ng tatlong totoong kwento",
      "body":"Puwede mong gamitin ulit ang stories na ito sa maraming interview questions. Hindi kailangang malaking achievement. Kailangan lang totoo at malinaw.",
      "step_number":1,
      "items":[
        "Learning story: panahong may natutunan kang mahirap",
        "Responsibility story: panahong may umasa sa iyo",
        "Problem-solving story: panahong may inayos o pinabuti kang maliit na bagay",
        "Teamwork story kung kailangan ng customer o team work ang job",
        "Mistake story kung saan natuto ka at inayos ang behavior"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'job-interview-basic-answers'),
    'step',
    4,
    $${
      "title":"Use a simple answer structure",
      "body":"When you feel nervous, use a structure instead of memorizing. This keeps your answer short and useful.",
      "step_number":2,
      "items":[
        "Direct answer: answer the question in one sentence",
        "Example: give one real situation",
        "Action: explain what you did",
        "Result or lesson: say what improved or what you learned",
        "Job connection: connect it to the role"
      ],
      "sample":"Question: Tell me about yourself. Answer: I am a first-time applicant interested in customer-facing work. In school, I handled group presentations and helped organize deadlines for projects. I learned to communicate clearly, follow schedules, and stay calm when tasks change. I think those habits can help me in this service crew role."
    }$$::jsonb,
    $${
      "title":"Gumamit ng simpleng answer structure",
      "body":"Kapag kinakabahan, gumamit ng structure imbes na mag-memorize. Nakakatulong ito para maikli at useful ang sagot.",
      "step_number":2,
      "items":[
        "Direct answer: sagutin ang tanong sa isang sentence",
        "Example: magbigay ng isang totoong situation",
        "Action: ipaliwanag ang ginawa mo",
        "Result o lesson: sabihin kung ano ang gumanda o natutunan mo",
        "Job connection: i-connect sa role"
      ],
      "sample":"Question: Tell me about yourself. Answer: I am a first-time applicant interested in customer-facing work. In school, I handled group presentations and helped organize deadlines for projects. I learned to communicate clearly, follow schedules, and stay calm when tasks change. I think those habits can help me in this service crew role."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'job-interview-basic-answers'),
    'step',
    5,
    $${
      "title":"Prepare answers for common first-job questions",
      "body":"You do not need perfect wording. You need honest points that you can say naturally.",
      "step_number":3,
      "items":[
        "Tell me about yourself",
        "Why do you want this job?",
        "What are your strengths?",
        "What is your weakness?",
        "Why should we hire you?",
        "How do you handle pressure or difficult customers?",
        "What is your expected salary?",
        "When can you start?"
      ]
    }$$::jsonb,
    $${
      "title":"Maghanda ng sagot sa common first-job questions",
      "body":"Hindi kailangan perfect ang wording. Kailangan mo ng honest points na kaya mong sabihin nang natural.",
      "step_number":3,
      "items":[
        "Tell me about yourself",
        "Why do you want this job?",
        "What are your strengths?",
        "What is your weakness?",
        "Why should we hire you?",
        "How do you handle pressure or difficult customers?",
        "What is your expected salary?",
        "When can you start?"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'job-interview-basic-answers'),
    'step',
    6,
    $${
      "title":"Ask two smart questions at the end",
      "body":"Asking questions shows that you are thinking about the actual work, not just trying to survive the interview.",
      "step_number":4,
      "items":[
        "What does a normal day look like for this role?",
        "What are the most important qualities for someone to succeed here?",
        "What training will new hires receive?",
        "What are the next steps after this interview?",
        "What documents should I prepare if I move forward?"
      ]
    }$$::jsonb,
    $${
      "title":"Magtanong ng dalawang maayos na tanong sa dulo",
      "body":"Ang pagtatanong ay nagpapakita na iniisip mo ang totoong work, hindi lang basta makaligtas sa interview.",
      "step_number":4,
      "items":[
        "What does a normal day look like for this role?",
        "What are the most important qualities for someone to succeed here?",
        "What training will new hires receive?",
        "What are the next steps after this interview?",
        "What documents should I prepare if I move forward?"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'job-interview-basic-answers'),
    'mistake',
    7,
    $${
      "title":"Common interview mistakes",
      "body":"These mistakes are fixable. Most happen because the applicant is nervous or trying too hard to impress.",
      "items":[
        "Giving very long answers without answering the question",
        "Saying only generic traits like hardworking and honest",
        "Talking badly about teachers, classmates, previous supervisors, or family",
        "Pretending to know skills you cannot explain",
        "Not knowing basic information about the company or role",
        "Forgetting to ask about next steps",
        "Accepting vague job offers without written details"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang interview mistakes",
      "body":"Naaayos ang mistakes na ito. Kadalasan nangyayari dahil kinakabahan o sobra ang pilit magpa-impress.",
      "items":[
        "Sobrang haba ng sagot pero hindi nasasagot ang tanong",
        "Puro generic traits lang tulad ng hardworking at honest",
        "Masamang pagsasalita tungkol sa teachers, classmates, previous supervisors, o pamilya",
        "Nagpapanggap na marunong sa skills na hindi kayang ipaliwanag",
        "Walang alam na basic information tungkol sa company o role",
        "Nakakalimutang magtanong tungkol sa next steps",
        "Tumatanggap ng vague job offers na walang written details"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'job-interview-basic-answers'),
    'tip',
    8,
    $${
      "title":"Interview prep checklist",
      "body":"Use this the night before or morning of the interview.",
      "items":[
        "I reviewed the job post",
        "I prepared three real stories",
        "I can explain my resume honestly",
        "I prepared expected salary range or answer",
        "I know my availability and start date",
        "I prepared two questions for the interviewer",
        "I checked company name, location, schedule, and contact person",
        "I will not pay fees or send sensitive details to unverified recruiters"
      ]
    }$$::jsonb,
    $${
      "title":"Interview prep checklist",
      "body":"Gamitin ito sa gabi bago interview o sa mismong umaga.",
      "items":[
        "Na-review ko ang job post",
        "May tatlong totoong stories akong handa",
        "Kaya kong ipaliwanag ang resume ko nang honest",
        "May prepared expected salary range o sagot ako",
        "Alam ko ang availability at start date ko",
        "May dalawang tanong ako para sa interviewer",
        "Na-check ko ang company name, location, schedule, at contact person",
        "Hindi ako magbabayad ng fees o magse-send ng sensitive details sa unverified recruiters"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'job-interview-basic-answers'),
    'tip',
    9,
    $${
      "title":"Sample weakness answer",
      "body":"Choose a real but manageable weakness, then show what you are doing about it.",
      "sample":"One weakness I am working on is that I sometimes become too quiet when I am unsure. I am improving this by asking clarifying questions earlier and writing down instructions so I can confirm if I understood correctly."
    }$$::jsonb,
    $${
      "title":"Sample weakness answer",
      "body":"Pumili ng totoong weakness na manageable, tapos ipakita kung ano ang ginagawa mo para ayusin ito.",
      "sample":"One weakness I am working on is that I sometimes become too quiet when I am unsure. I am improving this by asking clarifying questions earlier and writing down instructions so I can confirm if I understood correctly."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'job-interview-basic-answers'),
    'tip',
    10,
    $${
      "title":"What to expect",
      "body":"You may still feel nervous even after preparing. That is normal. A good interview does not mean zero mistakes. It means you understood the role, answered honestly, gave examples, asked useful questions, and protected yourself from suspicious offers."
    }$$::jsonb,
    $${
      "title":"Ano ang aasahan",
      "body":"Puwede ka pa ring kabahan kahit prepared ka. Normal iyon. Ang good interview ay hindi ibig sabihin zero mistakes. Ibig sabihin naiintindihan mo ang role, honest ang sagot mo, may examples ka, nagtatanong ka nang maayos, at pinoprotektahan mo ang sarili sa suspicious offers."
    }$$::jsonb
  );
