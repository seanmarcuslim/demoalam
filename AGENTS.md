# DemoAlam Agent Instructions

## Expo Version Rule

Expo has changed. Before writing Expo-specific code, check the exact versioned docs at:

https://docs.expo.dev/versions/v54.0.0/

## Product North Star

DemoAlam is becoming the Filipino Future Advantage Platform.

Mission:

Help Filipinos learn the right lesson, make the right decision, and take the right action before life teaches it the hard way.

Future Advantage means helping users make better decisions, avoid preventable mistakes, discover opportunities earlier, protect resources, and create better long-term outcomes.

Every product, UX, content, workflow, recommendation, notification, and architecture decision should answer:

"How does this increase the user's Future Advantage?"

If the answer is weak, question the change.

## Product Feel

DemoAlam should feel like:

- a wise mentor
- a trusted older sibling
- a future self giving advice
- a life navigation companion

It should not feel like:

- a government portal
- a generic content library
- a chatbot for its own sake
- a school project

The desired user reaction is:

"Why did nobody teach me this earlier?"

and later:

"I'm glad I learned this before it became a problem."

## Preserve The Foundation

Do not rebuild DemoAlam. Evolve it.

Preserve:

- existing Expo Router architecture
- existing Supabase backend
- existing guides
- existing categories
- existing search
- existing saved guides
- existing APK functionality
- existing dark mode support

Prefer small, reversible improvements over rewrites.

## Decision Rules

Optimize for:

- usefulness
- clarity
- accuracy
- trust
- timing
- actionability
- mobile readability
- user confidence
- long-term usefulness

Do not optimize for:

- number of features
- number of guides
- complexity
- AI for the sake of AI
- perfect process
- perfect architecture

Small reversible improvements may move fast:

- search phrase improvements
- guide readability polish
- translation fixes
- mobile layout fixes
- copy improvements
- trust/source fixes
- Quick Check wording
- small UI polish
- bug fixes

Structural changes need review first:

- database redesign
- flow engine
- AI systems
- payment systems
- major navigation rewrite
- analytics expansion
- large content migrations

## Working Style

For small polish:

Notice rough edge -> fix it -> typecheck -> manual QA -> commit/PR -> observe.

For bigger product changes, first explain:

1. Why it is better.
2. What problem it solves.
3. What tradeoffs it introduces.
4. How it aligns with Future Advantage.

Do not let process become the product.
