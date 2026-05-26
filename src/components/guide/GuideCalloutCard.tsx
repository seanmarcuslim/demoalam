import { StyleSheet, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'

import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import type { ThemeColors } from '../../theme/colors'
import SafeText from '../ui/SafeText'

type GuideCalloutVariant = 'offline' | 'warning'

interface GuideCalloutCardProps {
  title: string
  body: string
  variant: GuideCalloutVariant
}

export default function GuideCalloutCard({
  title,
  body,
  variant,
}: GuideCalloutCardProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors, variant)
  const isWarning = variant === 'warning'

  return (
    <View style={styles.card}>
      <View style={styles.iconWrap}>
        <Ionicons
          name={isWarning ? 'warning' : 'cloud-offline-outline'}
          size={isWarning ? 20 : 19}
          color={isWarning ? colors.danger : colors.warning}
        />
      </View>

      <View style={styles.copy}>
        <SafeText
          variant="label"
          color={isWarning ? 'danger' : 'warning'}
          weight="700"
        >
          {title}
        </SafeText>

        <SafeText variant="bodyMd" color="muted" style={styles.body}>
          {body}
        </SafeText>
      </View>
    </View>
  )
}

const createStyles = (colors: ThemeColors, variant: GuideCalloutVariant) => {
  const isWarning = variant === 'warning'

  return StyleSheet.create({
    card: {
      marginHorizontal: spacing.md,
      marginTop: spacing.lg,
      borderRadius: 16,
      borderWidth: 1,
      borderColor: isWarning ? `${colors.danger}35` : `${colors.warning}35`,
      backgroundColor: isWarning ? colors.dangerLight : colors.warningLight,
      padding: spacing.md,
      flexDirection: 'row',
      gap: spacing.md,
    },

    iconWrap: {
      width: 38,
      height: 38,
      borderRadius: 19,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
    },

    copy: {
      flex: 1,
    },

    body: {
      marginTop: spacing.xs,
    },
  })
}
