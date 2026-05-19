import { View, Text, StyleSheet } from 'react-native'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import { typography } from '../../theme/typography'
import { ThemeColors } from '../../theme/colors'

interface EmptyStateProps {
  icon?: string
  title: string
  subtitle?: string
}

export default function EmptyState({
  icon = '📭',
  title,
  subtitle,
}: EmptyStateProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors)

  return (
    <View style={styles.container}>
      <Text style={styles.icon}>{icon}</Text>

      <Text style={styles.title}>
        {title}
      </Text>

      {subtitle ? (
        <Text style={styles.subtitle}>
          {subtitle}
        </Text>
      ) : null}
    </View>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      alignItems: 'center',
      justifyContent: 'center',
      padding: spacing.xxl,
    },

    icon: {
      fontSize: 48,
      marginBottom: spacing.md,
    },

    title: {
      ...typography.h3,
      color: colors.text,
      textAlign: 'center',
      marginBottom: spacing.sm,
    },

    subtitle: {
      ...typography.body,
      color: colors.textMuted,
      textAlign: 'center',
      lineHeight: 22,
    },
  })
