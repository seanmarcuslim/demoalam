import { StyleSheet, View } from 'react-native'
import { useTheme } from '../../hooks/useTheme'

interface SkeletonProps {
  width?: number | `${number}%`
  height?: number
  radius?: number
  style?: any
}

export default function Skeleton({
  width = '100%',
  height = 16,
  radius = 8,
  style,
}: SkeletonProps) {
  const { colors } = useTheme()

  return (
    <View
      style={[
        styles.base,
        {
          width,
          height,
          borderRadius: radius,
          backgroundColor: colors.surfaceSecondary,
        },
        style,
      ]}
    />
  )
}

const styles = StyleSheet.create({
  base: {
    overflow: 'hidden',
  },
})
