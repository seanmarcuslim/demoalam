create table if not exists public.search_events (
  id uuid primary key default gen_random_uuid(),
  query text not null check (char_length(query) between 2 and 120),
  normalized_query text not null check (char_length(normalized_query) between 2 and 120),
  result_count int not null default 0 check (result_count >= 0),
  top_result_slug text,
  language text not null check (language in ('en', 'fil')),
  platform text default 'android',
  created_at timestamptz default now()
);

create index if not exists idx_search_events_created_at
  on public.search_events(created_at desc);

create index if not exists idx_search_events_normalized_query
  on public.search_events(normalized_query);

create index if not exists idx_search_events_zero_results
  on public.search_events(normalized_query, created_at desc)
  where result_count = 0;

alter table public.search_events enable row level security;

drop policy if exists "Anyone can log search events" on public.search_events;
create policy "Anyone can log search events"
  on public.search_events for insert
  with check (true);
