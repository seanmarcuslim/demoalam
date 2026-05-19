import {
  TouchableOpacity,
  Text,
  StyleSheet,
  ActivityIndicator,
  StyleProp,
  ViewStyle,
} from 'react-native'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import { typography } from '../../theme/typography'
import { ThemeColors } from '../../theme/colors'

interface AppButtonProps {
  title: string
  onPress: () => void
  loading?: boolean
  disabled?: boolean
  variant?: 'primary' | 'secondary' | 'danger'
  style?: StyleProp<ViewStyle>
}

export default function AppButton({
  title,
  onPress,
  loading = false,
  disabled = false,
  variant = 'primary',
  style,
}: AppButtonProps) {
  const { colors } = useTheme()

  const styles = createStyles(colors)

  const getButtonStyle = () => {
    switch (variant) {
      case 'secondary':
        return styles.secondaryButton

      case 'danger':
        return styles.dangerButton

      default:
        return styles.primaryButton
    }
  }

  const getTextStyle = () => {
    switch (variant) {
      case 'secondary':
        return styles.secondaryText

      default:
        return styles.primaryText
    }
  }

  return (
    <TouchableOpacity
      activeOpacity={0.85}
      style={[
        styles.button,
        getButtonStyle(),
        disabled && styles.disabled,
        style,
      ]}
      onPress={onPress}
      disabled={disabled || loading}
    >
      {loading ? (
        <ActivityIndicator
          color={colors.surface}
        />
      ) : (
        <Text style={getTextStyle()}>
          {title}
        </Text>
      )}
    </TouchableOpacity>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    button: {
      borderRadius: 14,
      paddingVertical: spacing.md,
      paddingHorizontal: spacing.lg,
      alignItems: 'center',
      justifyContent: 'center',
    },

    primaryButton: {
      backgroundColor: colors.primary,
    },

    secondaryButton: {
      backgroundColor: 'transparent',
      borderWidth: 1,
      borderColor: colors.primary,
    },

    dangerButton: {
      backgroundColor: colors.danger,
    },

    disabled: {
      opacity: 0.5,
    },

    primaryText: {
      ...typography.body,
      color: colors.surface,
      fontWeight: '700',
    },

    secondaryText: {
      ...typography.body,
      color: colors.primary,
      fontWeight: '700',
    },
  })
