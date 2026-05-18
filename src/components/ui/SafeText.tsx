import { ReactNode } from 'react'
import { Text, TextProps, TextStyle } from 'react-native'
import { useTheme } from '../../hooks/useTheme'
import { typography } from '../../theme/typography'

type TextVariant = keyof typeof typography
type TextColor = 'text' | 'muted' | 'light' | 'surface' | 'primary' | 'danger' | 'success' | 'warning'

interface SafeTextProps extends TextProps {
  children: ReactNode
  variant?: TextVariant
  color?: TextColor
  weight?: TextStyle['fontWeight']
}

export default function SafeText({
  children,
  variant = 'body',
  color = 'text',
  weight,
  style,
  ...props
}: SafeTextProps) {
  const { colors } = useTheme()

  const colorMap = {
    text: colors.text,
    muted: colors.textMuted,
    light: colors.textLight,
    surface: colors.surface,
    primary: colors.primary,
    danger: colors.danger,
    success: colors.success,
    warning: colors.warning,
  }

  return (
    <Text
      allowFontScaling={false}
      {...props}
      style={[
        typography[variant],
        { color: colorMap[color] },
        weight ? { fontWeight: weight } : null,
        style,
      ]}
    >
      {children}
    </Text>
  )
}
