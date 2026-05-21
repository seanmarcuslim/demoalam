import { ActivityIndicator, StyleSheet, View } from 'react-native'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import { ThemeColors } from '../../theme/colors'
import SafeText from './SafeText'

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
      <ActivityIndicator size="large" color={colors.primary} />

      <SafeText variant="bodyMd" color="muted" style={styles.message}>
        {message}
      </SafeText>
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
      marginTop: spacing.md,
      textAlign: 'center',
    },
  })
