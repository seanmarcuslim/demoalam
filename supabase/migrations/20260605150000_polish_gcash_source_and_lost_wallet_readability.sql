update public.guides
set
  official_sources = $$[
    {"title":"How can I protect my GCash account?","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/19578518834457-How-can-I-protect-my-GCash-account"},
    {"title":"I noticed unauthorized transactions in my GCash account. What do I do?","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/4416637093145-I-noticed-unauthorized-transactions-in-my-GCash-account-What-do-I-do"},
    {"title":"Lost or stolen SIM, phone, or device","publisher":"GCash Help Center","url":"https://help.gcash.com/hc/en-us/articles/900006457043-My-SIM-got-lost-deactivated-damaged-What-should-I-do"},
    {"title":"Contact Us","publisher":"Maya","url":"https://www.maya.ph/contact-us"},
    {"title":"Preventive Data Privacy Practices Against Smishing","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/npc-phe-bulletin-no-21-preventive-data-privacy-practices-against-smishing/"}
  ]$$::jsonb,
  updated_at = now()
where slug = 'gcash-maya-account-recovery-first-hour';

update public.guide_sections
set
  content_en = $${
    "title":"Use this priority order before traveling",
    "body":"After money access is protected, choose what to replace first. Start with anything that could affect money, OTP, identity, work, or school tomorrow.",
    "step_number":2,
    "items":[
      "1. ATM, debit, credit, prepaid, and e-wallet-linked cards",
      "2. SIM or phone number if OTP access is affected",
      "3. Driver's License, National ID, or another primary ID",
      "4. Company or school ID needed for entry",
      "5. Secondary cards, receipts, loyalty cards, and non-urgent items"
    ]
  }$$::jsonb,
  content_fil = $${
    "title":"Gamitin ang priority order bago bumiyahe",
    "body":"Pagkatapos ma-secure ang money access, piliin kung ano ang unang papalitan. Unahin ang puwedeng makaapekto sa pera, OTP, identity, work, o school bukas.",
    "step_number":2,
    "items":[
      "1. ATM, debit, credit, prepaid, at e-wallet-linked cards",
      "2. SIM o phone number kung apektado ang OTP access",
      "3. Driver's License, National ID, o ibang primary ID",
      "4. Company o school ID na kailangan sa entry",
      "5. Secondary cards, resibo, loyalty cards, at non-urgent items"
    ]
  }$$::jsonb
where
  guide_id = (select id from public.guides where slug = 'lost-wallet-first-steps')
  and order_index = 4;

update public.guide_sections
set
  content_en = $${
    "title":"Prepare proof before going to offices",
    "body":"Many replacements need proof, forms, or an affidavit of loss. Prepare first so you do not waste fare going back and forth.",
    "step_number":3,
    "items":[
      "Backup ID or clear photo of an ID",
      "Affidavit of loss if required by the office or bank",
      "Photocopies or digital copies of available IDs",
      "Card or account reference numbers, not passwords or PINs",
      "Emergency cash or fare",
      "Proof of SIM ownership if OTP number is affected"
    ]
  }$$::jsonb,
  content_fil = $${
    "title":"Ihanda ang proof bago pumunta sa offices",
    "body":"Maraming replacement ang may proof, forms, o affidavit of loss. Maghanda muna para hindi sayang ang pamasahe sa pabalik-balik.",
    "step_number":3,
    "items":[
      "Backup ID o malinaw na photo ng ID",
      "Affidavit of loss kung hinihingi ng office o bank",
      "Photocopies o digital copies ng available IDs",
      "Card o account reference numbers, hindi passwords o PINs",
      "Emergency cash o pamasahe",
      "Proof of SIM ownership kung apektado ang OTP number"
    ]
  }$$::jsonb
where
  guide_id = (select id from public.guides where slug = 'lost-wallet-first-steps')
  and order_index = 5;
