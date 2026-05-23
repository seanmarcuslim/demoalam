import { StyleSheet, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'

import SafeText from '../ui/SafeText'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import type { ThemeColors } from '../../theme/colors'

interface SampleBlockProps {
  sample?: string
  language: 'en' | 'fil'
}

export default function SampleBlock({ sample, language }: SampleBlockProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors)

  if (!sample) return null

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Ionicons
          name="chatbox-ellipses-outline"
          size={16}
          color={colors.primary}
        />

        <SafeText variant="label" color="primary" weight="700">
          {language === 'fil' ? 'Halimbawa ng tanong' : 'Sample you can ask'}
        </SafeText>
      </View>

      <SafeText variant="bodyMd" color="muted" style={styles.text}>
        {sample}
      </SafeText>
    </View>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      marginTop: spacing.md,
      borderRadius: 12,
      borderWidth: 1,
      borderColor: `${colors.primary}25`,
      backgroundColor: colors.primaryLight,
      padding: spacing.md,
      gap: spacing.sm,
    },

    header: {
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    text: {
      lineHeight: 22,
    },
  })
