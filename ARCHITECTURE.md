# DemoAlam Architecture

DemoAlam is a small product system, not a throwaway prototype. Keep changes lightweight, typed, and consistent with the existing layers.

## Routing

Use Expo Router file-based routing.

- `app/(tabs)/` for primary tabs
- `app/guide/[id].tsx` for guide detail
- `app/category/[id].tsx` for category detail
- auth and onboarding live as app-level routes

Do not add manual navigation config unless Expo Router cannot solve the problem.

## Data Flow

Preferred flow:

```txt
Screen -> Hook -> Service -> Supabase
```

Screens should not call Supabase directly.

## Server State

Use TanStack Query for Supabase-backed data:

- guides
- categories
- search
- guide detail
- trending

Use `networkMode: 'offlineFirst'` for app content queries.

## Global State

Use Zustand for small app state:

- settings
- saved guides
- session
- onboarding
- search history
- feedback toast
- viewing history

Persist only what needs to survive app restarts.

## Offline Strategy

Saved guides store both IDs and cached guide objects.

Important rules:

- saved IDs are the source of saved intent
- cached guide objects are an offline convenience
- persisted stores should be versioned when data shape changes
- guide detail should fall back to cached saved content when online fetch fails

## Trust Strategy

Guide Detail should be the most trustworthy surface.

Use:

- last updated metadata
- official source links when available
- clear disclaimers
- scam warning treatment for urgent guides
- offline copy notices

Do not show official-source UI unless `official_sources` exists.

## Search Strategy

Search should use:

- title fields
- tagline fields
- tags
- `keywords_en`
- `keywords_fil`

Search errors should show retry states. Failed search should not look like “no results.”

## Analytics

Guide views are privacy-safe:

- guide ID
- platform
- timestamp

Do not add PII to analytics tables.

## Type Safety

Keep `strict` TypeScript enabled.

Avoid:

- `any`
- screen-level Supabase calls
- untyped icon names where possible
- hard-coded category colors in UI

Use existing shared types and helpers.
