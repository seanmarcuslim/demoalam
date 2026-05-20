create or replace function public.get_trending_guides_with_category(
  since_interval interval default interval '7 days',
  result_limit int default 10
)
returns table (
  id uuid,
  slug text,
  category_id uuid,
  title_en text,
  title_fil text,
  tagline_en text,
  tagline_fil text,
  keywords_en text,
  keywords_fil text,
  official_sources jsonb,
  is_featured boolean,
  is_urgent boolean,
  is_published boolean,
  read_time_min int,
  difficulty text,
  estimated_time text,
  estimated_cost text,
  tags text[],
  search_vector tsvector,
  created_at timestamptz,
  updated_at timestamptz,
  published_at timestamptz,
  category jsonb
)
language sql
stable
security definer
set search_path = public
as $$
  select
    g.id,
    g.slug,
    g.category_id,
    g.title_en,
    g.title_fil,
    g.tagline_en,
    g.tagline_fil,
    g.keywords_en,
    g.keywords_fil,
    g.official_sources,
    g.is_featured,
    g.is_urgent,
    g.is_published,
    g.read_time_min,
    g.difficulty,
    g.estimated_time,
    g.estimated_cost,
    g.tags,
    g.search_vector,
    g.created_at,
    g.updated_at,
    g.published_at,
    to_jsonb(c) as category
  from public.guides g
  join public.categories c on c.id = g.category_id
  join (
    select guide_id, count(*) as view_count
    from public.guide_views
    where viewed_at >= now() - since_interval
    group by guide_id
  ) views on views.guide_id = g.id
  where g.is_published = true
    and c.is_active = true
  order by views.view_count desc, g.published_at desc
  limit least(greatest(result_limit, 1), 50);
$$;
