update public.guides
set
  title_en = 'SSS number checklist for your first job',
  title_fil = 'SSS number checklist para sa unang trabaho',
  tagline_en = 'Get or verify your SSS number without duplicate records, fixer fees, or wrong personal details.',
  tagline_fil = 'Kumuha o mag-verify ng SSS number nang walang duplicate record, fixer fee, o maling personal details.',
  read_time_min = 6,
  estimated_time = '30 minuto-1 araw',
  estimated_cost = 'Libre',
  difficulty = 'madali',
  is_urgent = false,
  is_featured = false,
  tags = array[
    'sss',
    'ss number',
    'first job',
    'employment',
    'government',
    'hr requirements',
    'my.sss',
    'e-1',
    'temporary sss',
    'duplicate sss'
  ],
  keywords_en = 'sss ss number social security system first job employee employment hr requirements my.sss e-1 e1 transaction number temporary permanent duplicate record contribution employer coverage fixer free registration',
  keywords_fil = 'sss ss number social security system unang trabaho empleyado requirements hr my.sss e-1 e1 transaction number temporary permanent duplicate record hulog contribution employer coverage fixer libre registration',
  official_sources = '[
    {"title":"Become an SSS Member","publisher":"Social Security System","url":"https://www.sss.gov.ph/become-an-sss-member/"},
    {"title":"Employees","publisher":"Social Security System","url":"https://www.sss.gov.ph/employees/"},
    {"title":"Apply for an SS Number Online","publisher":"Social Security System","url":"https://member.sss.gov.ph/members/rcsmi/main.html"}
  ]'::jsonb,
  updated_at = now()
where slug = 'sss-number-first-job';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'sss-number-first-job'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'sss-number-first-job'),
    'what_to_know',
    1,
    $${
      "title":"Your SSS number is a lifetime record, not just a job requirement",
      "body":"For many first-time workers, SSS feels like one more form HR is asking for. But your SS number becomes part of your work, contribution, benefit, loan, and future claim records. The safest goal is simple: use one correct record, keep proof, and avoid fixers or duplicate registration.",
      "items":[
        "If you already have an SS number, do not create a new one",
        "Use legal details that match your birth certificate and valid IDs",
        "Save the SS Number Slip, Transaction Number Slip, and E-1/E-6 form",
        "Ask HR what they need before uploading or sending documents",
        "Official registration should not require a fixer fee"
      ]
    }$$::jsonb,
    $${
      "title":"Lifetime record ang SSS number, hindi lang job requirement",
      "body":"Para sa maraming first-time workers, parang dagdag form lang ang SSS na hinihingi ng HR. Pero ang SS number mo ay magiging record para sa trabaho, contributions, benefits, loans, at future claims. Simple ang safest goal: isang tamang record, may proof, at walang fixer o duplicate registration.",
      "items":[
        "Kung may SS number ka na, huwag gumawa ng panibago",
        "Gamitin ang legal details na tugma sa birth certificate at valid IDs",
        "I-save ang SS Number Slip, Transaction Number Slip, at E-1/E-6 form",
        "Tanungin muna ang HR kung ano ang kailangan bago mag-upload o mag-send ng documents",
        "Hindi dapat kailangan ng fixer fee ang official registration"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'sss-number-first-job'),
    'warning',
    2,
    $${
      "title":"Verify first: do not make a second SSS number",
      "body":"If you registered before as a student, job applicant, prior registrant, self-employed person, OFW, or through an old employer, verify your existing record first. A duplicate SS number can delay future benefits, loans, corrections, or contribution records.",
      "severity":"high",
      "items":[
        "Search old email for SSS, SS Number Slip, E-1, E-6, or transaction number",
        "Ask parents or previous employer if you were registered before",
        "Check if you have a My.SSS account or old SSS documents",
        "If unsure, ask SSS through official channels instead of creating a new record",
        "Never pay someone promising instant cleanup of duplicate records"
      ]
    }$$::jsonb,
    $${
      "title":"I-verify muna: huwag gumawa ng pangalawang SSS number",
      "body":"Kung dati ka nang nag-register bilang student, job applicant, prior registrant, self-employed, OFW, o through old employer, i-verify muna ang existing record. Ang duplicate SS number ay puwedeng magpa-delay ng future benefits, loans, corrections, o contribution records.",
      "severity":"high",
      "items":[
        "I-search sa old email ang SSS, SS Number Slip, E-1, E-6, o transaction number",
        "Tanungin ang magulang o previous employer kung na-register ka na dati",
        "I-check kung may My.SSS account o lumang SSS documents ka",
        "Kung hindi sigurado, magtanong sa official SSS channels imbes na gumawa ng bagong record",
        "Huwag magbayad sa nangangakong instant cleanup ng duplicate records"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'sss-number-first-job'),
    'step',
    3,
    $${
      "title":"Prepare your exact personal details first",
      "body":"Most avoidable SSS problems start with small mismatches. Before applying or sending documents to HR, write your details exactly as they appear on your official documents.",
      "step_number":1,
      "items":[
        "Complete legal name, including middle name and suffix if any",
        "Date of birth and place of birth",
        "Civil status",
        "Current address, mobile number, and email you can still access",
        "Beneficiary details when required",
        "Valid ID or PSA birth certificate details if available"
      ]
    }$$::jsonb,
    $${
      "title":"Ihanda muna ang eksaktong personal details",
      "body":"Madalas nagsisimula ang SSS problem sa maliliit na mismatch. Bago mag-apply o mag-send sa HR, isulat ang details mo nang eksakto tulad ng nasa official documents.",
      "step_number":1,
      "items":[
        "Buong legal name, kasama ang middle name at suffix kung meron",
        "Birthday at place of birth",
        "Civil status",
        "Current address, mobile number, at email na naa-access mo pa",
        "Beneficiary details kung kailangan",
        "Valid ID o PSA birth certificate details kung available"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'sss-number-first-job'),
    'step',
    4,
    $${
      "title":"Use official SSS registration or verification routes",
      "body":"Open SSS links yourself from the official SSS website. Do not rely on random Facebook posts, private messages, or people offering to register you for a fee.",
      "step_number":2,
      "items":[
        "Use the official SSS website or SSS branch E-Center",
        "Check your email for the application continuation link",
        "Remember that some registration links expire, so finish the process carefully",
        "Download or save the generated slips and forms",
        "Create or activate your My.SSS access only through official pages"
      ]
    }$$::jsonb,
    $${
      "title":"Official SSS routes lang ang gamitin",
      "body":"Ikaw mismo ang magbukas ng SSS links mula sa official SSS website. Huwag umasa sa random Facebook posts, private messages, o taong nag-aalok na sila ang magre-register kapalit ng bayad.",
      "step_number":2,
      "items":[
        "Gamitin ang official SSS website o SSS branch E-Center",
        "I-check ang email para sa application continuation link",
        "Tandaan na may registration links na nag-e-expire, kaya tapusin nang maingat ang process",
        "I-download o i-save ang generated slips at forms",
        "Gumawa o mag-activate ng My.SSS access sa official pages lang"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'sss-number-first-job'),
    'step',
    5,
    $${
      "title":"Send HR only what they actually need",
      "body":"For a first job, HR may ask for your SS number or proof of registration. Before sending sensitive files, ask the exact requirement and protect information that is not needed.",
      "step_number":3,
      "items":[
        "Ask if HR needs the SS number only or a copy of the slip",
        "Confirm the deadline and accepted file format",
        "Avoid sending passwords, OTPs, or My.SSS login access",
        "Keep your own copy of every submitted file",
        "If HR will help with other records, separate SSS from PhilHealth, Pag-IBIG, and TIN requirements"
      ]
    }$$::jsonb,
    $${
      "title":"I-send sa HR ang kailangan lang talaga",
      "body":"Sa first job, puwedeng hingin ng HR ang SS number o proof of registration. Bago mag-send ng sensitive files, itanong ang eksaktong requirement at protektahan ang impormasyong hindi kailangan.",
      "step_number":3,
      "items":[
        "Itanong kung SS number lang o copy ng slip ang kailangan",
        "I-confirm ang deadline at accepted file format",
        "Huwag mag-send ng password, OTP, o My.SSS login access",
        "Magtabi ng sariling copy ng lahat ng submitted files",
        "Kung tutulong ang HR sa ibang records, paghiwalayin ang SSS, PhilHealth, Pag-IBIG, at TIN requirements"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'sss-number-first-job'),
    'mistake',
    6,
    $${
      "title":"Common mistakes that cause delays",
      "body":"These mistakes are usually not dramatic, but they can become annoying later when you need contributions, benefits, loans, or correction requests to match.",
      "items":[
        "Creating a new SS number because you forgot the old one",
        "Using nickname, wrong middle name, or wrong birth date",
        "Losing the Transaction Number Slip or E-1/E-6 form",
        "Assuming an SS number automatically means full benefit eligibility",
        "Letting another person control your My.SSS login",
        "Paying a fixer for free registration or basic verification"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang pagkakamali na nagdudulot ng delay",
      "body":"Hindi laging malaki agad ang epekto ng mistakes na ito, pero puwede silang maging abala kapag kailangan nang mag-match ang contributions, benefits, loans, o correction requests.",
      "items":[
        "Gumagawa ng bagong SS number dahil nakalimutan ang luma",
        "Gumagamit ng nickname, maling middle name, o maling birthday",
        "Nawawala ang Transaction Number Slip o E-1/E-6 form",
        "Inaakalang automatic full benefit eligibility na agad kapag may SS number",
        "Pinapahawak sa ibang tao ang My.SSS login",
        "Nagbabayad sa fixer para sa free registration o basic verification"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'sss-number-first-job'),
    'tip',
    7,
    $${
      "title":"Quick checklist before your HR deadline",
      "body":"Use this before submitting your first job requirements.",
      "items":[
        "I verified that I do not already have another SS number",
        "My name and birthday match my documents",
        "I saved my SS Number Slip and Transaction Number Slip",
        "I saved my E-1/E-6 form if generated",
        "I know whether my record is temporary or permanent",
        "I asked HR exactly what proof they need",
        "I did not share OTP, password, or My.SSS login access"
      ]
    }$$::jsonb,
    $${
      "title":"Quick checklist bago ang HR deadline",
      "body":"Gamitin ito bago mag-submit ng first job requirements.",
      "items":[
        "Na-verify ko na wala akong ibang SS number",
        "Tugma ang pangalan at birthday ko sa documents",
        "Na-save ko ang SS Number Slip at Transaction Number Slip",
        "Na-save ko ang E-1/E-6 form kung na-generate",
        "Alam ko kung temporary o permanent ang record ko",
        "Naitanong ko sa HR kung anong proof ang kailangan",
        "Hindi ako nag-share ng OTP, password, o My.SSS login access"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'sss-number-first-job'),
    'tip',
    8,
    $${
      "title":"Sample message to HR",
      "body":"Keep the question simple and specific so you do not overshare documents.",
      "sample":"Hi, for my SSS requirement, do you need only my SS number, or should I submit the SS Number Slip/E-1 form too? Please also confirm the deadline and file format. I will not send passwords, OTPs, or My.SSS login access."
    }$$::jsonb,
    $${
      "title":"Sample message sa HR",
      "body":"Gawing simple at specific ang tanong para hindi ka mag-overshare ng documents.",
      "sample":"Hi po, para sa SSS requirement ko, SS number lang po ba ang kailangan, o kailangan ko ring i-submit ang SS Number Slip/E-1 form? Paki-confirm din po ang deadline at file format. Hindi po ako magsesend ng password, OTP, o My.SSS login access."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'sss-number-first-job'),
    'tip',
    9,
    $${
      "title":"What to expect",
      "body":"Getting an SS number can be quick if your details and email access are ready. Corrections, duplicate records, expired links, unclear status, or missing supporting documents can take longer. If your case is not straightforward, use SSS official channels instead of guessing."
    }$$::jsonb,
    $${
      "title":"Ano ang aasahan",
      "body":"Puwedeng mabilis ang pagkuha ng SS number kung handa ang details at naa-access mo ang email. Mas tumatagal kapag may correction, duplicate record, expired link, unclear status, o kulang na supporting documents. Kung hindi simple ang case mo, official SSS channels ang gamitin imbes na manghula."
    }$$::jsonb
  );
