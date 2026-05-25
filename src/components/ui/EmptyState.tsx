import { StyleSheet, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import { ThemeColors } from '../../theme/colors'
import SafeText from './SafeText'

interface EmptyStateProps {
  icon?: string
  iconName?: keyof typeof Ionicons.glyphMap
  title: string
  subtitle?: string
}

export default function EmptyState({
  icon,
  iconName = 'file-tray-outline',
  title,
  subtitle,
}: EmptyStateProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors)

  return (
    <View style={styles.container}>
      <View style={styles.iconWrap}>
        {icon ? (
          <SafeText style={styles.iconText}>{icon}</SafeText>
        ) : (
          <Ionicons name={iconName} size={34} color={colors.primary} />
        )}
      </View>

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

    iconWrap: {
      width: 64,
      height: 64,
      borderRadius: 22,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
      marginBottom: spacing.md,
    },

    iconText: {
      fontSize: 34,
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
