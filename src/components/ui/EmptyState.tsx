import { StyleSheet, View } from 'react-native'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import { ThemeColors } from '../../theme/colors'
import SafeText from './SafeText'

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
      <SafeText style={styles.icon}>{icon}</SafeText>

      <SafeText variant="h3" weight="700" style={styles.title}>
        {title}
      </SafeText>

      {subtitle ? (
        <SafeText variant="bodyMd" color="muted" style={styles.subtitle}>
          {subtitle}
        </SafeText>
      ) : null}
    </View>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      alignItems: 'center',
      justifyContent: 'center',
      padding: spacing.xl,
    },

    icon: {
      fontSize: 48,
      marginBottom: spacing.md,
    },

    title: {
      textAlign: 'center',
      marginBottom: spacing.sm,
    },

    subtitle: {
      textAlign: 'center',
      maxWidth: 300,
    },
  })
