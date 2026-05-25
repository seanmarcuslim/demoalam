update public.guides
set
  title_en = 'Online loan red flags before you borrow',
  title_fil = 'Online loan red flags bago ka umutang',
  tagline_en = 'Check SEC records, total repayment, app permissions, collection tactics, and safer options before borrowing.',
  tagline_fil = 'I-check ang SEC records, total repayment, app permissions, paniningil, at safer options bago umutang.',
  read_time_min = 7,
  estimated_time = '15-30 minuto',
  estimated_cost = 'Libre mag-check',
  difficulty = 'katamtaman',
  is_urgent = true,
  tags = array['loan','online lending','debt','money','utang','fees','ola','sec','data privacy','harassment','collection','scam'],
  keywords_en = 'loan online lending debt money fees ola sec data privacy harassment lending app collection total repayment borrower contacts photos phone permissions loan agreement imessage complaint',
  keywords_fil = 'loan online lending utang pera fees ola sec data privacy harassment pautang lending app paniningil total repayment borrower contacts photos phone permissions loan agreement reklamo',
  official_sources = '[
    {"title":"List of Recorded Online Lending Platforms","publisher":"Securities and Exchange Commission","url":"https://www.sec.gov.ph/lending-companies-and-financing-companies-2/list-of-recorded-online-lending-platforms/"},
    {"title":"Advisory for Online Lending Platforms Borrowers","publisher":"Securities and Exchange Commission","url":"https://www.sec.gov.ph/wp-content/uploads/2023/10/2023advisory_For-Online-Lending-Platforms-Borrowers.pdf"},
    {"title":"Public Advisory on Online Lending Platforms","publisher":"DICT, NPC, and SEC","url":"https://privacy.gov.ph/wp-content/uploads/2026/03/DICT-NPC-SEC-Public-Advisory-on-Online-Lending-Platforms.pdf"},
    {"title":"Online lenders barred from harvesting borrowers phone and social-media contact list","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/online-lenders-barred-from-harvesting-borrowers-phone-and-social-media-contact-list-says-privacy-commission/"}
  ]'::jsonb,
  updated_at = now()
where slug = 'loan-red-flags-before-borrowing';

delete from public.guide_sections
where guide_id = (select id from public.guides where slug = 'loan-red-flags-before-borrowing');

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  ((select id from public.guides where slug = 'loan-red-flags-before-borrowing'),'what_to_know',1,
    $${
      "title":"Fast cash can become expensive when you ignore the full cost",
      "body":"Online loans can help in emergencies, but some apps use confusing fees, short due dates, aggressive collection, or excessive phone permissions. Before borrowing, check if the lender/platform is recorded, calculate the real repayment, and ask what data the app will access.",
      "items":["Amount released is not the same as total cost","Upfront deductions can make the loan more expensive than it looks","Short due dates can trigger penalties quickly","Abusive collection can involve harassment or misuse of personal data","A recorded platform still requires you to read the loan agreement carefully"]
    }$$::jsonb,
    $${
      "title":"Puwedeng maging mahal ang mabilis na pera kapag hindi chine-check ang full cost",
      "body":"Puwedeng makatulong ang online loans sa emergency, pero may apps na gumagamit ng malabong fees, maikling due dates, aggressive collection, o sobrang phone permissions. Bago umutang, i-check kung recorded ang lender/platform, kalkulahin ang totoong babayaran, at itanong kung anong data ang maa-access ng app.",
      "items":["Hindi pareho ang amount released at total cost","Puwedeng maging mahal ang loan dahil sa upfront deductions","Mabilis magka-penalty kapag maikli ang due date","Puwedeng mauwi sa harassment o misuse ng personal data ang abusive collection","Kahit recorded ang platform, kailangan pa ring basahin ang loan agreement"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'loan-red-flags-before-borrowing'),'warning',2,
    $${
      "title":"Stop if the app wants contacts, photos, files, or social accounts",
      "body":"Be very careful with loan apps that ask for broad access to contacts, gallery, files, messages, or social media. These permissions can be misused for shaming, threats, or unauthorized contact with people around you.",
      "severity":"high",
      "items":["Contacts or call logs","Photos, files, gallery, or storage","Messages or notification access","Social media account access","Threats to message your contacts if you miss payment","No clear privacy notice or company identity"]
    }$$::jsonb,
    $${
      "title":"Huminto kung humihingi ang app ng contacts, photos, files, o social accounts",
      "body":"Mag-ingat sa loan apps na humihingi ng malawak na access sa contacts, gallery, files, messages, o social media. Puwedeng magamit ito sa pamamahiya, pananakot, o unauthorized contact sa mga tao sa paligid mo.",
      "severity":"high",
      "items":["Contacts o call logs","Photos, files, gallery, o storage","Messages o notification access","Social media account access","Threat na imessage ang contacts mo kapag delayed ka","Walang malinaw na privacy notice o company identity"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'loan-red-flags-before-borrowing'),'step',3,
    $${
      "title":"Verify the company and platform first",
      "body":"Check the official SEC records before sending IDs, selfies, bank details, or emergency contacts. Verify both the company name and the app/platform name.",
      "step_number":1,
      "items":["Search the company name on the official SEC list","Check the online lending platform or app name","Look for real address, support channel, and company identity","Search for SEC advisories or complaints about the app","Avoid lenders that operate only through private chat"]
    }$$::jsonb,
    $${
      "title":"I-verify muna ang company at platform",
      "body":"I-check ang official SEC records bago mag-send ng IDs, selfies, bank details, o emergency contacts. I-verify ang company name at app/platform name.",
      "step_number":1,
      "items":["Hanapin ang company name sa official SEC list","I-check ang online lending platform o app name","Hanapin ang real address, support channel, at company identity","Maghanap ng SEC advisories o complaints tungkol sa app","Iwasan ang lenders na private chat lang ang operation"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'loan-red-flags-before-borrowing'),'step',4,
    $${
      "title":"Calculate the real repayment",
      "body":"Do not decide based on approval speed. Write the actual cash you receive and the total amount you must repay.",
      "step_number":2,
      "items":["Cash actually released to you","Processing, service, or platform fees","Interest and total repayment amount","Due date and grace period","Daily or late penalties","Collection process if delayed"]
    }$$::jsonb,
    $${
      "title":"Kalkulahin ang totoong babayaran",
      "body":"Huwag magdesisyon base sa bilis ng approval. Isulat ang totoong cash na matatanggap at total na babayaran.",
      "step_number":2,
      "items":["Cash na totoong mare-release sa iyo","Processing, service, o platform fees","Interest at total repayment amount","Due date at grace period","Daily o late penalties","Collection process kapag delayed"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'loan-red-flags-before-borrowing'),'step',5,
    $${
      "title":"Compare safer options before borrowing",
      "body":"If the loan is for a shortfall, check whether there is a less risky option before installing a questionable app.",
      "step_number":3,
      "items":["Ask for official payment extension or installment option","Reduce or delay a non-essential expense","Use emergency savings if available","Ask employer or billing provider for official options","Check government, school, or family assistance without giving app permissions","Borrow only the amount you can repay on time"]
    }$$::jsonb,
    $${
      "title":"I-compare muna ang safer options bago umutang",
      "body":"Kung pangkulang ang loan, i-check muna kung may less risky option bago mag-install ng kaduda-dudang app.",
      "step_number":3,
      "items":["Magtanong ng official payment extension o installment option","Bawasan o i-delay ang non-essential expense","Gamitin ang emergency savings kung meron","Magtanong sa employer o billing provider ng official options","I-check ang government, school, o family assistance nang hindi nagbibigay ng app permissions","Manghiram lang ng amount na kaya mong bayaran on time"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'loan-red-flags-before-borrowing'),'mistake',6,
    $${
      "title":"Common mistakes before borrowing",
      "body":"These mistakes usually happen because the borrower is embarrassed, rushed, or desperate.",
      "items":["Looking only at the cash released","Ignoring app permissions","Skipping the SEC/platform check","Using a second loan to cover the first loan","Deleting evidence of harassment or threats","Sharing bank login, OTP, ID selfies, or contacts under pressure","Borrowing for wants while bills and food are not planned"]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes bago umutang",
      "body":"Madalas nangyayari ito dahil nahihiya, minamadali, o desperado ang borrower.",
      "items":["Cash released lang ang tinitingnan","Hindi pinapansin ang app permissions","Hindi chine-check ang SEC/platform record","Gumagamit ng second loan para takpan ang first loan","Binubura ang evidence ng harassment o threats","Nagbibigay ng bank login, OTP, ID selfies, o contacts under pressure","Umutang para sa wants kahit hindi planado ang bills at pagkain"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'loan-red-flags-before-borrowing'),'tip',7,
    $${
      "title":"Loan safety checklist",
      "body":"Use this before submitting any application.",
      "items":["I checked the company and platform on official SEC sources","I know the cash I will receive and total repayment","I know the due date and penalties","I reviewed phone permissions","I saved screenshots of the offer and agreement","I did not share OTP, password, or bank login","I compared safer options first"]
    }$$::jsonb,
    $${
      "title":"Loan safety checklist",
      "body":"Gamitin ito bago mag-submit ng application.",
      "items":["Na-check ko ang company at platform sa official SEC sources","Alam ko ang cash na matatanggap at total repayment","Alam ko ang due date at penalties","Na-review ko ang phone permissions","Na-save ko ang screenshots ng offer at agreement","Hindi ako nag-share ng OTP, password, o bank login","Na-compare ko muna ang safer options"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'loan-red-flags-before-borrowing'),'tip',8,
    $${
      "title":"Sample question before borrowing",
      "body":"Ask this before continuing.",
      "sample":"Before I apply, please confirm the exact company name, SEC registration or recorded OLP details, app/platform name, cash I will receive, total repayment, due date, all fees, penalties, collection process, and phone permissions required."
    }$$::jsonb,
    $${
      "title":"Sample question bago umutang",
      "body":"Itanong ito bago tumuloy.",
      "sample":"Before I apply, paki-confirm po ang exact company name, SEC registration o recorded OLP details, app/platform name, cash na matatanggap ko, total repayment, due date, lahat ng fees, penalties, collection process, at required phone permissions."
    }$$::jsonb);

update public.guides
set
  title_en = 'Fake job offer checklist before you pay or send documents',
  title_fil = 'Fake job offer checklist bago magbayad o magpadala ng documents',
  tagline_en = 'Verify recruiter identity, fees, agency records, job orders, and contract details before trusting a job offer.',
  tagline_fil = 'I-verify ang recruiter identity, fees, agency records, job orders, at contract details bago magtiwala sa job offer.',
  read_time_min = 7,
  estimated_time = '15-30 minuto',
  estimated_cost = 'Libre mag-check',
  difficulty = 'katamtaman',
  is_urgent = true,
  tags = array['scam','job scam','work','recruiter','fees','trabaho','illegal recruitment','ofw','dmw','poea','placement fee','fake job'],
  keywords_en = 'fake job job scam illegal recruitment recruiter placement fee processing fee training fee ofw dmw poea contract visa tourist visa job order agency license facebook tiktok work abroad',
  keywords_fil = 'fake job job scam illegal recruitment recruiter placement fee processing fee training fee trabaho ofw dmw poea kontrata visa tourist visa job order agency license facebook tiktok abroad',
  official_sources = '[
    {"title":"Identify an illegal recruiter","publisher":"Department of Migrant Workers / POEA Archive","url":"https://dmw.gov.ph/archives/poea/air/identify.html"},
    {"title":"Modus Operandi of Illegal Recruiters","publisher":"Department of Migrant Workers / POEA Archive","url":"https://dmw.gov.ph/archives/poea/air/modus.html"},
    {"title":"Tips to job applicants using the internet in job search","publisher":"Department of Migrant Workers / POEA Archive","url":"https://dmw.gov.ph/archives/poea/air/internetscams.html"},
    {"title":"DMW warns public against illegal recruitment on Facebook and TikTok","publisher":"Philippine Information Agency","url":"https://pia.gov.ph/news/dmw-warns-public-against-illegal-recruitment-on-facebook-and-tiktok/"},
    {"title":"DMW cautions against overseas job scams on social media","publisher":"Philippine News Agency","url":"https://www.pna.gov.ph/articles/1233567"}
  ]'::jsonb,
  updated_at = now()
where slug = 'fake-job-offer-red-flags';

delete from public.guide_sections
where guide_id = (select id from public.guides where slug = 'fake-job-offer-red-flags');

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  ((select id from public.guides where slug = 'fake-job-offer-red-flags'),'what_to_know',1,
    $${
      "title":"A job offer is not real just because it sounds urgent",
      "body":"Fake recruiters often use high salary, fast deployment, direct-hire claims, tourist visa shortcuts, training fees, and private chat pressure. A real opportunity should survive verification.",
      "items":["High salary with vague employer details is a red flag","Fast deployment can be used to rush payment","A logo or edited certificate is not proof","Overseas work should be checked through DMW/POEA-related official channels","Local jobs should still have verifiable company identity and written terms"]
    }$$::jsonb,
    $${
      "title":"Hindi totoong trabaho agad porke urgent ang offer",
      "body":"Madalas gumamit ang fake recruiters ng mataas na sahod, mabilis na deployment, direct-hire claims, tourist visa shortcuts, training fees, at private chat pressure. Dapat kayang ma-verify ang totoong opportunity.",
      "items":["Red flag ang mataas na sahod pero vague ang employer details","Ginagamit ang fast deployment para madaliin ang payment","Hindi proof ang logo o edited certificate","Ang overseas work ay dapat chine-check sa DMW/POEA-related official channels","Kahit local job, dapat verifiable ang company identity at written terms"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'fake-job-offer-red-flags'),'warning',2,
    $${
      "title":"Do not pay or send sensitive documents before verification",
      "body":"Stop if the recruiter asks for processing fee, reservation fee, medical fee, training fee, placement fee, or passport/ID scans before you can verify the recruiter, agency, employer, and job order.",
      "severity":"high",
      "items":["Payment through personal e-wallet or bank account","Recruiter refuses office or agency verification","Tourist or visit visa suggested for work","No written contract or job order details","Pressure to submit passport, IDs, selfies, or birth certificates immediately","Guaranteed hiring if you pay today"]
    }$$::jsonb,
    $${
      "title":"Huwag magbayad o mag-send ng sensitive documents bago ma-verify",
      "body":"Huminto kung humihingi ng processing fee, reservation fee, medical fee, training fee, placement fee, o passport/ID scans bago mo ma-verify ang recruiter, agency, employer, at job order.",
      "severity":"high",
      "items":["Payment sa personal e-wallet o bank account","Ayaw magpa-verify sa office o agency","Tourist o visit visa ang sinasabi para sa work","Walang written contract o job order details","Pinapamadali ang passport, IDs, selfies, o birth certificates","Guaranteed hiring kapag nagbayad ka today"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'fake-job-offer-red-flags'),'step',3,
    $${
      "title":"Verify who is recruiting you",
      "body":"Ask for details you can independently check. A legitimate recruiter should not hide basic identity and authority.",
      "step_number":1,
      "items":["Recruiter full name and official role","Agency or company name","Office address and official contact details","License, registration, or authority details","Employer name and work location","Exact job title, salary, and contract terms"]
    }$$::jsonb,
    $${
      "title":"I-verify kung sino ang nagre-recruit sa iyo",
      "body":"Humingi ng details na kaya mong i-check independently. Hindi dapat itinatago ng legit recruiter ang identity at authority.",
      "step_number":1,
      "items":["Full name at official role ng recruiter","Agency o company name","Office address at official contact details","License, registration, o authority details","Employer name at work location","Exact job title, salary, at contract terms"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'fake-job-offer-red-flags'),'step',4,
    $${
      "title":"Check the offer against red flags",
      "body":"Slow down when the offer asks you to skip normal verification steps.",
      "step_number":2,
      "items":["Very high salary for unclear work","Payment before contract or deployment","Meetup in mall, cafe, terminal, or chat only","No employer website or official email trail","Tourist visa, visit visa, or student visa for work","Recruiter asks you to recruit more applicants","Job post uses copied logos but no verifiable office"]
    }$$::jsonb,
    $${
      "title":"I-check ang offer laban sa red flags",
      "body":"Huminto kapag pinapalampas ka ng offer sa normal verification steps.",
      "step_number":2,
      "items":["Sobrang taas na sahod para sa malabong work","Bayad bago contract o deployment","Meetup sa mall, cafe, terminal, o chat lang","Walang employer website o official email trail","Tourist visa, visit visa, o student visa para sa work","Pinapahanap ka ng recruiter ng iba pang applicants","May copied logos pero walang verifiable office"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'fake-job-offer-red-flags'),'step',5,
    $${
      "title":"Verify through official channels before sending documents",
      "body":"Open official websites yourself. Do not rely on screenshots, forwarded links, or private chat claims.",
      "step_number":3,
      "items":["Search official agency or employer website yourself","Use official phone, email, or office address","For overseas jobs, check DMW/POEA-related official verification resources","Ask if the exact job order or employer is authorized","Save screenshots, names, numbers, payment requests, and job post links"]
    }$$::jsonb,
    $${
      "title":"Mag-verify sa official channels bago magpadala ng documents",
      "body":"Ikaw mismo ang magbukas ng official websites. Huwag umasa sa screenshots, forwarded links, o private chat claims.",
      "step_number":3,
      "items":["Hanapin mismo ang official agency o employer website","Gamitin ang official phone, email, o office address","Para sa overseas jobs, i-check ang DMW/POEA-related official verification resources","Itanong kung authorized ang exact job order o employer","I-save ang screenshots, names, numbers, payment requests, at job post links"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'fake-job-offer-red-flags'),'mistake',6,
    $${
      "title":"Common mistakes jobseekers make under pressure",
      "body":"Scammers exploit urgency, hope, and embarrassment. These mistakes are common, especially when someone badly needs work.",
      "items":["Trusting a recruiter because they use a logo","Paying a fee to reserve a slot","Sending passport or IDs before verification","Accepting tourist visa work arrangements","Not asking for written contract details","Deleting chats after realizing it may be a scam","Not telling family or trusted friends because of shame"]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes ng jobseekers under pressure",
      "body":"Sinasamantala ng scammers ang urgency, pag-asa, at hiya. Common ito lalo na kapag kailangan na kailangan ng trabaho.",
      "items":["Nagtitiwala dahil may logo ang recruiter","Nagbabayad para ma-reserve ang slot","Nagpapadala ng passport o IDs bago verification","Tumatanggap ng tourist visa work arrangement","Hindi humihingi ng written contract details","Binubura ang chats kapag na-realize na scam","Hindi nagsasabi sa family o trusted friends dahil nahihiya"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'fake-job-offer-red-flags'),'tip',7,
    $${
      "title":"Job offer safety checklist",
      "body":"Use this before paying or sending documents.",
      "items":["I verified the recruiter and agency/company identity","I verified the employer and job details independently","I have written terms or contract details","I did not pay a personal account","I did not send passport/ID scans before verification","I saved screenshots and contact details","I asked a trusted person to review the offer"]
    }$$::jsonb,
    $${
      "title":"Job offer safety checklist",
      "body":"Gamitin ito bago magbayad o mag-send ng documents.",
      "items":["Na-verify ko ang recruiter at agency/company identity","Na-verify ko independently ang employer at job details","May written terms o contract details ako","Hindi ako nagbayad sa personal account","Hindi ako nag-send ng passport/ID scans bago verification","Na-save ko ang screenshots at contact details","May trusted person akong pinakita ang offer"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'fake-job-offer-red-flags'),'tip',8,
    $${
      "title":"Sample verification message",
      "body":"Ask this before sending money or documents.",
      "sample":"Before I submit documents or payment, please send the complete agency/company name, official office address, recruiter full name and role, employer name, exact job title, contract terms, job order or vacancy link, and official receipt/payment policy. I will verify these through official channels first."
    }$$::jsonb,
    $${
      "title":"Sample verification message",
      "body":"Itanong ito bago mag-send ng pera o documents.",
      "sample":"Before I submit documents or payment, paki-send po ang complete agency/company name, official office address, recruiter full name and role, employer name, exact job title, contract terms, job order o vacancy link, at official receipt/payment policy. Ive-verify ko po muna ito through official channels."
    }$$::jsonb);
