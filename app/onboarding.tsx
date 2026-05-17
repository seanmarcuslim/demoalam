import { View, Text, TouchableOpacity, StyleSheet } from 'react-native'
import { router } from 'expo-router'
import { useOnboardingStore } from '../src/stores/onboardingStore'
import { colors } from '../src/theme/colors'
import { spacing } from '../src/theme/spacing'
import { typography } from '../src/theme/typography'

export default function OnboardingScreen() {
  const completeOnboarding = useOnboardingStore(
    (state) => state.completeOnboarding
  )

  const handleGetStarted = () => {
    completeOnboarding()
    router.replace('/(tabs)')
  }

  return (
    <View style={styles.container}>
      <Text style={styles.logo}>DemoAlam 💡</Text>

      <Text style={styles.title}>
        Alamin ang mga bagay na sana noon mo pa nalaman.
      </Text>

      <Text style={styles.subtitle}>
        Guides, scam alerts, useful tips, and practical knowledge made simple.
      </Text>

      <View style={styles.card}>
        <Text style={styles.cardText}>📚 Learn useful guides</Text>
        <Text style={styles.cardText}>🚨 Avoid scams</Text>
        <Text style={styles.cardText}>🔖 Save important topics</Text>
        <Text style={styles.cardText}>🔍 Search what you need</Text>
      </View>

      <TouchableOpacity
        activeOpacity={0.85}
        style={styles.button}
        onPress={handleGetStarted}
      >
        <Text style={styles.buttonText}>Get Started</Text>
      </TouchableOpacity>
    </View>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.primary,
    padding: spacing.lg,
    justifyContent: 'center',
  },

  logo: {
    ...typography.h1,
    color: colors.surface,
    textAlign: 'center',
    marginBottom: spacing.xl,
  },

  title: {
    ...typography.h1,
    color: colors.surface,
    textAlign: 'center',
    marginBottom: spacing.md,
  },

  subtitle: {
    ...typography.body,
    color: colors.primaryLight,
    textAlign: 'center',
    lineHeight: 24,
    marginBottom: spacing.xl,
  },

  card: {
    backgroundColor: 'rgba(255,255,255,0.15)',
    borderRadius: 18,
    padding: spacing.lg,
    marginBottom: spacing.xl,
  },

  cardText: {
    ...typography.body,
    color: colors.surface,
    marginBottom: spacing.sm,
  },

  button: {
    backgroundColor: colors.surface,
    borderRadius: 16,
    padding: spacing.md,
    alignItems: 'center',
  },

  buttonText: {
    ...typography.body,
    color: colors.primary,
    fontWeight: '700',
  },
})