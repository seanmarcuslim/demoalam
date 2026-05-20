update public.guides
set slug = 'everyday-rights-philippines-checklist'
where slug = 'barangay-certificate-when-needed'
  and not exists (
    select 1
    from public.guides
    where slug = 'everyday-rights-philippines-checklist'
  );

insert into public.guides (
  slug,
  category_id,
  title_en,
  title_fil,
  tagline_en,
  tagline_fil,
  is_featured,
  is_urgent,
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
  'everyday-rights-philippines-checklist',
  (select id from public.categories where slug = 'gov'),
  'Everyday rights in the Philippines many people miss',
  'Everyday rights sa Pilipinas na madalas hindi alam',
  'Know basic rights for shopping, work pay, personal data, and dealing with authorities.',
  'Alamin ang basic rights sa pagbili, sweldo, personal data, at pakikipag-usap sa authorities.',
  false,
  false,
  6,
  'katamtaman',
  '20-30 minuto',
  'Libre',
  array['rights', 'law', 'consumer rights', 'labor rights', 'data privacy', 'bill of rights', 'philippines', 'karapatan', 'batas'],
  'rights law consumer rights labor rights data privacy bill of rights philippines',
  'karapatan batas consumer rights labor rights data privacy bill of rights pilipinas',
  '[
    {"title":"Article III: Bill of Rights","publisher":"Supreme Court E-Library","url":"https://elibrary.judiciary.gov.ph/thebookshelf/showdocs/45/25549"},
    {"title":"Workers Statutory Monetary Benefits Handbook","publisher":"National Wages and Productivity Commission","url":"https://nwpc.dole.gov.ph/wp-content/uploads/2024/11/Workers-Statutory-Monetary-Benefits-Handbook-2024-Edition.pdf"},
    {"title":"Know your rights and responsibilities as consumers","publisher":"Department of Trade and Industry","url":"https://www.dti.gov.ph/dti-archives/dti-consumers-rights-responsibilities/"},
    {"title":"Data Subject Rights","publisher":"National Privacy Commission","url":"https://privacy.gov.ph/data-subject-rights/"}
  ]'::jsonb,
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

delete from public.guides
where slug = 'barangay-certificate-when-needed';

delete from public.guide_sections
where guide_id = (
  select id
  from public.guides
  where slug = 'everyday-rights-philippines-checklist'
);

insert into public.guide_sections (guide_id, section_type, order_index, content_en, content_fil)
values
  (
    (select id from public.guides where slug = 'everyday-rights-philippines-checklist'),
    'what_to_know',
    1,
    '{"title":"What this guide covers","body":"This is not legal advice. It is a practical checklist of everyday rights many Filipinos can use when buying products, working for pay, sharing personal data, or dealing with authorities."}'::jsonb,
    '{"title":"Ano ang sakop ng guide na ito","body":"Hindi ito legal advice. Practical checklist ito ng everyday rights na magagamit ng maraming Pilipino kapag bumibili, nagtatrabaho, nagbibigay ng personal data, o humaharap sa authorities."}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'everyday-rights-philippines-checklist'),
    'step',
    2,
    '{"title":"For defective products, do not stop at no return, no exchange","body":"If a product is defective or not as represented, keep the receipt, photos, messages, warranty card, and ask the store for the proper remedy. DTI consumer rights materials explain that consumers have rights to safety, information, choice, representation, redress, education, basic needs, and a healthy environment.","step_number":1,"items":["Receipt or proof of payment","Photo or video of defect","Chat/order details","Warranty card if any","Store name, branch, and date"]}'::jsonb,
    '{"title":"Kung defective ang binili, huwag tumigil sa no return, no exchange","body":"Kung defective o iba sa sinabi ang produkto, itago ang resibo, photos, messages, warranty card, at humingi ng tamang remedy sa store. Ayon sa DTI consumer rights materials, may karapatan ang consumer sa safety, information, choice, representation, redress, education, basic needs, at healthy environment.","step_number":1,"items":["Resibo o proof of payment","Photo o video ng defect","Chat/order details","Warranty card kung meron","Pangalan ng store, branch, at date"]}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'everyday-rights-philippines-checklist'),
    'step',
    3,
    '{"title":"For work pay, check the written basics","body":"Before resigning, accepting unpaid work, or ignoring missing pay, check your wage, overtime, rest day, holiday pay, service incentive leave, 13th month pay, and statutory deductions. Use DOLE/NWPC benefit references for the current rules.","step_number":2,"sample":"Hello po. Pwede po bang makahingi ng breakdown ng sahod ko, deductions, overtime/holiday pay kung meron, at 13th month computation?"}'::jsonb,
    '{"title":"Sa sweldo at trabaho, i-check ang written basics","body":"Bago mag-resign, pumayag sa unpaid work, o palampasin ang kulang na sahod, i-check ang wage, overtime, rest day, holiday pay, service incentive leave, 13th month pay, at statutory deductions. Gamitin ang DOLE/NWPC references para sa current rules.","step_number":2,"sample":"Hello po. Pwede po bang makahingi ng breakdown ng sahod ko, deductions, overtime/holiday pay kung meron, at 13th month computation?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'everyday-rights-philippines-checklist'),
    'step',
    4,
    '{"title":"For personal data, ask why it is needed","body":"Under data privacy rules, you have rights over your personal data, including being informed, accessing your data, correcting inaccurate data, objecting in certain cases, and filing a complaint with the National Privacy Commission.","step_number":3,"sample":"Para saan po gagamitin ang ID/photo/data ko, sino po ang may access, at paano po ito ide-delete kung hindi na kailangan?"}'::jsonb,
    '{"title":"Sa personal data, itanong kung bakit kailangan","body":"Sa data privacy rules, may rights ka sa personal data mo, kasama ang right to be informed, access your data, correct inaccurate data, object in certain cases, at mag-file ng complaint sa National Privacy Commission.","step_number":3,"sample":"Para saan po gagamitin ang ID/photo/data ko, sino po ang may access, at paano po ito ide-delete kung hindi na kailangan?"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'everyday-rights-philippines-checklist'),
    'warning',
    5,
    '{"title":"If authorities are involved, stay calm and ask for basics","body":"The Bill of Rights protects people against unreasonable searches and seizures and protects due process. In risky situations, do not argue aggressively. Ask who is in charge, what the reason is, and contact family or legal help as soon as possible.","severity":"high"}'::jsonb,
    '{"title":"Kung may authorities, kumalma at itanong ang basics","body":"Pinoprotektahan ng Bill of Rights ang tao laban sa unreasonable searches and seizures at pinoprotektahan ang due process. Sa risky situations, huwag makipagtalo nang agresibo. Itanong kung sino ang in charge, ano ang dahilan, at kontakin agad ang pamilya o legal help.","severity":"high"}'::jsonb
  ),
  (
    (select id from public.guides where slug = 'everyday-rights-philippines-checklist'),
    'mistake',
    6,
    '{"title":"Do not rely on viral legal posts alone","body":"Laws have details and exceptions. Use viral posts only as a starting point, then verify with official sources such as DTI, DOLE/NWPC, NPC, Supreme Court/Official Gazette, or a lawyer/public legal aid office."}'::jsonb,
    '{"title":"Huwag umasa sa viral legal posts lang","body":"May details at exceptions ang batas. Gawing starting point lang ang viral posts, tapos i-verify sa official sources tulad ng DTI, DOLE/NWPC, NPC, Supreme Court/Official Gazette, o lawyer/public legal aid office."}'::jsonb
  );
