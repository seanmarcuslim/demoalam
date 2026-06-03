# DemoAlam Decision Flow Constitution v1

## Purpose

Decision flows are a triage layer for confusing, stressful, or high-risk situations where users need to know what to do first.

This document inherits from PRODUCT_CONSTITUTION.md. If conflicts occur, PRODUCT_CONSTITUTION.md has higher authority.

They do not replace guides. They coordinate guides.

The job of a decision flow is to reduce uncertainty, lower panic, and route the user toward the safest next step.

## Core Rule

A decision flow is allowed only when it helps the user choose between multiple meaningful next steps.

If the situation only needs one guide, do not create a flow.

## Product Relationship

DemoAlam should work like this:

```txt
Search
-> Decision Flow when needed
-> Guide
-> Checklist
-> Action
```

Not:

```txt
Search
-> Flow
-> Flow
-> Flow
```

Decision flows should remain rare, focused, and reserved for high-stress, high-uncertainty, high-consequence situations.

## When A Flow Is Allowed

A flow may be created only when most of these are true:

1. The user is likely stressed or confused.
2. The wrong first step can cause harm.
3. The situation has multiple possible paths.
4. The answer depends on the user's current condition.
5. The flow can coordinate multiple existing guides.
6. The flow can produce one clear first action.
7. The flow can be completed quickly.
8. The flow passes the DemoAlam Product Constitution.

Good candidates:

- stolen or lost phone
- wrong-send GCash
- lost SIM with OTP access
- hacked GCash or Maya account
- loan app harassment
- kulang sahod
- lost wallet with IDs/cards
- urgent medical assistance

## When A Flow Is Not Allowed

Do not create a flow when:

1. One guide already answers the issue clearly.
2. The situation is low-stress or low-consequence.
3. The flow would mainly organize information, not change decisions.
4. The user would need to answer many questions before getting value.
5. The flow would duplicate guide content.
6. The flow exists only because the topic is important.
7. The flow does not route to at least two useful guides or outcomes.

Poor candidates:

- a simple resume guide
- a single ID explainer
- broad budgeting advice
- generic education content
- general motivation or productivity topics

## Flow Design Rules

### 1. Every Question Must Change The Recommendation

Every question must affect at least one of these:

- recommended first action
- priority level
- warning level
- guide routing
- checklist routing

If removing the question does not change the outcome, remove the question.

The goal is reducing uncertainty, not collecting information.

### 2. Start With The Biggest Risk Multiplier

The earliest questions should identify the factor that can create the most damage.

Example for stolen phone:

```txt
SIM
-> OTP
-> GCash / Maya / bank
-> email recovery
```

If one answer changes several risks, ask that question early.

### 3. Keep The Flow Short

Default limits:

- maximum 7 questions
- maximum 4 options per question
- one primary recommendation
- 2-4 related guides
- target completion under 60 seconds

Confused users are impatient users.

### 4. Use Tap-Based Answers First

Do not use free-text input in early flow versions.

Use clear options such as:

- Yes
- No
- Not sure
- This applies to me

Free text can introduce ambiguity, privacy risk, and unnecessary complexity.

### 5. Always Provide A "Not Sure" Path

Users in stressful situations may not know the answer.

If the user selects "not sure," route them to the safer conservative path.

### 6. Outcome First, Explanation Second

The result screen should start with:

- priority level
- first action
- why this matters
- recommended guide

Long explanations belong inside guides, not inside flow results.

### 7. Show Priority Clearly

Each result should include a visible priority level:

- urgent
- high
- medium
- normal

Example:

```txt
Priority Level: HIGH
First Action: Secure SIM and OTP access
```

Users remember priorities better than paragraphs.

### 8. Personal Safety Comes Before Asset Recovery

Flows must never encourage users to chase thieves, meet strangers, confront suspects, or risk personal safety.

In lost or stolen item flows, safety guidance should appear early and clearly.

### 9. No Guarantees

Flows must not promise recovery, refunds, agency approval, legal outcomes, or account restoration.

They can help users protect access, prepare evidence, avoid scams, and use official channels.

### 10. Route To Guides, Do Not Rebuild Guides

Flows should not contain full guide content.

Flow:

- identifies path
- sets priority
- gives first action
- routes to guide

Guide:

- explains details
- lists steps
- provides checklists
- shows sources

Checklist:

- supports execution

## Required Flow Structure

Each decision flow should define:

1. Entry points
2. User problem statement
3. Questions
4. Options
5. Outcome rules
6. Priority levels
7. Recommended first action
8. Related guides
9. Failure cases
10. Success criteria

## Stolen Phone / Lost Phone Pilot

The first pilot flow should be:

```txt
Stolen Phone / Lost Phone First Hour
```

Reason:

This situation coordinates multiple guides and risks:

- stolen phone first-hour response
- lost SIM and OTP access
- GCash / Maya account recovery
- phishing and fake recovery scams
- lost ATM or debit card
- lost wallet and IDs

It is a strong pilot because the user often does not know where to start.

## Approved Pilot Flow Changes

The stolen phone pilot should use this simpler first question:

```txt
What best describes the situation?

- I think it was stolen
- I lost it and cannot find it
- I am not sure
```

The pilot should make the risk order explicit:

```txt
SIM / OTP access
-> financial apps
-> email and account recovery
-> device tracking
-> wallet, cards, and IDs
```

The result screen should include a visible emergency priority indicator.

## Flow Acceptance Test

Before building a flow, answer:

1. What uncertainty does this flow reduce?
2. What damage can it prevent?
3. What first decision becomes easier?
4. What safer next step becomes possible?
5. Which existing guides does it coordinate?
6. Would the flow still be useful if it had only one result?
7. Can it be completed in under 60 seconds?
8. Does every question change the recommendation?
9. Does the flow avoid legal, medical, or financial advice?
10. Does it pass the Product Constitution?

If the answers are weak, do not build the flow.

## Flow Rejection Test

Reject a proposed flow if:

- it coordinates only one guide
- it mostly repeats guide content
- it has no urgent or high-consequence decision
- it asks questions that do not change routing
- it feels like a quiz instead of help
- it exists mainly to make the app feel more advanced
- it makes DemoAlam harder to navigate
- it increases panic instead of reducing it

## Strategic Guardrail

DemoAlam should become a decision-support platform, not a flow library.

Decision flows are powerful because they are rare.

Build them only where the user's uncertainty is real, repeated, stressful, and consequential.
