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
  published_at
)
values (
  'dswd-burial-assistance-checklist',
  (select id from public.categories where slug = 'gov'),
  'DSWD burial assistance checklist before paying the funeral bill',
  'DSWD burial assistance checklist bago bayaran ang punerarya',
  'Know the documents, proof, and safe steps before asking for DSWD funeral or burial assistance.',
  'Alamin ang documents, proof, at safe steps bago lumapit para sa DSWD funeral o burial assistance.',
  false,
  true,
  true,
  7,
  'katamtaman',
  '1-3 araw depende sa dokumento, pila, assessment, at office schedule',
  'Libre, maliban sa printing, pamasahe, o internet data',
  array[
    'dswd',
    'aics',
    'burial assistance',
    'funeral assistance',
    'funeral bill',
    'guarantee letter',
    'death certificate',
    'crisis assistance',
    'government assistance',
    'fixer warning'
  ],
  'dswd burial assistance funeral assistance funeral bill aics guarantee letter death certificate funeral contract statement of account promissory note certificate of balance transfer permit quarantine permit social worker crisis assistance government assistance fixer fake assistance page',
  'dswd burial assistance funeral assistance burol libing punerarya funeral bill aics guarantee letter death certificate sertipiko ng kamatayan funeral contract statement of account promissory note certificate of balance transfer permit quarantine permit social worker tulong pinansyal ayuda gobyerno fixer fake assistance page',
  $$[
    {
      "title":"Assistance to Individuals in Crisis Situation (AICS)",
      "publisher":"Department of Social Welfare and Development",
      "url":"https://www.dswd.gov.ph/aics/"
    },
    {
      "title":"AICS / AKAP Frequently Asked Questions",
      "publisher":"DSWD Crisis Intervention Program",
      "url":"https://crisis-intervention.dswd.gov.ph/about-us/faqs/"
    },
    {
      "title":"Burial Assistance",
      "publisher":"DSWD Interactive Kiosk",
      "url":"https://kiosk.dswd.gov.ph/?page_id=303"
    },
    {
      "title":"AICS Citizen's Charter External Services",
      "publisher":"Department of Social Welfare and Development",
      "url":"https://aics.dswd.gov.ph/wp-content/uploads/2023/07/AICS-CC-External.pdf"
    },
    {
      "title":"DSWD resumes issuance of guarantee letters for Pinoys in crisis situation",
      "publisher":"Department of Social Welfare and Development",
      "url":"https://www.dswd.gov.ph/dswd-resumes-issuance-of-guarantee-letters-for-pinoys-in-crisis-situation/"
    }
  ]$$::jsonb,
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
  select id from public.guides
  where slug = 'dswd-burial-assistance-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'dswd-burial-assistance-checklist'),
    'what_to_know',
    1,
    $${
      "title":"Burial assistance is crisis support, not automatic reimbursement",
      "body":"DSWD AICS may help families facing funeral or burial expenses, but it usually depends on documents, assessment, available funds, and the current process of the office handling your request. Start by organizing the situation calmly: who passed away, who will request, what bill is unpaid, and what proof is available.",
      "items":[
        "Burial or funeral assistance is for families in crisis, not a guaranteed payout",
        "The form of help may be cash, referral, or a guarantee letter depending on assessment",
        "Requirements can vary depending on the case and local office process",
        "A social worker may ask questions to understand the crisis and family situation",
        "Do not pay fixers or strangers who promise faster release"
      ]
    }$$::jsonb,
    $${
      "title":"Ang burial assistance ay crisis support, hindi automatic reimbursement",
      "body":"Maaaring makatulong ang DSWD AICS sa funeral o burial expenses ng pamilya, pero kadalasan ay depende ito sa documents, assessment, available funds, at current process ng office na hahawak ng request. Magsimula sa mahinahong pag-aayos ng sitwasyon: sino ang namatay, sino ang magre-request, anong bill ang hindi pa bayad, at anong proof ang meron.",
      "items":[
        "Ang burial o funeral assistance ay para sa pamilyang nasa crisis, hindi guaranteed payout",
        "Ang tulong ay maaaring cash, referral, o guarantee letter depende sa assessment",
        "Maaaring mag-iba ang requirements depende sa kaso at proseso ng local office",
        "Maaaring magtanong ang social worker para maintindihan ang crisis at sitwasyon ng pamilya",
        "Huwag magbayad sa fixer o stranger na nangangako ng mas mabilis na release"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-burial-assistance-checklist'),
    'warning',
    2,
    $${
      "title":"START HERE: secure proof before paying everything",
      "body":"If the funeral bill is not fully paid yet, ask the funeral home what documents they can issue before you go to DSWD. If you already paid everything, still gather receipts and proof, but do not assume reimbursement is automatic.",
      "severity":"high",
      "items":[
        "Ask for statement of account, funeral contract, promissory note, or certificate of balance if applicable",
        "Keep official receipts and written proof of any payment",
        "Do not hand over original IDs or documents to fixers",
        "Do not post the death certificate or full personal details online",
        "Use official DSWD offices, websites, hotlines, or verified pages only"
      ]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: kumuha muna ng proof bago bayaran ang lahat",
      "body":"Kung hindi pa fully paid ang funeral bill, itanong sa punerarya kung anong documents ang puwede nilang i-issue bago pumunta sa DSWD. Kung nabayaran na ang lahat, tipunin pa rin ang resibo at proof, pero huwag isipin na automatic ang reimbursement.",
      "severity":"high",
      "items":[
        "Humingi ng statement of account, funeral contract, promissory note, o certificate of balance kung applicable",
        "Itago ang official receipts at written proof ng anumang bayad",
        "Huwag ibigay ang original IDs o documents sa fixers",
        "Huwag i-post online ang death certificate o buong personal details",
        "Official DSWD offices, websites, hotlines, o verified pages lang ang gamitin"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-burial-assistance-checklist'),
    'step',
    3,
    $${
      "title":"Identify who will request and what relation they have",
      "body":"Before lining up, decide who will process the request. The person should have a valid ID and should be ready to explain their relationship to the deceased and the family's current situation.",
      "step_number":1,
      "items":[
        "Requester or client with valid ID",
        "Relationship to the deceased",
        "Contact number that can receive calls or texts",
        "Address and barangay details",
        "Basic explanation of why help is needed"
      ]
    }$$::jsonb,
    $${
      "title":"Alamin kung sino ang magre-request at ano ang relasyon niya",
      "body":"Bago pumila, magdesisyon kung sino ang magpo-process ng request. Dapat may valid ID ang taong ito at handang ipaliwanag ang relasyon niya sa namatay at ang kasalukuyang sitwasyon ng pamilya.",
      "step_number":1,
      "items":[
        "Requester o client na may valid ID",
        "Relasyon sa namatay",
        "Contact number na nakakatanggap ng tawag o text",
        "Address at barangay details",
        "Maikling paliwanag kung bakit kailangan ng tulong"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-burial-assistance-checklist'),
    'step',
    4,
    $${
      "title":"Prepare proof of death and funeral expense",
      "body":"The core documents usually show two things: that a death happened, and that there is a funeral or burial expense that needs help. Ask the office or funeral home what specific version of the document is accepted.",
      "step_number":2,
      "items":[
        "Death certificate or acceptable certification depending on the case",
        "Funeral contract or statement of account",
        "Promissory note or certificate of balance if there is an unpaid balance",
        "Official receipts if partial payments were made",
        "Transfer or quarantine permit if remains will be transported, when applicable"
      ]
    }$$::jsonb,
    $${
      "title":"Ihanda ang proof of death at funeral expense",
      "body":"Karaniwang dalawang bagay ang pinapakita ng core documents: may namatay, at may funeral o burial expense na kailangang tulungan. Itanong sa office o punerarya kung anong specific version ng document ang tinatanggap.",
      "step_number":2,
      "items":[
        "Death certificate o acceptable certification depende sa kaso",
        "Funeral contract o statement of account",
        "Promissory note o certificate of balance kung may unpaid balance",
        "Official receipts kung may partial payments na nagawa",
        "Transfer o quarantine permit kung ililipat ang labi, kapag applicable"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-burial-assistance-checklist'),
    'step',
    5,
    $${
      "title":"Ask the right office before traveling",
      "body":"Processes can differ between DSWD Central Office, Field Offices, satellite offices, local social welfare offices, and Malasakit or crisis desks. Before spending time and fare, verify where your case should be handled.",
      "step_number":3,
      "items":[
        "Check official DSWD pages, hotlines, or local office announcements",
        "Ask if walk-in, appointment, online registration, or referral is required",
        "Ask what documents must be original, photocopy, or certified true copy",
        "Ask whether the client or authorized representative must appear",
        "Ask if the office is issuing cash assistance, guarantee letters, or referrals"
      ]
    }$$::jsonb,
    $${
      "title":"Magtanong muna sa tamang office bago bumiyahe",
      "body":"Maaaring magkaiba ang proseso ng DSWD Central Office, Field Offices, satellite offices, local social welfare offices, at Malasakit o crisis desks. Bago gumastos sa oras at pamasahe, i-verify muna kung saan dapat dalhin ang kaso.",
      "step_number":3,
      "items":[
        "I-check ang official DSWD pages, hotlines, o local office announcements",
        "Itanong kung walk-in, appointment, online registration, o referral ang kailangan",
        "Itanong kung anong documents ang original, photocopy, o certified true copy",
        "Itanong kung kailangang pumunta ang client o puwede ang authorized representative",
        "Itanong kung cash assistance, guarantee letter, o referral ang ini-issue ng office"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-burial-assistance-checklist'),
    'step',
    6,
    $${
      "title":"Prepare a short, factual crisis explanation",
      "body":"A clear explanation helps the social worker understand the request. Keep it factual and respectful. You do not need to exaggerate or invent details.",
      "step_number":4,
      "items":[
        "Who passed away and when",
        "Who is asking for help and their relationship",
        "How much is the funeral or burial bill",
        "How much is already paid, if any",
        "Why the family cannot fully cover the expense right now"
      ]
    }$$::jsonb,
    $${
      "title":"Maghanda ng maikli at factual na paliwanag ng crisis",
      "body":"Mas madaling maintindihan ng social worker ang request kung malinaw ang paliwanag. Gawing factual at respectful. Hindi kailangang magpalala o gumawa ng detalye.",
      "step_number":4,
      "items":[
        "Sino ang namatay at kailan",
        "Sino ang humihingi ng tulong at ano ang relasyon",
        "Magkano ang funeral o burial bill",
        "Magkano ang nabayaran na, kung meron",
        "Bakit hindi kayang sagutin ng pamilya ang buong gastos ngayon"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-burial-assistance-checklist'),
    'step',
    7,
    $${
      "title":"Understand cash, guarantee letter, and referral paths",
      "body":"Not every case is handled the same way. Some assistance may be released as cash, some may be through a guarantee letter to a service provider, and some may become referral to another office or charity partner.",
      "step_number":5,
      "items":[
        "Cash assistance may require assessment and available funds",
        "Guarantee letters may be addressed to the funeral home or service provider",
        "Referral may happen if another agency or local office is more appropriate",
        "Processing time can vary, especially during high-volume periods",
        "Always ask for the official next step, claim process, or reference details"
      ]
    }$$::jsonb,
    $${
      "title":"Intindihin ang cash, guarantee letter, at referral paths",
      "body":"Hindi pare-pareho ang handling ng bawat kaso. May tulong na maaaring cash, may tulong na guarantee letter sa service provider, at may iba na referral sa ibang office o charity partner.",
      "step_number":5,
      "items":[
        "Ang cash assistance ay maaaring dumaan sa assessment at availability ng funds",
        "Ang guarantee letter ay maaaring naka-address sa punerarya o service provider",
        "Maaaring magkaroon ng referral kung mas angkop ang ibang agency o local office",
        "Maaaring mag-iba ang processing time, lalo na kapag maraming clients",
        "Laging itanong ang official next step, claim process, o reference details"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-burial-assistance-checklist'),
    'mistake',
    8,
    $${
      "title":"Common mistakes that cause delays",
      "body":"Most delays happen because families are grieving, rushed, or receiving mixed advice. Slow down enough to protect documents and avoid wasted trips.",
      "items":[
        "Going to an office without checking the current process",
        "Bringing only photos when photocopies or certified copies are needed",
        "Losing receipts, statement of account, or balance documents",
        "Letting a fixer or stranger hold original documents",
        "Posting sensitive documents online while asking for help",
        "Assuming one office can approve every type of assistance immediately"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang pagkakamali na nagdudulot ng delay",
      "body":"Madalas nade-delay dahil nagluluksa, nagmamadali, o maraming naririnig na advice ang pamilya. Huminto saglit para maprotektahan ang documents at maiwasan ang sayang na biyahe.",
      "items":[
        "Pumupunta sa office nang hindi chine-check ang current process",
        "Pictures lang ang dala kahit kailangan ng photocopy o certified copy",
        "Nawawala ang resibo, statement of account, o balance documents",
        "Pinapahawak sa fixer o stranger ang original documents",
        "Pino-post online ang sensitive documents habang humihingi ng tulong",
        "Ina-assume na isang office lang ang agad makakapag-approve ng lahat ng assistance"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-burial-assistance-checklist'),
    'warning',
    9,
    $${
      "title":"Watch for fake assistance pages and funeral fixers",
      "body":"Bereaved families are vulnerable because they are tired, emotional, and under time pressure. Scammers may pretend to be DSWD staff, funeral coordinators, charity agents, or fast-track helpers.",
      "severity":"high",
      "items":[
        "Processing fee, reservation fee, or fast-track fee",
        "Private account where you are asked to send money",
        "Request for OTP, e-wallet PIN, password, or full ID details by chat",
        "Promise of guaranteed approval without assessment",
        "Instruction to hide the transaction from family or the official office"
      ]
    }$$::jsonb,
    $${
      "title":"Mag-ingat sa fake assistance pages at funeral fixers",
      "body":"Vulnerable ang bereaved families dahil pagod, emotional, at minamadali. Maaaring magpanggap ang scammers bilang DSWD staff, funeral coordinator, charity agent, o fast-track helper.",
      "severity":"high",
      "items":[
        "Processing fee, reservation fee, o fast-track fee",
        "Private account kung saan pinapapadala ang pera",
        "Hingi ng OTP, e-wallet PIN, password, o full ID details sa chat",
        "Pangako ng guaranteed approval kahit walang assessment",
        "Instruction na itago ang transaction sa pamilya o official office"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-burial-assistance-checklist'),
    'tip',
    10,
    $${
      "title":"Sample question before lining up",
      "body":"Use a clear question so the office can answer what you actually need.",
      "sample":"Good day. My family is asking about burial or funeral assistance under AICS. The deceased is my ____. We have a death certificate and a funeral bill / statement of account. May I confirm which office should handle this, what documents are required, and whether walk-in or appointment is needed?"
    }$$::jsonb,
    $${
      "title":"Sample question bago pumila",
      "body":"Gumamit ng malinaw na tanong para masagot ng office ang totoong kailangan ninyo.",
      "sample":"Good day po. Magtatanong po sana ang pamilya namin tungkol sa burial o funeral assistance under AICS. Ang namatay po ay aking ____. May death certificate po kami at funeral bill / statement of account. Puwede po bang i-confirm kung saang office ito dapat dalhin, anong documents ang kailangan, at kung walk-in po ba o appointment?"
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'dswd-burial-assistance-checklist'),
    'related',
    11,
    $${
      "title":"Related guides to open next",
      "body":"If the death is connected to hospital bills, transport, or missing documents, these guides may help you organize the next step.",
      "items":[
        "PCSO Medical Assistance Checklist",
        "Medical Emergency Documents",
        "Lost Wallet First Steps",
        "Office Help Message Checklist"
      ]
    }$$::jsonb,
    $${
      "title":"Related guides na puwedeng buksan pagkatapos",
      "body":"Kung konektado ang pagkamatay sa hospital bills, transport, o nawawalang documents, makakatulong ang mga guide na ito sa pag-aayos ng next step.",
      "items":[
        "PCSO Medical Assistance Checklist",
        "Medical Emergency Documents",
        "Lost Wallet First Steps",
        "Office Help Message Checklist"
      ]
    }$$::jsonb
  );
