create extension if not exists pgcrypto;

create table if not exists public.categories (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  name_en text not null,
  name_fil text not null,
  icon text not null,
  color text not null,
  order_index int default 0,
  is_active boolean default true,
  created_at timestamptz default now()
);

create table if not exists public.guides (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  category_id uuid references public.categories(id),
  title_en text not null,
  title_fil text not null,
  tagline_en text not null,
  tagline_fil text not null,
  is_featured boolean default false,
  is_urgent boolean default false,
  is_published boolean default true,
  read_time_min int default 3,
  difficulty text check (difficulty in ('madali', 'katamtaman', 'mahirap')),
  estimated_time text,
  estimated_cost text,
  tags text[],
  search_vector tsvector,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  published_at timestamptz
);

create table if not exists public.guide_sections (
  id uuid primary key default gen_random_uuid(),
  guide_id uuid references public.guides(id) on delete cascade,
  section_type text not null check (section_type in (
    'what_to_know',
    'mistake',
    'step',
    'warning',
    'tip',
    'related'
  )),
  order_index int not null default 0,
  content_en jsonb not null,
  content_fil jsonb not null,
  created_at timestamptz default now()
);

create table if not exists public.guide_views (
  id uuid primary key default gen_random_uuid(),
  guide_id uuid references public.guides(id) on delete cascade,
  viewed_at timestamptz default now(),
  platform text default 'android'
);

create index if not exists idx_guides_category on public.guides(category_id);
create index if not exists idx_guides_featured on public.guides(is_featured) where is_featured = true;
create index if not exists idx_guides_urgent on public.guides(is_urgent) where is_urgent = true;
create index if not exists idx_guides_published on public.guides(is_published, published_at desc);
create index if not exists idx_sections_guide on public.guide_sections(guide_id, order_index);
create index if not exists idx_search_vector on public.guides using gin(search_vector);

create or replace function public.update_guide_search_vector()
returns trigger as $$
begin
  new.search_vector :=
    to_tsvector('english', coalesce(new.title_en, '')) ||
    to_tsvector('english', coalesce(new.tagline_en, '')) ||
    to_tsvector('simple', coalesce(new.title_fil, '')) ||
    to_tsvector('simple', coalesce(new.tagline_fil, '')) ||
    to_tsvector('simple', coalesce(array_to_string(new.tags, ' '), ''));
  return new;
end;
$$ language plpgsql;

drop trigger if exists guide_search_vector_update on public.guides;
create trigger guide_search_vector_update
  before insert or update on public.guides
  for each row execute function public.update_guide_search_vector();

alter table public.guides enable row level security;
alter table public.categories enable row level security;
alter table public.guide_sections enable row level security;
alter table public.guide_views enable row level security;

drop policy if exists "Published guides are public" on public.guides;
create policy "Published guides are public"
  on public.guides for select
  using (is_published = true);

drop policy if exists "Categories are public" on public.categories;
create policy "Categories are public"
  on public.categories for select
  using (is_active = true);

drop policy if exists "Guide sections are public" on public.guide_sections;
create policy "Guide sections are public"
  on public.guide_sections for select
  using (
    exists (
      select 1
      from public.guides
      where guides.id = guide_sections.guide_id
        and guides.is_published = true
    )
  );

drop policy if exists "Anyone can log views" on public.guide_views;
create policy "Anyone can log views"
  on public.guide_views for insert
  with check (true);
