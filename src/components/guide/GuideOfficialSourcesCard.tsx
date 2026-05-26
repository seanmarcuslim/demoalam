import { StyleSheet, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'

import type { GuideOfficialSource } from '../../types/guide'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import type { ThemeColors } from '../../theme/colors'
import SafeText from '../ui/SafeText'
import OfficialSourceRow from './OfficialSourceRow'

interface GuideOfficialSourcesCardProps {
  sources: GuideOfficialSource[]
  title: string
  subtitle: string
  onOpenError: () => void
}

export default function GuideOfficialSourcesCard({
  sources,
  title,
  subtitle,
  onOpenError,
}: GuideOfficialSourcesCardProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors)

  if (sources.length === 0) {
    return null
  }

  return (
    <View style={styles.card}>
      <View style={styles.header}>
        <View style={styles.icon}>
          <Ionicons name="checkmark-done-circle" size={17} color={colors.success} />
        </View>

        <View style={styles.copy}>
          <SafeText variant="label" weight="700" style={styles.title}>
            {title}
          </SafeText>
          <SafeText variant="caption" color="muted" style={styles.subtitle}>
            {subtitle}
          </SafeText>
        </View>
      </View>

      <View style={styles.sources}>
        {sources.map((source) => (
          <OfficialSourceRow
            key={source.url}
            source={source}
            onOpenError={onOpenError}
          />
        ))}
      </View>
    </View>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    card: {
      marginHorizontal: spacing.md,
      marginTop: spacing.md,
      borderRadius: 12,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.md,
    },

    header: {
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
      marginBottom: spacing.sm,
    },

    icon: {
      width: 32,
      height: 32,
      borderRadius: 12,
      backgroundColor: colors.successLight,
      alignItems: 'center',
      justifyContent: 'center',
    },

    copy: {
      flex: 1,
    },

    title: {
      textTransform: 'uppercase',
    },

    subtitle: {
      marginTop: 1,
    },

    sources: {
      gap: spacing.sm,
    },
  })
