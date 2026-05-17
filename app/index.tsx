import { Redirect } from 'expo-router'
import { useOnboardingStore } from '../src/stores/onboardingStore'

export default function IndexScreen() {
  const hasCompletedOnboarding = useOnboardingStore(
    (state) => state.hasCompletedOnboarding
  )

  if (!hasCompletedOnboarding) {
    return <Redirect href="/onboarding" />
  }

  return <Redirect href="/(tabs)" />
}