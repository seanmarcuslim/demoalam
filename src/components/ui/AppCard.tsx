import {
  View,
  StyleSheet,
  TouchableOpacity,
  StyleProp,
  ViewStyle,
} from 'react-native'
import { ReactNode } from 'react'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import { ThemeColors } from '../../theme/colors'

interface AppCardProps {
  children: ReactNode
  onPress?: () => void
  style?: StyleProp<ViewStyle>
}

export default function AppCard({
  children,
  onPress,
  style,
}: AppCardProps) {
  const { colors } = useTheme()

  const styles = createStyles(colors)

  if (onPress) {
    return (
      <TouchableOpacity
        activeOpacity={0.85}
        style={[styles.card, style]}
        onPress={onPress}
      >
        {children}
      </TouchableOpacity>
    )
  }

  return (
    <View style={[styles.card, style]}>
      {children}
    </View>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    card: {
      backgroundColor: colors.surface,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.md,
      marginBottom: spacing.md,

      elevation: 2,
      shadowColor: colors.shadow,
      shadowOffset: {
        width: 0,
        height: 2,
      },
      shadowOpacity: 0.06,
      shadowRadius: 6,
    },
  })
