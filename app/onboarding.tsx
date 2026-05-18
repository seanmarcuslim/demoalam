import {
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  View,
} from 'react-native'
import { Ionicons } from '@expo/vector-icons'
import { router } from 'expo-router'
import { useOnboardingStore } from '../src/stores/onboardingStore'
import { useSettingsStore } from '../src/stores/settingsStore'
import { useTheme } from '../src/hooks/useTheme'
import { spacing } from '../src/theme/spacing'
import SafeText from '../src/components/ui/SafeText'

const VALUE_POINTS = [
  {
    icon: 'card-outline',
    fil: 'Alamin ang requirements bago pumila',
    en: 'Know requirements before lining up',
  },
  {
    icon: 'shield-checkmark-outline',
    fil: 'Iwasan ang common scam at red flags',
    en: 'Avoid common scams and red flags',
  },
  {
    icon: 'bookmark-outline',
    fil: 'I-save ang importanteng guide para balikan',
    en: 'Save important guides for later',
  },
]

export default function OnboardingScreen() {
  const completeOnboarding = useOnboardingStore(
    (state) => state.completeOnboarding
  )
  const { language, setLanguage } = useSettingsStore()
  const { colors } = useTheme()
  const styles = createStyles(colors)

  const isFilipino = language === 'fil'

  const handleGetStarted = () => {
    completeOnboarding()
    router.replace('/(tabs)')
  }

  return (
    <ScrollView
      style={styles.container}
      contentContainerStyle={styles.content}
      showsVerticalScrollIndicator={false}
    >
      <View style={styles.languageRow}>
        <TouchableOpacity
          activeOpacity={0.86}
          style={[
            styles.langButton,
            isFilipino && styles.langButtonActive,
          ]}
          onPress={() => setLanguage('fil')}
        >
          <SafeText
            variant="label"
            color={isFilipino ? 'surface' : 'primary'}
            weight="700"
          >
            FIL
          </SafeText>
        </TouchableOpacity>

        <TouchableOpacity
          activeOpacity={0.86}
          style={[
            styles.langButton,
            !isFilipino && styles.langButtonActive,
          ]}
          onPress={() => setLanguage('en')}
        >
          <SafeText
            variant="label"
            color={!isFilipino ? 'surface' : 'primary'}
            weight="700"
          >
            EN
          </SafeText>
        </TouchableOpacity>
      </View>

      <View style={styles.hero}>
        <View style={styles.logoMark}>
          <SafeText variant="h1">💡</SafeText>
        </View>

        <SafeText variant="caption" color="surface" style={styles.eyebrow}>
          DemoAlam
        </SafeText>

        <SafeText variant="h1" color="surface" style={styles.title}>
          {isFilipino
            ? 'Sayang, ngayon ko lang nalaman.'
            : 'Useful things worth knowing earlier.'}
        </SafeText>

        <SafeText variant="bodyMd" color="surface" style={styles.subtitle}>
          {isFilipino
            ? 'Praktikal na gabay para hindi ka malito sa ID, pera, trabaho, gobyerno, at scam alerts.'
            : 'Practical guides for IDs, money, work, government tasks, and scam alerts.'}
        </SafeText>
      </View>

      <View style={styles.previewCard}>
        <View style={styles.previewHeader}>
          <View style={styles.previewBadge}>
            <Ionicons name="warning" size={16} color={colors.danger} />
            <SafeText variant="label" color="danger" weight="700">
              {isFilipino ? 'Scam Alert' : 'Scam Alert'}
            </SafeText>
          </View>
          <SafeText variant="caption" color="light">
            3 min
          </SafeText>
        </View>

        <SafeText variant="h3" weight="700" style={styles.previewTitle}>
          {isFilipino
            ? 'Bago ka magpadala sa GCash'
            : 'Before sending money on GCash'}
        </SafeText>

        <SafeText variant="bodyMd" color="muted">
          {isFilipino
            ? 'Checklist muna: OTP, MPIN, sender name, at trusted contact.'
            : 'Check OTPs, MPINs, sender name, and trusted contacts first.'}
        </SafeText>
      </View>

      <View style={styles.valueList}>
        {VALUE_POINTS.map((item) => (
          <View key={item.icon} style={styles.valueRow}>
            <View style={styles.valueIcon}>
              <Ionicons
                name={item.icon as keyof typeof Ionicons.glyphMap}
                size={21}
                color={colors.primary}
              />
            </View>
            <SafeText variant="bodyMd" weight="700" style={styles.valueText}>
              {isFilipino ? item.fil : item.en}
            </SafeText>
          </View>
        ))}
      </View>

      <TouchableOpacity
        activeOpacity={0.88}
        style={styles.primaryButton}
        onPress={handleGetStarted}
      >
        <SafeText color="surface" weight="700">
          {isFilipino ? 'Magpatuloy bilang guest' : 'Continue as guest'}
        </SafeText>
        <Ionicons name="arrow-forward" size={18} color="#FFFFFF" />
      </TouchableOpacity>

      <SafeText variant="caption" color="muted" style={styles.footnote}>
        {isFilipino
          ? 'Walang account na kailangan para magsimula.'
          : 'No account needed to start.'}
      </SafeText>
    </ScrollView>
  )
}

const createStyles = (colors: any) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },

    content: {
      flexGrow: 1,
      padding: spacing.lg,
      paddingTop: spacing.xxl,
      paddingBottom: spacing.xl,
    },

    languageRow: {
      alignSelf: 'flex-end',
      flexDirection: 'row',
      backgroundColor: colors.surface,
      borderRadius: 999,
      borderWidth: 1,
      borderColor: colors.border,
      padding: 3,
      marginBottom: spacing.lg,
    },

    langButton: {
      minWidth: 46,
      minHeight: 34,
      borderRadius: 999,
      alignItems: 'center',
      justifyContent: 'center',
    },

    langButtonActive: {
      backgroundColor: colors.primary,
    },

    hero: {
      backgroundColor: colors.primary,
      borderRadius: 28,
      padding: spacing.lg,
      minHeight: 310,
      justifyContent: 'flex-end',
      overflow: 'hidden',
    },

    logoMark: {
      position: 'absolute',
      top: spacing.lg,
      left: spacing.lg,
      width: 62,
      height: 62,
      borderRadius: 20,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
    },

    eyebrow: {
      textTransform: 'uppercase',
      opacity: 0.82,
      marginBottom: spacing.sm,
    },

    title: {
      marginBottom: spacing.md,
    },

    subtitle: {
      opacity: 0.9,
    },

    previewCard: {
      backgroundColor: colors.surface,
      borderRadius: 18,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.md,
      marginTop: -spacing.lg,
      marginHorizontal: spacing.md,
      elevation: 4,
      shadowColor: colors.shadow,
      shadowOffset: { width: 0, height: 4 },
      shadowOpacity: 0.12,
      shadowRadius: 8,
    },

    previewHeader: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
      marginBottom: spacing.md,
    },

    previewBadge: {
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
      backgroundColor: colors.dangerLight,
      borderRadius: 999,
      paddingHorizontal: spacing.sm,
      paddingVertical: spacing.xs,
    },

    previewTitle: {
      marginBottom: spacing.xs,
    },

    valueList: {
      marginTop: spacing.lg,
      gap: spacing.sm,
    },

    valueRow: {
      backgroundColor: colors.surface,
      borderRadius: 16,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.md,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.md,
    },

    valueIcon: {
      width: 42,
      height: 42,
      borderRadius: 14,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
    },

    valueText: {
      flex: 1,
    },

    primaryButton: {
      minHeight: 54,
      borderRadius: 16,
      backgroundColor: colors.primary,
      marginTop: spacing.lg,
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'center',
      gap: spacing.sm,
    },

    footnote: {
      textAlign: 'center',
      marginTop: spacing.md,
    },
  })
