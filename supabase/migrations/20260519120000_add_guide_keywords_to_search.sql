alter table public.guides
  add column if not exists keywords_en text,
  add column if not exists keywords_fil text;

create or replace function public.update_guide_search_vector()
returns trigger as $$
begin
  new.search_vector :=
    to_tsvector('english', coalesce(new.title_en, '')) ||
    to_tsvector('english', coalesce(new.tagline_en, '')) ||
    to_tsvector('simple', coalesce(new.title_fil, '')) ||
    to_tsvector('simple', coalesce(new.tagline_fil, '')) ||
    to_tsvector('simple', coalesce(new.keywords_en, '')) ||
    to_tsvector('simple', coalesce(new.keywords_fil, '')) ||
    to_tsvector('simple', coalesce(array_to_string(new.tags, ' '), ''));
  return new;
end;
$$ language plpgsql;

update public.guides
set updated_at = updated_at;
