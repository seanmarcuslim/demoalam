# Apply Current Supabase Updates

Use this order in the Supabase SQL Editor.

## 1. Run Migrations

Run these files in order:

1. `migrations/20260519120000_add_guide_keywords_to_search.sql`
2. `migrations/20260519123000_add_guide_official_sources.sql`
3. `migrations/20260519124500_add_guide_views_index.sql`
4. `migrations/20260519131500_create_trending_guides_with_category_rpc.sql`
5. `migrations/20260519132500_drop_old_trending_guides_rpc.sql`

You can skip `20260519130000_create_trending_guides_rpc.sql`; it was replaced by the category-aware trending RPC.

## 2. Run Seed

After migrations succeed, run:

```txt
supabase/seed.sql
```

This refreshes:

- category colors
- guide keywords
- official source links
- search vectors
- seeded guide sections

## 3. Expected Result

After this, the app should stop falling back for Trending and should show official source links on supported guides.
