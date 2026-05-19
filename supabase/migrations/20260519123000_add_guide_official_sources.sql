alter table public.guides
  add column if not exists official_sources jsonb not null default '[]'::jsonb;
