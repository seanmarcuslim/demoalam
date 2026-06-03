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
  'loan-red-flags-before-borrowing',
  (select id from public.categories where slug = 'money'),
  'Online loan red flags before you borrow',
  'Online loan red flags bago ka umutang',
  'Check SEC records, total repayment, app permissions, collection tactics, and safer options before borrowing.',
  'I-check ang SEC records, total repayment, app permissions, paniningil, at safer options bago umutang.',
  true,
  true,
  true,
  6,
  'katamtaman',
  '15-30 minuto',
  'Libre, maliban sa internet data o tawag kung magve-verify',
  array[
    'loan',
    'online lending',
    'debt',
    'money',
    'utang',
    'pautang',
    'ola',
    'sec',
    'data privacy',
    'harassment',
    'collection',
    'scam',
    'fees'
  ],
  'loan online lending online loan app lending app debt money utang pautang fees ola sec data privacy harassment collection total repayment borrower contacts photos phone permissions app permissions loan agreement processing fee service fee interest penalty due date abusive collection public shaming fake legal threat sec loan app recorded online lending platform',
  'loan online lending online loan app lending app utang pautang pera fees ola sec data privacy harassment paniningil total repayment borrower contacts photos phone permissions app permissions loan agreement processing fee service fee interest penalty due date abusive collection pamamahiya fake legal threat sec loan app recorded online lending platform',
  $$[
    {"title":"List of Recorded Online Lending Platforms","publisher":"Securities and Exchange Commission","url":"https://www.sec.gov.ph/lending-companies-and-financing-companies-2/list-of-recorded-online-lending-platforms/"},
    {"title":"Advisory for Online Lending Platforms Borrowers","publisher":"Securities and Exchange Commission","url":"https://www.sec.gov.ph/wp-content/uploads/2023/10/2023advisory_For-Online-Lending-Platforms-Borrowers.pdf"},
    {"title":"Public Advisory on Online Lending Platforms","publisher":"DICT, National Privacy Commission, and Securities and Exchange Commission","url":"https://privacy.gov.ph/wp-content/uploads/2026/03/DICT-NPC-SEC-Public-Advisory-on-Online-Lending-Platforms.pdf"},
    {"title":"Online lenders barred from harvesting borrowers phone and social-media contact list","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/online-lenders-barred-from-harvesting-borrowers-phone-and-social-media-contact-list-says-privacy-commission/"},
    {"title":"Joint press statement against illegal practices of online lending apps","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/joint-press-statement-of-the-national-privacy-commission-fintech-alliance-ph-philippine-finance-association-and-the-non-bank-financing-sector-against-illegal-practices-of-online-lending-apps/"},
    {"title":"NPC Circular No. 20-01","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/wp-content/uploads/2022/02/NPC-Circular-No.-20-01.pdf"}
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
  updated_at = now();

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'loan-red-flags-before-borrowing'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'what_to_know',
    1,
    $${
      "title":"Fast approval does not mean the loan is safe or affordable",
      "body":"Online loans can help in emergencies, but fast approval can hide high fees, short due dates, aggressive collection, or risky app permissions. Being SEC-recorded or registered does not automatically mean the loan is affordable, suitable, or risk-free. It is only one verification signal.",
      "items":[
        "Amount released is not the same as total repayment",
        "Upfront deductions can make the loan more expensive than it looks",
        "Short due dates can trigger penalties quickly",
        "App permissions can expose contacts, photos, files, or messages",
        "You still need to check repayment, due dates, permissions, penalties, and collection practices"
      ]
    }$$::jsonb,
    $${
      "title":"Hindi ibig sabihin na safe o affordable ang loan dahil mabilis ang approval",
      "body":"Puwedeng makatulong ang online loans sa emergency, pero puwedeng itago ng mabilis na approval ang mataas na fees, maikling due dates, aggressive collection, o risky app permissions. Hindi automatic na affordable, bagay sa iyo, o risk-free ang loan dahil SEC-recorded o registered ito. Isa lang itong verification signal.",
      "items":[
        "Hindi pareho ang amount released at total repayment",
        "Puwedeng maging mas mahal ang loan dahil sa upfront deductions",
        "Mabilis magka-penalty kapag maikli ang due date",
        "Puwedeng ma-expose ang contacts, photos, files, o messages dahil sa app permissions",
        "Kailangan pa ring i-check ang repayment, due dates, permissions, penalties, at collection practices"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'warning',
    2,
    $${
      "title":"START HERE: stop if the app asks for excessive phone access",
      "body":"Be very careful with loan apps that demand broad access to contacts, gallery, files, messages, call logs, or social accounts before showing clear terms. These permissions can be misused for shaming, threats, or unauthorized contact with people around you.",
      "severity":"high",
      "items":[
        "Contacts, call logs, or emergency contacts",
        "Photos, files, gallery, storage, or media",
        "Messages, notifications, or screen access",
        "Social media account access",
        "Threats to message your contacts if you miss payment",
        "No clear privacy notice, company name, or support channel"
      ]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: huminto kung sobra ang hinihinging phone access",
      "body":"Mag-ingat sa loan apps na humihingi agad ng malawak na access sa contacts, gallery, files, messages, call logs, o social accounts bago ipakita ang malinaw na terms. Puwedeng magamit ang permissions na ito sa pamamahiya, pananakot, o unauthorized contact sa mga tao sa paligid mo.",
      "severity":"high",
      "items":[
        "Contacts, call logs, o emergency contacts",
        "Photos, files, gallery, storage, o media",
        "Messages, notifications, o screen access",
        "Social media account access",
        "Threat na imessage ang contacts mo kapag delayed ka",
        "Walang malinaw na privacy notice, company name, o support channel"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'step',
    3,
    $${
      "title":"Verify the company and online lending platform through SEC records",
      "body":"Do not rely only on the app logo, Facebook page, or chat agent. Check the company name and online lending platform against official SEC records before sending IDs, selfies, bank details, or emergency contacts.",
      "step_number":1,
      "items":[
        "Search the company name on official SEC sources",
        "Check the app or platform name, not only the logo",
        "Look for a real company identity, address, and support channel",
        "Search for SEC advisories or complaints about the app",
        "Remember: SEC-recorded does not automatically mean affordable or safe for your situation"
      ]
    }$$::jsonb,
    $${
      "title":"I-verify ang company at online lending platform gamit ang SEC records",
      "body":"Huwag umasa sa app logo, Facebook page, o chat agent lang. I-check ang company name at online lending platform sa official SEC records bago mag-send ng IDs, selfies, bank details, o emergency contacts.",
      "step_number":1,
      "items":[
        "Hanapin ang company name sa official SEC sources",
        "I-check ang app o platform name, hindi lang logo",
        "Hanapin ang totoong company identity, address, at support channel",
        "Maghanap ng SEC advisories o complaints tungkol sa app",
        "Tandaan: hindi automatic na affordable o safe sa sitwasyon mo dahil SEC-recorded ito"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'step',
    4,
    $${
      "title":"Check app permissions and personal data access before installing or submitting",
      "body":"Many users install the app first and only notice permissions later. Pause before allowing access. A loan app should not need broad access to your contacts, photos, messages, or social accounts to explain loan terms.",
      "step_number":2,
      "items":[
        "Review permissions before tapping Allow",
        "Avoid apps that require contact lists or gallery access before showing terms",
        "Check if the privacy notice clearly explains what data is collected",
        "Do not upload ID selfies until you understand the lender and loan terms",
        "If the app blocks you unless you grant broad access, treat it as a serious red flag"
      ]
    }$$::jsonb,
    $${
      "title":"I-check ang app permissions at personal data access bago mag-install o mag-submit",
      "body":"Maraming user ang nag-i-install muna ng app at saka lang napapansin ang permissions. Huminto muna bago mag-Allow. Hindi dapat kailangan ng loan app ang malawak na access sa contacts, photos, messages, o social accounts para ipaliwanag ang loan terms.",
      "step_number":2,
      "items":[
        "I-review ang permissions bago mag-tap ng Allow",
        "Iwasan ang apps na kailangang ma-access ang contacts o gallery bago ipakita ang terms",
        "I-check kung malinaw sa privacy notice kung anong data ang kinokolekta",
        "Huwag mag-upload ng ID selfies hangga't hindi malinaw ang lender at loan terms",
        "Kung bina-block ka ng app maliban kung magbigay ka ng broad access, red flag iyon"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'step',
    5,
    $${
      "title":"Calculate the real repayment, not just the cash released",
      "body":"Do not decide based on approval speed or the amount shown in the ad. Write the cash you will actually receive, then compare it with the total amount you must repay.",
      "step_number":3,
      "items":[
        "Cash actually released to you",
        "Processing, service, platform, or convenience fees",
        "Interest and total repayment amount",
        "Due date and any grace period",
        "Daily penalties or late fees",
        "What happens if payment is delayed"
      ]
    }$$::jsonb,
    $${
      "title":"Kalkulahin ang totoong babayaran, hindi lang cash na mare-release",
      "body":"Huwag magdesisyon base sa bilis ng approval o amount na nasa ad. Isulat ang cash na totoong matatanggap mo, pagkatapos i-compare sa total amount na babayaran.",
      "step_number":3,
      "items":[
        "Cash na totoong mare-release sa iyo",
        "Processing, service, platform, o convenience fees",
        "Interest at total repayment amount",
        "Due date at anumang grace period",
        "Daily penalties o late fees",
        "Ano ang mangyayari kapag delayed ang payment"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'step',
    6,
    $${
      "title":"Read the loan agreement, fees, due date, and penalties",
      "body":"A clear lender should show the amount released, fees, interest, due date, penalties, and collection process before you accept. If the terms are hidden, rushed, or only explained in chat, slow down.",
      "step_number":4,
      "items":[
        "Loan amount and net proceeds",
        "All fees and deductions",
        "Interest rate and total repayment",
        "Due date, cut-off, and payment channel",
        "Late penalties and collection process",
        "Cancellation, refund, or early repayment rules"
      ]
    }$$::jsonb,
    $${
      "title":"Basahin ang loan agreement, fees, due date, at penalties",
      "body":"Dapat ipakita ng malinaw na lender ang amount released, fees, interest, due date, penalties, at collection process bago ka mag-accept. Kung tago, minamadali, o sa chat lang ipinapaliwanag ang terms, huminto muna.",
      "step_number":4,
      "items":[
        "Loan amount at net proceeds",
        "Lahat ng fees at deductions",
        "Interest rate at total repayment",
        "Due date, cut-off, at payment channel",
        "Late penalties at collection process",
        "Cancellation, refund, o early repayment rules"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'step',
    7,
    $${
      "title":"Compare safer options before borrowing",
      "body":"If the loan is for a shortfall, check whether there is a less risky option before installing a questionable app or accepting expensive terms.",
      "step_number":5,
      "items":[
        "Ask for an official payment extension or installment option",
        "Reduce or delay a non-essential expense",
        "Use emergency savings if available",
        "Ask your employer, school, provider, or billing office for official options",
        "Check government, community, or family assistance without giving app permissions",
        "Borrow only the amount you can repay on time"
      ]
    }$$::jsonb,
    $${
      "title":"I-compare muna ang safer options bago umutang",
      "body":"Kung pangkulang ang loan, i-check muna kung may less risky option bago mag-install ng kaduda-dudang app o mag-accept ng mahal na terms.",
      "step_number":5,
      "items":[
        "Magtanong ng official payment extension o installment option",
        "Bawasan o i-delay ang non-essential expense",
        "Gamitin ang emergency savings kung meron",
        "Magtanong sa employer, school, provider, o billing office ng official options",
        "I-check ang government, community, o family assistance nang hindi nagbibigay ng app permissions",
        "Manghiram lang ng amount na kaya mong bayaran on time"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'step',
    8,
    $${
      "title":"If you still borrow, document the offer before accepting",
      "body":"Documentation helps you compare terms and protects you if the app later changes the story. Save proof before you accept, not only after problems start.",
      "step_number":6,
      "items":[
        "Company name, app name, and support channel",
        "Screenshots of loan amount, cash released, fees, and repayment",
        "Due date, penalties, and collection terms",
        "Privacy notice and app permissions requested",
        "Agreement, reference number, and payment channels",
        "Date and time when you accepted the offer"
      ]
    }$$::jsonb,
    $${
      "title":"Kung tutuloy ka pa rin, i-document ang offer bago mag-accept",
      "body":"Nakakatulong ang documentation para ma-compare ang terms at maprotektahan ka kung iba na ang sabihin ng app later. Mag-save ng proof bago mag-accept, hindi lang kapag may problema na.",
      "step_number":6,
      "items":[
        "Company name, app name, at support channel",
        "Screenshots ng loan amount, cash released, fees, at repayment",
        "Due date, penalties, at collection terms",
        "Privacy notice at app permissions na hinihingi",
        "Agreement, reference number, at payment channels",
        "Date at time kung kailan mo in-accept ang offer"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'mistake',
    9,
    $${
      "title":"Common mistakes before borrowing from an online loan app",
      "body":"These mistakes usually happen because the borrower is rushed, embarrassed, or desperate. Slow down before giving data or accepting terms.",
      "items":[
        "Looking only at the cash released",
        "Ignoring app permissions",
        "Skipping the SEC company and platform check",
        "Using a second loan to cover the first loan",
        "Sharing OTP, password, bank login, ID selfies, or contacts under pressure",
        "Deleting screenshots of terms, messages, or threats",
        "Borrowing for wants while food, rent, bills, or commute are not planned"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes bago umutang sa online loan app",
      "body":"Madalas nangyayari ito dahil minamadali, nahihiya, o desperado ang borrower. Huminto muna bago magbigay ng data o mag-accept ng terms.",
      "items":[
        "Cash released lang ang tinitingnan",
        "Hindi pinapansin ang app permissions",
        "Hindi chine-check ang SEC company at platform record",
        "Gumagamit ng second loan para takpan ang first loan",
        "Nagbibigay ng OTP, password, bank login, ID selfies, o contacts under pressure",
        "Binubura ang screenshots ng terms, messages, o threats",
        "Umutang para sa wants kahit hindi pa planado ang pagkain, renta, bills, o pamasahe"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'warning',
    10,
    $${
      "title":"Red flags of abusive collection, public shaming, and fake legal threats",
      "body":"Before borrowing, check if the app or agent already hints at abusive collection. Threats, shame, and contact-list pressure are not normal customer support behavior.",
      "severity":"high",
      "items":[
        "Threats to contact your family, employer, classmates, or friends",
        "Threats to post your photo, ID, or debt online",
        "Fake legal threats meant to scare you into paying immediately",
        "Abusive language before you even accept the loan",
        "Instructions to hide the loan from family or avoid official channels",
        "Pressure to pay through personal accounts instead of official channels"
      ]
    }$$::jsonb,
    $${
      "title":"Red flags ng abusive collection, pamamahiya, at fake legal threats",
      "body":"Bago umutang, i-check kung may hint na agad ang app o agent ng abusive collection. Hindi normal customer support behavior ang threats, pamamahiya, at pressure gamit ang contact list.",
      "severity":"high",
      "items":[
        "Threat na kokontakin ang pamilya, employer, classmates, o friends mo",
        "Threat na ipo-post ang photo, ID, o utang mo online",
        "Fake legal threats para takutin kang magbayad agad",
        "Abusive language kahit hindi mo pa ina-accept ang loan",
        "Instruction na itago ang loan sa pamilya o umiwas sa official channels",
        "Pressure na magbayad sa personal accounts imbes na official channels"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'tip',
    11,
    $${
      "title":"Sample question before borrowing",
      "body":"Ask this before continuing. If the lender cannot answer clearly, do not rush.",
      "sample":"Before I apply, please confirm the exact company name, SEC registration or recorded OLP details, app/platform name, cash I will receive, total repayment, due date, all fees, penalties, collection process, and phone permissions required."
    }$$::jsonb,
    $${
      "title":"Sample question bago umutang",
      "body":"Itanong ito bago tumuloy. Kung hindi malinaw ang sagot ng lender, huwag magmadali.",
      "sample":"Before I apply, paki-confirm po ang exact company name, SEC registration o recorded OLP details, app/platform name, cash na matatanggap ko, total repayment, due date, lahat ng fees, penalties, collection process, at required phone permissions."
    }$$::jsonb
  );
