insert into public.categories (slug, name_en, name_fil, icon, color, order_index, is_active)
values
  ('healthcare', 'Healthcare', 'Healthcare', '⚕️', '#2F8F83', 5, true),
  ('education', 'Education', 'Edukasyon', '🎓', '#4F73C7', 6, true),
  ('digital-safety', 'Digital Safety', 'Digital Safety', '🛡️', '#3A7CA5', 8, true)
on conflict (slug) do update set
  name_en = excluded.name_en,
  name_fil = excluded.name_fil,
  icon = excluded.icon,
  color = excluded.color,
  order_index = excluded.order_index,
  is_active = true;

update public.categories
set order_index = case slug
  when 'ids' then 1
  when 'gov' then 2
  when 'money' then 3
  when 'work' then 4
  when 'healthcare' then 5
  when 'education' then 6
  when 'scams' then 7
  when 'digital-safety' then 8
  when 'emergency' then 9
  when 'adulting' then 10
  else order_index
end
where slug in (
  'ids',
  'gov',
  'money',
  'work',
  'healthcare',
  'education',
  'scams',
  'digital-safety',
  'emergency',
  'adulting'
);

update public.guides
set category_id = (select id from public.categories where slug = 'digital-safety')
where slug in (
  'gcash-scam-red-flags',
  'phishing-link-checklist',
  'phone-stolen-first-hour'
);

update public.guides
set category_id = (select id from public.categories where slug = 'healthcare')
where slug = 'medical-emergency-documents';
