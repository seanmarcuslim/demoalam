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
  'child-support-evidence-checklist',
  (select id from public.categories where slug = 'adulting'),
  'Child support evidence checklist before asking for help',
  'Child support evidence checklist bago humingi ng tulong',
  'Organize proof, expenses, messages, and safe next questions before going to barangay, PAO, or a help desk.',
  'Ayusin ang proof, gastos, messages, at safe questions bago lumapit sa barangay, PAO, o help desk.',
  false,
  true,
  true,
  7,
  'katamtaman',
  '1-7 araw para mag-ipon ng proof; mas matagal kung kailangan ng formal legal help',
  'Libre, maliban sa printing, pamasahe, o legal/document fees kung kailangan',
  array[
    'child support',
    'support',
    'family code',
    'pao',
    'vawc',
    'economic abuse',
    'barangay',
    'evidence',
    'birth certificate',
    'school expenses',
    'medical expenses',
    'parenting'
  ],
  'child support evidence checklist sustento support family code pao public attorney office legal assistance vawc economic abuse barangay birth certificate paternity proof child expenses tuition school expenses medical expenses food clothing messages bank transfer receipts agreement parenting co parent',
  'child support evidence checklist sustento suporta family code pao public attorney office legal assistance vawc economic abuse barangay birth certificate proof ng anak proof ng tatay gastos ng bata tuition school expenses medical expenses pagkain damit messages bank transfer resibo kasunduan magulang co parent',
  $$[
    {
      "title":"Family Code of the Philippines",
      "publisher":"Lawphil",
      "url":"https://lawphil.net/executive/execord/eo1987/eo_209_1987.html"
    },
    {
      "title":"Republic Act No. 9262: Anti-Violence Against Women and Their Children Act",
      "publisher":"Lawphil",
      "url":"https://lawphil.net/statutes/repacts/ra2004/ra_9262_2004.html"
    },
    {
      "title":"SC: Paternity Must Be Proven to Convict for Economic Abuse Under Anti-VAWC Law",
      "publisher":"Supreme Court of the Philippines",
      "url":"https://sc.judiciary.gov.ph/sc-paternity-must-be-proven-to-convict-for-economic-abuse-under-anti-vawc-law/"
    },
    {
      "title":"PAO Services",
      "publisher":"Public Attorney's Office",
      "url":"https://pao.gov.ph/services-2/"
    },
    {
      "title":"DSWD reiterates strict enforcement of law on violence against women, children",
      "publisher":"Department of Social Welfare and Development",
      "url":"https://www.dswd.gov.ph/dswd-reiterates-strict-enforcement-of-law-on-violence-against-women-children-urges-public-to-report-vawc-incidents/"
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
  where slug = 'child-support-evidence-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'child-support-evidence-checklist'),
    'what_to_know',
    1,
    $${
      "title":"Child support starts with the child's needs and clear proof",
      "body":"This guide is not legal advice. It helps you organize facts before asking for help. Child support issues can involve family law, proof of parentage, expenses, communication history, and sometimes VAWC or economic abuse concerns. The safest first move is to collect clear records before confronting, posting, or filing anything.",
      "items":[
        "Support usually concerns the child's real needs such as food, school, medicine, clothing, and shelter",
        "The other parent's ability and actual situation may matter in formal discussions",
        "Proof of parentage or relationship can become important",
        "Messages and payment records are better than memory alone",
        "If there is abuse, threat, or danger, prioritize safety and official help"
      ]
    }$$::jsonb,
    $${
      "title":"Nagsisimula ang child support sa needs ng bata at malinaw na proof",
      "body":"Hindi legal advice ang guide na ito. Tutulong ito para maayos mo ang facts bago humingi ng tulong. Ang child support issues ay maaaring may kinalaman sa family law, proof ng pagiging magulang, gastos, communication history, at minsan VAWC o economic abuse concerns. Pinaka-safe na unang hakbang ang mag-ipon muna ng malinaw na records bago makipag-away, mag-post, o mag-file.",
      "items":[
        "Ang support ay karaniwang tungkol sa totoong needs ng bata gaya ng pagkain, school, gamot, damit, at tirahan",
        "Maaaring mahalaga sa formal discussion ang kakayahan at actual situation ng kabilang magulang",
        "Maaaring maging mahalaga ang proof ng parentage o relasyon",
        "Mas mabigat ang messages at payment records kaysa memory lang",
        "Kung may abuse, threat, o danger, unahin ang safety at official help"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'child-support-evidence-checklist'),
    'warning',
    2,
    $${
      "title":"START HERE: do not rely on public posts as your evidence plan",
      "body":"Posting online may feel relieving, but it can expose your child, weaken privacy, and trigger more conflict. Build a private evidence folder first. If you need urgent protection, go to official help instead of trying to win the argument online.",
      "severity":"high",
      "items":[
        "Do not post the child's birth certificate, school documents, address, or full name",
        "Do not expose private messages that show sensitive child details",
        "Do not threaten or invent facts to force payment",
        "Do not sign a rushed agreement you do not understand",
        "If there are threats or violence, contact barangay VAWC desk, police, DSWD, PAO, or a trusted official channel"
      ]
    }$$::jsonb,
    $${
      "title":"UNAHIN ITO: huwag gawing evidence plan ang public posts",
      "body":"Nakakagaan minsan ang mag-post online, pero puwede nitong ma-expose ang bata, masira ang privacy, at palalain ang conflict. Gumawa muna ng private evidence folder. Kung kailangan ng urgent protection, lumapit sa official help imbes na subukang manalo sa online argument.",
      "severity":"high",
      "items":[
        "Huwag i-post ang birth certificate, school documents, address, o buong pangalan ng bata",
        "Huwag i-expose ang private messages na may sensitive child details",
        "Huwag magbanta o gumawa ng facts para mapilit ang bayad",
        "Huwag pumirma sa minadaling kasunduan na hindi mo naiintindihan",
        "Kung may threats o violence, lumapit sa barangay VAWC desk, police, DSWD, PAO, o trusted official channel"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'child-support-evidence-checklist'),
    'step',
    3,
    $${
      "title":"Create one timeline of the child's support situation",
      "body":"A timeline helps barangay workers, PAO, social workers, or lawyers understand the case faster. Keep it factual and short.",
      "step_number":1,
      "items":[
        "Child's name, age, and current living arrangement",
        "When support started, stopped, became irregular, or became too low",
        "Important dates: birth, separation, school enrollment, medical events",
        "Dates when you asked for support and what response you received",
        "Any safety concerns, threats, or abusive incidents if present"
      ]
    }$$::jsonb,
    $${
      "title":"Gumawa ng isang timeline ng support situation ng bata",
      "body":"Mas mabilis maintindihan ng barangay workers, PAO, social workers, o lawyers ang kaso kapag may timeline. Gawing factual at maikli.",
      "step_number":1,
      "items":[
        "Pangalan, edad, at kasalukuyang living arrangement ng bata",
        "Kailan nagsimula, tumigil, naging irregular, o naging kulang ang support",
        "Important dates: birth, separation, school enrollment, medical events",
        "Mga petsa kung kailan ka humingi ng support at ano ang naging response",
        "Safety concerns, threats, o abusive incidents kung meron"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'child-support-evidence-checklist'),
    'step',
    4,
    $${
      "title":"Prepare proof of parentage or responsibility",
      "body":"Formal help may require proof that connects the child and the parent being asked to support. The exact proof depends on the case, so organize what you already have before asking for official guidance.",
      "step_number":2,
      "items":[
        "Birth certificate of the child",
        "Acknowledgment, signature, records, or documents showing parentage if available",
        "Messages where the other parent recognizes responsibility",
        "School or medical records listing parent or guardian details if relevant",
        "Any previous written agreement about support or expenses"
      ]
    }$$::jsonb,
    $${
      "title":"Ihanda ang proof ng parentage o responsibility",
      "body":"Sa formal help, maaaring kailangan ang proof na nagkokonekta sa bata at sa magulang na hinihingan ng support. Depende sa kaso ang eksaktong proof, kaya ayusin muna kung ano ang meron ka bago humingi ng official guidance.",
      "step_number":2,
      "items":[
        "Birth certificate ng bata",
        "Acknowledgment, pirma, records, o documents na nagpapakita ng parentage kung meron",
        "Messages kung saan kinikilala ng kabilang magulang ang responsibility",
        "School o medical records na may parent o guardian details kung relevant",
        "Dating written agreement tungkol sa support o expenses"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'child-support-evidence-checklist'),
    'step',
    5,
    $${
      "title":"List the child's monthly and urgent expenses",
      "body":"Do not ask for a random amount first. Start with the child's real expenses. A clear list makes the conversation more grounded and easier to verify.",
      "step_number":3,
      "items":[
        "Food, milk, vitamins, and basic hygiene",
        "School expenses, tuition, uniforms, modules, transport, and supplies",
        "Medical expenses, medicines, checkups, therapy, or hospital costs",
        "Rent, utilities, or shared household costs connected to the child",
        "Receipts, screenshots, payment slips, and written estimates"
      ]
    }$$::jsonb,
    $${
      "title":"Ilista ang monthly at urgent expenses ng bata",
      "body":"Huwag agad humingi ng random amount. Magsimula sa totoong gastos ng bata. Mas grounded at mas madaling i-verify ang usapan kapag malinaw ang listahan.",
      "step_number":3,
      "items":[
        "Pagkain, gatas, vitamins, at basic hygiene",
        "School expenses, tuition, uniforms, modules, pamasahe, at supplies",
        "Medical expenses, gamot, checkups, therapy, o hospital costs",
        "Rent, utilities, o shared household costs na konektado sa bata",
        "Receipts, screenshots, payment slips, at written estimates"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'child-support-evidence-checklist'),
    'step',
    6,
    $${
      "title":"Organize support history and missed payments",
      "body":"Separate what was promised, what was actually given, and what was missed. This helps avoid emotional back-and-forth and shows the pattern clearly.",
      "step_number":4,
      "items":[
        "Bank or e-wallet transfer records",
        "Receipts or cash acknowledgment messages",
        "Dates and amounts of support received",
        "Dates and amounts missed or reduced",
        "Messages where support was promised, refused, delayed, or conditioned"
      ]
    }$$::jsonb,
    $${
      "title":"Ayusin ang support history at missed payments",
      "body":"Paghiwalayin kung ano ang ipinangako, ano ang totoong naibigay, at ano ang hindi naibigay. Nakakatulong ito para hindi puro emosyon ang usapan at malinaw ang pattern.",
      "step_number":4,
      "items":[
        "Bank o e-wallet transfer records",
        "Receipts o cash acknowledgment messages",
        "Mga petsa at amount ng support na natanggap",
        "Mga petsa at amount na hindi naibigay o nabawasan",
        "Messages kung saan may promise, refusal, delay, o kondisyon sa support"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'child-support-evidence-checklist'),
    'step',
    7,
    $${
      "title":"Ask for clarification before escalation if it is safe",
      "body":"If there is no threat or violence, a calm written request can clarify whether the issue is confusion, lost job, disagreement, or refusal. Keep the message factual and child-focused.",
      "step_number":5,
      "items":[
        "State the child's current needs and the amount needed",
        "Ask what amount and schedule the other parent can commit to",
        "Ask for payment through a traceable method if possible",
        "Avoid insults, threats, or public shaming",
        "Save the reply or lack of reply"
      ]
    }$$::jsonb,
    $${
      "title":"Magtanong muna nang malinaw bago mag-escalate kung safe",
      "body":"Kung walang threat o violence, makakatulong ang mahinahong written request para malaman kung confusion, nawalan ng trabaho, disagreement, o refusal ang dahilan. Gawing factual at child-focused ang message.",
      "step_number":5,
      "items":[
        "Sabihin ang current needs ng bata at amount na kailangan",
        "Itanong kung anong amount at schedule ang kayang i-commit ng kabilang magulang",
        "Kung kaya, humingi ng payment through traceable method",
        "Iwasan ang insulto, banta, o public shaming",
        "I-save ang reply o kawalan ng reply"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'child-support-evidence-checklist'),
    'mistake',
    8,
    $${
      "title":"Common mistakes that make the case harder to explain",
      "body":"These mistakes are understandable when you are tired or angry, but they can make it harder for an official helper to separate facts from conflict.",
      "items":[
        "Mixing child expenses with unrelated personal arguments",
        "Deleting messages, receipts, or transfer records",
        "Posting sensitive documents online",
        "Asking only for a large round amount without expense details",
        "Signing verbal or written agreements without a copy",
        "Going to an office without a timeline or basic documents"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang pagkakamali na nagpapahirap ipaliwanag ang kaso",
      "body":"Naiintindihan ang mga pagkakamaling ito kapag pagod o galit, pero pinapahirap nitong ihiwalay ng official helper ang facts sa conflict.",
      "items":[
        "Hinahalo ang child expenses sa ibang personal arguments",
        "Binubura ang messages, receipts, o transfer records",
        "Pino-post online ang sensitive documents",
        "Humihingi lang ng malaking round amount na walang expense details",
        "Pumipirma sa verbal o written agreement nang walang copy",
        "Pumupunta sa office nang walang timeline o basic documents"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'child-support-evidence-checklist'),
    'warning',
    9,
    $${
      "title":"Know when this may need official protection or legal help",
      "body":"Non-support, threats, harassment, or economic abuse concerns should be discussed with the proper official channel. Do not diagnose your own case from social media. Bring the proof and ask what route applies.",
      "severity":"high",
      "items":[
        "If there is violence, threat, stalking, or coercion, prioritize safety",
        "If support is deliberately withheld to control or harm, ask about VAWC or economic abuse routes",
        "If parentage is denied, ask what proof or process is needed",
        "If you cannot afford a private lawyer, ask PAO if you qualify for assistance",
        "If the child is at immediate risk, ask DSWD, barangay, police, or a trusted official help desk"
      ]
    }$$::jsonb,
    $${
      "title":"Alamin kung kailan kailangan ng official protection o legal help",
      "body":"Ang non-support, threats, harassment, o economic abuse concerns ay dapat itanong sa tamang official channel. Huwag i-diagnose ang sariling kaso base sa social media. Dalhin ang proof at itanong kung anong route ang applicable.",
      "severity":"high",
      "items":[
        "Kung may violence, threat, stalking, o coercion, unahin ang safety",
        "Kung sinasadyang i-withhold ang support para kontrolin o saktan, itanong ang VAWC o economic abuse routes",
        "Kung dini-deny ang parentage, itanong kung anong proof o process ang kailangan",
        "Kung hindi kaya ang private lawyer, itanong sa PAO kung qualified ka for assistance",
        "Kung immediate risk ang bata, lumapit sa DSWD, barangay, police, o trusted official help desk"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'child-support-evidence-checklist'),
    'tip',
    10,
    $${
      "title":"Sample message before asking for official help",
      "body":"Use this only if it is safe to contact the other parent. Keep it calm and child-focused.",
      "sample":"Hi. I am organizing our child's support needs. This month, the main expenses are food, school, and medical needs totaling around ____. Can you confirm what amount and schedule you can provide starting ____? Please send through a traceable method so we both have a record. If we cannot agree, I may ask an official office what process applies."
    }$$::jsonb,
    $${
      "title":"Sample message bago humingi ng official help",
      "body":"Gamitin lang ito kung safe makipag-contact sa kabilang magulang. Gawing calm at child-focused.",
      "sample":"Hi. Inaayos ko ang support needs ng anak natin. Ngayong buwan, ang main expenses ay pagkain, school, at medical needs na umaabot sa around ____. Puwede mo bang i-confirm kung anong amount at schedule ang kaya mong ibigay starting ____? Pakisend sana through traceable method para pareho tayong may record. Kung hindi tayo magka-agree, magtatanong ako sa official office kung anong process ang applicable."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'child-support-evidence-checklist'),
    'related',
    11,
    $${
      "title":"Related guides to open next",
      "body":"Child support issues often connect to solo parent benefits, official messages, and evidence collection. These guides can help you prepare without rushing.",
      "items":[
        "Solo Parent Benefits Checklist",
        "Office Help Message Checklist",
        "Barangay Complaint Evidence Checklist",
        "Unpaid Salary / Kulang Sahod Checklist"
      ]
    }$$::jsonb,
    $${
      "title":"Related guides na puwedeng buksan pagkatapos",
      "body":"Madalas konektado ang child support issues sa solo parent benefits, official messages, at evidence collection. Makakatulong ang mga guide na ito para makapaghanda nang hindi nagmamadali.",
      "items":[
        "Solo Parent Benefits Checklist",
        "Office Help Message Checklist",
        "Barangay Complaint Evidence Checklist",
        "Unpaid Salary / Kulang Sahod Checklist"
      ]
    }$$::jsonb
  );
