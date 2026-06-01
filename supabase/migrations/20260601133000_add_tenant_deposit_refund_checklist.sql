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
  'tenant-deposit-refund-checklist',
  (select id from public.categories where slug = 'adulting'),
  'Tenant deposit refund checklist before moving out',
  'Tenant deposit refund checklist bago umalis sa inuupahan',
  'Organize contract, receipts, photos, bills, and safe messages before asking for your rental deposit back.',
  'Ayusin ang kontrata, resibo, photos, bills, at safe messages bago humingi ng refund ng rental deposit.',
  false,
  false,
  true,
  7,
  'katamtaman',
  '1-2 linggo depende sa inspection, bills, usapan, at documents',
  'Libre, maliban sa printing, pamasahe, o document fees kung kailangan',
  array[
    'rent',
    'tenant',
    'deposit refund',
    'rental deposit',
    'security deposit',
    'landlord',
    'lease contract',
    'apartment',
    'bedspace',
    'barangay mediation',
    'small claims',
    'move out'
  ],
  'tenant deposit refund rental deposit security deposit landlord lessor lessee rent apartment bedspace lease contract move out inspection photos receipts unpaid rent unpaid utilities damages normal wear and tear itemized deductions barangay mediation small claims demand letter',
  'tenant deposit refund rental deposit security deposit landlord lessor lessee upa inuupahan apartment bedspace kontrata lease contract move out inspection litrato photos resibo unpaid rent unpaid utilities damages normal wear and tear itemized deductions barangay mediation small claims demand letter',
  $$[
    {
      "title":"Republic Act No. 9653: Rent Control Act of 2009",
      "publisher":"Supreme Court E-Library",
      "url":"https://elibrary.judiciary.gov.ph/thebookshelf/showdocs/2/25956"
    },
    {
      "title":"Civil Code of the Philippines",
      "publisher":"Supreme Court E-Library",
      "url":"https://elibrary.judiciary.gov.ph/thebookshelf/showdocs/2/53360"
    },
    {
      "title":"SC Issues Rules on Expedited Procedures in the First Level Courts",
      "publisher":"Supreme Court of the Philippines",
      "url":"https://sc.judiciary.gov.ph/sc-issues-rules-on-expedited-procedures-in-the-first-level-courts/"
    },
    {
      "title":"Katarungang Pambarangay",
      "publisher":"Department of the Interior and Local Government Region XII",
      "url":"https://www.region12.dilg.gov.ph/programs-projects/katarungang-pambarangay-kp"
    },
    {
      "title":"Rules on Expedited Procedures in the First Level Courts",
      "publisher":"Supreme Court of the Philippines",
      "url":"https://sc.judiciary.gov.ph/wp-content/uploads/2022/04/21-08-09-SC.pdf"
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
  where slug = 'tenant-deposit-refund-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'tenant-deposit-refund-checklist'),
    'what_to_know',
    1,
    $${
      "title":"A deposit refund is easier to ask for when your records are clear",
      "body":"This guide is not legal advice. It helps renters organize proof before asking for a deposit refund. In many rental disputes, the problem is not only whether the deposit should be returned, but whether both sides have clear proof of payment, unit condition, unpaid bills, and agreed deductions.",
      "items":[
        "Start with your contract, receipts, and move-in records",
        "Separate deposit, advance rent, unpaid rent, unpaid utilities, and damage claims",
        "Ask for itemized deductions instead of arguing about the full amount immediately",
        "Photos before and after move-out are useful evidence",
        "Keep the tone calm and written so you have a record"
      ]
    }$$::jsonb,
    $${
      "title":"Mas madaling humingi ng deposit refund kapag malinaw ang records",
      "body":"Hindi legal advice ang guide na ito. Tutulong ito sa renters na ayusin ang proof bago humingi ng deposit refund. Sa maraming rental disputes, hindi lang tanong kung dapat ibalik ang deposit, kundi kung malinaw ang proof ng bayad, condition ng unit, unpaid bills, at napag-usapang deductions.",
      "items":[
        "Magsimula sa kontrata, resibo, at move-in records",
        "Paghiwalayin ang deposit, advance rent, unpaid rent, unpaid utilities, at damage claims",
        "Humingi ng itemized deductions imbes na agad makipagtalo sa buong amount",
        "Useful evidence ang photos bago at pagkatapos mag-move out",
        "Panatilihing calm at written ang usapan para may record"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'tenant-deposit-refund-checklist'),
    'warning',
    2,
    $${
      "title":"START HERE: do not leave without documenting the unit",
      "body":"Before handing over keys, take clear photos and videos if it is safe and allowed. Document walls, floors, doors, windows, appliances, meters, keys, and anything the landlord may later claim as damaged or unpaid.",
      "severity":"medium",
      "items":[
        "Take wide photos of each room",
        "Take close-up photos of existing damage or repaired areas",
        "Record meter readings for electricity and water if available",
        "Ask for written acknowledgment that keys were returned",
        "Do not delete old move-in photos, receipts, or messages"
      ]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: huwag umalis nang walang dokumentasyon ng unit",
      "body":"Bago ibalik ang susi, kumuha ng malinaw na photos at videos kung safe at allowed. I-document ang walls, floors, doors, windows, appliances, meters, susi, at anumang maaaring i-claim ng landlord na sira o unpaid.",
      "severity":"medium",
      "items":[
        "Kumuha ng wide photos ng bawat room",
        "Kumuha ng close-up photos ng existing damage o repaired areas",
        "I-record ang meter readings ng kuryente at tubig kung available",
        "Humingi ng written acknowledgment na naibalik ang susi",
        "Huwag burahin ang old move-in photos, receipts, o messages"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'tenant-deposit-refund-checklist'),
    'step',
    3,
    $${
      "title":"Check what you actually paid at move-in",
      "body":"Many disputes start because advance rent and security deposit are mixed together. Write down what each payment was for and attach proof.",
      "step_number":1,
      "items":[
        "Security deposit amount",
        "Advance rent amount and what month it covered",
        "Reservation fee or other move-in payment if any",
        "Official receipts, bank transfers, e-wallet screenshots, or acknowledgment messages",
        "Name of the person who received the payment"
      ]
    }$$::jsonb,
    $${
      "title":"I-check kung ano talaga ang binayaran mo noong move-in",
      "body":"Madalas nagsisimula ang dispute dahil nahahalo ang advance rent at security deposit. Isulat kung para saan ang bawat bayad at ilakip ang proof.",
      "step_number":1,
      "items":[
        "Amount ng security deposit",
        "Amount ng advance rent at anong buwan ang covered nito",
        "Reservation fee o ibang move-in payment kung meron",
        "Official receipts, bank transfers, e-wallet screenshots, o acknowledgment messages",
        "Pangalan ng taong tumanggap ng bayad"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'tenant-deposit-refund-checklist'),
    'step',
    4,
    $${
      "title":"Read the lease contract before asking for refund",
      "body":"Your contract may say how deposit, advance rent, repairs, utilities, notice period, and early move-out are handled. Do not rely only on memory or chat messages if there is a written contract.",
      "step_number":2,
      "items":[
        "Deposit refund clause",
        "Allowed deductions and repair rules",
        "Notice period before moving out",
        "Unpaid bills or association dues",
        "Early termination or lock-in period terms",
        "Timeline for inspection or refund if stated"
      ]
    }$$::jsonb,
    $${
      "title":"Basahin ang lease contract bago humingi ng refund",
      "body":"Maaaring nakasulat sa kontrata kung paano ang deposit, advance rent, repairs, utilities, notice period, at early move-out. Huwag umasa sa memory o chat messages lang kung may written contract.",
      "step_number":2,
      "items":[
        "Deposit refund clause",
        "Allowed deductions at repair rules",
        "Notice period bago umalis",
        "Unpaid bills o association dues",
        "Early termination o lock-in period terms",
        "Timeline ng inspection o refund kung nakasulat"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'tenant-deposit-refund-checklist'),
    'step',
    5,
    $${
      "title":"Separate valid questions from emotional arguments",
      "body":"Before messaging the landlord, list the practical questions. This keeps the discussion focused on money, proof, and deductions rather than personal conflict.",
      "step_number":3,
      "items":[
        "How much deposit is being returned",
        "When it will be returned",
        "What deductions are being made",
        "What receipts or estimates support the deductions",
        "What unpaid rent or bills are being claimed",
        "Whether a joint inspection can be done"
      ]
    }$$::jsonb,
    $${
      "title":"Paghiwalayin ang valid questions at emotional arguments",
      "body":"Bago mag-message sa landlord, ilista muna ang practical questions. Pinapanatili nitong focused ang usapan sa pera, proof, at deductions imbes na personal conflict.",
      "step_number":3,
      "items":[
        "Magkano ang deposit na ibabalik",
        "Kailan ito ibabalik",
        "Anong deductions ang ginagawa",
        "Anong resibo o estimate ang basehan ng deductions",
        "Anong unpaid rent o bills ang sinisingil",
        "Kung puwedeng magkaroon ng joint inspection"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'tenant-deposit-refund-checklist'),
    'step',
    6,
    $${
      "title":"Ask for an itemized deduction list",
      "body":"If the landlord says the deposit will be reduced or forfeited, ask for a breakdown. A clear breakdown helps you see whether the issue is unpaid bills, actual damage, normal wear, or a contract dispute.",
      "step_number":4,
      "items":[
        "Unpaid rent balance",
        "Unpaid water, electricity, internet, or association dues",
        "Repair item, photo, and estimated or actual cost",
        "Cleaning or repainting claim with basis",
        "Amount to be returned after deductions",
        "Target date and method of refund"
      ]
    }$$::jsonb,
    $${
      "title":"Humingi ng itemized deduction list",
      "body":"Kung sinabi ng landlord na mababawasan o forfeited ang deposit, humingi ng breakdown. Mas makikita mo kung unpaid bills, actual damage, normal wear, o contract dispute ang issue kapag malinaw ang breakdown.",
      "step_number":4,
      "items":[
        "Unpaid rent balance",
        "Unpaid water, electricity, internet, o association dues",
        "Repair item, photo, at estimated o actual cost",
        "Cleaning o repainting claim na may basehan",
        "Amount na ibabalik pagkatapos ng deductions",
        "Target date at method ng refund"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'tenant-deposit-refund-checklist'),
    'step',
    7,
    $${
      "title":"Prepare a calm escalation folder",
      "body":"If the discussion does not move, prepare a folder before going to the barangay, legal aid, or court help desk. Do not show up with only anger and screenshots scattered across different chats.",
      "step_number":5,
      "items":[
        "Lease contract or written agreement",
        "Proof of deposit and advance rent payments",
        "Move-in and move-out photos",
        "Messages about refund, deductions, inspection, and key turnover",
        "Utility bills, receipts, and meter readings",
        "Your short timeline and requested refund amount"
      ]
    }$$::jsonb,
    $${
      "title":"Maghanda ng calm escalation folder",
      "body":"Kung hindi umuusad ang usapan, maghanda ng folder bago pumunta sa barangay, legal aid, o court help desk. Huwag pumunta na puro galit lang at kalat-kalat ang screenshots sa iba't ibang chat.",
      "step_number":5,
      "items":[
        "Lease contract o written agreement",
        "Proof ng deposit at advance rent payments",
        "Move-in at move-out photos",
        "Messages tungkol sa refund, deductions, inspection, at key turnover",
        "Utility bills, receipts, at meter readings",
        "Maikling timeline at requested refund amount"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'tenant-deposit-refund-checklist'),
    'mistake',
    8,
    $${
      "title":"Common mistakes that weaken your refund request",
      "body":"These mistakes are common because moving out is stressful. Fix what you can before escalating.",
      "items":[
        "Leaving without photos or key turnover proof",
        "Mixing advance rent and deposit in one unclear claim",
        "Ignoring unpaid utility bills that may be deducted",
        "Arguing about normal wear without photos from move-in",
        "Accepting verbal promises with no date or written record",
        "Threatening online exposure instead of asking for a written breakdown"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang pagkakamali na nagpapahina ng refund request",
      "body":"Common ito dahil stressful ang paglipat. Ayusin ang kaya mong ayusin bago mag-escalate.",
      "items":[
        "Umaalis nang walang photos o key turnover proof",
        "Hinahalo ang advance rent at deposit sa isang malabong claim",
        "Hindi pinapansin ang unpaid utility bills na maaaring ibawas",
        "Nakikipagtalo tungkol sa normal wear kahit walang move-in photos",
        "Tumatanggap ng verbal promise na walang date o written record",
        "Nagbabanta ng online exposure imbes na humingi ng written breakdown"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'tenant-deposit-refund-checklist'),
    'warning',
    9,
    $${
      "title":"Be careful with intimidation, fake legal threats, and harassment",
      "body":"Both renters and landlords can make bad decisions when money is involved. Keep everything factual. If someone threatens, harasses, locks you out, keeps belongings, or uses fake legal pressure, ask an official help desk what process applies.",
      "severity":"high",
      "items":[
        "Do not sign a settlement you do not understand",
        "Do not hand over original documents to a broker or fixer",
        "Do not pay a processing fee to recover your own deposit",
        "Save threatening messages or fake legal notices",
        "Use barangay, legal aid, or court help desks instead of private fixers"
      ]
    }$$::jsonb,
    $${
      "title":"Mag-ingat sa intimidation, fake legal threats, at harassment",
      "body":"Puwedeng magkamali ang renter at landlord kapag pera ang usapan. Panatilihing factual ang lahat. Kung may nagbabanta, nangha-harass, nag-lock out, nagtatago ng gamit, o gumagamit ng fake legal pressure, itanong sa official help desk kung anong process ang applicable.",
      "severity":"high",
      "items":[
        "Huwag pumirma sa settlement na hindi mo naiintindihan",
        "Huwag ibigay ang original documents sa broker o fixer",
        "Huwag magbayad ng processing fee para mabawi ang sarili mong deposit",
        "I-save ang threatening messages o fake legal notices",
        "Gamitin ang barangay, legal aid, o court help desks imbes na private fixers"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'tenant-deposit-refund-checklist'),
    'tip',
    10,
    $${
      "title":"Sample refund message",
      "body":"Send a calm message that asks for the refund or a clear deduction breakdown.",
      "sample":"Hello po. I moved out / will move out on ____. My security deposit was ____ and my advance rent covered ____. I have returned / will return the keys on ____. May I ask for the target date of deposit refund? If there are deductions, please send the itemized list with photos, receipts, unpaid bills, or repair estimates so I can review them properly."
    }$$::jsonb,
    $${
      "title":"Sample refund message",
      "body":"Mag-send ng calm message na humihingi ng refund o malinaw na deduction breakdown.",
      "sample":"Hello po. Nag-move out / magmo-move out po ako noong ____. Ang security deposit ko po ay ____ at ang advance rent ay covered ang ____. Naibalik / ibabalik ko po ang susi noong ____. Puwede po bang malaman ang target date ng deposit refund? Kung may deductions, paki-send po ang itemized list na may photos, resibo, unpaid bills, o repair estimates para ma-review ko nang maayos."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'tenant-deposit-refund-checklist'),
    'related',
    11,
    $${
      "title":"Related guides to open next",
      "body":"Deposit refund problems often connect to first-time renting, office messages, evidence collection, and utility bills.",
      "items":[
        "First-Time Renting Checklist",
        "Office Help Message Checklist",
        "Barangay Complaint Evidence Checklist",
        "Utility Bill Disconnection Checklist"
      ]
    }$$::jsonb,
    $${
      "title":"Related guides na puwedeng buksan pagkatapos",
      "body":"Madalas konektado ang deposit refund problems sa first-time renting, office messages, evidence collection, at utility bills.",
      "items":[
        "First-Time Renting Checklist",
        "Office Help Message Checklist",
        "Barangay Complaint Evidence Checklist",
        "Utility Bill Disconnection Checklist"
      ]
    }$$::jsonb
  );
