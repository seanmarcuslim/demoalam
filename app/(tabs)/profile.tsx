import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Switch,
  Alert,
  ScrollView,
} from 'react-native'
import { router } from 'expo-router'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { useSavedStore } from '../../src/stores/savedStore'
import { useSessionStore } from '../../src/stores/sessionStore'
import { useOnboardingStore } from '../../src/stores/onboardingStore'
import { useAuth } from '../../src/hooks/useAuth'
import { colors } from '../../src/theme/colors'
import { spacing } from '../../src/theme/spacing'
import { typography } from '../../src/theme/typography'

export default function ProfileScreen() {
  const { language, setLanguage } = useSettingsStore()
  const { savedIds } = useSavedStore()
  const { isGuest, email } = useSessionStore()
  const { resetOnboarding } = useOnboardingStore()
  const { signOut, isLoading } = useAuth()

  const handleLogout = async () => {
    try {
      await signOut()
      Alert.alert('Logged out', 'You are now browsing as guest.')
    } catch (error: any) {
      Alert.alert('Logout failed', error.message || 'Please try again.')
    }
  }

  const handleResetOnboarding = () => {
    resetOnboarding()
    router.replace('/onboarding')
  }

  return (
    <ScrollView
      style={styles.container}
      contentContainerStyle={styles.content}
      showsVerticalScrollIndicator={false}
    >
      <View style={styles.header}>
        <Text style={styles.avatar}>{isGuest ? '👤' : '✅'}</Text>

        <Text style={styles.title}>
          {isGuest ? 'Guest User' : 'Logged In'}
        </Text>

        <Text style={styles.subtitle}>
          {isGuest ? 'Nagba-browse bilang bisita' : email}
        </Text>
      </View>

      <View style={styles.statsRow}>
        <View style={styles.statCard}>
          <Text style={styles.statNumber}>{savedIds.length}</Text>
          <Text style={styles.statLabel}>Na-save</Text>
        </View>
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Account</Text>

        {isGuest ? (
          <View style={styles.authCard}>
            <TouchableOpacity
              activeOpacity={0.85}
              style={styles.primaryButton}
              onPress={() => router.push('/login')}
            >
              <Text style={styles.primaryButtonText}>Login</Text>
            </TouchableOpacity>

            <TouchableOpacity
              activeOpacity={0.85}
              style={styles.secondaryButton}
              onPress={() => router.push('/register')}
            >
              <Text style={styles.secondaryButtonText}>
                Create Account
              </Text>
            </TouchableOpacity>
          </View>
        ) : (
          <TouchableOpacity
            activeOpacity={0.85}
            style={styles.logoutButton}
            onPress={handleLogout}
            disabled={isLoading}
          >
            <Text style={styles.logoutButtonText}>
              {isLoading ? 'Logging out...' : 'Logout'}
            </Text>
          </TouchableOpacity>
        )}
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Mga Setting</Text>

        <View style={styles.settingRow}>
          <View>
            <Text style={styles.settingLabel}>Wika</Text>

            <Text style={styles.settingSubtitle}>
              {language === 'fil' ? 'Filipino' : 'English'}
            </Text>
          </View>

          <Switch
            value={language === 'fil'}
            onValueChange={(val) => setLanguage(val ? 'fil' : 'en')}
            trackColor={{
              false: colors.border,
              true: colors.primary,
            }}
            thumbColor={colors.surface}
          />
        </View>

        <TouchableOpacity
          activeOpacity={0.85}
          style={styles.resetButton}
          onPress={handleResetOnboarding}
        >
          <Text style={styles.resetButtonText}>
            Reset Onboarding
          </Text>
        </TouchableOpacity>
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Tungkol sa App</Text>

        <View style={styles.aboutCard}>
          <Text style={styles.appName}>DemoAlam 💡</Text>

          <Text style={styles.appTagline}>
            "Sayang, ngayon ko lang nalaman."
          </Text>

          <Text style={styles.appVersion}>
            Version 1.0.0
          </Text>
        </View>
      </View>
    </ScrollView>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },

  content: {
    paddingBottom: 140,
  },

  header: {
    backgroundColor: colors.primary,
    padding: spacing.lg,
    paddingTop: spacing.xxl,
    alignItems: 'center',
  },

  avatar: {
    fontSize: 48,
    marginBottom: spacing.sm,
  },

  title: {
    ...typography.h2,
    color: colors.surface,
  },

  subtitle: {
    ...typography.body,
    color: colors.primaryLight,
    marginTop: spacing.xs,
    textAlign: 'center',
  },

  statsRow: {
    flexDirection: 'row',
    padding: spacing.md,
    gap: spacing.md,
  },

  statCard: {
    backgroundColor: colors.surface,
    borderRadius: 12,
    padding: spacing.md,
    alignItems: 'center',
    flex: 1,
    elevation: 2,
  },

  statNumber: {
    ...typography.h1,
    color: colors.primary,
  },

  statLabel: {
    ...typography.caption,
    color: colors.textMuted,
    marginTop: spacing.xs,
  },

  section: {
    padding: spacing.md,
  },

  sectionTitle: {
    ...typography.h3,
    color: colors.text,
    marginBottom: spacing.md,
  },

  authCard: {
    backgroundColor: colors.surface,
    borderRadius: 12,
    padding: spacing.md,
    elevation: 2,
  },

  primaryButton: {
    backgroundColor: colors.primary,
    borderRadius: 12,
    padding: spacing.md,
    alignItems: 'center',
    marginBottom: spacing.sm,
  },

  primaryButtonText: {
    ...typography.body,
    color: colors.surface,
    fontWeight: '700',
  },

  secondaryButton: {
    borderWidth: 1,
    borderColor: colors.primary,
    borderRadius: 12,
    padding: spacing.md,
    alignItems: 'center',
  },

  secondaryButtonText: {
    ...typography.body,
    color: colors.primary,
    fontWeight: '700',
  },

  logoutButton: {
    backgroundColor: colors.danger,
    borderRadius: 12,
    padding: spacing.md,
    alignItems: 'center',
  },

  logoutButtonText: {
    ...typography.body,
    color: colors.surface,
    fontWeight: '700',
  },

  settingRow: {
    backgroundColor: colors.surface,
    borderRadius: 12,
    padding: spacing.md,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    elevation: 2,
  },

  settingLabel: {
    ...typography.body,
    color: colors.text,
    fontWeight: '600',
  },

  settingSubtitle: {
    ...typography.caption,
    color: colors.textMuted,
    marginTop: 2,
  },

  resetButton: {
    backgroundColor: colors.surface,
    borderRadius: 12,
    padding: spacing.md,
    alignItems: 'center',
    marginTop: spacing.md,
    borderWidth: 1,
    borderColor: colors.border,
  },

  resetButtonText: {
    ...typography.body,
    color: colors.text,
    fontWeight: '700',
  },

  aboutCard: {
    backgroundColor: colors.surface,
    borderRadius: 12,
    padding: spacing.lg,
    alignItems: 'center',
    elevation: 2,
  },

  appName: {
    ...typography.h2,
    color: colors.primary,
  },

  appTagline: {
    ...typography.body,
    color: colors.textMuted,
    textAlign: 'center',
    marginTop: spacing.sm,
    fontStyle: 'italic',
  },

  appVersion: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.md,
  },
})