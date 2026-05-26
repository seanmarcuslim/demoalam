import { StyleSheet, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'
import { useSafeAreaInsets } from 'react-native-safe-area-context'
import { useOffline } from '../../hooks/useOffline'
import { useSettingsStore } from '../../stores/settingsStore'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import type { ThemeColors } from '../../theme/colors'
import SafeText from '../ui/SafeText'
import { translations } from '../../utils/translations'

export default function OfflineBanner() {
  const { isOffline } = useOffline()
  const { language } = useSettingsStore()
  const { colors } = useTheme()
  const labels = translations[language].components.offlineBanner
  const insets = useSafeAreaInsets()
  const styles = createStyles(colors)

  if (!isOffline) {
    return null
  }

  return (
    <View
      pointerEvents="none"
      style={[
        styles.banner,
        {
          top: Math.max(insets.top, spacing.sm) + spacing.sm,
        },
      ]}
    >
      <View style={styles.iconWrap}>
        <Ionicons name="cloud-offline-outline" size={17} color={colors.warning} />
      </View>

      <SafeText variant="caption" weight="700" style={styles.text}>
        {labels.message}
      </SafeText>
    </View>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    banner: {
      position: 'absolute',
      left: spacing.md,
      right: spacing.md,
      zIndex: 60,
      elevation: 10,
      minHeight: 44,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: `${colors.warning}40`,
      backgroundColor: colors.warningLight,
      paddingHorizontal: spacing.md,
      paddingVertical: spacing.sm,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
      shadowColor: colors.shadow,
      shadowOffset: { width: 0, height: 3 },
      shadowOpacity: 0.14,
      shadowRadius: 8,
    },

    iconWrap: {
      width: 28,
      height: 28,
      borderRadius: 14,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
    },

    text: {
      flex: 1,
      color: colors.text,
    },
  })
