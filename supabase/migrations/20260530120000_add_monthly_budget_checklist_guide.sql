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
  'monthly-budget-checklist-families',
  (select id from public.categories where slug = 'money'),
  'Monthly budget checklist for Filipino families',
  'Monthly budget checklist para sa pamilyang Pilipino',
  'List your income, expenses, debt, and goals each month to avoid payday crisis and stay ahead of bills.',
  'I-list ang income, gastos, utang, at goals bawat buwan para maiwasan ang payday crisis at manatiling ahead sa bills.',
  true,
  false,
  true,
  8,
  'madali',
  '20-30 minuto',
  'Libre',
  array['budget','money','monthly','family','expenses','income','planning','financial planning','payday','bills','debt'],
  'monthly budget family budget checklist expense tracking income bills expenses rent food transport utilities debt goals savings 50-30-20 rule budget planning personal finance money management cash flow petsa de peligro shortfall paycheck salary sweldo',
  'monthly budget pamilya budget checklist tracking gastos income bills expenses renta pagkain transport kuryente tubig utang goals savings 50-30-20 rule budget planning pera management cash flow petsa de peligro kulang sweldo sahod',
  '[
    {"title":"Money Management and Personal Finance","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/Pages/InclusiveFinance/MoneyManagementAndPersonalFinance.aspx"},
    {"title":"Financial Wellness: Getting Started with Money Management","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/Pages/InclusiveFinance/GettingStarted.aspx"},
    {"title":"Basic Financial Planning","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/Pages/InclusiveFinance/FinancialPlanning.aspx"},
    {"title":"Budgeting and Expense Tracking","publisher":"Financial Management Bureau","url":"https://www.fmb.gov.ph/index.php?id=financial-literacy"},
    {"title":"Personal Financial Management Guide","publisher":"Bangko Sentral ng Pilipinas","url":"https://www.bsp.gov.ph/SitePages/InclusiveFinance/InclusiveFinance.aspx"}
  ]'::jsonb,
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
  published_at = excluded.published_at,
  updated_at = now();

delete from public.guide_sections
where guide_id = (
  select id from public.guides
  where slug = 'monthly-budget-checklist-families'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'monthly-budget-checklist-families'),
    'what_to_know',
    1,
    $${
      "title":"A monthly budget is just a plan of what happens to your money before it disappears",
      "body":"You don't need fancy tools or spreadsheets to budget. You need 20-30 minutes at the start of the month to write down what money is coming in, where it must go (rent, food, transport, bills), what you owe, and what little bit you can save or use for extra things. When you know the plan, you can make choices instead of surprises.",
      "items":[
        "Income = all money coming in (salary, side income, remittance, allowance, loans, selling things)",
        "Essentials = must-pay expenses (rent, food, transport, electricity, water, medicines, minimum debt payment)",
        "Goals = small goals (savings, emergency fund, birthday, school supplies) or big goals (house, travel, education)",
        "Debt = money you owe monthly (loan, credit card, utang sa tao, installment)",
        "Leftover = what's left after essentials and debt; this is your flexibility money",
        "Write it down. Memory fails, but a list doesn't."
      ]
    }$$::jsonb,
    $${
      "title":"Ang monthly budget ay plano lang kung ano ang mangyayari sa pera mo bago mawala",
      "body":"Hindi kailangan ng fancy tools o spreadsheets para mag-budget. Kailangan mo lang ng 20-30 minuto sa simula ng buwan para isulat kung anong pera ang papasok, saan dapat pumunta (renta, pagkain, pamasahe, bills), ano ang iyong utang, at ano ang kaunting maiipon o magagamit sa extra. Kapag alam mo ang plano, pwede kang mag-decide sa halip na ma-surprise.",
      "items":[
        "Income = lahat ng pera na papasok (sweldo, side income, remittance, allowance, loan, selling things)",
        "Essentials = kailangang bayaran (renta, pagkain, pamasahe, kuryente, tubig, gamot, minimum debt payment)",
        "Goals = maliit na goals (ipon, emergency fund, birthday, school supplies) o malalaking goals (bahay, travel, education)",
        "Debt = pera na iyong utang bawat buwan (loan, credit card, utang sa tao, installment)",
        "Leftover = natira pagkatapos ng essentials at debt; ito ang flexibility money mo",
        "Isulat mo. Nakakalimutan ng isip, pero ang listahan ay hindi."
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'monthly-budget-checklist-families'),
    'warning',
    2,
    $${
      "title":"The biggest budget mistake is waiting until money is gone to realize it's gone",
      "body":"Most Filipino families don't budget because they think it's depressing or means they're poor. Wrong. Not knowing where your money goes is what makes you poor. Budgeting is just saying 'this 50 pesos goes here, that 50 pesos goes there' so you stay in control instead of panicking on day 25 when you're short.",
      "severity":"high",
      "items":[
        "If you don't know where your money goes, you can't protect it from disappearing",
        "No budget = no plan = surprise crisis = panic borrowing = debt spiral",
        "Small leaks sink big ships: 100 pesos daily snacks = 3000 pesos monthly",
        "Budgeting doesn't mean poverty; it means power",
        "Your budget will change month to month (that's normal)",
        "The best budget is the one you actually do, not the perfect one you never start"
      ]
    }$$::jsonb,
    $${
      "title":"Ang pinakamalaking budget mistake ay maghintay hanggang mawala na ang pera para maramdaman",
      "body":"Karamihan ng pamilyang Pilipino ay hindi nag-budget dahil iniisip nila na nakakadepressing o sign na mahirap ang buhay. Mali. Ang hindi mo pag-alam kung saan napupunta ang pera mo ang nagpapahirap. Ang budgeting ay lang 'ang 50 pisong ito dito, ang 50 pisong ito doon' para manatili kang in control sa halip na mag-panic sa day 25 pag kulang.",
      "severity":"high",
      "items":[
        "Kung hindi mo alam kung saan napupunta ang pera mo, hindi mo ito mapoprotektahan.",
        "Walang budget = walang plano = surprise crisis = panic borrow = utang spiral",
        "Small leaks ay naglubog ng malalaking barko: 100 pesos daily snacks = 3000 pesos monthly",
        "Ang budgeting ay hindi sign ng kahirapan; ito ay sign ng power",
        "Ang budget mo ay magbabago buwan-buwan (normal lang yan)",
        "Ang best budget ay ang ginagawa mo talaga, hindi ang perfect na hindi mo sisimulan"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'monthly-budget-checklist-families'),
    'step',
    3,
    $${
      "title":"Step 1: Write down all money coming in this month (INCOME)",
      "body":"Don't forget irregular income like bonuses, selling things, side gigs, or help from family. Write down the likely minimum if it changes. This is your total money to work with for the whole month.",
      "items":[
        "Main salary or wages (yours, spouse, working family members)",
        "Side income (freelance, small business, part-time, selling stuff)",
        "Remittance from family working abroad",
        "Allowance from parents or family support",
        "Loan or advance (write it down; you'll need to pay it back)",
        "Selling things (phone, clothes, furniture, appliances)",
        "Government assistance (if any)",
        "Other money coming in"
      ]
    }$$::jsonb,
    $${
      "title":"Step 1: Isulat lahat ng pera na papasok ngayong buwan (INCOME)",
      "body":"Huwag palampasin ang irregular income tulad ng bonus, pagbebenta, side gigs, o tulong ng pamilya. Isulat ang likely minimum kung nagbabago. Ito ang total na pera na mayroon ka para sa whole month.",
      "items":[
        "Main salary o wages (mo, spouse, working family members)",
        "Side income (freelance, small business, part-time, selling stuff)",
        "Remittance mula sa pamilya na nagtatrabaho abroad",
        "Allowance mula sa parents o family support",
        "Loan o advance (isulat mo; kailangan mo ito bayaran)",
        "Pagbebenta ng things (phone, clothes, furniture, appliances)",
        "Government assistance (kung may)",
        "Iba pang pera na papasok"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'monthly-budget-checklist-families'),
    'step',
    4,
    $${
      "title":"Step 2: List MUST-PAY expenses (essentials first)",
      "body":"These are the things that will cause real problems if you skip them: eviction, hunger, no power, overdue debt. Write these down with their due dates. This is the money that has to be protected.",
      "items":[
        "Rent or mortgage (day it's due)",
        "Food for the month (groceries, market)",
        "Transportation (gas, jeepney, train, tricycle)",
        "Electricity bill (amount and day due)",
        "Water bill (amount and day due)",
        "Medicines and health expenses (if chronic)",
        "Minimum debt payment (credit card, loan, utang)",
        "School fees or supplies (if studying)",
        "Childcare if working parents need it"
      ]
    }$$::jsonb,
    $${
      "title":"Step 2: I-list ang MUST-PAY expenses (essentials first)",
      "body":"Ito ang things na magkakaroon ng tunay na problema kung hindi mo babayaran: eviction, gutom, walang kuryente, overdue debt. Isulat ang mga ito with their due dates. Ito ang pera na kailangang protektahan.",
      "items":[
        "Renta o mortgage (day it's due)",
        "Pagkain para sa buwan (groceries, market)",
        "Transportation (gas, jeepney, train, tricycle)",
        "Electricity bill (amount at day due)",
        "Water bill (amount at day due)",
        "Gamot at health expenses (kung may chronic)",
        "Minimum debt payment (credit card, loan, utang)",
        "School fees o supplies (kung may schooling)",
        "Childcare kung working parents may kailangan"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'monthly-budget-checklist-families'),
    'step',
    5,
    $${
      "title":"Step 3: List your DEBT payments (everything you owe, due dates)",
      "body":"Credit cards, personal loans, installments, utang sa kaibigan - everything. Put the due date next to each one. If you can't pay the full amount, at least pay the minimum to keep from getting in worse trouble. Never skip debt payments; it compounds fast.",
      "items":[
        "Credit card (amount due, payment date)",
        "Personal loans (amount due, payment date)",
        "Installment payments (appliances, phone, gadgets)",
        "Utang to family or friends (agreed amount, agreed date)",
        "Informal loans (5-6, hulugan, etc.)",
        "School loans or student debt",
        "Medical debt (hospital, doctor)",
        "Overdue debt or penalty (if any)"
      ]
    }$$::jsonb,
    $${
      "title":"Step 3: I-list ang DEBT payments (lahat na iyong utang, due dates)",
      "body":"Credit cards, personal loans, installments, utang sa kaibigan - lahat. Ilagay ang due date next sa bawat isa. Kung hindi mo kaya ang full amount, at least bayaran ang minimum para maiwasan ang mas worse trouble. Never skip debt payments; lumalaki ng mabilis.",
      "items":[
        "Credit card (amount due, payment date)",
        "Personal loans (amount due, payment date)",
        "Installment payments (appliances, phone, gadgets)",
        "Utang to family o friends (agreed amount, agreed date)",
        "Informal loans (5-6, hulugan, etc.)",
        "School loans o student debt",
        "Medical debt (hospital, doctor)",
        "Overdue debt o penalty (kung may)"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'monthly-budget-checklist-families'),
    'step',
    6,
    $${
      "title":"Step 4: Do the math: Can you pay for essentials and debt with your income?",
      "body":"Add up essentials. Add up debt. Subtract from income. If the answer is negative (you can't cover it), you have a real problem that needs solving - not next month, now. Possible fixes: reduce expenses, increase income, or talk to creditors about payment terms.",
      "items":[
        "Essential expenses total = ?",
        "Debt payments total = ?",
        "Essentials + Debt = Total needs",
        "Total income - Total needs = Leftover (or shortfall)",
        "If shortfall: This is urgent; you need to talk to creditors or cut expenses now",
        "If leftover: Good; this is your flexibility money"
      ]
    }$$::jsonb,
    $${
      "title":"Step 4: Gawin ang math: Kaya mo bang magbayad ng essentials at debt with income?",
      "body":"Idagdag ang essentials. Idagdag ang debt. Bawasan sa income. Kung ang answer ay negative (hindi mo kaya), mayroon kang tunay na problema na kailangan solusyonan - hindi next month, ngayon. Possible fixes: reduce expenses, increase income, o kausap ang creditors about payment terms.",
      "items":[
        "Essential expenses total = ?",
        "Debt payments total = ?",
        "Essentials + Debt = Total needs",
        "Total income - Total needs = Leftover (o shortfall)",
        "Kung shortfall: Urgent ito; kailangan mong kausap ang creditors o cut expenses ngayon",
        "Kung leftover: Maganda; ito ang flexibility money mo"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'monthly-budget-checklist-families'),
    'step',
    7,
    $${
      "title":"Step 5: Allocate leftover money to GOALS and EXTRAS",
      "body":"If you have money left after essentials and debt, decide what happens to it now, before you spend it. A common method is: 50% needs (essentials), 30% wants (entertainment, clothes, dining out), 20% savings (emergency fund, goals). Adjust for your reality, but the idea is: have a plan.",
      "items":[
        "50% of income = Essentials and debt (already covered in Steps 1-4)",
        "30% of income = Wants (food treats, entertainment, clothes, hobbies, dining out, gifts)",
        "20% of income = Savings or goals (emergency fund, school fund, birthday savings, appliance fund)",
        "Your ratio might be different (60-30-10 or 40-40-20); adjust for your family",
        "The key: allocate it before you spend it, not after"
      ]
    }$$::jsonb,
    $${
      "title":"Step 5: Ibigay ang leftover money sa GOALS at EXTRAS",
      "body":"Kung may natira pang pera pagkatapos ng essentials at debt, magdesisyon kung ano ang mangyayari dito, bago mo gastusin. Ang common method ay: 50% needs (essentials), 30% wants (entertainment, clothes, dining out), 20% savings (emergency fund, goals). Adjust sa reality mo, pero ang idea ay: may plano.",
      "items":[
        "50% ng income = Essentials at debt (covered na sa Steps 1-4)",
        "30% ng income = Wants (food treats, entertainment, clothes, hobbies, dining out, gifts)",
        "20% ng income = Savings o goals (emergency fund, school fund, birthday savings, appliance fund)",
        "Ang ratio mo ay puwedeng iba (60-30-10 o 40-40-20); adjust sa pamilya mo",
        "Ang key: allocate bago mo gastusin, hindi pagkatapos"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'monthly-budget-checklist-families'),
    'tip',
    8,
    $${
      "title":"Make a simple list and keep it visible",
      "body":"Write your budget on paper, in a notes app, or even on your wall. Look at it on payday, mid-month, and before you spend money. This one habit - keeping the budget visible - is the single most useful thing you can do to stay on track.",
      "items":[
        "Paper notebook, phone notes, or a whiteboard on the wall",
        "List: Income, Essentials due dates, Debt due dates, Leftover",
        "Check it on payday (confirm your income)",
        "Check it mid-month (are you on pace?)",
        "Check it before big purchases (can you afford this?)",
        "Update it when surprises happen (bonus, emergency, unexpected expense)"
      ]
    }$$::jsonb,
    $${
      "title":"Gumawa ng simple list at panatilihing visible",
      "body":"Isulat ang budget mo sa paper, sa notes app, o kahit sa wall. Tingnan mo ito sa payday, mid-month, at bago ka gumastos. Ang one habit na ito - keeping budget visible - ang single most useful thing na pwede mo gawin para manatiling on track.",
      "items":[
        "Paper notebook, phone notes, o whiteboard sa wall",
        "List: Income, Essentials due dates, Debt due dates, Leftover",
        "Check ito sa payday (confirm ang income mo)",
        "Check ito mid-month (on pace ba?)",
        "Check ito bago mag-big purchases (kaya mo bang afford?)",
        "Update kapag may surprises (bonus, emergency, unexpected expense)"
      ]
    }$$::jsonb
  ),
  (
    (select id from public.guides where slug = 'monthly-budget-checklist-families'),
    'tip',
    9,
    $${
      "title":"If money is short, fix it now - don't wait for payday crisis",
      "body":"If you see in Step 4 that you can't cover essentials and debt, don't panic and don't wait. Talk to your creditors about payment plans. Cut small expenses now (food, transportation, entertainment) while you figure out the bigger solution. Ask for extra work or a side gig. But do something - waiting makes it worse.",
      "items":[
        "Can't make debt payment? Call creditor and explain; many offer payment plans",
        "Can't cover rent? Talk to landlord early; they often work with you",
        "Can't cover food? Reduce grocery items or use government food programs if available",
        "Need more income? Ask for extra hours, weekend work, or side gigs",
        "Never borrow from online loan apps if essentials are short - this starts the debt spiral",
        "Small fixes now prevent big crisis later"
      ]
    }$$::jsonb,
    $${
      "title":"Kung kulang ang pera, ayusin ngayon - huwag maghintay ng payday crisis",
      "body":"Kung makikita mo sa Step 4 na hindi mo kaya ang essentials at debt, huwag mag-panic at huwag maghintay. Kausap ang creditors mo about payment plans. Bawasan ang small expenses ngayon (food, transportation, entertainment) habang nag-figure out ng bigger solution. Humingi ng extra work o side gig. Pero gumawa ng something - waiting makes worse.",
      "items":[
        "Hindi kaya bayaran ang debt? Call creditor at explain; maraming may payment plans",
        "Hindi kaya bayaran ang renta? Kausap ang landlord early; karamihan ay nakikipagtulungan",
        "Hindi kaya bayaran ang pagkain? Bawasan ang grocery items o gamitin ang government food programs kung may",
        "Kailangan ng more income? Hilingin ang extra hours, weekend work, o side gigs",
        "Huwag mangutang sa online loan apps kung essentials ang short - ito ang nagsisimula ng debt spiral",
        "Small fixes ngayon ay maiwawasan ang big crisis later"
      ]
    }$$::jsonb
  )
;
