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
- Checklist-first practical guidance
- Samples/templates when users need to copy, prepare, or verify something
- Backend-driven content

## Guide Content Standard

DemoAlam guides should not stay broad explanations. Each important guide should help a user take action immediately.

Every priority guide should include:

- `what_to_know`: short context and who the guide is for
- `step`: concrete steps in the order the user should do them
- `mistake`: common mistakes, red flags, or things to avoid
- `tip`: practical shortcut or decision rule
- checklist content: documents, screenshots, questions, or items to prepare
- sample content when useful: sample message, sample question to ask, sample checklist, sample budget split, sample warning script
- official sources when the topic involves money, IDs, government, health, employment, or scams

The content test is simple: after reading a guide, the user should know what to prepare, what to ask, what to avoid, and where to verify.

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

1. Upgrade priority guides with checklists, samples, and official sources
2. Trust and source quality
3. Search relevance for real user terms
4. Offline saved guide reliability
5. Guide detail UX for long practical content
6. Performance on budget Android phones
