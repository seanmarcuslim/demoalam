import {
  Alert,
  ScrollView,
  StyleSheet,
  Switch,
  TouchableOpacity,
  View,
} from 'react-native'
import { router } from 'expo-router'
import Constants from 'expo-constants'
import { Ionicons } from '@expo/vector-icons'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { useSavedStore } from '../../src/stores/savedStore'
import { useSessionStore } from '../../src/stores/sessionStore'
import { useOnboardingStore } from '../../src/stores/onboardingStore'
import { useAuth } from '../../src/hooks/useAuth'
import { useTheme } from '../../src/hooks/useTheme'
import { translations } from '../../src/utils/translations'
import { spacing } from '../../src/theme/spacing'
import type { ThemeColors } from '../../src/theme/colors'
import SafeText from '../../src/components/ui/SafeText'

export default function ProfileScreen() {
  const {
    language,
    setLanguage,
    theme,
    toggleTheme,
  } = useSettingsStore()

  const { colors, isDark } = useTheme()
  const { savedIds } = useSavedStore()
  const { isGuest, email } = useSessionStore()
  const { resetOnboarding } = useOnboardingStore()
  const { signOut, isLoading } = useAuth()
  const t = translations[language]
  const labels = t.profileScreen
  const styles = createStyles(colors)
  const appVersion = Constants.expoConfig?.version || '1.0.0'

  const handleLogout = async () => {
    try {
      await signOut()

      Alert.alert(
        labels.loggedOutTitle,
        labels.loggedOutMessage
      )
    } catch (error: unknown) {
      Alert.alert(
        labels.logoutFailedTitle,
        getErrorMessage(error, labels.tryAgain)
      )
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
      <View style={styles.hero}>
        <View style={styles.heroGlow} />

        <View style={styles.avatar}>
          <Ionicons
            name={isGuest ? 'person-outline' : 'checkmark-circle'}
            size={30}
            color={colors.primary}
          />
        </View>

        <SafeText variant="h1" color="surface" style={styles.heroTitle}>
          {isGuest ? labels.guestMode : labels.loggedIn}
        </SafeText>

        <SafeText variant="bodyMd" color="surface" style={styles.heroSubtitle}>
          {isGuest ? labels.guestSubtitle : email}
        </SafeText>

        <View style={styles.heroStats}>
          <View style={styles.statPill}>
            <SafeText variant="h2" color="surface">
              {savedIds.length}
            </SafeText>
            <SafeText variant="caption" color="surface" style={styles.statLabel}>
              {labels.savedStat}
            </SafeText>
          </View>
        </View>
      </View>

      <View style={styles.section}>
        <SafeText variant="h3" weight="700" style={styles.sectionTitle}>
          {t.account}
        </SafeText>

        {isGuest ? (
          <View style={styles.panel}>
            <SafeText variant="bodyMd" color="muted" style={styles.panelCopy}>
              {labels.guestAccountCopy}
            </SafeText>

            <TouchableOpacity
              activeOpacity={0.86}
              style={styles.primaryButton}
              onPress={() => router.push('/login')}
            >
              <Ionicons name="log-in-outline" size={18} color="#FFFFFF" />
              <SafeText color="surface" weight="700">
                {t.login}
              </SafeText>
            </TouchableOpacity>

            <TouchableOpacity
              activeOpacity={0.86}
              style={styles.secondaryButton}
              onPress={() => router.push('/register')}
            >
              <SafeText color="primary" weight="700">
                {t.createAccount}
              </SafeText>
            </TouchableOpacity>
          </View>
        ) : (
          <TouchableOpacity
            activeOpacity={0.86}
            style={styles.dangerButton}
            onPress={handleLogout}
            disabled={isLoading}
          >
            <Ionicons name="log-out-outline" size={18} color="#FFFFFF" />
            <SafeText color="surface" weight="700">
              {isLoading
                ? labels.loggingOut
                : t.logout}
            </SafeText>
          </TouchableOpacity>
        )}
      </View>

      <View style={styles.section}>
        <SafeText variant="h3" weight="700" style={styles.sectionTitle}>
          {labels.settings}
        </SafeText>

        <SettingRow
          icon="language-outline"
          title={labels.language}
          subtitle={language === 'fil' ? 'Filipino' : 'English'}
          right={
            <Switch
              value={language === 'fil'}
              onValueChange={(val) => setLanguage(val ? 'fil' : 'en')}
              trackColor={{
                false: colors.border,
                true: colors.primary,
              }}
              thumbColor={colors.surface}
            />
          }
        />

        <SettingRow
          icon="moon-outline"
          title={t.darkMode}
          subtitle={isDark ? t.enabled : t.disabled}
          right={
            <Switch
              value={theme === 'dark'}
              onValueChange={toggleTheme}
              trackColor={{
                false: colors.border,
                true: colors.primary,
              }}
              thumbColor={colors.surface}
            />
          }
        />

        <TouchableOpacity
          activeOpacity={0.86}
          style={styles.resetRow}
          onPress={handleResetOnboarding}
        >
          <View style={styles.rowIcon}>
            <Ionicons name="refresh" size={20} color={colors.primary} />
          </View>
          <View style={styles.rowCopy}>
            <SafeText weight="700">
              {labels.resetOnboarding}
            </SafeText>
            <SafeText variant="caption" color="muted" style={styles.rowSubtitle}>
              {labels.resetOnboardingSubtitle}
            </SafeText>
          </View>
          <Ionicons name="chevron-forward" size={18} color={colors.textLight} />
        </TouchableOpacity>
      </View>

      <View style={styles.section}>
        <SafeText variant="h3" weight="700" style={styles.sectionTitle}>
          {labels.aboutApp}
        </SafeText>

        <View style={styles.aboutCard}>
          <View style={styles.aboutIcon}>
            <SafeText variant="h2">{'\u{1F4A1}'}</SafeText>
          </View>
          <SafeText variant="h2" color="primary">
            DemoAlam
          </SafeText>
          <SafeText variant="bodyMd" color="muted" style={styles.appTagline}>
            {labels.tagline}
          </SafeText>
          <SafeText variant="bodyMd" color="muted" style={styles.appMission}>
            {labels.mission}
          </SafeText>
          <SafeText variant="caption" color="light" style={styles.appVersion}>
            Version {appVersion}
          </SafeText>
        </View>
      </View>
    </ScrollView>
  )

  function SettingRow({
    icon,
    title,
    subtitle,
    right,
  }: {
    icon: keyof typeof Ionicons.glyphMap
    title: string
    subtitle: string
    right: React.ReactNode
  }) {
    return (
      <View style={styles.settingRow}>
        <View style={styles.rowIcon}>
          <Ionicons name={icon} size={20} color={colors.primary} />
        </View>
        <View style={styles.rowCopy}>
          <SafeText weight="700">{title}</SafeText>
          <SafeText variant="caption" color="muted" style={styles.rowSubtitle}>
            {subtitle}
          </SafeText>
        </View>
        {right}
      </View>
    )
  }
}

function getErrorMessage(error: unknown, fallback: string) {
  return error instanceof Error ? error.message : fallback
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },

    content: {
      paddingBottom: 140,
    },

    hero: {
      backgroundColor: colors.primary,
      paddingHorizontal: spacing.lg,
      paddingTop: spacing.xxl,
      paddingBottom: spacing.lg,
      borderBottomLeftRadius: 24,
      borderBottomRightRadius: 24,
      alignItems: 'center',
      overflow: 'hidden',
    },

    heroGlow: {
      position: 'absolute',
      right: -48,
      top: -52,
      width: 152,
      height: 152,
      borderRadius: 76,
      backgroundColor: 'rgba(255,255,255,0.13)',
    },

    avatar: {
      width: 68,
      height: 68,
      borderRadius: 24,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
      marginBottom: spacing.md,
    },

    heroTitle: {
      textAlign: 'center',
    },

    heroSubtitle: {
      opacity: 0.9,
      marginTop: spacing.sm,
      textAlign: 'center',
    },

    heroStats: {
      marginTop: spacing.lg,
      flexDirection: 'row',
    },

    statPill: {
      minWidth: 110,
      borderRadius: 16,
      borderWidth: 1,
      borderColor: 'rgba(255,255,255,0.28)',
      backgroundColor: 'rgba(255,255,255,0.12)',
      paddingVertical: spacing.md,
      paddingHorizontal: spacing.lg,
      alignItems: 'center',
    },

    statLabel: {
      opacity: 0.88,
    },

    section: {
      paddingHorizontal: spacing.md,
      paddingTop: spacing.lg,
    },

    sectionTitle: {
      marginBottom: spacing.md,
    },

    panel: {
      backgroundColor: colors.surface,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.md,
    },

    panelCopy: {
      marginBottom: spacing.md,
    },

    primaryButton: {
      minHeight: 50,
      borderRadius: 14,
      backgroundColor: colors.primary,
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'center',
      gap: spacing.sm,
      marginBottom: spacing.sm,
    },

    secondaryButton: {
      minHeight: 50,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.primary,
      alignItems: 'center',
      justifyContent: 'center',
    },

    dangerButton: {
      minHeight: 50,
      borderRadius: 14,
      backgroundColor: colors.danger,
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'center',
      gap: spacing.sm,
    },

    settingRow: {
      backgroundColor: colors.surface,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.md,
      flexDirection: 'row',
      alignItems: 'center',
      marginBottom: spacing.md,
      gap: spacing.md,
    },

    resetRow: {
      backgroundColor: colors.surface,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.md,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.md,
    },

    rowIcon: {
      width: 40,
      height: 40,
      borderRadius: 14,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
    },

    rowCopy: {
      flex: 1,
    },

    rowSubtitle: {
      marginTop: 2,
    },

    aboutCard: {
      backgroundColor: colors.surface,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.lg,
      alignItems: 'center',
    },

    aboutIcon: {
      width: 58,
      height: 58,
      borderRadius: 20,
      backgroundColor: colors.accentLight,
      alignItems: 'center',
      justifyContent: 'center',
      marginBottom: spacing.md,
    },

    appTagline: {
      textAlign: 'center',
      marginTop: spacing.sm,
      fontStyle: 'italic',
    },

    appMission: {
      textAlign: 'center',
      marginTop: spacing.md,
      maxWidth: 330,
    },

    appVersion: {
      marginTop: spacing.md,
    },
  })
