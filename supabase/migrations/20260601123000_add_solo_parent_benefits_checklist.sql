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
  'solo-parent-benefits-checklist',
  (select id from public.categories where slug = 'gov'),
  'Solo parent benefits checklist before applying for an ID',
  'Solo parent benefits checklist bago kumuha ng ID',
  'Check eligibility, documents, discounts, PhilHealth, leave, and safe questions before applying for solo parent benefits.',
  'I-check ang eligibility, documents, discounts, PhilHealth, leave, at safe questions bago kumuha ng solo parent benefits.',
  false,
  false,
  true,
  7,
  'katamtaman',
  '1-4 linggo depende sa LGU, documents, verification, at schedule',
  'Libre, maliban sa printing, pamasahe, o internet data',
  array[
    'solo parent',
    'solo parent id',
    'solo parent benefits',
    'single parent',
    'ra 11861',
    'dswd',
    'lgu',
    'philhealth',
    'solo parent leave',
    'vat exemption',
    'discount',
    'parental leave'
  ],
  'solo parent solo parent id solo parent benefits single parent solo mother solo father ra 11861 expanded solo parents welfare act dswd lgu cswdo mswdo social welfare philhealth automatic coverage solo parent leave parental leave flexible work discount vat exemption baby essentials milk diapers medicine vaccine low income subsidy solo parent cash assistance',
  'solo parent solo parent id solo parent benefits single parent solo mother solo father ra 11861 expanded solo parents welfare act dswd lgu cswdo mswdo social welfare philhealth automatic coverage solo parent leave parental leave flexible work discount vat exemption baby essentials gatas diaper gamot bakuna low income subsidy ayuda cash assistance',
  $$[
    {
      "title":"DSWD assures solo parents of sustained implementation of RA 11861",
      "publisher":"Department of Social Welfare and Development",
      "url":"https://www.dswd.gov.ph/dswd-assures-solo-parents-of-sustained-implementation-of-ra-11861/"
    },
    {
      "title":"DSWD clears misconceptions on Expanded Solo Parents Welfare Act",
      "publisher":"Department of Social Welfare and Development",
      "url":"https://www.dswd.gov.ph/dswd-clears-misconceptions-on-expanded-solo-parents-welfare-act-reiterates-guidelines-on-availment-of-benefits/"
    },
    {
      "title":"Republic Act No. 11861",
      "publisher":"Supreme Court E-Library",
      "url":"https://elibrary.judiciary.gov.ph/thebookshelf/showdocs/2/95472"
    },
    {
      "title":"Revenue Regulations No. 1-2023 on solo parent discount and VAT exemption",
      "publisher":"Bureau of Internal Revenue",
      "url":"https://www.ntrc.gov.ph/images/BIR/RR/2023/RR%201-2023.pdf"
    },
    {
      "title":"PhilHealth Circular 2024-0020: Automatic Coverage of Solo Parents and their Dependents",
      "publisher":"PhilHealth",
      "url":"https://www.philhealth.gov.ph/circulars/2024/TS_PC2024-0020.pdf"
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
  where slug = 'solo-parent-benefits-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'solo-parent-benefits-checklist'),
    'what_to_know',
    1,
    $${
      "title":"Solo parent benefits start with proof, not assumptions",
      "body":"A Solo Parent ID can help you access benefits under RA 11861, but not everyone raising a child automatically qualifies. The key issue is whether you are exercising sole parental care and support under the rules used by your LGU or social welfare office.",
      "items":[
        "The Solo Parent ID is usually processed through the city or municipal social welfare office",
        "Eligibility depends on your actual family and support situation",
        "Benefits may include discounts, PhilHealth coverage, leave, flexible work, and possible assistance",
        "Some benefits have income, child age, employment, or document requirements",
        "Do not pay anyone who promises guaranteed approval or faster processing"
      ]
    }$$::jsonb,
    $${
      "title":"Nagsisimula sa proof ang solo parent benefits, hindi sa assumptions",
      "body":"Makakatulong ang Solo Parent ID para ma-access ang benefits under RA 11861, pero hindi automatic na qualified ang lahat ng nagpapalaki ng anak. Ang mahalagang tanong ay kung ikaw ang may sole parental care and support ayon sa rules ng LGU o social welfare office.",
      "items":[
        "Karaniwang pinoproseso ang Solo Parent ID sa city o municipal social welfare office",
        "Nakadepende ang eligibility sa totoong family at support situation",
        "Maaaring kasama sa benefits ang discounts, PhilHealth coverage, leave, flexible work, at possible assistance",
        "May ilang benefits na may income, edad ng bata, employment, o document requirements",
        "Huwag magbayad sa nangangako ng guaranteed approval o mas mabilis na processing"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'solo-parent-benefits-checklist'),
    'warning',
    2,
    $${
      "title":"START HERE: verify if your situation qualifies",
      "body":"Before collecting papers or asking HR, confirm your category with the local social welfare office. This avoids wasted trips and prevents you from claiming a benefit that may not apply to your situation.",
      "severity":"medium",
      "items":[
        "Being unmarried does not always mean automatic solo parent status",
        "Shared parenting or regular co-parenting may affect eligibility",
        "Occasional help may be treated differently from regular support",
        "Grandparents or relatives caring for a child may have a different proof path",
        "Ask your LGU what proof they require for your exact case"
      ]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: i-verify kung qualified ang sitwasyon mo",
      "body":"Bago mangolekta ng papeles o magtanong sa HR, i-confirm muna ang category mo sa local social welfare office. Makakaiwas ito sa sayang na biyahe at sa pag-claim ng benefit na maaaring hindi pala applicable sa sitwasyon mo.",
      "severity":"medium",
      "items":[
        "Hindi laging automatic solo parent status ang pagiging unmarried",
        "Maaaring makaapekto sa eligibility ang shared parenting o regular co-parenting",
        "Maaaring iba ang treatment sa occasional help kumpara sa regular support",
        "Maaaring iba ang proof path ng lolo, lola, o relative na nag-aalaga ng bata",
        "Itanong sa LGU kung anong proof ang kailangan para sa eksaktong kaso mo"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'solo-parent-benefits-checklist'),
    'step',
    3,
    $${
      "title":"Prepare your identity and child documents first",
      "body":"Most applications start with basic identity, residence, and child-related documents. Requirements can vary by LGU, so treat this as a preparation checklist before you ask for the official list.",
      "step_number":1,
      "items":[
        "Valid ID of the applicant",
        "Birth certificate of the child or children",
        "Proof of residence or barangay certificate if required",
        "Recent photo if your LGU requires it for the ID",
        "Contact number and address that match your application"
      ]
    }$$::jsonb,
    $${
      "title":"Ihanda muna ang identity at documents ng bata",
      "body":"Madalas nagsisimula ang application sa basic identity, residence, at child-related documents. Maaaring mag-iba ang requirements kada LGU, kaya gamitin ito bilang preparation checklist bago hingin ang official list.",
      "step_number":1,
      "items":[
        "Valid ID ng applicant",
        "Birth certificate ng anak o mga anak",
        "Proof of residence o barangay certificate kung required",
        "Recent photo kung kailangan ng LGU para sa ID",
        "Contact number at address na tugma sa application"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'solo-parent-benefits-checklist'),
    'step',
    4,
    $${
      "title":"Prepare proof of your solo parent situation",
      "body":"The hardest part is usually proving why you are the one carrying sole parental care and support. Ask the social welfare office what document fits your case instead of guessing.",
      "step_number":2,
      "items":[
        "Death certificate, if the other parent has died",
        "Proof of separation, abandonment, detention, disability, or other qualifying situation if applicable",
        "Barangay certification or social case documents if required",
        "Court or legal documents if your case involves custody or annulment",
        "Written explanation of your situation in simple factual terms"
      ]
    }$$::jsonb,
    $${
      "title":"Ihanda ang proof ng solo parent situation mo",
      "body":"Karaniwang pinakamahirap ang pag-prove kung bakit ikaw ang may sole parental care and support. Itanong sa social welfare office kung anong document ang bagay sa kaso mo imbes na manghula.",
      "step_number":2,
      "items":[
        "Death certificate kung namatay ang kabilang magulang",
        "Proof of separation, abandonment, detention, disability, o ibang qualifying situation kung applicable",
        "Barangay certification o social case documents kung required",
        "Court o legal documents kung may custody o annulment issue ang kaso",
        "Written explanation ng sitwasyon mo sa simple at factual na paraan"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'solo-parent-benefits-checklist'),
    'step',
    5,
    $${
      "title":"Ask your LGU how the Solo Parent ID process works",
      "body":"The process may involve assessment, interview, home visit, orientation, or document verification depending on the LGU. Before going, ask how to submit and how long review usually takes.",
      "step_number":3,
      "items":[
        "Office name: CSWDO, MSWDO, or local social welfare office",
        "Walk-in, appointment, online form, or barangay endorsement",
        "Originals and photocopies needed",
        "Validity period and renewal process of the ID",
        "Where to ask for follow-up without paying anyone"
      ]
    }$$::jsonb,
    $${
      "title":"Itanong sa LGU kung paano ang Solo Parent ID process",
      "body":"Maaaring may assessment, interview, home visit, orientation, o document verification depende sa LGU. Bago pumunta, itanong kung paano mag-submit at gaano katagal ang usual review.",
      "step_number":3,
      "items":[
        "Office name: CSWDO, MSWDO, o local social welfare office",
        "Walk-in, appointment, online form, o barangay endorsement",
        "Originals at photocopies na kailangan",
        "Validity period at renewal process ng ID",
        "Saan magfo-follow up nang hindi nagbabayad kahit kanino"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'solo-parent-benefits-checklist'),
    'step',
    6,
    $${
      "title":"Understand the discount and VAT exemption path",
      "body":"Qualified solo parents earning below the income threshold may access the 10 percent discount and VAT exemption for specific essential goods for children aged six years old and below. This is not a general discount for all purchases.",
      "step_number":4,
      "items":[
        "Check if your child is within the covered age",
        "Check if your income falls within the required threshold",
        "Bring Solo Parent ID and booklet if required",
        "Ask the store what documents they need before paying",
        "Keep receipts in case you need to clarify or report problems"
      ]
    }$$::jsonb,
    $${
      "title":"Intindihin ang discount at VAT exemption path",
      "body":"Ang qualified solo parents na pasok sa income threshold ay maaaring maka-access ng 10 percent discount at VAT exemption sa specific essential goods para sa batang anim na taon pababa. Hindi ito general discount para sa lahat ng bilihin.",
      "step_number":4,
      "items":[
        "I-check kung pasok ang edad ng bata",
        "I-check kung pasok ang income mo sa required threshold",
        "Dalhin ang Solo Parent ID at booklet kung required",
        "Itanong sa store kung anong documents ang kailangan bago magbayad",
        "Itago ang resibo kung kailangan mong mag-clarify o mag-report ng problema"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'solo-parent-benefits-checklist'),
    'step',
    7,
    $${
      "title":"Check PhilHealth and work benefits separately",
      "body":"Solo parent benefits are not all claimed in one place. PhilHealth coverage, parental leave, and flexible work questions may require separate coordination with PhilHealth, HR, or your employer.",
      "step_number":5,
      "items":[
        "Ask PhilHealth or your LGU how solo parent coverage is recorded",
        "If employed, ask HR what proof they need for solo parent leave",
        "Ask if flexible work arrangements are available in your role",
        "Keep copies of your Solo Parent ID and official acknowledgments",
        "Do not assume HR can process LGU or PhilHealth updates automatically"
      ]
    }$$::jsonb,
    $${
      "title":"I-check nang hiwalay ang PhilHealth at work benefits",
      "body":"Hindi lahat ng solo parent benefits ay kinukuha sa iisang lugar. Ang PhilHealth coverage, parental leave, at flexible work questions ay maaaring kailangan ng hiwalay na coordination sa PhilHealth, HR, o employer.",
      "step_number":5,
      "items":[
        "Itanong sa PhilHealth o LGU kung paano nare-record ang solo parent coverage",
        "Kung employed, itanong sa HR kung anong proof ang kailangan para sa solo parent leave",
        "Itanong kung may flexible work arrangement na puwede sa role mo",
        "Magtago ng copies ng Solo Parent ID at official acknowledgments",
        "Huwag i-assume na automatic maaayos ng HR ang LGU o PhilHealth updates"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'solo-parent-benefits-checklist'),
    'mistake',
    8,
    $${
      "title":"Common mistakes that waste time",
      "body":"Many applicants are delayed because they hear one benefit online and assume the same process applies everywhere. Keep each benefit separate: ID, discount, PhilHealth, leave, subsidy, and assistance.",
      "items":[
        "Applying without confirming the exact LGU requirements",
        "Assuming a Solo Parent ID automatically gives every benefit immediately",
        "Using expired, incomplete, or mismatched documents",
        "Asking HR for benefits before confirming what proof HR accepts",
        "Expecting cash subsidy without checking income and program rules",
        "Leaving without asking for a reference number or next step"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang pagkakamali na nagsasayang ng oras",
      "body":"Maraming applicants ang nade-delay dahil may nabasang isang benefit online at inakala na pare-pareho ang process sa lahat ng lugar. Paghiwalayin ang bawat benefit: ID, discount, PhilHealth, leave, subsidy, at assistance.",
      "items":[
        "Nag-a-apply nang hindi kinukumpirma ang eksaktong LGU requirements",
        "Ina-assume na automatic makukuha lahat ng benefits kapag may Solo Parent ID",
        "Gumagamit ng expired, kulang, o hindi tugmang documents",
        "Nagtatanong sa HR ng benefits bago alamin kung anong proof ang tinatanggap ng HR",
        "Umaasa sa cash subsidy nang hindi chine-check ang income at program rules",
        "Umaalis nang hindi nagtatanong ng reference number o next step"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'solo-parent-benefits-checklist'),
    'warning',
    9,
    $${
      "title":"Watch for fake Solo Parent ID and benefits fixers",
      "body":"Scammers may use the confusion around benefits to collect fees, IDs, or personal details. Solo parent benefits involve sensitive family information, so protect your documents.",
      "severity":"high",
      "items":[
        "Payment request for guaranteed Solo Parent ID approval",
        "Private person asking for original birth certificates or IDs",
        "Fake online form asking for OTP, password, or e-wallet PIN",
        "Promise of instant cash subsidy without assessment",
        "Instruction to send documents through a personal social media account"
      ]
    }$$::jsonb,
    $${
      "title":"Mag-ingat sa fake Solo Parent ID at benefits fixers",
      "body":"Ginagamit ng scammers ang kalituhan sa benefits para makakuha ng bayad, IDs, o personal details. Sensitive ang family information sa solo parent benefits, kaya protektahan ang documents mo.",
      "severity":"high",
      "items":[
        "Hingi ng bayad kapalit ng guaranteed Solo Parent ID approval",
        "Private person na humihingi ng original birth certificates o IDs",
        "Fake online form na humihingi ng OTP, password, o e-wallet PIN",
        "Pangako ng instant cash subsidy kahit walang assessment",
        "Instruction na magpadala ng documents sa personal social media account"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'solo-parent-benefits-checklist'),
    'tip',
    10,
    $${
      "title":"Sample question to your LGU or social welfare office",
      "body":"Ask one clear question first instead of arguing about benefits immediately.",
      "sample":"Good day. I would like to ask about applying for a Solo Parent ID under RA 11861. My situation is ____. I am caring for my child / children named ____. May I confirm what documents are required, whether my case qualifies for assessment, and what benefits I should ask about after the ID is approved?"
    }$$::jsonb,
    $${
      "title":"Sample question sa LGU o social welfare office",
      "body":"Magtanong muna nang malinaw imbes na agad makipagtalo tungkol sa benefits.",
      "sample":"Good day po. Magtatanong po sana ako tungkol sa pag-apply ng Solo Parent ID under RA 11861. Ang sitwasyon ko po ay ____. Ako po ang nag-aalaga sa anak / mga anak kong si ____. Puwede po bang i-confirm kung anong documents ang kailangan, kung qualified for assessment ang case ko, at anong benefits ang dapat kong itanong pagkatapos ma-approve ang ID?"
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'solo-parent-benefits-checklist'),
    'related',
    11,
    $${
      "title":"Related guides to open next",
      "body":"Solo parent benefits often connect to work, healthcare, school costs, and government assistance. These guides can help you organize the next step.",
      "items":[
        "Student Financial Aid Philippines Checklist",
        "First Job Requirements",
        "PhilHealth, Pag-IBIG, and TIN Basics",
        "Office Help Message Checklist"
      ]
    }$$::jsonb,
    $${
      "title":"Related guides na puwedeng buksan pagkatapos",
      "body":"Madalas konektado ang solo parent benefits sa trabaho, healthcare, gastos sa school, at government assistance. Makakatulong ang mga guide na ito para maayos ang next step.",
      "items":[
        "Student Financial Aid Philippines Checklist",
        "First Job Requirements",
        "PhilHealth, Pag-IBIG, and TIN Basics",
        "Office Help Message Checklist"
      ]
    }$$::jsonb
  );
