# DemoAlam Project Roadmap

Date: 2026-05-26

## Current Strategic Decision

DemoAlam is now a structured MVP. The biggest current risk is uncontrolled growth, not lack of features.

Before adding major new features or categories, finish the remaining stabilization work, then prioritize guide quality. New content should grow as guide clusters inside existing categories instead of creating new categories too early.

Recent stabilization progress:

- Guide detail skeleton and trust summary were extracted.
- Guide section, checklist, sample, source row, meta pill, and completeness/trust items now exist as reusable guide components.
- Search aliases and search relevance logic were split out of the service layer.
- Home curated sections, search suggestions, and category copy helpers were extracted.
- Typecheck passed after the refactor batch.

Current decision:

Architecture stabilization is no longer the main blocker, but `app/guide/[id].tsx` is still large and should be treated carefully. Do not do a broad rewrite. Only extract or clean up pieces that directly reduce risk.

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

## Priority 1: Final Stabilization Pass

### 1. Extract Guide Detail Blocks

Status: APPROVED
Priority: HIGH
MVP decision: REQUIRED
Impact: 9/10
Complexity: 3/10

Objective:
Finish reducing risk in `app/guide/[id].tsx` without changing behavior.

Completed:

- `GuideSectionCard`
- `GuideTrustSummaryCard`
- `GuideDetailSkeleton`
- `OfficialSourceRow`
- `GuideCompletenessItem`
- `GuideMetaPill`
- `ChecklistBlock`
- `SampleBlock`

Remaining tasks:

- Audit `app/guide/[id].tsx` for unused helpers/styles/imports.
- Extract only obvious repeated UI if it reduces file risk.
- Avoid changing guide layout or rendering rules during this pass.
- Run typecheck after cleanup.

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
Reduce duplicated UI labels and prevent English/Filipino drift.

Tasks:

- Continue domain-by-domain centralization.
- Keep data selection logic near data when needed.
- Avoid migrating every inline ternary in one risky pass.
- Prioritize user-visible labels, empty states, and metadata copy.

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
Priority: COMPLETED
MVP decision: REQUIRED
Impact: 8/10
Complexity: 1/10

Objective:
Keep `guidesService.ts` focused on data access and move search relevance logic into its own module.

Completed:

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
Priority: COMPLETED
MVP decision: REQUIRED
Impact: 6/10
Complexity: 1/10

Objective:
Move category copy, accents, and signals out of `categories.tsx`.

Completed:

- Category display/copy helpers were extracted into `src/lib/categoryCopy.ts`.
- Categories, category detail, and search reuse the helper.

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

Status: MVP-ready core completed

Current anchor:

- `first-job-requirements`
  - Polished as the Work entry guide.
  - Search support added for everyday terms like `unang trabaho`, `pre employment requirements`, `HR requirements`, `first time jobseeker`, `free NBI`, and `SSS PhilHealth Pag-IBIG TIN`.

Completed support/protection guides:

- `resume-no-experience`
- `job-interview-basic-answers`
- `fake-job-offer-red-flags`

Decision:
Do not add more Work guides immediately. Move to Emergency or Adulting so the app does not become uneven.

Potential next guides:

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

Status: Active

Current anchor:

- `road-accident-first-steps`
  - Added as the first Emergency cluster anchor guide.
  - Focus: safety first, 911/local responders, evidence, police/traffic reporting, insurance caution, and anti-pressure settlement guidance.
  - Search support added for `road accident`, `road crash`, `car accident`, `motorcycle accident`, `traffic accident`, `police report`, and `insurance claim`.

Polished support guides:

- `medical-emergency-documents`
  - Improved title/copy, warning strength, document safety checklist, and search discovery for hospital/PhilHealth/HMO/billing/social-service terms.
- `phone-stolen-first-hour`
  - Search discovery strengthened for Filipino lost/stolen phone, lost SIM, SIM replacement, and IMEI terms.
- `lost-wallet-first-steps`
  - Search discovery strengthened for Filipino lost wallet, freeze/block card, affidavit of loss, and lost ID terms.

Decision:
Emergency is strong enough for MVP after verification. Move next to Adulting or Healthcare.

Potential next guides:

- Road accident first steps
- Motorcycle safety checklist
- Commuter safety tips
- Disaster preparation
- What to prepare before long travel

Rule:
Write for stressful situations. Prioritize first actions, safety, documentation, and official reporting.

### Healthcare Cluster

Priority: HIGH

Status: Active

Current anchor:

- `philhealth-hospital-benefits-checklist`
  - Added as the first Healthcare cluster anchor guide.
  - Focus: hospital billing clarity, PhilHealth benefit questions, documents, HMO/company benefit coordination, social service options, and anti-fixer guidance.
  - Search support added for `philhealth benefits`, `hospital bill`, `case rate`, `PhilHealth MDR`, `Claim Form 1`, and `discharge billing`.

Completed support guide:

- `public-hospital-social-service-desk-guide`
  - Added as the public-hospital assistance navigation guide.
  - Focus: official Medical Social Service/Malasakit-style desks, assistance assessment, document readiness, realistic expectations, and anti-fixer warnings.
  - Search support added for `hospital assistance`, `medical assistance`, `malasakit`, `malasakit center`, `public hospital`, `medical social worker`, `MAIFIP`, and `MAIPP`.

Potential next guides:

- PhilHealth YAKAP/Konsulta guide
- Generic medicine and medicine-price checklist

Rule:
Healthcare content must guide access and preparation, not diagnosis or treatment. Use official/current sources for every health-related program claim.

### DSWD / Government Aid Cluster

Priority: CRITICAL - CORE SPRINT COMPLETED

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

Next DSWD content audit:

- Completed for the core sprint: AICS, Walang Gutom, 4Ps, Social Pension, ECT, Student Cash-for-Work, and SLP.
- Pause new DSWD guide creation unless a clear bug, accuracy issue, or high-demand missing program appears.
- Next step: audit discovery so users can find these guides through plain-language searches and category browsing.

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

1. Run a search and category discovery audit for the completed DSWD cluster.
2. Run a final small cleanup audit on `app/guide/[id].tsx` only if new guide rendering issues appear.
3. Fix bundle UI theme consistency if still hardcoded.
4. Continue localization centralization only where drift is visible.
5. Strengthen Money, Work, Emergency, and Adulting guide clusters without adding new categories.
6. Add new DSWD guides only after search/category discovery proves the current cluster is easy to find.

This order avoids overengineering and moves the app back toward the highest product value: trustworthy, practical, searchable guides.
