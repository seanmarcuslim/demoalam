import { StyleSheet, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'

import { spacing } from '../../theme/spacing'
import SafeText from '../ui/SafeText'

interface GuideMetaPillProps {
  icon: keyof typeof Ionicons.glyphMap
  label: string
}

export default function GuideMetaPill({ icon, label }: GuideMetaPillProps) {
  return (
    <View style={styles.pill}>
      <Ionicons name={icon} size={15} color="#FFFFFF" />
      <SafeText variant="caption" color="surface" weight="700">
        {label}
      </SafeText>
    </View>
  )
}

const styles = StyleSheet.create({
  pill: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: spacing.xs,
    borderRadius: 999,
    borderWidth: 1,
    borderColor: 'rgba(255,255,255,0.25)',
    backgroundColor: 'rgba(255,255,255,0.12)',
    paddingHorizontal: spacing.md,
    paddingVertical: spacing.sm,
  },
})
