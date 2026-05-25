import { Linking, StyleSheet, TouchableOpacity, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'

import type { GuideOfficialSource } from '../../types/guide'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import type { ThemeColors } from '../../theme/colors'
import SafeText from '../ui/SafeText'

interface OfficialSourceRowProps {
  source: GuideOfficialSource
  onOpenError: () => void
}

export default function OfficialSourceRow({
  source,
  onOpenError,
}: OfficialSourceRowProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors)
  const sourceDomain = getSourceDomain(source.url)

  const openSource = () => {
    Linking.openURL(source.url).catch(onOpenError)
  }

  return (
    <TouchableOpacity
      activeOpacity={0.86}
      style={styles.row}
      onPress={openSource}
    >
      <View style={styles.icon}>
        <Ionicons name="shield-checkmark" size={17} color={colors.success} />
      </View>

      <View style={styles.copy}>
        <SafeText variant="bodyMd" weight="700" numberOfLines={1}>
          {source.title}
        </SafeText>

        <View style={styles.metaRow}>
          {source.publisher ? (
            <View style={styles.publisherPill}>
              <SafeText
                variant="caption"
                weight="700"
                style={{ color: colors.success }}
                numberOfLines={1}
              >
                {source.publisher}
              </SafeText>
            </View>
          ) : null}

          {sourceDomain ? (
            <SafeText
              variant="caption"
              color="muted"
              numberOfLines={1}
              style={styles.domain}
            >
              {sourceDomain}
            </SafeText>
          ) : null}
        </View>
      </View>

      <Ionicons name="open-outline" size={17} color={colors.textLight} />
    </TouchableOpacity>
  )
}

function getSourceDomain(url: string) {
  try {
    return new URL(url).hostname.replace(/^www\./, '')
  } catch {
    return ''
  }
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    row: {
      minHeight: 64,
      borderRadius: 12,
      borderWidth: 1,
      borderColor: colors.border,
      backgroundColor: colors.surfaceSecondary,
      paddingHorizontal: spacing.md,
      paddingVertical: spacing.sm,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    icon: {
      width: 32,
      height: 32,
      borderRadius: 16,
      backgroundColor: colors.successLight,
      alignItems: 'center',
      justifyContent: 'center',
    },

    copy: {
      flex: 1,
    },

    metaRow: {
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
      marginTop: spacing.xs,
    },

    publisherPill: {
      maxWidth: '62%',
      minHeight: 22,
      borderRadius: 999,
      backgroundColor: colors.successLight,
      paddingHorizontal: spacing.sm,
      justifyContent: 'center',
    },

    domain: {
      flex: 1,
    },
  })
