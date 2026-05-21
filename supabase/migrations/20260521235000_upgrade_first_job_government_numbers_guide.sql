update public.guides
set
  title_en = 'SSS, PhilHealth, Pag-IBIG, and TIN checklist for your first job',
  title_fil = 'SSS, PhilHealth, Pag-IBIG, at TIN checklist para sa unang trabaho',
  tagline_en = 'Know which numbers you need, what HR can process, and how to avoid fixer fees.',
  tagline_fil = 'Alamin kung aling numbers ang kailangan, ano ang kayang i-process ng HR, at paano umiwas sa fixer fees.',
  tags = array['sss', 'philhealth', 'pagibig', 'tin', 'bir', 'government', 'work', 'first job', 'requirements', 'hr', 'benefits'],
  keywords_en = 'sss philhealth pagibig tin bir government work first job requirements hr benefits employee payroll contribution fixer',
  keywords_fil = 'sss philhealth pagibig tin bir gobyerno trabaho unang trabaho requirements hr benefits empleyado kontribusyon fixer',
  official_sources = '[
    {"title":"Become an SSS Member","publisher":"Social Security System","url":"https://www.sss.gov.ph/become-an-sss-member/"},
    {"title":"PhilHealth Online Services","publisher":"PhilHealth","url":"https://www.philhealth.gov.ph/services"},
    {"title":"Membership Registration Form","publisher":"Pag-IBIG Fund","url":"https://www.pagibigfund.gov.ph/document/pdf/dlforms/providentrelated/FPF095_MembershipRegistrationForm_V01.pdf"},
    {"title":"Primary Registration","publisher":"Bureau of Internal Revenue","url":"https://www.bir.gov.ph/primary-registration"},
    {"title":"BIR Form 1902","publisher":"Bureau of Internal Revenue","url":"https://www.bir.gov.ph/bir-forms?datasetCode=3381&idTag=BIR1902&label=1902&tab=Application+Forms&type=TAB+LINK"}
  ]'::jsonb,
  updated_at = now()
where slug = 'philhealth-pagibig-tin-basics';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'philhealth-pagibig-tin-basics'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'philhealth-pagibig-tin-basics'),
    'what_to_know',
    1,
    '{"title":"These numbers unlock work benefits, payroll, tax, and health coverage","body":"SSS, PhilHealth, Pag-IBIG, and TIN are separate government records. Some employers help new workers process or update them, but you should still know what each one is for so you do not pay fixers or submit the wrong document."}'::jsonb,
    '{"title":"Binubuksan ng numbers na ito ang work benefits, payroll, tax, at health coverage","body":"Separate government records ang SSS, PhilHealth, Pag-IBIG, at TIN. May employers na tumutulong mag-process o mag-update para sa bagong workers, pero dapat alam mo pa rin ang gamit ng bawat isa para hindi ka magbayad sa fixer o mag-submit ng maling document."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'philhealth-pagibig-tin-basics'),
    'warning',
    2,
    '{"title":"Do not pay a fixer for basic registration","body":"Basic registration or verification should be done through official agency channels, employer HR, or official forms. Be careful with people who promise instant numbers, guaranteed approval, or special processing for a fee.","severity":"high"}'::jsonb,
    '{"title":"Huwag magbayad sa fixer para sa basic registration","body":"Ang basic registration o verification ay dapat dumaan sa official agency channels, employer HR, o official forms. Mag-ingat sa nangangako ng instant numbers, guaranteed approval, o special processing kapalit ng bayad.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'philhealth-pagibig-tin-basics'),
    'step',
    3,
    '{"title":"List what you already have","body":"Before your first job requirements deadline, write down which records you already have. Do not create a duplicate number if you already registered before.","step_number":1,"items":["SSS number or My.SSS account","PhilHealth Identification Number or Member Portal access","Pag-IBIG MID number or registration tracking number","TIN or proof that you do not have one yet","Valid ID and birth certificate details that match your records"]}'::jsonb,
    '{"title":"Ilista kung ano na ang meron ka","body":"Bago ang deadline ng first job requirements, isulat kung aling records ang meron ka na. Huwag gumawa ng duplicate number kung dati ka nang na-register.","step_number":1,"items":["SSS number o My.SSS account","PhilHealth Identification Number o Member Portal access","Pag-IBIG MID number o registration tracking number","TIN o proof na wala ka pa nito","Valid ID at birth certificate details na tugma sa records mo"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'philhealth-pagibig-tin-basics'),
    'step',
    4,
    '{"title":"Ask HR what they will handle","body":"For employees, HR often gives instructions for payroll and government contribution records. Ask clearly which registrations they will process and which ones you must do yourself.","step_number":2,"items":["Will HR process my TIN through the company?","Do I need to create or only verify my SSS record?","Do you need PhilHealth PMRF or only my PhilHealth number?","Do you need my Pag-IBIG MID or registration tracking number?","What exact deadline and file format do you require?"]}'::jsonb,
    '{"title":"Tanungin ang HR kung ano ang sila ang mag-aasikaso","body":"Para sa employees, madalas may instructions ang HR para sa payroll at government contribution records. Linawin kung aling registrations ang sila ang magpa-process at alin ang ikaw ang gagawa.","step_number":2,"items":["HR po ba ang magpa-process ng TIN ko through the company?","Kailangan ko bang gumawa o i-verify lang ang SSS record ko?","PhilHealth PMRF ba ang kailangan o PhilHealth number lang?","Pag-IBIG MID ba ang kailangan o registration tracking number?","Ano ang exact deadline at file format na required?"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'philhealth-pagibig-tin-basics'),
    'step',
    5,
    '{"title":"Use official pages and forms only","body":"Open the agency websites yourself instead of using links from random posts or fixers. Save screenshots or PDFs of confirmation pages, but protect sensitive numbers before sharing them.","step_number":3,"items":["SSS for SS number and membership record","PhilHealth portal or PMRF for PhilHealth records","Pag-IBIG registration form or official channels for MID","BIR primary registration or Form 1902 for employee TIN concerns","Official receipts or confirmation pages only"]}'::jsonb,
    '{"title":"Official pages at forms lang ang gamitin","body":"Ikaw mismo ang magbukas ng agency websites imbes na gumamit ng links mula sa random posts o fixers. I-save ang screenshots o PDFs ng confirmation pages, pero takpan ang sensitive numbers bago i-share.","step_number":3,"items":["SSS para sa SS number at membership record","PhilHealth portal o PMRF para sa PhilHealth records","Pag-IBIG registration form o official channels para sa MID","BIR primary registration o Form 1902 para sa employee TIN concerns","Official receipts o confirmation pages lang"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'philhealth-pagibig-tin-basics'),
    'tip',
    6,
    '{"title":"Send HR one clean message","body":"A clear message prevents back-and-forth and helps you avoid wrong assumptions.","sample":"Hi po. For my pre-employment requirements, can you confirm which government numbers I need to submit now: SSS, PhilHealth, Pag-IBIG, and TIN? Also, will the company process my TIN if I do not have one yet, or should I register first using the BIR form you require?"}'::jsonb,
    '{"title":"Mag-send ng isang malinaw na message sa HR","body":"Mas kaunti ang pabalik-balik kapag malinaw ang tanong, at maiiwasan ang maling akala.","sample":"Hi po. Para sa pre-employment requirements ko, pwede po bang i-confirm kung aling government numbers ang kailangan kong i-submit ngayon: SSS, PhilHealth, Pag-IBIG, at TIN? Also, company po ba ang magpa-process ng TIN kung wala pa ako, o kailangan ko munang mag-register gamit ang BIR form na required ninyo?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'philhealth-pagibig-tin-basics'),
    'mistake',
    7,
    '{"title":"Creating duplicate records because you forgot an old number","body":"Duplicate records can delay benefits, payroll requirements, and future corrections. If you are unsure, ask the agency or HR how to verify first before registering again."}'::jsonb,
    '{"title":"Gumagawa ng duplicate records dahil nakalimutan ang old number","body":"Pwedeng ma-delay ang benefits, payroll requirements, at future corrections kapag may duplicate records. Kung hindi ka sure, itanong muna sa agency o HR kung paano mag-verify bago mag-register ulit."}'::jsonb
  );
