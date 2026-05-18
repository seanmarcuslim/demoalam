import { StyleSheet, View } from 'react-native'
import SafeText from './SafeText'
import { spacing } from '../../theme/spacing'

interface BadgeProps {
  label: string
  color: string
  icon?: string
  tone?: 'soft' | 'solid'
}

export default function Badge({
  label,
  color,
  icon,
  tone = 'soft',
}: BadgeProps) {
  const isSolid = tone === 'solid'

  return (
    <View
      style={[
        styles.badge,
        {
          backgroundColor: isSolid ? color : `${color}18`,
          borderColor: isSolid ? color : `${color}30`,
        },
      ]}
    >
      <SafeText
        variant="label"
        color={isSolid ? 'surface' : 'text'}
        style={{ color: isSolid ? '#FFFFFF' : color }}
        numberOfLines={1}
      >
        {icon ? `${icon} ` : ''}
        {label}
      </SafeText>
    </View>
  )
}

const styles = StyleSheet.create({
  badge: {
    alignSelf: 'flex-start',
    borderRadius: 999,
    borderWidth: 1,
    paddingHorizontal: spacing.sm,
    paddingVertical: spacing.xs,
  },
})
