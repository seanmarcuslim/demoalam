import { StyleSheet, TouchableOpacity } from 'react-native'
import { Ionicons } from '@expo/vector-icons'
import { useSafeAreaInsets } from 'react-native-safe-area-context'
import { useFeedbackStore } from '../../stores/feedbackStore'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import SafeText from '../ui/SafeText'

export default function FeedbackToast() {
  const insets = useSafeAreaInsets()
  const { colors } = useTheme()
  const { message, kind, hide } = useFeedbackStore()

  if (!message) {
    return null
  }

  const isSuccess = kind === 'success'

  return (
    <TouchableOpacity
      activeOpacity={0.92}
      style={[
        styles.toast,
        {
          bottom: Math.max(insets.bottom, 12) + 76,
          backgroundColor: isSuccess ? colors.success : colors.primary,
        },
      ]}
      onPress={hide}
    >
      <Ionicons
        name={isSuccess ? 'checkmark-circle' : 'information-circle'}
        size={19}
        color="#FFFFFF"
      />
      <SafeText color="surface" variant="bodyMd" weight="700" style={styles.text}>
        {message}
      </SafeText>
    </TouchableOpacity>
  )
}

const styles = StyleSheet.create({
  toast: {
    position: 'absolute',
    left: spacing.md,
    right: spacing.md,
    zIndex: 50,
    elevation: 8,
    minHeight: 52,
    borderRadius: 16,
    paddingHorizontal: spacing.md,
    paddingVertical: spacing.sm,
    flexDirection: 'row',
    alignItems: 'center',
    gap: spacing.sm,
    shadowColor: '#000000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.18,
    shadowRadius: 10,
  },

  text: {
    flex: 1,
  },
})
