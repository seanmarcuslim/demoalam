import { View, Text, StyleSheet } from 'react-native'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import { typography } from '../../theme/typography'

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
    <View
      style={[
        styles.header,
        centered && styles.centered,
      ]}
    >
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

const createStyles = (colors: any) =>
  StyleSheet.create({
    header: {
      backgroundColor: colors.primary,
      padding: spacing.lg,
      paddingTop: spacing.xxl,
      borderBottomLeftRadius: 24,
      borderBottomRightRadius: 24,
    },

    centered: {
      alignItems: 'center',
    },

    title: {
      ...typography.h1,
      color: '#FFFFFF',
    },

    subtitle: {
      ...typography.body,
      color: colors.primaryLight,
      marginTop: spacing.xs,
    },
  })