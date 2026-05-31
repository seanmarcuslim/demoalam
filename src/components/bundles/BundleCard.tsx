import { StyleSheet, TouchableOpacity, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'
import { router } from 'expo-router'

import type { GuideBundleWithItems } from '../../types/bundle'
import SafeText from '../ui/SafeText'
import { useSettingsStore } from '../../stores/settingsStore'
import { useTheme } from '../../hooks/useTheme'
import { translations } from '../../utils/translations'
import {
  getBundleTitle,
  getBundleDescription,
} from '../../lib/bundleDisplay'
import type { ThemeColors } from '../../theme/colors'

interface BundleCardProps {
  bundle: GuideBundleWithItems
}

export function BundleCard({ bundle }: BundleCardProps) {
  const { language } = useSettingsStore()
  const { colors } = useTheme()
  const labels = translations[language].components.bundleCard
  const styles = createStyles(colors)

  const guideCount = bundle.items.length
  const urgentCount = bundle.items.filter((item) => item.guide?.is_urgent).length

  const title = getBundleTitle(bundle, language)
  const description = getBundleDescription(bundle, language)

  return (
    <TouchableOpacity
      activeOpacity={0.9}
      onPress={() =>
        router.push({
          pathname: '/bundle/[slug]',
          params: { slug: bundle.slug },
        })
      }
      style={styles.card}
    >
      <View style={styles.header}>
        <View style={styles.badge}>
          <SafeText variant="caption" weight="700">
            {labels.preparedBundle}
          </SafeText>
        </View>

        <Ionicons name="arrow-forward" size={18} color={colors.primary} />
      </View>

      <SafeText variant="h3" weight="700" style={styles.title}>
        {title}
      </SafeText>

      {description ? (
        <SafeText
          variant="bodyMd"
          color="muted"
          style={styles.description}
        >
          {description}
        </SafeText>
      ) : null}

      <View style={styles.metaRow}>
        <View style={styles.pill}>
          <SafeText variant="caption" weight="700">
            {guideCount}{' '}
            {guideCount === 1 ? labels.guideSingular : labels.guidePlural}
          </SafeText>
        </View>

        {urgentCount > 0 ? (
          <View style={styles.urgentPill}>
            <SafeText variant="caption" weight="700">
              {urgentCount} {labels.urgent}
            </SafeText>
          </View>
        ) : null}
      </View>
    </TouchableOpacity>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    card: {
      backgroundColor: colors.surface,
      borderRadius: 22,
      padding: 18,
      marginTop: 14,
      borderWidth: 1,
      borderColor: colors.border,
    },

    header: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
      marginBottom: 12,
    },

    badge: {
      backgroundColor: colors.surfaceSecondary,
      borderRadius: 999,
      paddingHorizontal: 12,
      paddingVertical: 8,
    },

    title: {
      marginBottom: 10,
    },

    description: {
      marginBottom: 14,
      lineHeight: 24,
    },

    metaRow: {
      flexDirection: 'row',
      gap: 10,
      flexWrap: 'wrap',
    },

    pill: {
      backgroundColor: colors.surfaceSecondary,
      borderRadius: 999,
      paddingHorizontal: 12,
      paddingVertical: 8,
    },

    urgentPill: {
      backgroundColor: colors.dangerLight,
      borderRadius: 999,
      paddingHorizontal: 12,
      paddingVertical: 8,
    },
  })
