import { StyleSheet, View } from 'react-native'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import type { ThemeColors } from '../../theme/colors'
import SafeText from './SafeText'

interface AppHeaderProps {
  title: string
  subtitle?: string
  centered?: boolean
}

export default function AppHeader({
  title,
  subtitle,
  centered = false,
}: AppHeaderProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors)

  return (
    <View style={[styles.header, centered && styles.centered]}>
      <SafeText variant="h1" color="surface" style={styles.title}>
        {title}
      </SafeText>

      {subtitle ? (
        <SafeText variant="bodyMd" color="surface" style={styles.subtitle}>
          {subtitle}
        </SafeText>
      ) : null}
    </View>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    header: {
      backgroundColor: colors.primary,
      paddingHorizontal: spacing.lg,
      paddingTop: spacing.xxl,
      paddingBottom: spacing.lg,
      borderBottomLeftRadius: 24,
      borderBottomRightRadius: 24,
    },

    centered: {
      alignItems: 'center',
    },

    title: {
      maxWidth: 360,
    },

    subtitle: {
      opacity: 0.9,
      marginTop: spacing.sm,
      maxWidth: 360,
    },
  })
