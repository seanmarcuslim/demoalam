import { StyleSheet, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'

import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import type { ThemeColors } from '../../theme/colors'
import SafeText from '../ui/SafeText'

interface GuideTrustItemProps {
  icon: keyof typeof Ionicons.glyphMap
  label: string
  value: string
}

export default function GuideTrustItem({
  icon,
  label,
  value,
}: GuideTrustItemProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors)

  return (
    <View style={styles.item}>
      <Ionicons name={icon} size={17} color={colors.primary} />

      <View style={styles.copy}>
        <SafeText variant="caption" color="muted" numberOfLines={1}>
          {label}
        </SafeText>
        <SafeText variant="caption" weight="700" numberOfLines={1}>
          {value}
        </SafeText>
      </View>
    </View>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    item: {
      flexBasis: '48.8%',
      flexGrow: 1,
      minHeight: 46,
      borderRadius: 12,
      backgroundColor: colors.surfaceSecondary,
      paddingHorizontal: spacing.sm,
      paddingVertical: spacing.xs,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
    },

    copy: {
      flex: 1,
    },
  })
