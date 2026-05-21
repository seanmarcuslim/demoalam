update public.guides
set
  title_en = 'Online loan red flags before you borrow',
  title_fil = 'Online loan red flags bago ka umutang',
  tagline_en = 'Check SEC registration, total repayment, app permissions, and collection risks before borrowing.',
  tagline_fil = 'I-check ang SEC registration, total repayment, app permissions, at collection risks bago umutang.',
  tags = array['loan', 'online lending', 'debt', 'money', 'utang', 'fees', 'ola', 'sec', 'data privacy', 'harassment'],
  keywords_en = 'loan online lending debt money fees ola sec data privacy harassment lending app collection total repayment borrower',
  keywords_fil = 'loan online lending utang pera fees ola sec data privacy harassment pautang lending app paniningil total repayment borrower',
  official_sources = '[
    {"title":"List of Recorded Online Lending Platforms","publisher":"Securities and Exchange Commission","url":"https://www.sec.gov.ph/lending-companies-and-financing-companies-2/list-of-recorded-online-lending-platforms/"},
    {"title":"Online lenders barred from harvesting borrowers phone and social-media contact list","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/online-lenders-barred-from-harvesting-borrowers-phone-and-social-media-contact-list-says-privacy-commission/"},
    {"title":"Joint press statement against illegal practices of online lending apps","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/joint-press-statement-of-the-national-privacy-commission-fintech-alliance-ph-philippine-finance-association-and-the-non-bank-financing-sector-against-illegal-practices-of-online-lending-apps/"}
  ]'::jsonb,
  updated_at = now()
where slug = 'loan-red-flags-before-borrowing';

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
    '{"title":"A fast loan can become expensive if you only look at cash received","body":"Before borrowing, check who is lending, the total amount you will repay, the due date, penalties, and what personal data the app wants from your phone."}'::jsonb,
    '{"title":"Pwedeng maging mahal ang mabilis na loan kung cash received lang ang titingnan","body":"Bago umutang, i-check kung sino ang nagpapautang, total na babayaran, due date, penalties, at anong personal data ang hinihingi ng app mula sa phone mo."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'warning',
    2,
    '{"title":"Do not continue if the app wants excessive phone access","body":"Be careful with loan apps that demand access to contacts, photos, files, or social media lists. The National Privacy Commission has warned against abusive online lending practices involving harassment and unauthorized use of personal data.","severity":"high"}'::jsonb,
    '{"title":"Huwag tumuloy kung sobra ang hinihinging phone access","body":"Mag-ingat sa loan apps na humihingi ng access sa contacts, photos, files, o social media lists. Nagbabala ang National Privacy Commission tungkol sa abusive online lending practices na may harassment at unauthorized use ng personal data.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'step',
    3,
    '{"title":"Verify the lender before applying","body":"Check if the lending or financing company and online lending platform are recorded with the SEC. Do this before sending IDs, selfies, bank details, or emergency contacts.","step_number":1,"items":["Search the lender name on the official SEC list","Check the app or platform name, not only the company logo","Look for a real company name, address, and contact details","Avoid lenders that only transact through chat accounts","Save screenshots of the loan offer and lender profile"]}'::jsonb,
    '{"title":"I-verify ang lender bago mag-apply","body":"I-check kung recorded sa SEC ang lending o financing company at online lending platform. Gawin ito bago mag-send ng IDs, selfies, bank details, o emergency contacts.","step_number":1,"items":["Hanapin ang lender name sa official SEC list","I-check ang app o platform name, hindi lang company logo","Hanapin ang totoong company name, address, at contact details","Iwasan ang lender na puro chat account lang ang transaction","I-save ang screenshots ng loan offer at lender profile"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'step',
    4,
    '{"title":"Calculate the real cost","body":"Do not decide based only on the amount released. Some loans deduct fees upfront, then still charge interest and penalties on a short deadline.","step_number":2,"items":["Cash you will actually receive","Processing or service fee deducted upfront","Total repayment amount","Due date and grace period","Late fee or penalty per day","Collection method if you miss payment"]}'::jsonb,
    '{"title":"Kalkulahin ang totoong gastos","body":"Huwag magdesisyon base lang sa amount na mare-release. May loans na may upfront deduction, pero may interest at penalties pa rin sa maikling deadline.","step_number":2,"items":["Cash na totoong matatanggap mo","Processing o service fee na ibabawas agad","Total repayment amount","Due date at grace period","Late fee o penalty kada araw","Collection method kapag na-delay ang bayad"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'step',
    5,
    '{"title":"Check privacy and collection behavior","body":"Before installing or submitting, review permissions and privacy notices. A lender should not need your entire contact list or gallery just to decide a loan.","step_number":3,"items":["Does the app request contacts?","Does it request photos, files, or messages?","Does it explain how your data will be used?","Does it threaten to message your contacts?","Can you contact support through official channels?"]}'::jsonb,
    '{"title":"I-check ang privacy at collection behavior","body":"Bago mag-install o mag-submit, basahin ang permissions at privacy notice. Hindi dapat kailangan ng lender ang buong contact list o gallery mo para magdesisyon sa loan.","step_number":3,"items":["Humihingi ba ng contacts ang app?","Humihingi ba ng photos, files, o messages?","Ipinaliwanag ba kung paano gagamitin ang data mo?","May threat ba na imessage ang contacts mo?","May official support channels ba?"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'tip',
    6,
    '{"title":"Ask one direct question before borrowing","body":"A trustworthy lender should be able to answer clearly before you agree.","sample":"Before I continue, please confirm the exact company name, SEC registration or recorded OLP details, amount I will receive, total amount I must repay, due date, all fees, penalties, and what phone permissions or personal data you require."}'::jsonb,
    '{"title":"Magtanong ng isang direct question bago umutang","body":"Dapat kayang sagutin nang malinaw ng trustworthy lender bago ka pumayag.","sample":"Before I continue, paki-confirm po ang exact company name, SEC registration o recorded OLP details, amount na matatanggap ko, total na babayaran ko, due date, lahat ng fees, penalties, at anong phone permissions o personal data ang required ninyo."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'loan-red-flags-before-borrowing'),
    'mistake',
    7,
    '{"title":"Borrowing because approval is fast","body":"Fast approval is not enough. If the loan has unclear fees, dangerous permissions, pressure tactics, or public-shaming threats, the risk may be bigger than the money you receive."}'::jsonb,
    '{"title":"Umutang dahil mabilis ang approval","body":"Hindi sapat na mabilis ang approval. Kung malabo ang fees, delikado ang permissions, may pressure tactics, o may threat na ipapahiya ka, mas malaki ang risk kaysa sa perang matatanggap mo."}'::jsonb
  );
