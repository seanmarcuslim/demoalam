# DemoAlam QA Checklist

Use this with Expo Go before considering a build ready.

## Smoke Test

- App opens without red screen.
- Onboarding appears for first launch.
- Bottom tabs load after onboarding.
- Dark mode toggle works.
- Language toggle updates visible copy.
- Pull-to-refresh does not crash Home, Categories, or Category Detail.

## Home

- Hero text fits on small phone screens.
- Category chips scroll horizontally.
- Trending section appears.
- Guide cards open guide detail.
- Save button shows feedback.
- Home shows retry state when guide loading fails.

## Categories

- Top banner has correct height and does not crowd stat pills.
- All categories render.
- Category banner tap opens Category Detail.
- Empty/error state shows correct copy.
- Retry button works after failed load.

## Search

- Keyboard stays open while typing.
- Recent searches save only on submit, suggestion tap, or recent tap.
- Category filters do not hide any category.
- No-results state is clear.
- Error state shows retry.

## Guide Detail

- Back button works.
- Save/share buttons work.
- Trust check card renders.
- Official sources appear only when guide has sources.
- Source links open browser.
- Offline cached guide shows saved offline notice.
- Empty cached summary explains how to refresh full guide.

## Saved

- Saved guide appears after saving.
- Saved guide opens detail.
- After cache migration, saved IDs show refresh state instead of false empty state.
- Offline saved notice is visible when cached guides exist.

## Profile

- Language toggle works.
- Dark mode toggle works.
- Login/register navigation works.
- Logout handles failure gracefully.

## Offline

- Offline banner appears when network is disabled.
- Saved screen remains usable with cached guides.
- Search/Home show useful retry or cached behavior.

## Performance

- Home scroll feels smooth.
- Category list scroll feels smooth.
- Search typing does not dismiss keyboard.
- No obvious layout jump after loading skeletons.
