# DemoAlam Design Notes

DemoAlam should feel practical, trustworthy, calm, and easy to read.

## Visual Direction

- Professional, not playful-first.
- Warm enough for everyday Filipino users.
- Calm enough for government, money, and scam-prevention topics.
- Mobile-first and readable on budget Android phones.

## Color System

Colors live in `src/theme/colors.ts`.

Use theme tokens instead of hard-coded colors whenever possible:

- `colors.background`
- `colors.surface`
- `colors.surfaceSecondary`
- `colors.text`
- `colors.textMuted`
- `colors.primary`
- `colors.accent`
- `colors.success`
- `colors.warning`
- `colors.danger`

## Dark Mode

Dark mode should use charcoal/navy surfaces, not pure black.

Goal:

- reduce harsh contrast
- keep cards readable
- keep blue premium, not neon
- preserve semantic warning/danger/success meaning

## Category Accents

Category accent colors live in `src/lib/categoryVisuals.ts`.

Use `getCategoryAccent(category, colors.primary)` instead of reading `category.color` directly in UI. This protects the app from old database colors and keeps Home, Search, Categories, and Guide cards visually consistent.

## Cards

- Use `AppCard` for repeated card surfaces.
- Avoid nested cards.
- Prefer borders plus subtle elevation.
- Keep radius moderate. DemoAlam should not look like a toy app.

## Guide Trust UI

Guide Detail should always make clear:

- when the content was last updated
- whether official sources exist
- that DemoAlam helps but does not replace official advice
- when the user is seeing a saved offline copy

Official links should only appear when `official_sources` exists.
