# DemoAlam Guide Depth Audit v2

Status: product roadmap audit  
Purpose: align Home promises with real guide depth before adding more features  
Source: Codex guide-depth audit plus external cross-review refinement

## Executive Verdict

DemoAlam's Home screen is directionally correct. The app is now presenting itself less like a guide library and more like a Future Advantage companion.

The main problem is a promise-depth gap:

```txt
Home makes promises.
Some guide paths cannot fully keep them yet.
```

This is not primarily a Home design problem, navigation problem, or copy problem. It is a guide coverage and routing problem.

Do not fix this by:

- Redesigning Home again
- Deleting unused guides immediately
- Adding many more Home cards
- Rebuilding navigation
- Creating a new guide engine

Fix it by:

- Matching each Home promise to a complete guide path
- Surfacing hidden valuable guides into existing paths
- Polishing weak guides before promoting them
- Verifying what is genuinely missing versus what is only buried

Core operating principle:

```txt
Stop adding.
Start connecting.
Then polish.
Then measure.
Then add.
```

## Home Card Coverage

### Check if it's a scam

Verdict: Strong

Current guides include:

- `gcash-scam-red-flags`
- `gcash-maya-account-recovery-first-hour`
- `wrong-send-gcash-checklist`
- `phishing-link-checklist`
- `fake-job-offer-red-flags`
- `loan-red-flags-before-borrowing`
- `loan-app-harassment-evidence-checklist`

Action:

- Keep as-is for now.
- Continue improving search routing for scam phrases.
- Do not add Scam Intelligence UI yet.

### Find scholarships or aid

Verdict: Useful, but under-connected

Current guides:

- `student-financial-aid-philippines-checklist`
- `student-cash-for-work-dswd-checklist`
- `dswd-aics-assistance-checklist`
- `cash-for-training`

Likely hidden value to verify and surface:

- `four-ps-validation-checklist`
- `walang-gutom-food-credits-checklist`
- `solo-parent-benefits-checklist`
- `sustainable-livelihood-program-checklist`
- `dswd-burial-assistance-checklist`

Action:

- Verify the hidden aid/benefit guides in Supabase.
- If published and accurate, connect them to this path.

### Prepare for your first job

Verdict: Strong

Current guides:

- `first-job-requirements`
- `resume-no-experience`
- `job-interview-basic-answers`
- `nbi-clearance-first-timers`
- `sss-number-first-job`
- `philhealth-pagibig-tin-basics`
- `bank-account-first-time`
- `fast-valid-id`

Missing future depth:

- First payslip explainer
- Probationary period rights
- Contract red flags before signing
- Illegal deductions and unpaid salary escalation

Action:

- Keep current path.
- Add future work-rights content only after the current hidden-guide surfacing pass.

### Get emergency help

Verdict: Strong

Current guides:

- `phone-stolen-first-hour`
- `medical-emergency-documents`
- `public-hospital-social-service-desk-guide`
- `pcso-medical-assistance-checklist`
- `philhealth-hospital-benefits-checklist`
- `road-accident-first-steps`
- `emergency-cash-transfer-disaster-aid-checklist`
- `lost-wallet-first-steps`
- `lost-atm-debit-card-checklist`
- `lost-sim-replacement-checklist`

Potential hidden guides to verify:

- `generic-medicine-buying-checklist`
- `dswd-burial-assistance-checklist`

Action:

- Verify and surface health/crisis-adjacent guides if they are published and strong.

### Fix a money problem

Verdict: Good, but missing practical household money depth

Current guides:

- `gcash-maya-account-recovery-first-hour`
- `wrong-send-gcash-checklist`
- `payday-budget-simple-split`
- `emergency-fund-starter-checklist`
- `loan-red-flags-before-borrowing`
- `salary-paycheck-checklist`
- `bank-account-first-time`

Potential hidden guides to verify and surface:

- `monthly-budget-checklist-families`
- `moving-out-budget`
- `utility-bill-disconnection-checklist`
- `sustainable-livelihood-program-checklist`

Action:

- Surface existing practical money guides before creating new money content.

### Prepare important documents

Verdict: Partial-good

Current guides:

- `fast-valid-id`
- `national-id-problems-checklist`
- `nbi-clearance-first-timers`
- `philhealth-pagibig-tin-basics`
- `first-job-requirements`
- `bank-account-first-time`

Potential hidden or legacy guides to verify:

- `barangay-certificate-when-needed`
- `fastest-valid-id`
- `how-to-open-bank-account`
- `office-help-message-checklist`

Action:

- Verify these slugs before surfacing.
- If they are legacy artifacts, do not use them.

### Choose a course

Verdict: Strongest Future Advantage path

Current guides:

- `choose-course-fit-checklist`
- `compare-3-course-options-checklist`
- `student-financial-aid-philippines-checklist`
- `study-smarter-when-behind-checklist`

Also supported by:

- Course Fit Quick Check
- Your Next Move continuity card

Missing future depth:

- TESDA vs college comparison
- How to check if a school/program is legitimate
- What work looks like after common strands/courses

Action:

- Keep this path.
- Do not expand until hidden-guide surfacing is handled.

### Study smarter

Verdict: Weakest promise-depth ratio

Current guides:

- `study-smarter-when-behind-checklist`
- `student-financial-aid-philippines-checklist`
- `student-cash-for-work-dswd-checklist`
- `choose-course-fit-checklist`
- `emergency-fund-starter-checklist`

Problem:

Only one guide is truly study-focused. The rest are adjacent student-life guides.

Action options:

1. Rename to better match existing depth.
2. Merge into Course path temporarily.
3. Add real study-depth guides later.

Recommended near-term action:

- Keep the card only if the copy clearly promises a small study reset, not a full study system.

### Understand work life

Verdict: Partial and too vague

Current guides:

- `first-job-requirements`
- `sss-number-first-job`
- `salary-paycheck-checklist`
- `unpaid-salary-kulang-sahod-checklist`
- `payday-budget-simple-split`
- `bank-account-first-time`

Problem:

"Understand work life" is broad. Users usually think in concrete risks:

- no contract
- unpaid salary
- illegal deductions
- probationary period
- no overtime pay
- first payslip

Action:

- Consider renaming later to a more concrete promise, such as:
  - `Know your rights at work`
  - `Before you sign or start work`

### Lessons I wish I knew earlier

Verdict: On-brand, emotionally strong, but currently scattered

Current guides:

- `choose-course-fit-checklist`
- `compare-3-course-options-checklist`
- `study-smarter-when-behind-checklist`
- `loan-red-flags-before-borrowing`
- `salary-paycheck-checklist`
- `emergency-fund-starter-checklist`
- `everyday-rights-philippines-checklist`
- `fake-job-offer-red-flags`
- `tenant-deposit-refund-checklist`
- `renting-first-time-checklist`

Problem:

The promise is powerful, but the path currently feels like a mixed collection rather than a curated sequence.

Future action:

- Turn this into a signature Future Advantage path only after guide utilization and hidden-guide surfacing are complete.

## Unused or Under-Connected Guides

### Surface Immediately If Verified

These appear aligned with current Home promises and should be verified first:

- `four-ps-validation-checklist`
- `walang-gutom-food-credits-checklist`
- `solo-parent-benefits-checklist`
- `sustainable-livelihood-program-checklist`
- `monthly-budget-checklist-families`
- `utility-bill-disconnection-checklist`
- `generic-medicine-buying-checklist`
- `office-help-message-checklist`
- `dswd-burial-assistance-checklist`

### Verify Before Surfacing

These may be legacy, renamed, inactive, or incomplete:

- `barangay-certificate-when-needed`
- `cash-for-work`
- `common-job-scams`
- `government-benefits-programs-checklist`
- `how-to-open-bank-account`
- `fastest-valid-id`
- `e-wallet`
- `barangay-complaint-evidence-checklist`
- `child-support-evidence-checklist`
- `first-time-utility-bills`
- `moving-out-budget`

Do not delete them without verification.

### Future Path Candidates

These may belong in future paths, not necessarily current Home:

- `barangay-complaint-evidence-checklist`
- `child-support-evidence-checklist`
- `first-time-utility-bills`
- `moving-out-budget`
- `tenant-deposit-refund-checklist`
- `renting-first-time-checklist`

## Missing Path Candidate

The audit suggests one high-impact missing path:

```txt
Claim what is yours
```

Possible subtitle:

```txt
Benefits most Filipinos never knew they could check.
```

Potential guide set:

- `four-ps-validation-checklist`
- `walang-gutom-food-credits-checklist`
- `solo-parent-benefits-checklist`
- `sustainable-livelihood-program-checklist`
- `dswd-burial-assistance-checklist`
- `student-cash-for-work-dswd-checklist`
- `dswd-aics-assistance-checklist`

Important:

Do not add this card until the guides are verified as published, accurate, and useful.

## Correct Supabase Verification Query

Use this query instead of assuming `guides.view_count`, `guides.title`, or `guides.category` columns exist:

```sql
select
  g.slug,
  g.title_en,
  c.slug as category_slug,
  c.name_en as category_name,
  g.is_published,
  count(v.id) as views,
  max(v.viewed_at) as latest_view,
  g.updated_at,
  case
    when g.is_published = false then 'Archive candidate or draft'
    when count(v.id) = 0 then 'Hidden - needs surfacing or polish'
    when count(v.id) < 10 then 'Low traffic - check title and routing'
    when count(v.id) < 50 then 'Growing - keep and improve'
    else 'Strong - protect and feature'
  end as utilization_status
from public.guides g
left join public.categories c on c.id = g.category_id
left join public.guide_views v on v.guide_id = g.id
group by
  g.id,
  g.slug,
  g.title_en,
  c.slug,
  c.name_en,
  g.is_published,
  g.updated_at
order by
  g.is_published desc,
  views desc,
  g.updated_at desc;
```

## Targeted Verification Query

Use this before surfacing hidden or legacy guides:

```sql
select
  g.slug,
  g.title_en,
  c.slug as category_slug,
  g.is_published,
  count(v.id) as views,
  max(v.viewed_at) as latest_view,
  g.updated_at
from public.guides g
left join public.categories c on c.id = g.category_id
left join public.guide_views v on v.guide_id = g.id
where g.slug in (
  'four-ps-validation-checklist',
  'walang-gutom-food-credits-checklist',
  'solo-parent-benefits-checklist',
  'sustainable-livelihood-program-checklist',
  'dswd-burial-assistance-checklist',
  'monthly-budget-checklist-families',
  'utility-bill-disconnection-checklist',
  'generic-medicine-buying-checklist',
  'office-help-message-checklist',
  'barangay-certificate-when-needed',
  'cash-for-work',
  'common-job-scams',
  'government-benefits-programs-checklist',
  'how-to-open-bank-account',
  'fastest-valid-id',
  'e-wallet',
  'barangay-complaint-evidence-checklist',
  'child-support-evidence-checklist',
  'first-time-utility-bills',
  'moving-out-budget'
)
group by
  g.id,
  g.slug,
  g.title_en,
  c.slug,
  g.is_published,
  g.updated_at
order by
  g.is_published desc,
  views desc,
  g.updated_at desc;
```

## Execution Plan

### Week 1: Verify and Connect

1. Run the targeted verification query.
2. Classify each result:
   - Surface now
   - Polish first
   - Keep hidden
   - Archive candidate
3. Connect verified Group A guides to existing Home paths.
4. Do not create new guides yet.

### Week 2: Polish Surfaced Guides

For each surfaced guide:

- Rewrite title if it is not benefit-first.
- Add or improve the first "why this matters" section.
- Make the first action obvious.
- Check official sources.
- Add or improve a "what to do next" ending.

### Week 3: Decide on New Home Path

Only after verification:

- Decide whether to add `Claim what is yours`.
- If approved, use existing verified aid/benefit guides.
- Do not create a new system or flow.

### Week 4: Measure

After changes are live:

- Compare guide views before and after surfacing.
- Check search terms for benefit/aid intent.
- Keep what improves usage.
- Polish or hide what still feels weak.

## Final Judgment

DemoAlam does not need another big Home redesign right now.

It needs this sequence:

```txt
Verify hidden guides
Connect useful ones
Polish weak ones
Measure usage
Then add only what is still missing
```

The guide library is richer than it looks. The next win is not more content volume. It is better routing, better framing, and better continuity between Home promises and guide depth.

