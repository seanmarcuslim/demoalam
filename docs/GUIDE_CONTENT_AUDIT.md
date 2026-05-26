# DemoAlam Guide Content Audit

Date: 2026-05-26

## Executive Decision

DemoAlam should prioritize guide quality standardization before adding more large features.

The product is strongest when a guide feels like a calm, practical decision helper: clear priority order, checklist, common mistakes, warnings, sample questions, and official sources. The current app already supports this structure, but not every guide has reached that quality bar yet.

## Audit Standard

Each important guide should be scored against these requirements:

- Specific user problem: one clear real-life situation, not a broad article topic.
- First action: tells the user what to do first when stressed or confused.
- Priority order: helps users avoid wasting time on low-impact steps.
- Checklist: concrete items users can prepare or verify.
- Mistakes: common errors, fixer traps, scams, or wasted trips.
- Warning: visible risk guidance for money, documents, privacy, or identity.
- Sample question/script: gives users exact words to ask an office, bank, school, or support channel.
- Official sources: at least one credible source when government, legal, money, health, or safety advice is involved.
- Filipino readability: everyday language, but not sloppy Taglish.
- Anti-fixer stance: users should be guided toward official channels and verification.

## Current Strongest Guides

These guides are closest to the DemoAlam product standard:

1. `student-financial-aid-philippines-checklist`
   - Status: Strong
   - Why: Specific, high-impact, source-backed, has program sorting, eligibility checks, scam warnings, and sample message.
   - Keep improving: add more region/LGU caveats later, but avoid making it too long.

2. `dswd-aics-assistance-checklist`
   - Status: Strong
   - Why: Very aligned with the mission: hidden public assistance, anti-fixer, practical requirements, and official sources.
   - Keep improving: add a better priority matrix for medical, burial, transport, education, and food assistance.

3. `medical-emergency-documents`
   - Status: Strong
   - Why: Clear practical use case, good emotional fit, strong checklist behavior.
   - Keep improving: add a "what to ask billing/social service" checklist.

4. `phone-stolen-first-hour`
   - Status: Strong
   - Why: Urgent, highly actionable, protects money, accounts, SIM, and identity.
   - Keep improving: add SIM replacement documents and account recovery sample questions.

5. `phishing-link-checklist`
   - Status: Strong
   - Why: Fits digital safety and scam prevention well. Good red-flag structure.
   - Keep improving: add screenshots/examples later only if we can do it safely and clearly.

6. `fake-job-offer-red-flags`
   - Status: Strong
   - Why: High exploitation risk, very practical, strong anti-scam fit.
   - Keep improving: add OFW/local job distinction if guide gets too broad.

7. `nbi-clearance-first-timers`
   - Status: Strong
   - Why: Specific, official-source driven, strong first-time jobseeker angle.
   - Keep improving: keep updated because fees/processes may change.

8. `loan-red-flags-before-borrowing`
   - Status: Strong
   - Why: Protects users from financial harm and data abuse.
   - Keep improving: add clearer "do not install if..." checklist.

## Acceptable But Needs Upgrade

These guides are useful, but should be upgraded to the richer guide standard.

1. `everyday-rights-philippines-checklist`
   - Issue: High-value topic, but naturally broad.
   - Decision: Keep, but split later if it becomes too dense.
   - Upgrade: add separate checklist blocks for consumer, labor, data privacy, and police/barangay interaction.

2. `philhealth-pagibig-tin-basics`
   - Issue: Useful, but may overlap with first-job requirements and SSS guide.
   - Decision: Keep as a first-job government numbers hub.
   - Upgrade: add "what HR handles vs what you handle yourself."

3. `first-job-requirements`
   - Issue: Good beginner topic, but currently thinner than newer guides.
   - Decision: Keep.
   - Upgrade: add checklist, HR sample question, and common mistakes.

4. `resume-no-experience`
   - Issue: Useful for students, but less mission-critical than government/money/scam guides.
   - Decision: Keep as support content.
   - Upgrade: add sample resume bullets and "do not fake experience" warning.

5. `gcash-scam-red-flags`
   - Issue: Important, but may overlap with phishing and phone-stolen guides.
   - Decision: Keep only if upgraded into a GCash-specific scam guide.
   - Upgrade: add fake support, send-money pressure, QR/payment reversal scams, OTP/MPIN warnings.

6. `lost-wallet-first-steps`
   - Issue: Live guide appears upgraded, but make sure the final SQL is captured in a repo migration.
   - Decision: Keep.
   - Upgrade: repository must contain the same rich content that exists in Supabase.

## Weakest Or Lowest-Leverage Guides

These are candidates to upgrade, merge, or replace.

1. `payday-budget-simple-split`
   - Issue: Previously useful but generic. Many apps/articles already cover ordinary budget splits.
   - Decision: Upgraded into a higher-impact shortfall guide.
   - New direction: "Salary short before payday: what to prioritize first."
   - Why: Better fits DemoAlam because it helps users avoid panic borrowing, loan-app traps, missed essentials, and debt spirals.

2. `first-time-utility-bills`
   - Issue: Practical but thin.
   - Decision: Upgrade only if it becomes a broader "avoid disconnection/fees" guide.
   - Better direction: "Meralco/water/internet bill checklist before due date."

3. `moving-out-budget`
   - Issue: Similar to renting guide; could become duplicate adulting content.
   - Decision: Merge with renting or make it much more specific.

4. `renting-first-time-checklist`
   - Issue: Useful but currently thin.
   - Decision: Upgrade if kept.
   - Better direction: "Boarding house/rent red flags before paying deposit."

5. `job-interview-basic-answers`
   - Issue: Useful, but less unique to DemoAlam.
   - Decision: Low priority.
   - Better direction: keep only if it includes Filipino first-job scripts and exploitation warnings.

6. `bank-account-first-time`
   - Issue: Useful but likely too generic unless it explains fees, maintaining balance, IDs, and scams.
   - Decision: Upgrade or replace.
   - Better direction: "Bank account vs e-wallet: what first-time workers should know."

7. `sss-number-first-job`
   - Issue: May duplicate `philhealth-pagibig-tin-basics`.
   - Decision: Merge into the first-job government numbers guide unless it becomes a full SSS-specific guide.

8. `fast-valid-id`
   - Issue: Potential overlap with NBI and other ID guides.
   - Decision: Verify if still published. If published, upgrade or replace.
   - Better direction: "Best first valid ID path when you have no ID yet."

## Technical Debt Warnings

1. Empty migration file
   - File: `supabase/migrations/20260522040000_add_official_sources_to_guides.sql`
   - Risk: Confusing migration history.
   - Decision: Leave for now if already tracked locally, but do not rely on it.

2. Live database drift risk
   - Some guide upgrades may have been pasted directly into Supabase SQL Editor.
   - Risk: Supabase production can become ahead of the repo.
   - Decision: Every SQL applied manually should also exist as a migration file.

3. Uneven guide completeness
   - New guides have 6-11 sections. Older guides have 1-2 sections.
   - Risk: users may feel quality drops between screens.
   - Decision: upgrade the weakest published guides before adding new feature systems.

4. Filipino copy consistency
   - Recent UI copy cleanup improved labels.
   - Remaining risk: guide body copy still uses mixed terms.
   - Decision: allow common terms like OTP, SIM, e-wallet, and online loan; reduce awkward verbs like "I-check" when possible.

## Recommended Next Work

Architecture has improved enough to resume content work carefully.

Reference roadmap:
`docs/PROJECT_ROADMAP.md`

Priority 1: Final guide detail cleanup
- Priority: High
- MVP necessity: Required
- Complexity: 3/10
- Reason: reusable guide blocks now exist, but `app/guide/[id].tsx` is still large. Do only small cleanup that reduces risk; avoid a broad rewrite.

Priority 2: DSWD/government aid guide consistency
- Priority: Critical
- MVP necessity: Required
- Complexity: 4/10
- Reason: AICS, Walang Gutom, 4Ps, Social Pension, ECT, Student Cash-for-Work, and SLP are high-impact guides. They must be consistent, source-backed, and careful about eligibility/approval claims.

Priority 3: Centralize localization where drift remains
- Priority: High
- MVP necessity: Required
- Complexity: 4/10
- Reason: UI labels are improving, but guide detail and metadata copy can still drift between English and Filipino.

Priority 4: Fix bundle UI theme consistency
- Priority: Medium-High
- MVP necessity: Required
- Complexity: 2/10
- Reason: bundle UI may still have hardcoded colors and should follow the app theme before bundle features expand.

Priority 5: Search quality regression check
- Priority: High
- MVP necessity: Required
- Complexity: 2/10
- Reason: search aliases and scoring were extracted. Verify important searches still surface the right guides.

Priority 6: Resume broader guide cluster upgrades
- Priority: High
- MVP necessity: Required
- Complexity: 4-6/10
- Reason: strengthen existing categories with high-impact guide clusters instead of adding new categories.

## Next Content Audit Targets

1. `dswd-aics-assistance-checklist`
   - Priority: Critical
   - Check for: assistance-type decision matrix, cash vs guarantee letter explanation, official-source completeness, sample questions, anti-fixer warning.
   - Current inspection: Strong and verified. It explains assessment, assistance paths, Guarantee Letters, AKAP confusion, fake pages, and application trail.
   - Next action: Do not rewrite now.

2. `walang-gutom-food-credits`
   - Priority: Critical
   - Check for: food credits vs cash distinction, validation explanation, accredited merchant details, fake registration warnings, realistic rollout caveats.
   - Current inspection: Upgraded and verified.
   - Next action: Do not rewrite now.

3. `4ps-validation-guide`
   - Priority: High
   - Check for: clear explanation that 4Ps is not a normal open application, CBMS/validation wording, household preparation checklist, grievance questions.
   - Current inspection: Upgraded and verified. It correctly frames 4Ps as validation-based, not instant registration.
   - Next action: Do not rewrite now.

4. `social-pension-senior-citizens`
   - Priority: High
   - Check for: eligibility caveats, OSCA/LGU coordination, payout expectations, waitlist language, scam warnings.
   - Current inspection: Upgraded and verified.
   - Next action: Do not rewrite now.

5. `national-id-problems`
   - Priority: High
   - Check for: anti-fixer positioning, what to do for delayed/missing ID, transaction slip/ePhilID guidance, sample questions.

6. `gcash-scam-red-flags`
   - Priority: Medium-High
   - Check for: differentiation from phishing guide, send-money pressure scams, fake support, reversal/refund scams, evidence checklist.

## Completed DSWD Sprint

The DSWD/government-aid cluster now has a strong verified core:

- `dswd-aics-assistance-checklist`
- `walang-gutom-food-credits-checklist`
- `social-pension-indigent-senior-citizens`
- `four-ps-validation-checklist`
- `emergency-cash-transfer-disaster-aid-checklist`
- `student-cash-for-work-dswd-checklist`
- `sustainable-livelihood-program-checklist`

Decision:
Pause new DSWD guide creation. The next step should be search/category quality audit so users can actually discover these guides by plain-language terms like `ayuda`, `senior pension`, `4Ps`, `livelihood`, `cash for work`, `bagyo cash aid`, and `walang gutom`.

## DSWD Discovery Audit

Status: Completed initial pass

Search aliases and relevance scoring now directly support the most important plain-language DSWD discovery terms:

- `ayuda`
- `senior pension`
- `4Ps`
- `walang gutom`
- `cash for work`
- `livelihood`
- `bagyo cash aid`

Expo Web verification:

- `ayuda` surfaces AICS, Emergency Cash Transfer, 4Ps, Walang Gutom, and SLP.
- `senior pension` surfaces Social Pension.
- `walang gutom` surfaces Walang Gutom.
- `cash for work` surfaces Student Cash-for-Work.
- `livelihood` surfaces SLP.
- `bagyo cash aid` surfaces Emergency Cash Transfer.
- Government category shows the core DSWD guides.

Next action:
Do not add more DSWD content yet. Watch for real user search misses, then add targeted aliases instead of broad new content.

## Product Direction Decision

Approved direction:
DemoAlam should focus on hidden-in-plain-sight public benefits, scam prevention, document readiness, first-job systems, health/emergency preparation, and rights awareness.

## Money Cluster Progress

Status: Active after DSWD core sprint

Decision:
Strengthen Money through harm-reduction guides before adding generic financial literacy content.

Completed initial Money move:

- Upgraded `payday-budget-simple-split` into a shortfall/prioritization guide for users whose salary is not enough before payday.
- Added search support for `kulang sweldo`, `kulang sahod`, `petsa de peligro`, `salary short`, and `before payday`.
- Verified in Expo Web after SQL apply: `kulang sweldo`, `petsa de peligro`, and `before payday` surface the upgraded guide.
- Verified guide rendering: warning, checklist, sample message, and priority steps display correctly.

Next Money candidates:

1. `gcash-scam-red-flags`
   - Improve differentiation from general phishing.
   - Add more GCash-specific send-money, fake support, QR, refund, and wrong-send safety logic.

2. `bank-account-first-time`
   - Polish Filipino title and simplify beginner wording.
   - Keep bank fees, maintaining balance, Basic Deposit Account, and money-mule warnings.

3. `loan-red-flags-before-borrowing`
   - Already strong.
   - Later improvement: add a clearer "do not install if..." visual checklist if UI supports it.

Rejected direction:
Do not become a generic life hacks or blog article app.

Postponed:
AI assistant, push notifications, community reports, monetization, and personalization should wait until the guide quality floor is consistently high.
