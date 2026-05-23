-- Polish Filipino guide copy for a more consistent, trust-first tone.
-- Scope: phrasing only. This keeps the existing guide structure and JSONB content intact.

do $$
declare
  replacement record;
begin
  for replacement in
    select * from (
      values
        ('I-check muna', 'Suriin muna'),
        ('I-check ang', 'Suriin ang'),
        ('I-check kung', 'Suriin kung'),
        ('i-check muna', 'suriin muna'),
        ('i-check ang', 'suriin ang'),
        ('i-check kung', 'suriin kung'),
        ('mag-check', 'magsuri'),
        ('official sources', 'opisyal na sanggunian'),
        ('official links', 'opisyal na sanggunian'),
        ('final reference', 'panghuling batayan')
    ) as replacements(search_text, replacement_text)
  loop
    update public.guides
    set
      title_fil = replace(title_fil, replacement.search_text, replacement.replacement_text),
      tagline_fil = replace(tagline_fil, replacement.search_text, replacement.replacement_text),
      keywords_fil = replace(coalesce(keywords_fil, ''), replacement.search_text, replacement.replacement_text)
    where
      title_fil like '%' || replacement.search_text || '%'
      or tagline_fil like '%' || replacement.search_text || '%'
      or coalesce(keywords_fil, '') like '%' || replacement.search_text || '%';

    update public.guide_sections
    set content_fil = replace(content_fil::text, replacement.search_text, replacement.replacement_text)::jsonb
    where content_fil::text like '%' || replacement.search_text || '%';
  end loop;
end $$;

-- Refresh search vectors after copy updates.
update public.guides
set updated_at = now()
where is_published = true;
