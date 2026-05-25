# DemoAlam Project Roadmap

Date: 2026-05-25

## Current Strategic Decision

DemoAlam is now a structured MVP. The biggest current risk is uncontrolled growth, not lack of features.

Before adding major new features or categories, prioritize architecture stabilization, localization consistency, search maintainability, and guide quality. New content should grow as guide clusters inside existing categories instead of creating new categories too early.

## Product Direction

DemoAlam should become a Filipino citizen preparedness and decision-support platform.

The app should help ordinary Filipinos:

- understand hidden-in-plain-sight public benefits and rights
- avoid scams, fixers, fake links, and wrong processes
- know what to do first during stressful situations
- prepare documents, questions, and checklists before going to offices
- make practical money, work, health, school, ID, and emergency decisions

DemoAlam should not become a generic life hacks, news, motivation, politics, religion, social feed, or entertainment app.

## Category Policy

Status: APPROVED

Do not add new top-level categories yet.

Keep the current category structure stable:

1. IDs
2. Work
3. Money
4. Government
5. Healthcare
6. Education
7. Scams
8. Digital Safety
9. Emergency
10. Adulting

Reason:

- The current navigation is already broad enough.
- More categories will create clutter before there is enough content depth.
- New topic ideas should prove value as guide clusters first.

Future category promotion rule:

A guide cluster can become a new category only when it has enough high-quality guides, clear user demand, low overlap with existing categories, and a distinct user mental model.

## Priority 1: Architecture Stabilization

### 1. Extract Guide Detail Blocks

Status: APPROVED
Priority: CRITICAL
MVP decision: REQUIRED
Impact: 9/10
Complexity: 5/10

Objective:
Reduce risk in `app/guide/[id].tsx`, which is currently the largest and riskiest screen.

Tasks:

- Extract `GuideSectionCard`
- Extract `GuideTrustCard`
- Extract `OfficialSourceRow`
- Extract `CompletenessItem`
- Extract `MetaPill`
- Keep behavior identical during extraction
- Run typecheck after each safe batch

Files affected:

- `app/guide/[id].tsx`
- `src/components/guide/`

Testing:

- Open one normal guide
- Open one urgent/scam guide
- Open one guide with official sources
- Open one saved/cached guide
- Verify language switching still works

### 2. Centralize Localization

Status: APPROVED
Priority: HIGH
MVP decision: REQUIRED
Impact: 9/10
Complexity: 5/10

Objective:
Reduce duplicated inline `language === 'fil' ? ... : ...` copy and prevent English/Filipino drift.

Tasks:

- Split locale copy by domain:
  - `common`
  - `guideDetail`
  - `search`
  - `saved`
  - `categories`
  - `profile`
- Replace duplicated inline strings gradually
- Do not migrate all screens in one risky pass
- Start with guide detail and saved/search copy

Files affected:

- `src/utils/translations.ts`
- possible future `src/i18n/`
- major screens using inline bilingual strings

Testing:

- Toggle Filipino/English
- Check tabs, guide detail, saved, search, categories, and profile
- Verify no mixed-language labels where avoidable

### 3. Split Search Architecture

Status: APPROVED
Priority: HIGH
MVP decision: REQUIRED
Impact: 8/10
Complexity: 4/10

Objective:
Keep `guidesService.ts` focused on data access and move search relevance logic into its own module.

Tasks:

- Move search aliases into `src/lib/searchAliases.ts`
- Move scoring helpers into `src/lib/searchRelevance.ts`
- Keep Supabase query execution inside the service
- Preserve current search behavior

Files affected:

- `src/services/guidesService.ts`
- `src/lib/searchAliases.ts`
- `src/lib/searchRelevance.ts`

Testing:

- Search: `dswd`, `ayuda`, `4Ps`, `Walang Gutom`, `loan app`, `fake job`, `wallet`, `phishing`, `nbi`, `philhealth`
- Verify top results remain sensible

### 4. Fix Bundle UI Theme Consistency

Status: APPROVED
Priority: MEDIUM-HIGH
MVP decision: REQUIRED
Impact: 7/10
Complexity: 2/10

Objective:
Remove hardcoded dark colors from bundle UI and align it with the app theme.

Tasks:

- Refactor `BundleCard` to use `useTheme`
- Replace inline hardcoded colors with theme colors
- Improve light/dark consistency
- Keep bundle layout simple

Files affected:

- `src/components/bundles/BundleCard.tsx`
- `app/bundle/[slug].tsx`

Testing:

- Check bundle card in light mode
- Check bundle card in dark mode
- Open a bundle detail screen

### 5. Extract Category Config

Status: APPROVED
Priority: MEDIUM
MVP decision: REQUIRED
Impact: 6/10
Complexity: 3/10

Objective:
Move category copy, accents, and signals out of `categories.tsx`.

Tasks:

- Create `src/lib/categoryConfig.ts`
- Move `CATEGORY_COPY`
- Move `CATEGORY_SIGNALS`
- Reuse config in home/category screens if useful

Files affected:

- `app/(tabs)/categories.tsx`
- `src/lib/categoryConfig.ts`
- possibly `src/lib/categoryVisuals.ts`

Testing:

- Categories screen still renders all categories
- Filipino/English category copy remains correct
- Guide counts and priority pills still work

## Priority 2: Existing Category Guide Clusters

Status: APPROVED

Do not add new categories yet. Strengthen current categories with high-impact guide clusters.

### Money Cluster

Priority: HIGH

Potential guides:

- Basic budgeting for Filipino families
- Emergency fund starter guide
- Utang checklist before borrowing
- Loan app red flags
- Simple payday budget split
- Compound interest basics
- SSS, Pag-IBIG, PhilHealth money basics

Rule:
Keep these practical and anti-exploitation. Avoid generic finance-blog tone.

### Work Cluster

Priority: HIGH

Potential guides:

- First job requirements
- Resume basics
- Interview communication
- TESDA guide
- Online job scam checks
- Basic AI/work skills

Future rename candidate:
`Work` may eventually become `Work & Skills`, but do not rename yet.

### Adulting Cluster

Priority: MEDIUM-HIGH

Potential guides:

- How to write a proper message to an office
- How to ask for help clearly
- Barangay complaint message template
- How to say no respectfully
- Conflict handling
- Emotional self-control before decisions

Rule:
Adulting must not become a junk drawer. Only keep guides that reduce confusion, prevent exploitation, or help users act confidently.

### Emergency Cluster

Priority: HIGH

Potential guides:

- Road accident first steps
- Motorcycle safety checklist
- Commuter safety tips
- Disaster preparation
- What to prepare before long travel

Rule:
Write for stressful situations. Prioritize first actions, safety, documentation, and official reporting.

### DSWD / Government Aid Cluster

Priority: CRITICAL

Keep following `docs/DSWD_FINANCIAL_AID_ROADMAP.md`.

Core guides:

- DSWD AICS
- Social Pension
- 4Ps validation
- Walang Gutom
- Emergency Cash Transfer
- Student Cash-for-Work
- Sustainable Livelihood Program

Rule:
Never promise approval or guaranteed payout. Always explain verification, assessment, documents, and scam/fixer risks.

## Postponed For MVP

Status: POSTPONED

Do not build these yet:

- AI assistant
- push notifications
- gamification
- social feed
- comments/community reports
- monetization
- complex personalization
- more top-level categories
- politics/religion/news/lifestyle content

Reason:
These add operational complexity before the app has a stable guide system, localization system, search system, and content quality floor.

## Immediate Task Order

1. Extract guide detail blocks
2. Centralize localization for guide detail and saved/search screens
3. Split search relevance logic out of `guidesService.ts`
4. Fix bundle UI theme consistency
5. Extract category config
6. Resume high-impact guide cluster upgrades

This order protects the architecture first, then allows content to grow safely.
