import { View, Text, ActivityIndicator, StyleSheet } from 'react-native'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import { typography } from '../../theme/typography'
import { ThemeColors } from '../../theme/colors'

interface LoadingScreenProps {
  message?: string
}

export default function LoadingScreen({
  message = 'Loading...',
}: LoadingScreenProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors)

  return (
    <View style={styles.container}>
      <ActivityIndicator
        size="large"
        color={colors.primary}
      />

      <Text style={styles.message}>
        {message}
      </Text>
    </View>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      padding: spacing.xl,
      backgroundColor: colors.background,
    },

    message: {
      ...typography.body,
      color: colors.textMuted,
      marginTop: spacing.md,
      textAlign: 'center',
    },
  })
