update public.guides
set
  title_en = 'First job requirements checklist',
  title_fil = 'First job requirements checklist',
  tagline_en = 'Prepare the right documents, ask HR the right questions, and avoid paying for things you may get free as a first-time jobseeker.',
  tagline_fil = 'Ihanda ang tamang documents, itanong ang tamang tanong sa HR, at iwasang magbayad sa bagay na maaaring libre para sa first-time jobseeker.',
  read_time_min = 7,
  estimated_time = '1-3 araw',
  estimated_cost = 'Libre-300 pesos',
  difficulty = 'katamtaman',
  is_featured = true,
  is_urgent = false,
  tags = array[
    'work',
    'first job',
    'requirements',
    'employment',
    'hr',
    'nbi',
    'sss',
    'philhealth',
    'pagibig',
    'tin',
    'first time jobseeker',
    'ra 11261'
  ],
  keywords_en = 'first job requirements checklist employment hr pre employment documents nbi police clearance barangay certificate first time jobseeker ra 11261 free documents sss philhealth pagibig tin bir form 1902 payroll bank account medical certificate resume valid id',
  keywords_fil = 'unang trabaho requirements checklist employment hr pre employment documents nbi police clearance barangay certificate first time jobseeker ra 11261 libreng documents sss philhealth pagibig tin bir form 1902 payroll bank account medical certificate resume valid id trabaho',
  official_sources = '[
    {"title":"Republic Act No. 11261 - First Time Jobseekers Assistance Act","publisher":"Official Gazette / Lawphil","url":"https://lawphil.net/statutes/repacts/ra2019/pdf/ra_11261_2019.pdf"},
    {"title":"Oath of Undertaking - RA 11261","publisher":"DOLE Bureau of Local Employment","url":"https://www.ble.dole.gov.ph/wp-content/uploads/2022/06/FORM2-Oath-of-Undertaking-asof16June2021.pdf"},
    {"title":"Become an SSS Member","publisher":"Social Security System","url":"https://www.sss.gov.ph/become-an-sss-member/"},
    {"title":"Employees","publisher":"Social Security System","url":"https://www.sss.gov.ph/employees/"},
    {"title":"BIR Form No. 1902","publisher":"Bureau of Internal Revenue","url":"https://bir-cdn.bir.gov.ph/BIR/pdf/1902%20October%202025%20%28ENCS%29%20Final.pdf"},
    {"title":"BIR Citizens Charter - TIN of Local Employee","publisher":"Bureau of Internal Revenue","url":"https://bir-cdn.bir.gov.ph/local/pdf/BIR_Citizens_Charter_2020-2nd_Edition.pdf"},
    {"title":"NBI Clearance Portal","publisher":"National Bureau of Investigation","url":"https://clearance.nbi.gov.ph/"}
  ]'::jsonb,
  updated_at = now()
where slug = 'first-job-requirements';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'first-job-requirements'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'first-job-requirements'),
    'what_to_know',
    1,
    $${
      "title":"Do not collect every document blindly",
      "body":"First job requirements can feel overwhelming because different employers ask for different timing. Some documents are needed before onboarding, while others can follow after you are hired. The smart move is to ask HR for the exact checklist first, then prioritize documents that unlock payroll, identity verification, and legal employment records.",
      "items":[
        "Ask HR which documents are required now and which can follow",
        "Use the first-time jobseeker benefit if you qualify",
        "Prioritize SSS, PhilHealth, Pag-IBIG, TIN, valid ID, and payroll needs",
        "Do not create duplicate government numbers",
        "Do not pay fixers for documents you can process through official channels"
      ]
    }$$::jsonb,
    $${
      "title":"Huwag basta kolektahin lahat ng documents",
      "body":"Nakaka-overwhelm ang first job requirements dahil iba-iba ang timing ng hinihingi ng employers. May documents na kailangan bago onboarding, pero may iba na puwedeng ihabol after hiring. Ang matalinong gawin: humingi muna ng exact checklist sa HR, pagkatapos unahin ang documents na kailangan para sa payroll, identity verification, at legal employment records.",
      "items":[
        "Tanungin ang HR kung alin ang kailangan ngayon at alin ang puwedeng ihabol",
        "Gamitin ang first-time jobseeker benefit kung qualified ka",
        "Unahin ang SSS, PhilHealth, Pag-IBIG, TIN, valid ID, at payroll needs",
        "Huwag gumawa ng duplicate government numbers",
        "Huwag magbayad sa fixer para sa documents na kaya sa official channels"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'first-job-requirements'),
    'warning',
    2,
    $${
      "title":"Verify first before paying for clearances or processing help",
      "body":"Under the First Time Jobseekers Assistance Act, qualified first-time jobseekers may get certain government documents without paying government fees. You usually need a barangay certification and oath of undertaking. Ask first before paying online, paying a helper, or rushing to a fixer.",
      "severity":"high",
      "items":[
        "Ask your barangay about the First-Time Jobseeker Certificate and oath",
        "Confirm with the agency or office how the free benefit is claimed",
        "Do not pay someone promising instant NBI, police clearance, TIN, or SSS results",
        "Do not send OTPs, account passwords, or full ID photos to strangers",
        "If the website asks for payment, pause and verify whether you selected the correct first-time jobseeker path"
      ]
    }$$::jsonb,
    $${
      "title":"I-verify muna bago magbayad sa clearance o processing help",
      "body":"Sa ilalim ng First Time Jobseekers Assistance Act, maaaring libre ang ilang government documents para sa qualified first-time jobseekers. Kadalasan kailangan ng barangay certification at oath of undertaking. Magtanong muna bago magbayad online, magbayad sa helper, o magmadali sa fixer.",
      "severity":"high",
      "items":[
        "Magtanong sa barangay tungkol sa First-Time Jobseeker Certificate at oath",
        "I-confirm sa agency o office kung paano i-claim ang free benefit",
        "Huwag magbayad sa nangangakong instant NBI, police clearance, TIN, o SSS results",
        "Huwag mag-send ng OTP, account password, o full ID photos sa strangers",
        "Kung nanghihingi ng payment ang website, huminto muna at i-verify kung tama ang first-time jobseeker path na napili"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'first-job-requirements'),
    'step',
    3,
    $${
      "title":"Ask HR for the exact checklist and deadline",
      "body":"Do this before spending money or traveling to offices. Requirements vary by employer, industry, job type, and whether you are already hired or still applying.",
      "step_number":1,
      "items":[
        "Which documents are required before start date?",
        "Which documents can follow after onboarding?",
        "Will the company help process TIN or payroll account?",
        "Do you need numbers only, or scanned copies too?",
        "What file format and deadline should I follow?"
      ],
      "sample":"Hi, may I ask for the exact pre-employment requirements checklist? Please mark which documents are needed before my start date and which ones can follow after onboarding."
    }$$::jsonb,
    $${
      "title":"Humingi ng exact checklist at deadline sa HR",
      "body":"Gawin ito bago gumastos o bumiyahe sa offices. Nag-iiba ang requirements depende sa employer, industry, job type, at kung hired ka na o applying pa lang.",
      "step_number":1,
      "items":[
        "Aling documents ang kailangan bago start date?",
        "Aling documents ang puwedeng ihabol after onboarding?",
        "Tutulong ba ang company sa TIN o payroll account?",
        "Numbers lang ba ang kailangan, o scanned copies din?",
        "Anong file format at deadline ang susundin?"
      ],
      "sample":"Hi po, puwede po bang makahingi ng exact pre-employment requirements checklist? Paki-mark po kung alin ang kailangan bago start date at alin ang puwedeng ihabol after onboarding."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'first-job-requirements'),
    'step',
    4,
    $${
      "title":"Separate identity, government numbers, and clearance documents",
      "body":"Do not treat all requirements as equal. Group them so you can see what blocks employment, payroll, or compliance.",
      "step_number":2,
      "items":[
        "Identity: valid ID, birth certificate, school ID if accepted, resume",
        "Government numbers: SSS, PhilHealth, Pag-IBIG, TIN",
        "Clearances: NBI or police clearance if required",
        "Health or job-specific: medical certificate, drug test, fit-to-work, licenses",
        "Payroll: bank account, payroll form, emergency contact, address details"
      ]
    }$$::jsonb,
    $${
      "title":"Paghiwalayin ang identity, government numbers, at clearance documents",
      "body":"Huwag ituring na pare-pareho ang lahat ng requirements. I-group sila para makita mo kung alin ang blocking sa employment, payroll, o compliance.",
      "step_number":2,
      "items":[
        "Identity: valid ID, birth certificate, school ID kung accepted, resume",
        "Government numbers: SSS, PhilHealth, Pag-IBIG, TIN",
        "Clearances: NBI o police clearance kung required",
        "Health o job-specific: medical certificate, drug test, fit-to-work, licenses",
        "Payroll: bank account, payroll form, emergency contact, address details"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'first-job-requirements'),
    'step',
    5,
    $${
      "title":"Use the first-time jobseeker benefit carefully",
      "body":"If this is your first time actively looking for work, ask your barangay about the certificate and oath of undertaking for RA 11261. The benefit is not a shortcut for fake documents; it is meant to reduce the cost of legitimate employment requirements.",
      "step_number":3,
      "items":[
        "Ask for the barangay certification for first-time jobseekers",
        "Prepare the oath of undertaking if required",
        "Check validity and whether the benefit can only be used once",
        "Bring the certificate when claiming fee exemption at the agency",
        "Keep copies because some offices may ask to see proof"
      ]
    }$$::jsonb,
    $${
      "title":"Gamitin nang maingat ang first-time jobseeker benefit",
      "body":"Kung first time mong actively maghanap ng trabaho, magtanong sa barangay tungkol sa certificate at oath of undertaking para sa RA 11261. Hindi ito shortcut para sa fake documents; para ito mabawasan ang gastos sa legitimate employment requirements.",
      "step_number":3,
      "items":[
        "Humingi ng barangay certification for first-time jobseekers",
        "Ihanda ang oath of undertaking kung required",
        "I-check ang validity at kung isang beses lang magagamit ang benefit",
        "Dalhin ang certificate kapag magki-claim ng fee exemption sa agency",
        "Magtabi ng copies dahil may offices na hihingi ng proof"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'first-job-requirements'),
    'step',
    6,
    $${
      "title":"Avoid duplicate government records",
      "body":"Before registering for SSS, PhilHealth, Pag-IBIG, or TIN, check whether you already have a record from school, scholarship, old work, parents, or previous applications. Duplicate records can create delays later.",
      "step_number":4,
      "items":[
        "Search old email for SSS, PhilHealth, Pag-IBIG, TIN, MID, or transaction number",
        "Ask HR if they will process TIN using the correct employee form",
        "Do not create another SS number or TIN if you already have one",
        "Use official portals or agency offices for verification",
        "Save confirmation pages, slips, and reference numbers"
      ]
    }$$::jsonb,
    $${
      "title":"Iwasan ang duplicate government records",
      "body":"Bago mag-register sa SSS, PhilHealth, Pag-IBIG, o TIN, i-check kung may record ka na mula sa school, scholarship, dating work, magulang, o previous applications. Puwedeng magdulot ng delay ang duplicate records.",
      "step_number":4,
      "items":[
        "I-search sa old email ang SSS, PhilHealth, Pag-IBIG, TIN, MID, o transaction number",
        "Tanungin ang HR kung sila ang magpa-process ng TIN gamit ang tamang employee form",
        "Huwag gumawa ng panibagong SS number o TIN kung mayroon ka na",
        "Official portals o agency offices ang gamitin sa verification",
        "I-save ang confirmation pages, slips, at reference numbers"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'first-job-requirements'),
    'mistake',
    7,
    $${
      "title":"Common mistakes that waste money and time",
      "body":"Most first-job requirement problems come from rushing, unclear HR instructions, or trusting unofficial helpers.",
      "items":[
        "Paying for NBI or other documents before checking first-time jobseeker eligibility",
        "Getting documents the employer does not require yet",
        "Creating duplicate SSS or TIN records",
        "Sending full ID photos, passwords, OTPs, or portal access through chat",
        "Using random links from social media instead of official portals",
        "Not saving reference numbers, appointment slips, or confirmation emails",
        "Waiting until the day before onboarding to ask HR questions"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang pagkakamali na sayang sa pera at oras",
      "body":"Madalas nanggagaling ang first-job requirement problems sa pagmamadali, malabong HR instructions, o tiwala sa unofficial helpers.",
      "items":[
        "Nagbabayad sa NBI o ibang documents bago i-check ang first-time jobseeker eligibility",
        "Kumukuha ng documents na hindi pa naman required ng employer",
        "Gumagawa ng duplicate SSS o TIN records",
        "Nagpapadala ng full ID photos, passwords, OTPs, o portal access through chat",
        "Gumagamit ng random links sa social media imbes na official portals",
        "Hindi nagse-save ng reference numbers, appointment slips, o confirmation emails",
        "Naghihintay hanggang day before onboarding bago magtanong sa HR"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'first-job-requirements'),
    'tip',
    8,
    $${
      "title":"Master checklist",
      "body":"Use this as a starting list, then follow your employer checklist.",
      "items":[
        "Updated resume",
        "Valid ID or acceptable identity document",
        "Birth certificate if requested",
        "SSS number or proof of registration",
        "PhilHealth number or form if requested",
        "Pag-IBIG MID number or registration proof",
        "TIN or BIR Form 1902 process through employer if applicable",
        "NBI or police clearance if required",
        "Barangay first-time jobseeker certificate and oath if claiming fee waiver",
        "Payroll bank details or company payroll instructions",
        "Medical or fit-to-work documents if required"
      ]
    }$$::jsonb,
    $${
      "title":"Master checklist",
      "body":"Gamitin ito bilang starting list, pagkatapos sundin ang checklist ng employer mo.",
      "items":[
        "Updated resume",
        "Valid ID o acceptable identity document",
        "Birth certificate kung hinihingi",
        "SSS number o proof of registration",
        "PhilHealth number o form kung hinihingi",
        "Pag-IBIG MID number o registration proof",
        "TIN o BIR Form 1902 process through employer kung applicable",
        "NBI o police clearance kung required",
        "Barangay first-time jobseeker certificate at oath kung magki-claim ng fee waiver",
        "Payroll bank details o company payroll instructions",
        "Medical o fit-to-work documents kung required"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'first-job-requirements'),
    'tip',
    9,
    $${
      "title":"Sample message if you are confused",
      "body":"Send this before spending money on documents.",
      "sample":"Hi, I am preparing my first-job requirements. Can you confirm which documents are required before my start date, which ones can follow, and whether the company will process my TIN or payroll account? I may also be eligible for first-time jobseeker fee waivers, so I want to avoid paying for the wrong document."
    }$$::jsonb,
    $${
      "title":"Sample message kung nalilito ka",
      "body":"I-send ito bago gumastos sa documents.",
      "sample":"Hi po, inaayos ko po ang first-job requirements ko. Paki-confirm po kung aling documents ang kailangan bago start date, alin ang puwedeng ihabol, at kung company po ba ang magpa-process ng TIN o payroll account ko. Posible rin po akong eligible sa first-time jobseeker fee waivers kaya gusto ko pong maiwasan magbayad sa maling document."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'first-job-requirements'),
    'tip',
    10,
    $${
      "title":"What to expect",
      "body":"Some requirements can be finished in a day if your IDs and online accounts are ready. Others depend on appointment slots, HR process, or agency verification. The goal is not to finish everything instantly; the goal is to know what blocks your start date and what can safely follow."
    }$$::jsonb,
    $${
      "title":"Ano ang aasahan",
      "body":"May requirements na kaya matapos sa isang araw kung ready ang IDs at online accounts mo. May iba namang depende sa appointment slots, HR process, o agency verification. Hindi goal na matapos lahat agad; ang goal ay malaman kung alin ang blocking sa start date at alin ang puwedeng ihabol nang safe."
    }$$::jsonb
  );
