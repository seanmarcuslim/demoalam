# DSWD Financial Aid Guide Roadmap

Date: 2026-05-26

## Architecture Decision

Status: APPROVED

DemoAlam should create a focused DSWD/government assistance guide cluster. This fits the product mission better than generic adulting content because many Filipinos miss active public benefits due to poor dissemination, confusing requirements, fake pages, and fixer culture.

The cluster must stay trust-first:

- Use official DSWD, field office, or program pages as sources.
- Avoid claiming guaranteed approval.
- Explain assessment, eligibility, and documents clearly.
- Warn against fake pages, processing fees, OTP requests, and fixer promises.
- Keep each guide specific to one user situation.

## Priority Guide Cluster

### 1. DSWD AICS Crisis Assistance

Status: Upgraded and verified
Priority: CRITICAL
MVP necessity: REQUIRED
Impact: 10/10
Complexity: 4/10

Why:
AICS is the strongest current DSWD financial assistance guide for DemoAlam because it covers crisis needs such as medical, burial, transportation, education, food, and other urgent assistance after social worker assessment.

Next upgrade:

- Add decision matrix by assistance type.
- Add "cash vs guarantee letter" explanation.
- Add sample questions for medical, burial, education, and transportation needs.
- Add warning that AKAP-related needs may now route through AICS depending on current DSWD implementation.

### 2. Social Pension for Indigent Senior Citizens

Status: Upgraded and verified
Priority: CRITICAL
MVP necessity: REQUIRED
Impact: 10/10
Complexity: 4/10

Guide title:
`Social pension checklist para sa indigent senior citizens`

Why:
Very high public value. Many families do not understand eligibility, waitlists, LGU/OSCA coordination, quarterly payout, and scam risks.

Core content:

- Who may qualify: 60+, indigent, sickly/frail/with disability, no SSS/GSIS/PVAO pension, no regular income or adequate family support.
- Amount: DSWD sources state Php1,000 monthly stipend, usually released quarterly.
- Process: DSWD Field Offices coordinate with LGUs, OSCA, and local social welfare offices.
- Warning: fake pension registration links, data harvesting, and people promising inclusion for a fee.
- Sample question: "Pwede po bang malaman kung nasa waitlist ang senior namin, ano ang requirements, at saan po ang official validation?"

### 3. 4Ps New Beneficiary Validation

Status: Upgraded and verified as explainer guide, not application guide
Priority: HIGH
MVP necessity: REQUIRED
Impact: 9/10
Complexity: 4/10

Guide title:
`4Ps validation: bakit hindi ito basta ina-applyan`

Why:
This is a common confusion point. DSWD has stated that new 4Ps beneficiaries come from the CBMS list after validation and verification, not from ordinary walk-in application.

Core content:

- 4Ps is not a normal open application.
- New beneficiaries are based on CBMS/PSA data and DSWD validation.
- Explain what families can prepare: correct household records, contact details, children school attendance, health requirements if selected.
- Warning: fake 4Ps registration links and paid "inclusion" promises.
- Include adjacent benefit awareness: qualified 4Ps households may have automatic lifeline rate enrollment for electricity subsidy based on DSWD/DOE/ERC policy.

### 4. Emergency Cash Transfer / Disaster Cash Aid

Status: Upgraded and verified
Priority: HIGH
MVP necessity: REQUIRED
Impact: 9/10
Complexity: 5/10

Guide title:
`Disaster cash aid checklist pagkatapos ng baha, lindol, sunog, o evacuation`

Why:
ECT and disaster cash aid are highly relevant but location/event-specific. DemoAlam should explain how to verify eligibility and avoid fake payout posts, not promise availability everywhere.

Core content:

- Disaster cash aid depends on affected area, validation, and DSWD/LGU coordination.
- Prepare ID, proof of residence, household details, evacuation/disaster impact records, and LGU validation info.
- Ask barangay/LGU/DSWD field office for official payout schedule.
- Warning: fake payout lists and "processing fee" scams.

### 5. Walang Gutom Program / Food Stamp Program

Status: Upgraded and verified
Priority: HIGH
MVP necessity: REQUIRED
Impact: 9/10
Complexity: 5/10

Guide title:
`Walang Gutom food credits: paano i-check kung kasama ang household`

Why:
Walang Gutom is an active DSWD food assistance and nutrition-focused program. It is highly relevant because people may mistake it for general cash ayuda. The guide should explain EBT/food credits, accredited stores, validation, rollout, and fake registration risks.

Core content:

- It is for food-poor households and selected beneficiaries after official validation.
- It uses Electronic Benefit Transfer cards/food credits to buy selected nutritious foods from accredited merchants.
- DSWD reported reaching 600,000 household-beneficiaries in its second year rollout.
- Some sources mention Php3,000 food credits in 2026 redemption activities.
- It is not a random online application or guaranteed cash payout.
- Ask DSWD/LGU/official program channels about validation, EBT card, accredited store, redemption schedule, and current rollout in your area.
- Warning: fake registration links, payout posts, processing fees, and people asking for OTP, bank login, or e-wallet login.

Verified improvements:

- Improved Filipino title and copy.
- Added clearer expectations before traveling.
- Kept the guide careful: it explains verification and food credits, not cash payout or guaranteed inclusion.

### 6. Student Cash-for-Work / Tara, Basa / KALAHI-CIDSS Opportunities

Status: Upgraded and verified
Priority: HIGH
MVP necessity: REQUIRED
Impact: 8/10
Complexity: 5/10

Guide title:
`Student cash-for-work programs: paano i-check kung may bukas sa lugar mo`

Why:
Recent DSWD updates show active student/youth-related cash-for-work and tutoring initiatives. These are useful but not universally available, so the guide must teach verification by LGU, school, DSWD field office, and official announcements.

Core content:

- Programs may involve LGUs, schools, state universities, and DSWD field offices.
- Availability depends on area, partner institutions, and current rollout.
- Prepare school ID, enrollment proof, residency, contact details, and official application channel.
- Warning: fake training fees and fake recruitment forms.

### 7. Sustainable Livelihood Program / Livelihood Assistance

Status: Upgraded and verified
Priority: HIGH
MVP necessity: REQUIRED
Impact: 8/10
Complexity: 6/10

Guide title:
`Livelihood assistance checklist: kailan DSWD SLP ang tamang tanungin`

Why:
Useful, especially for vulnerable workers, 4Ps households, repatriated OFWs, disaster-affected families, and families needing income recovery. The guide must explain SLP as livelihood preparation and support, not instant cash ayuda.

Core content:

- Explain that livelihood aid may require assessment and program fit.
- Distinguish cash assistance from livelihood support.
- Prepare basic household, skills, income, and livelihood plan details.
- Warn against people promising instant livelihood grants for a fee.

## Replace Or Deprioritize

To make room for this stronger direction, deprioritize or replace low-leverage generic guides first:

1. `payday-budget-simple-split`
2. `first-time-utility-bills`
3. `moving-out-budget`
4. `job-interview-basic-answers`

Do not remove all adulting content. Keep only adulting guides that prevent exploitation, debt, housing loss, or document problems.

## Sprint Result

Completed and verified:

1. `dswd-aics-assistance-checklist`
2. `walang-gutom-food-credits-checklist`
3. `social-pension-indigent-senior-citizens`
4. `four-ps-validation-checklist`
5. `emergency-cash-transfer-disaster-aid-checklist`
6. `student-cash-for-work-dswd-checklist`
7. `sustainable-livelihood-program-checklist`

Next DSWD action:

Do not add more DSWD guides immediately. Run a search/category quality audit first, then decide whether to add a new guide or improve discovery.

## Content Rule

Never write DSWD guides as "how to get guaranteed ayuda."

Write them as:

- "How to know if this program might apply to you"
- "What documents to prepare"
- "Where to verify"
- "What scams/fixers to avoid"
- "What exact question to ask"

This keeps DemoAlam truthful, practical, anti-fixer, and safe.
