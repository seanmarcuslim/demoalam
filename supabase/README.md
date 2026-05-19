# DemoAlam Supabase Notes

Run migrations in timestamp order before reseeding content.

## Current Important Migrations

- `20260518100000_create_demoalam_v1_schema.sql`
  Base schema for categories, guides, guide sections, guide views, search vector, indexes, and RLS.

- `20260519120000_add_guide_keywords_to_search.sql`
  Adds `keywords_en` and `keywords_fil` to guides and includes them in full-text search.

- `20260519123000_add_guide_official_sources.sql`
  Adds `official_sources` JSON metadata for verified source links.

- `20260519124500_add_guide_views_index.sql`
  Adds an index for guide view analytics by guide and time.

- `20260519131500_create_trending_guides_with_category_rpc.sql`
  Adds the category-aware trending guides RPC used by Home.

- `20260519132500_drop_old_trending_guides_rpc.sql`
  Removes the older trending RPC that did not include category data.

## After Migrations

Run `seed.sql` again so:

- category colors match the app palette
- seeded guide keywords populate `keywords_en` and `keywords_fil`
- official source metadata is available for supported guides
- search vectors refresh through the database trigger

If using the Supabase SQL Editor, run the migration SQL files first, then run `seed.sql`.

## Known Setup Notes

If Supabase CLI login or project linking fails, use the Supabase SQL Editor instead:

1. Open your Supabase project dashboard.
2. Go to SQL Editor.
3. Run the migration files in timestamp order.
4. Run `seed.sql`.

The CLI command `supabase db seed` may not exist in some installed CLI versions. In that case, paste and run `supabase/seed.sql` manually in SQL Editor.

If you see `Cannot find project ref. Have you run supabase link?`, the local CLI is not linked to your remote project. Either run `supabase link --project-ref YOUR_PROJECT_REF` or use SQL Editor.

If you see `Unauthorized`, regenerate/login with a Supabase access token, then retry linking. SQL Editor is still the quickest fallback.
