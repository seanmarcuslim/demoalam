update public.guides
set
  title_en = 'Resume checklist with no work experience',
  title_fil = 'Resume checklist kahit walang work experience',
  tagline_en = 'Turn school, projects, responsibilities, volunteer work, and real skills into a clean one-page resume.',
  tagline_fil = 'Gawing malinaw na one-page resume ang school, projects, responsibilities, volunteer work, at totoong skills.',
  read_time_min = 7,
  estimated_time = '1-2 oras',
  estimated_cost = 'Libre',
  difficulty = 'madali',
  is_featured = false,
  is_urgent = false,
  tags = array[
    'resume',
    'work',
    'job',
    'no experience',
    'first job',
    'fresh graduate',
    'student',
    'philjobnet',
    'jobstart',
    'tesda'
  ],
  keywords_en = 'resume no experience first job fresh graduate student job application skills projects volunteer work school leadership certificates tesda philjobnet jobstart one page cv biodata trabaho apply',
  keywords_fil = 'resume walang experience first job fresh graduate student job application skills projects volunteer work school leadership certificates tesda philjobnet jobstart one page cv biodata trabaho apply',
  official_sources = '[
    {"title":"PhilJobNet - Jobs and LMI Portal","publisher":"Department of Labor and Employment","url":"https://philjobnet.gov.ph/"},
    {"title":"JobStart Philippines Program","publisher":"Department of Labor and Employment","url":"https://jobstart.philjobnet.gov.ph/index.aspx"},
    {"title":"TESDA Skills Passport","publisher":"Technical Education and Skills Development Authority","url":"https://tesda.gov.ph/Media/NewsDetail/20452"},
    {"title":"Republic Act No. 11261 - First Time Jobseekers Assistance Act","publisher":"Official Gazette / Lawphil","url":"https://lawphil.net/statutes/repacts/ra2019/pdf/ra_11261_2019.pdf"}
  ]'::jsonb,
  updated_at = now()
where slug = 'resume-no-experience';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'resume-no-experience'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'resume-no-experience'),
    'what_to_know',
    1,
    $${
      "title":"No work experience does not mean no proof",
      "body":"A first resume should not pretend you already have a career. It should show proof that you can learn, show up, communicate, finish tasks, use tools, and be trusted with responsibility. School work, projects, family duties, volunteer work, certificates, and small achievements can count if they are written honestly.",
      "items":[
        "Employers know first-time applicants may not have formal work experience",
        "Your resume should show useful proof, not filler",
        "One clean page is usually enough",
        "Do not lie about jobs, certificates, or skills",
        "Tailor the resume to the job instead of sending one random version everywhere"
      ]
    }$$::jsonb,
    $${
      "title":"Walang work experience hindi ibig sabihin walang proof",
      "body":"Hindi kailangang magpanggap ang first resume na may career ka na. Dapat nitong ipakita na kaya mong matuto, pumasok nang maayos, makipag-usap, tumapos ng tasks, gumamit ng tools, at pagkatiwalaan sa responsibility. Puwedeng counted ang school work, projects, family duties, volunteer work, certificates, at small achievements kung honest ang pagkakasulat.",
      "items":[
        "Alam ng employers na walang formal work experience ang maraming first-time applicants",
        "Dapat useful proof ang laman ng resume, hindi filler",
        "Kadalasan sapat ang isang malinis na page",
        "Huwag magsinungaling tungkol sa jobs, certificates, o skills",
        "I-tailor ang resume sa job imbes na isang random version ang ipasa sa lahat"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'resume-no-experience'),
    'warning',
    2,
    $${
      "title":"Do not fake experience, certificates, or references",
      "body":"A fake resume may get attention, but it can damage trust when the employer checks details or asks follow-up questions. Be honest, but do not undersell yourself. Turn real activities into clear evidence.",
      "severity":"high",
      "items":[
        "Do not invent companies or job titles",
        "Do not claim tools you cannot actually use",
        "Do not list certificates you did not earn",
        "Do not use people as references without permission",
        "Do not pay someone promising guaranteed hiring through a resume"
      ]
    }$$::jsonb,
    $${
      "title":"Huwag mag-fake ng experience, certificates, o references",
      "body":"Puwedeng makakuha ng attention ang fake resume, pero sisira ito ng trust kapag nag-check ang employer o nagtanong ng follow-up. Maging honest, pero huwag maliitin ang sarili. Gawing malinaw na evidence ang totoong activities.",
      "severity":"high",
      "items":[
        "Huwag mag-imbento ng companies o job titles",
        "Huwag mag-claim ng tools na hindi mo talaga kayang gamitin",
        "Huwag maglagay ng certificates na hindi mo nakuha",
        "Huwag gumamit ng references nang walang permission",
        "Huwag magbayad sa nangangakong guaranteed hiring dahil sa resume"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'resume-no-experience'),
    'step',
    3,
    $${
      "title":"Choose the job target first",
      "body":"A resume is easier to write when you know the role. A cashier resume, encoder resume, service crew resume, internship resume, and admin assistant resume should highlight different proof.",
      "step_number":1,
      "items":[
        "Job title or role you are applying for",
        "Top 3 requirements from the job post",
        "Tools or skills mentioned in the job post",
        "Schedule, location, or availability requirements",
        "Documents the employer asks for"
      ]
    }$$::jsonb,
    $${
      "title":"Pumili muna ng job target",
      "body":"Mas madaling gumawa ng resume kapag alam mo ang role. Magkaiba ang dapat i-highlight sa cashier resume, encoder resume, service crew resume, internship resume, at admin assistant resume.",
      "step_number":1,
      "items":[
        "Job title o role na ina-applyan",
        "Top 3 requirements mula sa job post",
        "Tools o skills na binanggit sa job post",
        "Schedule, location, o availability requirements",
        "Documents na hinihingi ng employer"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'resume-no-experience'),
    'step',
    4,
    $${
      "title":"List proof from school, home, projects, and community",
      "body":"Do not start by writing sentences. Start by collecting proof. Then choose the best ones for the job.",
      "step_number":2,
      "items":[
        "School projects, research, presentations, or group work",
        "Volunteer work, church/community tasks, or student organization roles",
        "Family business help, caregiving, tutoring, selling, or admin errands",
        "Certificates, trainings, TESDA NCs, seminars, or online courses",
        "Tools used: Excel, Canva, POS, Google Docs, email, basic coding, editing, equipment",
        "Achievements with numbers if available"
      ]
    }$$::jsonb,
    $${
      "title":"Ilista ang proof mula sa school, bahay, projects, at community",
      "body":"Huwag agad magsulat ng sentences. Magsimula sa pagkolekta ng proof. Pagkatapos piliin ang pinaka-bagay sa job.",
      "step_number":2,
      "items":[
        "School projects, research, presentations, o group work",
        "Volunteer work, church/community tasks, o student organization roles",
        "Tulong sa family business, caregiving, tutoring, selling, o admin errands",
        "Certificates, trainings, TESDA NCs, seminars, o online courses",
        "Tools na nagamit: Excel, Canva, POS, Google Docs, email, basic coding, editing, equipment",
        "Achievements na may numbers kung available"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'resume-no-experience'),
    'step',
    5,
    $${
      "title":"Use simple sections",
      "body":"Keep the structure easy to scan. Recruiters do not need a dramatic design; they need to find your fit quickly.",
      "step_number":3,
      "items":[
        "Name, mobile number, email, city or area",
        "Short summary matched to the job",
        "Education",
        "Projects, volunteer work, leadership, or relevant activities",
        "Skills and tools",
        "Certificates or trainings",
        "Availability or languages if relevant"
      ]
    }$$::jsonb,
    $${
      "title":"Gumamit ng simpleng sections",
      "body":"Gawing madaling i-scan ang structure. Hindi kailangan ng recruiter ng dramatic design; kailangan nilang makita agad kung bagay ka sa role.",
      "step_number":3,
      "items":[
        "Name, mobile number, email, city o area",
        "Short summary na tugma sa job",
        "Education",
        "Projects, volunteer work, leadership, o relevant activities",
        "Skills at tools",
        "Certificates o trainings",
        "Availability o languages kung relevant"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'resume-no-experience'),
    'step',
    6,
    $${
      "title":"Write bullets as action plus proof",
      "body":"Weak bullets only list traits. Stronger bullets show what you did, where, and what changed.",
      "step_number":4,
      "items":[
        "Weak: Hardworking student",
        "Better: Assisted a 5-person group project by organizing deadlines and compiling final presentation",
        "Weak: Good with computers",
        "Better: Created class reports using Google Docs, Sheets, and Canva",
        "Weak: Leadership skills",
        "Better: Coordinated attendance and task reminders for a student event"
      ]
    }$$::jsonb,
    $${
      "title":"Isulat ang bullets bilang action plus proof",
      "body":"Ang weak bullets ay puro traits lang. Mas malakas ang bullets kapag ipinapakita kung ano ang ginawa mo, saan, at ano ang naging result.",
      "step_number":4,
      "items":[
        "Weak: Hardworking student",
        "Mas okay: Assisted a 5-person group project by organizing deadlines and compiling final presentation",
        "Weak: Good with computers",
        "Mas okay: Created class reports using Google Docs, Sheets, and Canva",
        "Weak: Leadership skills",
        "Mas okay: Coordinated attendance and task reminders for a student event"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'resume-no-experience'),
    'mistake',
    7,
    $${
      "title":"Common resume mistakes for first-time applicants",
      "body":"These mistakes make a resume look less trustworthy even when the applicant is capable.",
      "items":[
        "Using a long objective that says nothing specific",
        "Adding photo, age, religion, height, or full address when not required",
        "Listing too many generic traits like hardworking, honest, and flexible",
        "Using an unprofessional email address",
        "Making the resume two or three pages with filler",
        "Sending the same resume to every role without adjusting keywords",
        "Forgetting to check spelling, phone number, and email"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang resume mistakes ng first-time applicants",
      "body":"Pinapahina ng mistakes na ito ang trust kahit capable naman ang applicant.",
      "items":[
        "Mahabang objective na walang specific na sinasabi",
        "Naglalagay ng photo, age, religion, height, o full address kahit hindi required",
        "Sobrang daming generic traits tulad ng hardworking, honest, at flexible",
        "Unprofessional ang email address",
        "Two or three pages ang resume pero puro filler",
        "Parehong resume ang pinapasa sa lahat ng role kahit iba-iba ang keywords",
        "Hindi chine-check ang spelling, phone number, at email"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'resume-no-experience'),
    'tip',
    8,
    $${
      "title":"One-page resume checklist",
      "body":"Use this before sending your resume.",
      "items":[
        "My contact number and email are correct",
        "The summary mentions the role I want",
        "I included school, project, volunteer, or responsibility proof",
        "My skills are things I can explain or demonstrate",
        "I removed filler and private details not required",
        "My resume is one page if possible",
        "File name is clear, like Juan_Dela_Cruz_Resume.pdf",
        "I saved a PDF copy before sending"
      ]
    }$$::jsonb,
    $${
      "title":"One-page resume checklist",
      "body":"Gamitin ito bago mag-send ng resume.",
      "items":[
        "Tama ang contact number at email ko",
        "Binabanggit ng summary ang role na gusto ko",
        "May school, project, volunteer, o responsibility proof ako",
        "Ang skills ko ay kaya kong ipaliwanag o ipakita",
        "Tinanggal ko ang filler at private details na hindi required",
        "One page ang resume kung kaya",
        "Malinaw ang file name, tulad ng Juan_Dela_Cruz_Resume.pdf",
        "May PDF copy ako bago mag-send"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'resume-no-experience'),
    'tip',
    9,
    $${
      "title":"Sample resume summary",
      "body":"Use this as a pattern, then make it true to your own situation.",
      "sample":"First-time job applicant with experience in school projects, customer-facing volunteer tasks, and basic document work using Google Docs, Sheets, and Canva. Willing to learn, available for shifting schedule, and interested in entry-level admin or service roles."
    }$$::jsonb,
    $${
      "title":"Sample resume summary",
      "body":"Gamitin ito bilang pattern, tapos gawing totoo sa sitwasyon mo.",
      "sample":"First-time job applicant with experience in school projects, customer-facing volunteer tasks, and basic document work using Google Docs, Sheets, and Canva. Willing to learn, available for shifting schedule, and interested in entry-level admin or service roles."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'resume-no-experience'),
    'tip',
    10,
    $${
      "title":"What to expect",
      "body":"Your first resume will not be perfect, and that is normal. The goal is to make it honest, readable, and specific enough for an employer to understand what role you can start with. Improve it after every application, interview, or feedback."
    }$$::jsonb,
    $${
      "title":"Ano ang aasahan",
      "body":"Hindi magiging perfect ang first resume mo, at normal iyon. Ang goal ay gawing honest, readable, at specific enough para maintindihan ng employer kung anong role ang kaya mong simulan. I-improve ito after every application, interview, o feedback."
    }$$::jsonb
  );
