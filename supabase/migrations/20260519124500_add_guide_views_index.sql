create index if not exists idx_guide_views_guide_time
  on public.guide_views(guide_id, viewed_at desc);
