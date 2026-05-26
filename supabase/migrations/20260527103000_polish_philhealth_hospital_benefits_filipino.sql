update public.guides
set
  tagline_fil = 'Itanong ang tamang billing, PhilHealth, HMO, at social service details bago ka mabigla sa final bill.',
  estimated_cost = 'Libre magtanong; iba-iba ang gastos sa ospital',
  updated_at = now()
where slug = 'philhealth-hospital-benefits-checklist';

update public.guide_sections
set content_fil = jsonb_set(
  content_fil,
  '{title}',
  '"Checklist ng itatanong sa hospital billing"'::jsonb
)
where guide_id = (
  select id from public.guides
  where slug = 'philhealth-hospital-benefits-checklist'
)
and section_type = 'tip'
and order_index = 7;

update public.guide_sections
set content_fil = jsonb_set(
  content_fil,
  '{items}',
  '[
    "PhilHealth-accredited ba ang facility para sa case na ito?",
    "Anong PhilHealth benefit o case rate ang ina-apply?",
    "Anong documents ang kulang mula sa amin?",
    "Puwede bang makita ang updated billing breakdown?",
    "Paano maaapektuhan ng HMO, company benefit, o guarantee letter ang remaining balance?",
    "May social service desk o medical social worker ba na puwedeng kausapin?",
    "Anong receipts, claim records, o discharge papers ang dapat naming itabi?"
  ]'::jsonb
)
where guide_id = (
  select id from public.guides
  where slug = 'philhealth-hospital-benefits-checklist'
)
and section_type = 'tip'
and order_index = 7;

update public.guide_sections
set content_fil = jsonb_set(
  content_fil,
  '{title}',
  '"Sample message sa billing o claims desk"'::jsonb
)
where guide_id = (
  select id from public.guides
  where slug = 'philhealth-hospital-benefits-checklist'
)
and section_type = 'tip'
and order_index = 8;

update public.guide_sections
set content_fil = jsonb_set(
  content_fil,
  '{sample}',
  '"Hello po. Admitted po ang patient namin for [case/procedure]. Puwede po ba kaming magpa-verify ng PhilHealth eligibility, benefit o case rate na ina-apply, kulang na documents, HMO/company benefit coordination, at kung puwede kaming makausap ng social service bago discharge?"'::jsonb
)
where guide_id = (
  select id from public.guides
  where slug = 'philhealth-hospital-benefits-checklist'
)
and section_type = 'tip'
and order_index = 8;
