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
  'office-help-message-checklist',
  (select id from public.categories where slug = 'adulting'),
  'How to ask an office for help without wasting time',
  'Paano magtanong sa office nang malinaw at hindi pabalik-balik',
  'Send one clear message with the right details, proof, and next-step questions before going in person.',
  'Magpadala ng isang malinaw na message na may tamang details, proof, at next-step questions bago pumunta.',
  true,
  false,
  true,
  6,
  'madali',
  '5-10 minuto maghanda',
  'Libre',
  array[
    'adulting',
    'communication',
    'office message',
    'customer support',
    'requirements',
    'documents',
    'paper trail',
    'barangay',
    'government office',
    'school',
    'hospital',
    'bank',
    'landlord',
    'hr',
    'telco'
  ],
  'office help message ask requirements customer support inquiry documents proof reference number paper trail next steps appointment office hours fees status follow up escalation government office barangay school hospital bank landlord hr telco email chat call',
  'office help message tanong requirements customer support inquiry documents proof reference number paper trail next steps appointment office hours fees status follow up escalation government office barangay school hospital bank landlord hr telco email chat tawag pabalik balik malinaw na message magtanong',
  '[]'::jsonb,
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
  updated_at = now();

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'office-help-message-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'office-help-message-checklist'),
    'what_to_know',
    1,
    $${
      "title":"A clear message can save a trip",
      "body":"Many delays happen because the first message is too vague: 'How po?' or 'Requirements?' The office cannot answer well if they do not know your case, document, date, location, and what you already tried. A good message is short, respectful, specific, and asks for the next step.",
      "items":["Say who you are and what you need","Include the exact document, account, case, bill, appointment, or transaction involved","Mention what you already have or already tried","Ask what to bring, where to submit, fees, office hours, and next steps","Save the reply, reference number, and name of the office or staff if given"]
    }$$::jsonb,
    $${
      "title":"Makakatipid ng biyahe ang malinaw na message",
      "body":"Maraming delay ang nagsisimula sa sobrang vague na message tulad ng 'How po?' o 'Requirements?' Hindi makakasagot nang maayos ang office kung hindi malinaw ang case, document, date, location, at kung ano na ang nagawa mo. Ang magandang message ay maikli, magalang, specific, at may tanong tungkol sa next step.",
      "items":["Sabihin kung sino ka at ano ang kailangan mo","Ilagay ang exact document, account, case, bill, appointment, o transaction involved","Sabihin kung ano ang meron ka na o ano ang na-try mo na","Itanong kung ano ang dadalhin, saan ipapasa, fees, office hours, at next steps","I-save ang reply, reference number, at pangalan ng office o staff kung binigay"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'office-help-message-checklist'),
    'warning',
    2,
    $${
      "title":"START HERE: do not send sensitive details too early",
      "body":"Be clear, but do not overshare. Send only what is needed for the office to understand the request. Avoid full ID photos, passwords, OTPs, full card numbers, private medical details, or bank logins in normal chat unless you are inside a verified official secure process.",
      "severity":"medium",
      "items":["Do not send OTP, MPIN, password, or login codes","Do not send full card numbers or bank login details","Do not post full IDs, bills, addresses, or case details publicly","Use official pages, official email, official hotline, or the office's verified channel","If unsure, ask first: Is this the correct official channel for this concern?"]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: huwag agad mag-send ng sensitibong details",
      "body":"Maging malinaw, pero huwag mag-overshare. Ibigay lang ang kailangan para maintindihan ng office ang concern. Iwasan ang full ID photos, passwords, OTPs, full card numbers, private medical details, o bank logins sa normal chat maliban kung nasa verified official secure process ka.",
      "severity":"medium",
      "items":["Huwag mag-send ng OTP, MPIN, password, o login codes","Huwag mag-send ng full card numbers o bank login details","Huwag mag-post publicly ng full IDs, bills, address, o case details","Gamitin ang official page, official email, official hotline, o verified channel ng office","Kung hindi sigurado, itanong muna: Ito po ba ang correct official channel para sa concern na ito?"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'office-help-message-checklist'),
    'step',
    3,
    $${
      "title":"Write the situation in one sentence",
      "body":"Start with the main problem. Do not begin with a long story unless they ask for it.",
      "step_number":1,
      "items":["I need to apply for ____","I need to correct ____","I need to follow up ____","I need to ask requirements for ____","I need help because ____ happened on ____"]
    }$$::jsonb,
    $${
      "title":"Isulat ang sitwasyon sa isang sentence",
      "body":"Simulan sa main problem. Huwag muna magkwento nang mahaba kung hindi pa hinihingi.",
      "step_number":1,
      "items":["Kailangan ko pong mag-apply for ____","Kailangan ko pong ipa-correct ang ____","Kailangan ko pong mag-follow up ng ____","Kailangan ko pong magtanong ng requirements para sa ____","Kailangan ko po ng tulong dahil nangyari ang ____ noong ____"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'office-help-message-checklist'),
    'step',
    4,
    $${
      "title":"Add only the useful details",
      "body":"Useful details help the office route the concern. Too many unrelated details slow the conversation.",
      "step_number":2,
      "items":["Full name only if needed","Reference number, appointment number, account number, or ticket number if available","Date and branch/location involved","Document or service name","What you already submitted or already tried","Best contact number or email if they need to reply"]
    }$$::jsonb,
    $${
      "title":"Idagdag lang ang useful details",
      "body":"Ang useful details ang tumutulong sa office na ma-route ang concern. Kapag masyadong maraming unrelated details, bumabagal ang usapan.",
      "step_number":2,
      "items":["Full name kung kailangan","Reference number, appointment number, account number, o ticket number kung meron","Date at branch/location involved","Document o service name","Ano ang na-submit mo na o na-try mo na","Best contact number o email kung kailangan nilang mag-reply"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'office-help-message-checklist'),
    'step',
    5,
    $${
      "title":"Ask for the next step clearly",
      "body":"End with questions that prevent back-and-forth.",
      "step_number":3,
      "items":["What documents should I prepare?","Do I need an appointment?","Where should I submit this?","Is there a fee, and how much?","What office hours or cut-off time should I follow?","Can I get a reference number or written confirmation?"]
    }$$::jsonb,
    $${
      "title":"Itanong nang malinaw ang next step",
      "body":"Tapusin ang message sa mga tanong na makakaiwas sa pabalik-balik.",
      "step_number":3,
      "items":["Anong documents po ang ihahanda ko?","Kailangan po ba ng appointment?","Saan po ito ipapasa?","May fee po ba, at magkano?","Anong office hours o cut-off time ang susundin?","Puwede po bang makahingi ng reference number o written confirmation?"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'office-help-message-checklist'),
    'mistake',
    6,
    $${
      "title":"Common mistakes that cause pabalik-balik",
      "body":"These make it harder for the office to answer correctly.",
      "items":["Sending only 'How po?' or 'Requirements?'","Not saying which branch, office, document, or service you mean","Sending a long emotional story before the exact concern","Forgetting the date, reference number, or appointment details","Asking five different concerns in one message","Not saving screenshots, replies, names, and reference numbers","Posting personal details publicly instead of using official channels"]
    }$$::jsonb,
    $${
      "title":"Karaniwang pagkakamali na nauuwi sa pabalik-balik",
      "body":"Mas mahirap makasagot nang tama ang office kapag ganito ang message.",
      "items":["'How po?' o 'Requirements?' lang ang sinasabi","Hindi sinasabi kung aling branch, office, document, o service ang tinutukoy","Mahabang emotional story agad bago ang exact concern","Nakakalimutan ang date, reference number, o appointment details","Limang magkakaibang concern sa isang message","Hindi nagse-save ng screenshots, replies, names, at reference numbers","Nagpo-post ng personal details publicly imbes na official channels"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'office-help-message-checklist'),
    'tip',
    7,
    $${
      "title":"Message checklist",
      "body":"Use this before sending.",
      "items":["Concern is clear in the first sentence","Office, branch, document, or service is named","Date, reference number, account number, or appointment number included if needed","You listed what you already have or already tried","You asked for documents, fees, location, appointment, office hours, and next step","You removed sensitive details that are not needed","You saved a screenshot or copy of the message"]
    }$$::jsonb,
    $${
      "title":"Checklist bago mag-send",
      "body":"Gamitin ito bago ipadala ang message.",
      "items":["Malinaw ang concern sa first sentence","Nabanggit ang office, branch, document, o service","Nailagay ang date, reference number, account number, o appointment number kung kailangan","Nasabi kung ano ang meron ka na o na-try mo na","Naitanong ang documents, fees, location, appointment, office hours, at next step","Natanggal ang sensitive details na hindi kailangan","Na-save ang screenshot o copy ng message"]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'office-help-message-checklist'),
    'tip',
    8,
    $${
      "title":"Reusable message template",
      "body":"Copy this structure and replace the blanks.",
      "sample":"Hello po. Magtatanong lang po sana ako tungkol sa [document/service/concern]. Ako po si [name if needed]. Ang concern ko po ay [one sentence]. Mayroon na po akong [documents/reference number/appointment/details]. Ano po ang requirements, fees, office hours, at next step? Kailangan po ba ng appointment, at saan po dapat isumite?"
    }$$::jsonb,
    $${
      "title":"Reusable message template",
      "body":"Kopyahin ang structure at palitan ang blanks.",
      "sample":"Hello po. Magtatanong lang po sana ako tungkol sa [document/service/concern]. Ako po si [name kung kailangan]. Ang concern ko po ay [one sentence]. Mayroon na po akong [documents/reference number/appointment/details]. Ano po ang requirements, fees, office hours, at next step? Kailangan po ba ng appointment, at saan po dapat isumite?"
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'office-help-message-checklist'),
    'tip',
    9,
    $${
      "title":"If the answer is unclear",
      "body":"Ask one polite follow-up. Do not fight immediately. Ask for the exact missing detail and keep the reply.",
      "sample":"Thank you po. Para lang po malinaw bago ako pumunta: [specific question]. Puwede po bang i-confirm kung [option A] or [option B], and kung may reference number po itong inquiry?"
    }$$::jsonb,
    $${
      "title":"Kung hindi malinaw ang sagot",
      "body":"Mag-follow up nang magalang. Huwag agad makipag-away. Itanong ang exact missing detail at i-save ang reply.",
      "sample":"Thank you po. Para lang po malinaw bago ako pumunta: [specific question]. Puwede po bang i-confirm kung [option A] o [option B], at kung may reference number po itong inquiry?"
    }$$::jsonb
  );
