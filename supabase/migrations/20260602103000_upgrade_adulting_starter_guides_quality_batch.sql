-- Upgrade thin Adulting starter guides from 1-section placeholders into practical guides.
-- Targets only:
-- - renting-first-time-checklist
-- - first-time-utility-bills
-- - moving-out-budget
-- No schema changes.

update public.guides
set
  title_en = 'Renting for the first time checklist',
  title_fil = 'Checklist sa unang pag-upa',
  tagline_en = 'Check rent, deposits, contract terms, utility rules, and move-in proof before paying or signing.',
  tagline_fil = 'I-check ang rent, deposits, contract terms, utility rules, at move-in proof bago magbayad o pumirma.',
  read_time_min = 7,
  estimated_time = '1-2 araw',
  estimated_cost = 'Usually 1 month advance plus deposit',
  difficulty = 'katamtaman',
  is_featured = false,
  is_urgent = false,
  tags = array['renting','apartment','bedspace','deposit','contract','utilities','tenant','landlord','rent control','adulting'],
  keywords_en = 'renting first time apartment bedspace boarding house deposit advance rent contract lease tenant landlord rent control act ra 9653 utilities meralco water move in inspection eviction sublease',
  keywords_fil = 'renting unang upa apartment bedspace boarding house deposit advance rent kontrata lease tenant landlord rent control act ra 9653 utilities kuryente tubig move in inspection paalis sublease',
  official_sources = '[
    {"title":"Republic Act No. 9653 - Rent Control Act of 2009","publisher":"Lawphil","url":"https://lawphil.net/statutes/repacts/ra2009/ra_9653_2009.html"},
    {"title":"Rent Control Covering January 1, 2025 to December 31, 2026","publisher":"Department of Human Settlements and Urban Development","url":"https://dhsud.gov.ph/laws-and-issuances-2/policies-and-other-advisories/nhsb-policies/"},
    {"title":"Republic Act 11201 - DHSUD Legal FAQs","publisher":"Department of Human Settlements and Urban Development","url":"https://dhsud.gov.ph/republic-act-11201/"}
  ]'::jsonb,
  updated_at = now()
where slug = 'renting-first-time-checklist';

delete from public.guide_sections
where guide_id = (select id from public.guides where slug = 'renting-first-time-checklist');

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  ((select id from public.guides where slug = 'renting-first-time-checklist'),'what_to_know',1,
    $${
      "title":"Renting is not just finding a cheap room",
      "body":"The first cheap place can become expensive if the rules are unclear. Before paying, understand the total move-in cash, deposit rules, utility setup, house rules, repair responsibility, and what proof you will receive.",
      "items":["Ask the full move-in amount before visiting","Clarify advance rent, deposit, and refund rules","Read the contract before paying reservation money","Check utility, internet, visitor, curfew, cooking, and laundry rules","Document the room condition before moving in"]
    }$$::jsonb,
    $${
      "title":"Ang pag-upa ay hindi lang paghahanap ng murang room",
      "body":"Puwedeng maging mahal ang unang murang place kapag malabo ang rules. Bago magbayad, alamin ang total move-in cash, deposit rules, utility setup, house rules, repair responsibility, at anong proof ang matatanggap mo.",
      "items":["Itanong ang full move-in amount bago bumisita","Linawin ang advance rent, deposit, at refund rules","Basahin ang contract bago magbayad ng reservation","I-check ang utility, internet, visitor, curfew, cooking, at laundry rules","I-document ang condition ng room bago lumipat"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'renting-first-time-checklist'),'warning',2,
    $${
      "title":"Do not pay without proof, contract terms, and identity of the lessor",
      "body":"Rental scams often use urgency, fake listings, or vague ownership. If the person avoids showing the unit, refuses receipts, or pressures you to send money quickly, pause.",
      "severity":"high",
      "items":["Do not send reservation money before verifying the unit exists","Ask who owns or manages the place","Get a receipt for reservation, deposit, and rent","Avoid paying to personal accounts without written proof of purpose","Do not sign blank pages or unclear house rules"]
    }$$::jsonb,
    $${
      "title":"Huwag magbayad nang walang proof, contract terms, at identity ng lessor",
      "body":"Madalas gumagamit ang rental scams ng urgency, fake listings, o malabong ownership. Kung ayaw ipakita ang unit, ayaw magbigay ng resibo, o minamadali kang magpadala ng pera, huminto muna.",
      "severity":"high",
      "items":["Huwag mag-send ng reservation money bago ma-verify na existing ang unit","Itanong kung sino ang owner o manager","Humingi ng resibo para sa reservation, deposit, at rent","Iwasang magbayad sa personal account nang walang written proof ng purpose","Huwag pumirma sa blank pages o malabong house rules"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'renting-first-time-checklist'),'step',3,
    $${
      "title":"Ask the total move-in cost",
      "body":"Do not ask only for monthly rent. Ask for the full amount needed before you can sleep there legally and safely.",
      "step_number":1,
      "items":["Monthly rent","Advance rent","Security deposit","Utility deposit or meter deposit","Association dues, keys, internet, parking, or bedspace fees","Refund conditions and deductions"]
    }$$::jsonb,
    $${
      "title":"Itanong ang total move-in cost",
      "body":"Huwag monthly rent lang ang itanong. Alamin ang buong amount bago ka makatulog doon nang legal at safe.",
      "step_number":1,
      "items":["Monthly rent","Advance rent","Security deposit","Utility deposit o meter deposit","Association dues, keys, internet, parking, o bedspace fees","Refund conditions at deductions"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'renting-first-time-checklist'),'step',4,
    $${
      "title":"Check the unit before signing",
      "body":"Visit if possible. Photos can hide leaks, weak locks, noisy surroundings, poor signal, pests, and unsafe wiring.",
      "step_number":2,
      "items":["Door lock, windows, lights, outlets, water pressure","Leaks, drainage, mold, pests, and smell","Phone signal and internet availability","Flooding history and transport access","Safety at night and emergency exits"]
    }$$::jsonb,
    $${
      "title":"I-check ang unit bago pumirma",
      "body":"Bumisita kung kaya. Puwedeng maitago ng photos ang tagas, mahihinang lock, ingay, mahinang signal, peste, at delikadong wiring.",
      "step_number":2,
      "items":["Door lock, windows, ilaw, outlets, water pressure","Tagas, drainage, amag, peste, at amoy","Phone signal at internet availability","Flooding history at access sa transport","Safety sa gabi at emergency exits"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'renting-first-time-checklist'),'step',5,
    $${
      "title":"Get the important terms in writing",
      "body":"Verbal promises are hard to prove later. Write down payment dates, rules, repairs, deposit return, and early move-out terms.",
      "step_number":3,
      "items":["Rent amount and due date","Deposit and refund rules","Minimum stay or lock-in period","Who pays electricity, water, internet, repairs, and dues","Visitor, curfew, pets, cooking, and laundry rules","Notice period before moving out"]
    }$$::jsonb,
    $${
      "title":"Ilagay sa written form ang important terms",
      "body":"Mahirap patunayan later ang verbal promises. Isulat ang payment dates, rules, repairs, deposit return, at early move-out terms.",
      "step_number":3,
      "items":["Rent amount at due date","Deposit at refund rules","Minimum stay o lock-in period","Sino ang magbabayad ng kuryente, tubig, internet, repairs, at dues","Visitor, curfew, pets, cooking, at laundry rules","Notice period bago umalis"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'renting-first-time-checklist'),'mistake',6,
    $${
      "title":"Common first-renter mistakes",
      "body":"Most problems come from rushing because the place looks affordable.",
      "items":["Paying before seeing the unit or proof of authority","Ignoring utility and internet rules","Not taking move-in photos or videos","Assuming deposit is automatically refundable in full","Not asking who handles repairs","Accepting house rules only after payment"]
    }$$::jsonb,
    $${
      "title":"Karaniwang mistakes ng first-time renter",
      "body":"Madalas nanggagaling ang problema sa pagmamadali dahil mukhang affordable ang place.",
      "items":["Nagbabayad bago makita ang unit o proof of authority","Hindi chine-check ang utility at internet rules","Walang move-in photos o videos","Inaakalang automatic full refund ang deposit","Hindi nagtatanong kung sino ang gagawa ng repairs","Tinatanggap ang house rules after payment na"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'renting-first-time-checklist'),'tip',7,
    $${
      "title":"Before paying checklist",
      "body":"Use this before sending reservation money or signing.",
      "items":["I saw the unit or verified it safely","I know the total move-in cash","I know deposit refund conditions","I received written terms or contract","I have receipt details ready","I took photos or videos of the unit","I understand utility and house rules"]
    }$$::jsonb,
    $${
      "title":"Checklist bago magbayad",
      "body":"Gamitin ito bago mag-send ng reservation money o pumirma.",
      "items":["Nakita ko ang unit o na-verify ito safely","Alam ko ang total move-in cash","Alam ko ang deposit refund conditions","May written terms o contract ako","May receipt details ako","May photos o videos ako ng unit","Naiintindihan ko ang utility at house rules"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'renting-first-time-checklist'),'tip',8,
    $${
      "title":"Sample message before paying",
      "body":"Ask this before sending money.",
      "sample":"Hi, before I pay reservation/deposit, can you send the written terms: monthly rent, advance, deposit, refund rules, utility payment setup, house rules, and official receipt details? I would also like to inspect the unit and document its condition before move-in."
    }$$::jsonb,
    $${
      "title":"Sample message bago magbayad",
      "body":"Itanong ito bago mag-send ng pera.",
      "sample":"Hi po, bago po ako magbayad ng reservation/deposit, puwede po bang makahingi ng written terms: monthly rent, advance, deposit, refund rules, utility payment setup, house rules, at official receipt details? Gusto ko rin po sanang ma-inspect ang unit at ma-document ang condition bago move-in."
    }$$::jsonb);

update public.guides
set
  title_en = 'First utility bills checklist',
  title_fil = 'Checklist sa unang bayarin sa kuryente, tubig, at internet',
  tagline_en = 'Understand electricity, water, internet, deposits, due dates, and disconnection risks before your first bill surprises you.',
  tagline_fil = 'Intindihin ang kuryente, tubig, internet, deposits, due dates, at disconnection risks bago ka mabigla sa unang bill.',
  read_time_min = 7,
  estimated_time = '30-60 minuto',
  estimated_cost = 'Depends on provider and usage',
  difficulty = 'madali',
  is_featured = false,
  is_urgent = false,
  tags = array['utility bills','electricity','water','internet','meralco','maynilad','bill deposit','due date','disconnection','adulting'],
  keywords_en = 'utility bills electricity water internet meralco maynilad bill deposit meter due date disconnection reconnection consumption kwh cubic meter residential consumer rights magna carta adulting',
  keywords_fil = 'utility bills kuryente tubig internet meralco maynilad bill deposit metro due date putol disconnection reconnection konsumo residential consumer rights magna carta adulting',
  official_sources = '[
    {"title":"Rights and Responsibilities of Residential Electricity Consumers","publisher":"Department of Energy","url":"https://legacy.doe.gov.ph/consumer-connect/rights-and-responsibilities-residential-electricity-consumers"},
    {"title":"Magna Carta for Residential Electricity Consumers","publisher":"Supreme Court E-Library / ERC","url":"https://elibrary.judiciary.gov.ph/thebookshelf/showdocs/11/39112"},
    {"title":"Meralco Service Application","publisher":"Meralco","url":"https://www.meralco.com.ph/residential/electric-service/start-or-modify/start-service"},
    {"title":"Maynilad FAQs","publisher":"Maynilad Water Services","url":"https://www.mayniladwater.com.ph/contact-us/faqs/"}
  ]'::jsonb,
  updated_at = now()
where slug = 'first-time-utility-bills';

delete from public.guide_sections
where guide_id = (select id from public.guides where slug = 'first-time-utility-bills');

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  ((select id from public.guides where slug = 'first-time-utility-bills'),'what_to_know',1,
    $${
      "title":"Utility bills are part usage, part rules",
      "body":"Your bill is not only about how much you use. It also depends on due dates, meter reading, deposits, unpaid balances, reconnection rules, provider coverage, and whether the account is under your name, landlord, or building.",
      "items":["Know whose name is on the account","Ask how meter reading and sharing works","Track due dates before penalties or disconnection","Keep receipts and reference numbers","Report issues through official channels"]
    }$$::jsonb,
    $${
      "title":"Ang utility bills ay hindi lang usage, may rules din",
      "body":"Hindi lang konsumo ang dahilan ng bill. Depende rin ito sa due dates, meter reading, deposits, unpaid balances, reconnection rules, provider coverage, at kung kanino nakapangalan ang account: sa iyo, landlord, o building.",
      "items":["Alamin kung kanino nakapangalan ang account","Itanong paano ang meter reading at sharing","I-track ang due dates bago penalty o disconnection","Itago ang receipts at reference numbers","Official channels ang gamitin sa reports"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'first-time-utility-bills'),'warning',2,
    $${
      "title":"Do not ignore notices, estimated bills, or sudden high usage",
      "body":"A small bill issue can become bigger if you wait until service is disconnected. If the bill suddenly changes, ask for explanation early and keep proof.",
      "severity":"high",
      "items":["Do not wait until disconnection notice becomes urgent","Do not pay through random agents or unverified links","Do not ignore shared-meter disputes","Do not assume the landlord paid unless you have proof","Do not share OTP or account login to someone offering bill help"]
    }$$::jsonb,
    $${
      "title":"Huwag balewalain ang notices, estimated bills, o biglang taas ng usage",
      "body":"Puwedeng lumaki ang maliit na bill issue kapag hinintay mo pang maputulan. Kung biglang nagbago ang bill, magtanong agad at magtabi ng proof.",
      "severity":"high",
      "items":["Huwag hintayin maging urgent ang disconnection notice","Huwag magbayad sa random agents o unverified links","Huwag balewalain ang shared-meter disputes","Huwag i-assume na bayad na ng landlord kung walang proof","Huwag mag-share ng OTP o account login sa nag-aalok ng bill help"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'first-time-utility-bills'),'step',3,
    $${
      "title":"Identify who controls each utility",
      "body":"Before move-in or first bill, clarify if the account is direct, submetered, shared, prepaid, or included in rent.",
      "step_number":1,
      "items":["Electricity account name and meter number","Water account name and meter/submeter setup","Internet owner, lock-in period, and modem responsibility","Garbage, association dues, and building fees","Who receives notices and official bills"]
    }$$::jsonb,
    $${
      "title":"Alamin kung sino ang may control ng bawat utility",
      "body":"Bago move-in o unang bill, linawin kung direct account, submetered, shared, prepaid, o included sa rent.",
      "step_number":1,
      "items":["Electricity account name at meter number","Water account name at meter/submeter setup","Internet owner, lock-in period, at modem responsibility","Basura, association dues, at building fees","Sino ang tumatanggap ng notices at official bills"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'first-time-utility-bills'),'step',4,
    $${
      "title":"Take opening readings and photos",
      "body":"On move-in day, record meter readings and condition. This protects you from paying for usage before you arrived.",
      "step_number":2,
      "items":["Electric meter reading","Water meter or submeter reading","Photos of meter numbers","Screenshot or copy of last bill if available","Written agreement on starting balance"]
    }$$::jsonb,
    $${
      "title":"Kunan ang opening readings at photos",
      "body":"Sa move-in day, i-record ang meter readings at condition. Proteksyon ito para hindi mo mabayaran ang usage bago ka dumating.",
      "step_number":2,
      "items":["Electric meter reading","Water meter o submeter reading","Photos ng meter numbers","Screenshot o copy ng last bill kung meron","Written agreement sa starting balance"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'first-time-utility-bills'),'step',5,
    $${
      "title":"Build a due-date and receipt habit",
      "body":"Bills become stressful when due dates are scattered. Put them in one note or calendar.",
      "step_number":3,
      "items":["Provider name and account number","Due date and cutoff date","Usual monthly range","Official payment channels","Receipt/reference number folder","Hotline or support page"]
    }$$::jsonb,
    $${
      "title":"Gumawa ng due-date at receipt habit",
      "body":"Nakaka-stress ang bills kapag kalat ang due dates. Ilagay sila sa isang note o calendar.",
      "step_number":3,
      "items":["Provider name at account number","Due date at cutoff date","Usual monthly range","Official payment channels","Receipt/reference number folder","Hotline o support page"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'first-time-utility-bills'),'mistake',6,
    $${
      "title":"Common first utility bill mistakes",
      "body":"These are easy to miss when you are focused on moving in.",
      "items":["No opening meter reading","No receipt for shared bills","Not asking if internet has lock-in fees","Ignoring estimated or unusually high bills","Using unofficial payment links","Not saving account numbers and support channels"]
    }$$::jsonb,
    $${
      "title":"Karaniwang first utility bill mistakes",
      "body":"Madaling makaligtaan ito kapag busy sa paglipat.",
      "items":["Walang opening meter reading","Walang receipt sa shared bills","Hindi tinanong kung may internet lock-in fees","Binalewala ang estimated o sobrang taas na bills","Gumamit ng unofficial payment links","Hindi sinave ang account numbers at support channels"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'first-time-utility-bills'),'tip',7,
    $${
      "title":"Utility setup checklist",
      "body":"Use this before your first billing cycle.",
      "items":["I know who receives each bill","I took opening meter photos","I know due dates and payment channels","I know who pays deposits and reconnection fees","I saved receipts and account numbers","I know how to report outage, leak, billing issue, or disconnection notice"]
    }$$::jsonb,
    $${
      "title":"Utility setup checklist",
      "body":"Gamitin ito bago ang first billing cycle.",
      "items":["Alam ko kung sino ang tumatanggap ng bawat bill","May opening meter photos ako","Alam ko ang due dates at payment channels","Alam ko kung sino ang magbabayad ng deposits at reconnection fees","Na-save ko ang receipts at account numbers","Alam ko paano mag-report ng outage, leak, billing issue, o disconnection notice"]
    }$$::jsonb);

update public.guides
set
  title_en = 'Moving out budget checklist',
  title_fil = 'Budget checklist para bumukod',
  tagline_en = 'Estimate rent, deposits, utilities, food, transport, and emergency cash before leaving home.',
  tagline_fil = 'I-estimate ang rent, deposits, utilities, pagkain, pamasahe, at emergency cash bago bumukod.',
  read_time_min = 7,
  estimated_time = '1-2 oras',
  estimated_cost = 'Depends on rent and location',
  difficulty = 'katamtaman',
  is_featured = false,
  is_urgent = false,
  tags = array['moving out','budget','rent','utilities','adulting','first job','emergency fund','deposit','food','transport'],
  keywords_en = 'moving out budget rent deposit advance utility bills food transport emergency fund first job salary sweldo adulting apartment bedspace dorm expenses checklist',
  keywords_fil = 'bumukod moving out budget renta deposit advance utility bills pagkain pamasahe emergency fund unang trabaho sweldo adulting apartment bedspace dorm gastos checklist',
  official_sources = '[
    {"title":"Republic Act No. 9653 - Rent Control Act of 2009","publisher":"Lawphil","url":"https://lawphil.net/statutes/repacts/ra2009/ra_9653_2009.html"},
    {"title":"Financial Products and Services","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/Pages/InclusiveFinance/FinancialProductsServices.aspx"},
    {"title":"Meralco Service Application","publisher":"Meralco","url":"https://www.meralco.com.ph/residential/electric-service/start-or-modify/start-service"},
    {"title":"Maynilad FAQs","publisher":"Maynilad Water Services","url":"https://www.mayniladwater.com.ph/contact-us/faqs/"}
  ]'::jsonb,
  updated_at = now()
where slug = 'moving-out-budget';

delete from public.guide_sections
where guide_id = (select id from public.guides where slug = 'moving-out-budget');

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  ((select id from public.guides where slug = 'moving-out-budget'),'what_to_know',1,
    $${
      "title":"Moving out is a cash-flow test, not just a rent decision",
      "body":"The monthly rent may look affordable, but the first month often includes deposit, advance rent, transport, food setup, cleaning items, bedding, utilities, and emergency money. If you only budget rent, you may end up borrowing in the first week.",
      "items":["Estimate move-in cash before choosing a place","Separate one-time setup costs from monthly costs","Keep emergency money untouched","Do not move out based only on gross salary","Plan food, transport, and utilities realistically"]
    }$$::jsonb,
    $${
      "title":"Ang pagbukod ay cash-flow test, hindi rent decision lang",
      "body":"Mukhang affordable ang monthly rent, pero ang first month madalas may deposit, advance rent, pamasahe, food setup, cleaning items, bedding, utilities, at emergency money. Kung rent lang ang budget, puwede kang mangutang agad sa first week.",
      "items":["I-estimate ang move-in cash bago pumili ng place","Paghiwalayin ang one-time setup costs at monthly costs","Huwag galawin ang emergency money","Huwag bumukod base lang sa gross salary","Planuhin nang realistic ang pagkain, pamasahe, at utilities"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'moving-out-budget'),'warning',2,
    $${
      "title":"Do not move out with zero buffer",
      "body":"Even if rent is paid, one delayed salary, sickness, lost phone, sudden bill, or job issue can break your plan. A small buffer is not extra; it is part of the moving-out cost.",
      "severity":"high",
      "items":["Do not spend the full first salary on move-in costs","Do not rely only on expected overtime or side income","Do not ignore deposit refund delays","Do not borrow from high-pressure lenders for furniture or wants","Do not sign a place you cannot sustain for at least two paydays"]
    }$$::jsonb,
    $${
      "title":"Huwag bumukod nang zero buffer",
      "body":"Kahit bayad ang rent, puwedeng masira ang plano dahil sa delayed salary, sakit, lost phone, biglaang bill, o job issue. Hindi extra ang maliit na buffer; parte ito ng moving-out cost.",
      "severity":"high",
      "items":["Huwag ubusin ang first salary sa move-in costs","Huwag umasa lang sa expected overtime o side income","Huwag balewalain ang deposit refund delays","Huwag umutang sa high-pressure lenders para sa furniture o wants","Huwag pumirma sa place na hindi kaya for at least two paydays"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'moving-out-budget'),'step',3,
    $${
      "title":"Calculate move-in cash",
      "body":"Write the cash needed before day one. This is different from monthly budget.",
      "step_number":1,
      "items":["Advance rent","Security deposit","Reservation fee if any","Transport or moving cost","Basic bedding and cooking items","Initial groceries and cleaning supplies","Utility deposits or setup fees"]
    }$$::jsonb,
    $${
      "title":"Kalkulahin ang move-in cash",
      "body":"Isulat ang perang kailangan bago day one. Iba ito sa monthly budget.",
      "step_number":1,
      "items":["Advance rent","Security deposit","Reservation fee kung meron","Pamasahe o moving cost","Basic bedding at cooking items","Initial groceries at cleaning supplies","Utility deposits o setup fees"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'moving-out-budget'),'step',4,
    $${
      "title":"Estimate monthly survival cost",
      "body":"Use conservative numbers, not best-case numbers. If you underestimate food and transport, the budget fails quickly.",
      "step_number":2,
      "items":["Rent or bedspace fee","Electricity, water, internet, load","Food and groceries","Transport to work or school","Laundry and hygiene","Medicine and health needs","Family contribution or debt payments"]
    }$$::jsonb,
    $${
      "title":"I-estimate ang monthly survival cost",
      "body":"Gumamit ng conservative numbers, hindi best-case numbers. Kapag minamaliit ang pagkain at pamasahe, mabilis bumigay ang budget.",
      "step_number":2,
      "items":["Rent o bedspace fee","Kuryente, tubig, internet, load","Pagkain at groceries","Pamasahe papuntang work o school","Laundry at hygiene","Gamot at health needs","Family contribution o bayad utang"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'moving-out-budget'),'step',5,
    $${
      "title":"Stress-test the plan",
      "body":"Ask what happens if one thing goes wrong. If the plan collapses immediately, adjust before moving.",
      "step_number":3,
      "items":["What if salary is delayed one week?","What if electricity or water is higher than expected?","What if phone is lost or needs repair?","What if you need to go home urgently?","What if the landlord delays deposit return?"]
    }$$::jsonb,
    $${
      "title":"I-stress-test ang plano",
      "body":"Itanong kung ano ang mangyayari kapag may isang pumalya. Kung agad guguho ang plano, ayusin muna bago lumipat.",
      "step_number":3,
      "items":["Paano kung delayed ang sweldo ng one week?","Paano kung mas mataas ang kuryente o tubig?","Paano kung mawala o masira ang phone?","Paano kung kailangan umuwi urgently?","Paano kung delayed ang deposit return?"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'moving-out-budget'),'mistake',6,
    $${
      "title":"Common moving-out budget mistakes",
      "body":"These mistakes make people feel independent for one week and trapped by the second payday.",
      "items":["Budgeting rent only","Buying furniture before emergency cash","Ignoring utility deposits and setup fees","Choosing a place far from work to save rent but losing money on transport","No food plan","No written agreement for deposit and bills"]
    }$$::jsonb,
    $${
      "title":"Karaniwang moving-out budget mistakes",
      "body":"Dahil dito, may freedom sa first week pero trapped na by second payday.",
      "items":["Rent lang ang binudget","Bumili ng furniture bago emergency cash","Hindi sinama ang utility deposits at setup fees","Pumili ng malayo para makamura sa rent pero talo sa pamasahe","Walang food plan","Walang written agreement sa deposit at bills"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'moving-out-budget'),'tip',7,
    $${
      "title":"Moving-out budget checklist",
      "body":"Use this before committing to a place.",
      "items":["I know total move-in cash","I know monthly survival cost","I have emergency money separate","I checked commute cost and time","I understand rent, deposit, and bill rules","I can survive two paydays without borrowing for basics"]
    }$$::jsonb,
    $${
      "title":"Moving-out budget checklist",
      "body":"Gamitin ito bago mag-commit sa place.",
      "items":["Alam ko ang total move-in cash","Alam ko ang monthly survival cost","May separate emergency money ako","Na-check ko ang commute cost at time","Naiintindihan ko ang rent, deposit, at bill rules","Kaya ko ang two paydays nang hindi nangungutang para sa basics"]
    }$$::jsonb),
  ((select id from public.guides where slug = 'moving-out-budget'),'tip',8,
    $${
      "title":"Sample budget note",
      "body":"Copy this into Notes and fill it in before deciding.",
      "sample":"Move-in cash: ____. Monthly rent: ____. Utilities: ____. Food: ____. Transport: ____. Laundry/hygiene: ____. Debt/family obligations: ____. Emergency buffer: ____. Total monthly survival cost: ____."
    }$$::jsonb,
    $${
      "title":"Sample budget note",
      "body":"Kopyahin ito sa Notes at punan bago magdesisyon.",
      "sample":"Move-in cash: ____. Monthly rent: ____. Utilities: ____. Food: ____. Transport: ____. Laundry/hygiene: ____. Utang/family obligations: ____. Emergency buffer: ____. Total monthly survival cost: ____."
    }$$::jsonb);
