update public.categories
set
  name_fil = case slug
    when 'healthcare' then 'Kalusugan'
    when 'digital-safety' then 'Digital Safety'
    when 'emergency' then 'Emergency'
    when 'adulting' then 'Adulting'
    else name_fil
  end,
  icon = case slug
    when 'adulting' then chr(129517)
    else icon
  end
where slug in (
  'healthcare',
  'digital-safety',
  'emergency',
  'adulting'
);
