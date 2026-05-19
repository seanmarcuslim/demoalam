# DemoAlam

Filipino practical knowledge discovery app.

> "Sayang, ngayon ko lang nalaman."

DemoAlam helps Filipinos discover practical guidance for everyday tasks involving IDs, work, money, government requirements, emergencies, adulting, and scam prevention.

## Stack

- Expo Router
- React Native
- TypeScript
- Supabase
- TanStack Query
- Zustand
- AsyncStorage

## Architecture

- `app/`
  Expo Router routes, tabs, auth screens, onboarding, guide detail, and category detail.

- `src/components/`
  Reusable UI, guide cards, layout components, loading and empty states.

- `src/hooks/`
  Query hooks and app behavior hooks.

- `src/services/`
  Supabase access layer. UI should not call Supabase directly.

- `src/stores/`
  Zustand persisted state for saved guides, session, settings, onboarding, search, history, and feedback.

- `src/theme/`
  Centralized light/dark color system, spacing, and typography.

- `supabase/`
  Database migrations, seed content, and Supabase notes.

## Core Product Principles

- Mobile-first
- Lightweight for low-end Android
- Guest-first
- Filipino/English support
- Offline-aware saved guides
- Trust-first guide detail UX
- Backend-driven content

## Development

Install dependencies:

```bash
npm install
```

Start Expo:

```bash
npx expo start
```

Run TypeScript check:

```bash
npm run typecheck
```

## Environment

Create `.env` with:

```env
EXPO_PUBLIC_SUPABASE_URL=your-supabase-url
EXPO_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key
```

The app validates these values at startup.

## Supabase

Run migrations in timestamp order, then run `supabase/seed.sql`.

See [supabase/README.md](./supabase/README.md) for migration notes.

## Current Priorities

1. Trust and source quality
2. Offline saved guide reliability
3. Search relevance
4. Guide detail UX
5. Performance on budget Android phones
