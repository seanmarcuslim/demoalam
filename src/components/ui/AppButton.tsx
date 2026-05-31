import {
  ActivityIndicator,
  StyleProp,
  StyleSheet,
  TouchableOpacity,
  TouchableOpacityProps,
  ViewStyle,
} from 'react-native'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import { ThemeColors } from '../../theme/colors'
import SafeText from './SafeText'

interface AppButtonProps extends Omit<TouchableOpacityProps, 'style' | 'disabled'> {
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
  accessibilityLabel,
  accessibilityRole = 'button',
  ...props
}: AppButtonProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors)

  const isSecondary = variant === 'secondary'

  return (
    <TouchableOpacity
      activeOpacity={0.85}
      style={[
        styles.button,
        variant === 'danger'
          ? styles.dangerButton
          : isSecondary
            ? styles.secondaryButton
            : styles.primaryButton,
        disabled && styles.disabled,
        style,
      ]}
      onPress={onPress}
      disabled={disabled || loading}
      accessibilityLabel={accessibilityLabel || title}
      accessibilityRole={accessibilityRole}
      {...props}
    >
      {loading ? (
        <ActivityIndicator color="#FFFFFF" />
      ) : (
        <SafeText
          variant="bodyMd"
          weight="700"
          style={isSecondary ? styles.secondaryText : styles.primaryText}
        >
          {title}
        </SafeText>
      )}
    </TouchableOpacity>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    button: {
      minHeight: 48,
      borderRadius: 12,
      paddingVertical: spacing.md,
      paddingHorizontal: spacing.lg,
      alignItems: 'center',
      justifyContent: 'center',
    },

    primaryButton: {
      backgroundColor: colors.primary,
      elevation: 2,
      shadowColor: colors.shadow,
      shadowOffset: { width: 0, height: 3 },
      shadowOpacity: 0.12,
      shadowRadius: 6,
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
      color: '#FFFFFF',
    },

    secondaryText: {
      color: colors.primary,
    },
  })
