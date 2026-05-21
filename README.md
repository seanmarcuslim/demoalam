# DemoAlam

Filipino practical knowledge discovery app.

> "Sayang, ngayon ko lang nalaman."

DemoAlam helps Filipinos discover practical guidance for everyday tasks involving IDs, work, money, government requirements, public benefits, emergencies, adulting, and scam prevention.

The deeper mission is to uncover important rights, resources, benefits, and privileges that already exist but are often hidden in plain sight because of poor dissemination, confusing processes, lack of interest, or gatekeeping by fixers and corrupt actors.

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
- Public-benefit discovery for programs people do not know they can ask about
- Anti-fixer, anti-scam, source-first guidance
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

## Priority Content Clusters

DemoAlam should prioritize hidden-in-plain-sight public resources that apply to many Filipinos.

Highest-priority clusters:

- DSWD financial assistance and new/updated aid programs
- basic rights and laws most Filipinos can use in daily life
- first-time worker benefits and deductions
- scam and fixer avoidance
- government IDs, requirements, and official verification paths
- emergency actions for lost wallet, stolen phone, medical needs, and urgent documents

DSWD guides must be specific, current, and source-backed. Prefer separate guides for AICS, Walang Gutom, 4Ps-linked benefits, student cash-for-work, electricity lifeline subsidy, and other active aid programs instead of one broad DSWD article.

## Category Strategy

Categories should exist only when they reduce confusion, prevent exploitation, improve access, or help users act confidently.

Current priority category system:

- IDs: identity, clearances, and required documents
- Government: public benefits, agencies, requirements, and verification
- Money: banking, debt, subsidies, deductions, and everyday finance
- Work: job hunting, first-job documents, pay, and workplace basics
- Healthcare: medical access, hospital documents, PhilHealth, and assistance
- Education: scholarships, student aid, school documents, and pathways
- Scams: broad scam patterns, fixers, fake recruiters, and exploitation
- Digital Safety: e-wallets, phishing, account recovery, stolen phones, and online identity
- Emergency: urgent action guides for time-sensitive situations
- Adulting: practical home, bills, renting, and independent-living tasks

Next category to add only when there is enough content: Transportation.

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

1. Build a DSWD financial-aid guide pack with checklists, samples, and official sources
2. Upgrade priority rights/benefits guides with source-backed trust indicators
3. Search relevance for real Filipino terms, slang, and mixed Tagalog-English queries
4. Offline saved guide reliability
5. Guide detail UX for long practical content
6. Scam/fixer alert system
7. Performance on budget Android phones

## Product Roadmap

### Phase 1: Trustworthy Public-Benefit Guides

Goal: make DemoAlam useful enough that a Filipino can open one guide and know what to prepare, what to ask, what to avoid, and where to verify.

- Build a DSWD financial-aid guide pack:
  - AICS medical, burial, transport, education, food, and crisis assistance
  - Walang Gutom Program
  - 4Ps-linked benefits such as AlkanSSSya
  - electricity lifeline subsidy for eligible households
  - student cash-for-work and learning support programs
- Upgrade legal/rights guides:
  - consumer rights
  - work pay and benefits
  - data privacy
  - basic Bill of Rights situations
- Add official source links to every government, money, rights, health, and scam guide.
- Add checklist and sample sections to every priority guide.
- Add anti-fixer warnings where people commonly get exploited.

### Phase 2: Trust System And Search

Goal: make users feel the app is reliable, current, and easy to search even with everyday Filipino wording.

- Add visible trust indicators:
  - last verified date
  - official source count
  - source publisher labels
  - requirements may change warning
  - not legal/financial advice disclaimers where needed
- Improve search for:
  - Tagalog-English mixed queries
  - slang and common misspellings
  - user intent such as "gcash nahack" or "kuha ayuda"
  - category synonyms such as ayuda, benepisyo, sahod, reklamo, fixer
- Add better no-results suggestions and related searches.

### Phase 3: Offline And Retention

Goal: make DemoAlam valuable even with weak signal, low data, or repeated real-life use.

- Improve offline saved guides.
- Add offline search cache for saved or priority guides.
- Add recently viewed and continue reading.
- Add user segments:
  - student
  - first-time worker
  - parent
  - freelancer
  - OFW/family of OFW
- Add recommended next guides.

### Phase 4: Alerts And Community Signals

Goal: help users discover urgent public information without creating misinformation risk.

- Add scam/fixer alert content.
- Add trending public-benefit topics.
- Add "people are searching this" signals.
- Add report/suggest topic flow.
- Add moderation rules before any community-submitted content appears publicly.

### Phase 5: Long-Term Expansion

Goal: become the trusted explanation layer for Filipino public resources.

- LGU-specific guides.
- School and student assistance guides.
- OFW and family assistance guides.
- AI-assisted guide discovery, only after source-backed content is strong.
- Partnerships with educators, civic groups, legal aid groups, or public-information advocates.
