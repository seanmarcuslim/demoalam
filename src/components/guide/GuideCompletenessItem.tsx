import { StyleSheet, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'

import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import type { ThemeColors } from '../../theme/colors'
import SafeText from '../ui/SafeText'

interface GuideCompletenessItemProps {
  done: boolean
  label: string
}

export default function GuideCompletenessItem({
  done,
  label,
}: GuideCompletenessItemProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors)

  return (
    <View style={[styles.item, done ? styles.done : styles.pending]}>
      <Ionicons
        name={done ? 'checkmark-circle' : 'ellipse-outline'}
        size={15}
        color={done ? colors.success : colors.textLight}
      />
      <SafeText
        variant="caption"
        weight="700"
        style={{ color: done ? colors.success : colors.textMuted }}
        numberOfLines={1}
      >
        {label}
      </SafeText>
    </View>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    item: {
      minHeight: 30,
      borderRadius: 999,
      borderWidth: 1,
      paddingHorizontal: spacing.sm,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
    },

    done: {
      borderColor: `${colors.success}30`,
      backgroundColor: colors.successLight,
    },

    pending: {
      borderColor: colors.border,
      backgroundColor: colors.surfaceSecondary,
    },
  })
