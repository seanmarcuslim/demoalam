import { StyleSheet, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'

import SafeText from '../ui/SafeText'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import type { ThemeColors } from '../../theme/colors'

interface ChecklistBlockProps {
  items: string[]
  language: 'en' | 'fil'
}

export default function ChecklistBlock({ items, language }: ChecklistBlockProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors)

  if (!items?.length) {
    return null
  }

  return (
    <View style={styles.container}>
      <SafeText variant="label" weight="700" style={styles.title}>
        {language === 'fil' ? 'Listahan' : 'Checklist'}
      </SafeText>

      {items.map((item, index) => (
        <View key={`${item}-${index}`} style={styles.row}>
          <Ionicons name="checkmark-circle" size={18} color={colors.success} />

          <SafeText variant="bodyMd" color="muted" style={styles.item}>
            {item}
          </SafeText>
        </View>
      ))}
    </View>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      marginTop: spacing.lg,
      borderRadius: 16,
      borderWidth: 1,
      borderColor: colors.border,
      backgroundColor: colors.surfaceSecondary,
      padding: spacing.md,
      gap: spacing.md,
    },

    title: {
      color: colors.text,
      letterSpacing: 0.6,
    },

    row: {
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.sm,
    },

    item: {
      flex: 1,
      lineHeight: 22,
    },
  })
