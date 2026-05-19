# DemoAlam Changelog

## Unreleased

### Architecture

- Added reusable UI components: `AppButton`, `EmptyState`, and `LoadingScreen`.
- Refactored Saved, Search, and Categories screens toward reusable UI patterns.
- Added root architecture documentation.
- Added project README and QA checklist.
- Added design notes for color, dark mode, category accents, cards, and trust UI.
- Added `npm run typecheck`.

### Type Safety

- Added reusable guide/category type aliases.
- Removed real `any` usage from app and reusable UI code.
- Added typed theme color support with `ThemeColors`.
- Typed auth input rows and error handling.

### UX

- Improved Categories hero/banner layout.
- Improved app color palette for light and dark mode.
- Added Home, Search, Categories, and Category Detail retry states.
- Added global offline banner.
- Added offline cached-guide notice in Guide Detail.
- Added Saved refresh state for migrated cached data.

### Trust

- Added Guide Detail trust check card.
- Added `official_sources` guide metadata.
- Added official source links in Guide Detail when available.
- Added official source signal in Guide cards.

### Offline

- Added offline-first React Query behavior for guide, category, and search queries.
- Added saved guide detail fallback from cached saved content.
- Added saved cache versioning and migration.
- Added saved cache hydration from current guide list.

### Search

- Added `keywords_en` and `keywords_fil` schema support.
- Included keyword fields in Supabase search vector.
- Updated seed behavior to populate keyword fields.
- Added Search error/retry state.
- Removed hard-coded category filter limit.

### Supabase

- Added guide view analytics logging.
- Added guide view index.
- Added category-aware trending guides RPC.
- Wired Home Trending section to trending data with fallback.
- Added Supabase migration notes and setup troubleshooting.
