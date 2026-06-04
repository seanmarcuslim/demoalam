create table if not exists public.flow_events (
  id uuid primary key default gen_random_uuid(),
  flow_slug text not null check (char_length(flow_slug) between 2 and 80),
  event_name text not null check (
    event_name in (
      'flow_opened',
      'flow_completed',
      'flow_outcome_shown',
      'flow_guide_opened'
    )
  ),
  outcome_id text check (outcome_id is null or char_length(outcome_id) between 2 and 80),
  guide_slug text check (guide_slug is null or char_length(guide_slug) between 2 and 120),
  search_query text check (search_query is null or char_length(search_query) between 2 and 120),
  language text not null check (language in ('en', 'fil')),
  platform text not null default 'unknown' check (platform in ('ios', 'android', 'web', 'unknown')),
  created_at timestamptz default now()
);

create index if not exists idx_flow_events_created_at
  on public.flow_events(created_at desc);

create index if not exists idx_flow_events_flow_slug_created_at
  on public.flow_events(flow_slug, created_at desc);

create index if not exists idx_flow_events_event_name_created_at
  on public.flow_events(event_name, created_at desc);

alter table public.flow_events enable row level security;

drop policy if exists "Anyone can log flow events" on public.flow_events;
create policy "Anyone can log flow events"
  on public.flow_events for insert
  with check (true);

comment on table public.flow_events is
  'Lightweight decision-flow analytics. Does not store user answers or personal data.';

comment on column public.flow_events.event_name is
  'flow_completed means the final question was answered. flow_outcome_shown means the result screen was rendered.';

comment on column public.flow_events.search_query is
  'Optional originating search query. Only populated for flow_opened events.';
