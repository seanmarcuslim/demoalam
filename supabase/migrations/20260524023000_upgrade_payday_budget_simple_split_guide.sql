update public.guides
set
  title_en = 'Payday budget split before spending',
  title_fil = 'Payday budget split bago gumastos',
  tagline_en = 'Divide your salary before it disappears into bills, transfers, loans, cravings, and emergency requests.',
  tagline_fil = 'Hatiin muna ang sweldo bago ito mawala sa bills, transfers, utang, cravings, at biglaang hingi.',
  read_time_min = 6,
  estimated_time = '20-30 minuto',
  estimated_cost = 'Libre',
  difficulty = 'madali',
  is_featured = false,
  is_urgent = false,
  tags = array[
    'money',
    'budget',
    'payday',
    'salary',
    'savings',
    'debt',
    'emergency fund',
    'first job',
    'bank account',
    'online lending'
  ],
  keywords_en = 'payday budget salary sweldo money split savings emergency fund bills rent food transport debt utang loan online lending wants needs bank account payroll first job cash envelope spend tracker',
  keywords_fil = 'payday budget sweldo sahod pera hati savings ipon emergency fund bills renta pagkain pamasahe utang loan online lending luho needs bank account payroll unang trabaho cash envelope gastos tracker',
  official_sources = '[
    {"title":"Financial Products and Services","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/Pages/InclusiveFinance/FinancialProductsServices.aspx"},
    {"title":"Financial Inclusion","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/SitePages/InclusiveFinance/InclusiveFinance.aspx"},
    {"title":"Online lenders barred from harvesting borrowers phone and social-media contact list","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/online-lenders-barred-from-harvesting-borrowers-phone-and-social-media-contact-list-says-privacy-commission/"},
    {"title":"Public Advisory on Online Lending Platforms","publisher":"DICT, NPC, and SEC","url":"https://privacy.gov.ph/wp-content/uploads/2026/03/DICT-NPC-SEC-Public-Advisory-on-Online-Lending-Platforms.pdf"}
  ]'::jsonb,
  updated_at = now()
where slug = 'payday-budget-simple-split';

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'payday-budget-simple-split'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'what_to_know',
    1,
    $${
      "title":"Payday feels big only before the money has a job",
      "body":"A salary can disappear fast when bills, family requests, food, transport, online shopping, subscriptions, debt, and small treats all pull from the same account. The point of a payday split is not to be perfect. It is to decide the order before emotion, pressure, or cravings decide for you.",
      "items":[
        "There is no perfect percentage for every salary",
        "Fixed bills and food should be separated before wants",
        "Debt payments need a plan, not panic",
        "A small emergency fund matters even if it starts tiny",
        "Money for wants is safer after essentials are already protected"
      ]
    }$$::jsonb,
    $${
      "title":"Mukhang malaki lang ang sweldo bago magkaroon ng trabaho ang pera",
      "body":"Mabilis mawala ang sweldo kapag bills, hingi ng pamilya, pagkain, pamasahe, online shopping, subscriptions, utang, at small treats ay galing lahat sa iisang account. Hindi goal ng payday split na maging perfect. Ang goal ay ikaw ang magdesisyon ng order bago pa emotion, pressure, o cravings ang magdesisyon para sa iyo.",
      "items":[
        "Walang perfect percentage para sa lahat ng sweldo",
        "Ihiwalay muna ang fixed bills at pagkain bago wants",
        "Kailangan ng plan ang utang, hindi panic",
        "Mahalaga ang maliit na emergency fund kahit paunti-unti lang",
        "Mas safe gumastos sa wants kapag protected na ang essentials"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'warning',
    2,
    $${
      "title":"Do not borrow just to protect a lifestyle after payday",
      "body":"If your money is short every payday, pause before using online loans, salary advances, or buy-now-pay-later offers. Fast cash can become a cycle if fees, penalties, and collection pressure are unclear.",
      "severity":"high",
      "items":[
        "Do not borrow before listing bills and due dates",
        "Do not install loan apps that demand contacts, photos, or broad phone access",
        "Do not use another loan to hide the first loan",
        "Do not let shame stop you from asking the lender for official payment options",
        "Do not send OTP, PIN, bank login, or payroll access to anyone offering help"
      ]
    }$$::jsonb,
    $${
      "title":"Huwag umutang para lang panatilihin ang lifestyle pagkatapos ng payday",
      "body":"Kung laging kulang ang pera tuwing payday, huminto muna bago gumamit ng online loans, salary advance, o buy-now-pay-later offers. Puwedeng maging cycle ang fast cash kapag malabo ang fees, penalties, at collection pressure.",
      "severity":"high",
      "items":[
        "Huwag umutang bago ilista ang bills at due dates",
        "Huwag mag-install ng loan apps na humihingi ng contacts, photos, o malawak na phone access",
        "Huwag gumamit ng panibagong loan para itago ang unang loan",
        "Huwag hayaang pigilan ka ng hiya sa paghingi ng official payment options sa lender",
        "Huwag mag-send ng OTP, PIN, bank login, o payroll access sa kahit sinong nag-aalok ng tulong"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'step',
    3,
    $${
      "title":"Write the real take-home amount",
      "body":"Start with the money that actually arrived, not your gross salary. Use net pay after deductions, cash advances, payroll loans, or previous unpaid balances.",
      "step_number":1,
      "items":[
        "Net pay received",
        "Cash on hand",
        "Money already committed before payday",
        "Automatic deductions or bank fees",
        "Expected delayed money, if any"
      ]
    }$$::jsonb,
    $${
      "title":"Isulat ang totoong take-home amount",
      "body":"Magsimula sa perang totoong pumasok, hindi sa gross salary. Gamitin ang net pay pagkatapos ng deductions, cash advances, payroll loans, o dating unpaid balances.",
      "step_number":1,
      "items":[
        "Net pay na natanggap",
        "Cash on hand",
        "Pera na committed na bago payday",
        "Automatic deductions o bank fees",
        "Expected delayed money kung meron"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'step',
    4,
    $${
      "title":"Separate survival money first",
      "body":"Before transfers and treats, protect the costs that keep you able to work and live until the next payday.",
      "step_number":2,
      "items":[
        "Food and groceries",
        "Transport to work or school",
        "Rent or housing share",
        "Utilities, load, internet, or water",
        "Medicine or required health expenses",
        "Required family contribution if this is non-negotiable"
      ]
    }$$::jsonb,
    $${
      "title":"Ihiwalay muna ang survival money",
      "body":"Bago transfers at treats, protektahan muna ang gastos na kailangan para makapasok sa trabaho o school at mabuhay hanggang next payday.",
      "step_number":2,
      "items":[
        "Pagkain at groceries",
        "Pamasahe papuntang work o school",
        "Renta o share sa bahay",
        "Utilities, load, internet, o tubig",
        "Gamot o required health expenses",
        "Required family contribution kung hindi negotiable"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'step',
    5,
    $${
      "title":"Pay or schedule obligations before wants",
      "body":"Bills and debts become heavier when ignored. If you cannot pay full amount, still write the due date and ask for official options instead of hiding.",
      "step_number":3,
      "items":[
        "Rent, utilities, phone, internet, subscriptions",
        "Debt minimums or agreed payments",
        "School or family obligations",
        "Bank account maintaining balance if needed",
        "Calendar reminders three days before due dates",
        "Official payment channels only"
      ]
    }$$::jsonb,
    $${
      "title":"Bayaran o i-schedule muna ang obligations bago wants",
      "body":"Mas bumibigat ang bills at utang kapag iniiwasan. Kung hindi kayang bayaran nang buo, isulat pa rin ang due date at magtanong ng official options imbes na magtago.",
      "step_number":3,
      "items":[
        "Renta, utilities, phone, internet, subscriptions",
        "Debt minimums o agreed payments",
        "School o family obligations",
        "Bank account maintaining balance kung kailangan",
        "Calendar reminders tatlong araw bago due dates",
        "Official payment channels lang"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'step',
    6,
    $${
      "title":"Keep a small protected amount for emergencies",
      "body":"Do not wait until you can save a big amount. Even a small protected balance can prevent panic borrowing for load, medicine, transport, or an urgent document.",
      "step_number":4,
      "items":[
        "Start with any amount you can repeat",
        "Keep it separate from spending money if possible",
        "Do not use it for cravings or sales",
        "Use it only for real interruptions",
        "Refill it first on the next payday if used"
      ]
    }$$::jsonb,
    $${
      "title":"Magtabi ng maliit na protected amount para sa emergency",
      "body":"Huwag hintayin na malaki agad ang maiipon. Kahit maliit na protected balance ay puwedeng makaiwas sa panic borrowing para sa load, gamot, pamasahe, o urgent document.",
      "step_number":4,
      "items":[
        "Magsimula sa kahit anong amount na kaya mong ulitin",
        "Ihiwalay sa spending money kung kaya",
        "Huwag gamitin sa cravings o sale",
        "Gamitin lang sa totoong interruption",
        "Kapag nagamit, unahin itong punuin ulit sa next payday"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'step',
    7,
    $${
      "title":"Give wants a limit, not a guilt trip",
      "body":"A budget that bans all enjoyment usually fails. Give yourself a small planned amount after essentials, obligations, and emergency money are separated.",
      "step_number":5,
      "items":[
        "Food treats",
        "Online shopping",
        "Gaming, streaming, or subscriptions",
        "Dates or hangouts",
        "Small personal reward",
        "A hard stop amount"
      ]
    }$$::jsonb,
    $${
      "title":"Bigyan ng limit ang wants, hindi guilt trip",
      "body":"Madalas bumibigay ang budget na bawal lahat ng enjoyment. Maglaan ng maliit na planned amount pagkatapos maihiwalay ang essentials, obligations, at emergency money.",
      "step_number":5,
      "items":[
        "Food treats",
        "Online shopping",
        "Gaming, streaming, o subscriptions",
        "Dates o hangouts",
        "Small personal reward",
        "Hard stop amount"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'mistake',
    8,
    $${
      "title":"Common payday mistakes",
      "body":"These are common because payday feels like relief. The problem is when relief spends the money before responsibilities are named.",
      "items":[
        "Treating gross salary as spendable money",
        "Paying wants before food, transport, and due dates",
        "Keeping all money in one spending account",
        "Ignoring small subscriptions and transfer fees",
        "Using online loans to cover unplanned wants",
        "Sending money under pressure without checking your own budget",
        "Not tracking what happened after payday"
      ]
    }$$::jsonb,
    $${
      "title":"Karaniwang payday mistakes",
      "body":"Common ito dahil parang relief ang payday. Ang problema, nauuna ang relief gumastos bago mapangalanan ang responsibilities.",
      "items":[
        "Iniisip na spendable ang gross salary",
        "Nauuna ang wants bago pagkain, pamasahe, at due dates",
        "Lahat ng pera nasa isang spending account",
        "Hindi pinapansin ang small subscriptions at transfer fees",
        "Gumagamit ng online loans para sa unplanned wants",
        "Nagpapadala ng pera under pressure kahit hindi pa checked ang sariling budget",
        "Hindi tinatrack kung saan napunta ang pera after payday"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'tip',
    9,
    $${
      "title":"Simple split checklist",
      "body":"Use this every payday before spending.",
      "items":[
        "I wrote my real take-home pay",
        "I separated food and transport",
        "I listed bills and due dates",
        "I scheduled debt payments or asked for official options",
        "I kept a small emergency amount",
        "I set a limit for wants",
        "I did not borrow for cravings",
        "I left enough money until next payday"
      ]
    }$$::jsonb,
    $${
      "title":"Simple split checklist",
      "body":"Gamitin ito tuwing payday bago gumastos.",
      "items":[
        "Naisulat ko ang totoong take-home pay",
        "Naihiwalay ko ang pagkain at pamasahe",
        "Nailista ko ang bills at due dates",
        "Na-schedule ko ang debt payments o nagtanong ng official options",
        "May maliit akong emergency amount",
        "May limit ang wants ko",
        "Hindi ako umutang para sa cravings",
        "May natira hanggang next payday"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'tip',
    10,
    $${
      "title":"Sample payday note",
      "body":"Copy this into Notes and fill it in.",
      "sample":"Payday amount: ____. Food/transport: ____. Bills due before next payday: ____. Debt payments: ____. Emergency money: ____. Wants limit: ____. Money that must not be touched: ____."
    }$$::jsonb,
    $${
      "title":"Sample payday note",
      "body":"Kopyahin ito sa Notes at punan.",
      "sample":"Payday amount: ____. Pagkain/pamasahe: ____. Bills due bago next payday: ____. Bayad utang: ____. Emergency money: ____. Wants limit: ____. Pera na hindi dapat galawin: ____."
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'payday-budget-simple-split'),
    'tip',
    11,
    $${
      "title":"What to expect",
      "body":"The first split may feel uncomfortable because it shows the truth. That is useful. If the money is not enough, the answer is not pretending. Reduce one expense, delay one want, ask for an official payment arrangement, or plan income earlier. The goal is progress every payday, not perfection."
    }$$::jsonb,
    $${
      "title":"Ano ang aasahan",
      "body":"Puwedeng uncomfortable ang unang split dahil pinapakita nito ang totoo. Useful iyon. Kung kulang ang pera, hindi sagot ang magpanggap. Bawasan ang isang gastos, i-delay ang isang want, magtanong ng official payment arrangement, o magplano ng income nang mas maaga. Progress tuwing payday ang goal, hindi perfection."
    }$$::jsonb
  );
