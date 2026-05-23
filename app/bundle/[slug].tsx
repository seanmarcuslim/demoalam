import {
  FlatList,
  StyleSheet,
  TouchableOpacity,
  View,
} from 'react-native'

import {
  router,
  useLocalSearchParams,
} from 'expo-router'

import { Ionicons } from '@expo/vector-icons'

import SafeText from '../../src/components/ui/SafeText'
import LoadingFeed from '../../src/components/layout/LoadingFeed'
import { useGuideBundle } from '../../src/hooks/useGuideBundles'
import { useTheme } from '../../src/hooks/useTheme'
import { spacing } from '../../src/theme/spacing'
import type { ThemeColors } from '../../src/theme/colors'

export default function BundleDetailsScreen() {
  const { slug } = useLocalSearchParams()
  const bundleSlug = typeof slug === 'string' ? slug : slug?.[0]
  const { colors } = useTheme()
  const styles = createStyles(colors)

  const { data: bundle, isLoading } = useGuideBundle(bundleSlug)

  if (isLoading) {
    return <LoadingFeed count={3} />
  }

  if (!bundle) {
    return (
      <View style={styles.empty}>
        <SafeText variant="h3" weight="700">
          Bundle not found
        </SafeText>
      </View>
    )
  }

  return (
    <FlatList
      data={bundle.items}
      keyExtractor={(item) => item.id}
      contentContainerStyle={styles.content}
      ListHeaderComponent={
        <View style={styles.hero}>
          <View style={styles.badge}>
            <SafeText variant="caption" weight="700">
              Guided preparedness
            </SafeText>
          </View>

          <SafeText variant="h1" weight="700" style={styles.title}>
            {bundle.title_en}
          </SafeText>

          {bundle.description_en ? (
            <SafeText variant="bodyMd" color="muted" style={styles.description}>
              {bundle.description_en}
            </SafeText>
          ) : null}

          <View style={styles.orderNote}>
            <Ionicons
              name="information-circle-outline"
              size={18}
              color={colors.primary}
            />

            <SafeText variant="caption" color="muted" style={styles.orderNoteText}>
              Follow this order first. Secure access, reduce risk, then recover documents.
            </SafeText>
          </View>
        </View>
      }
      renderItem={({ item, index }) => (
        <TouchableOpacity
          activeOpacity={0.88}
          style={styles.guideCard}
          onPress={() => {
            if (!item.guide?.id) return

            router.push({
              pathname: '/guide/[id]',
              params: { id: item.guide.id },
            })
          }}
        >
          <View style={styles.stepCircle}>
            <SafeText variant="caption" weight="700">
              {index === 0 ? 'START' : index + 1}
            </SafeText>
          </View>

          <View style={styles.guideContent}>
            <SafeText variant="h3" weight="700">
              {item.guide?.title_en}
            </SafeText>

            {item.reason_en ? (
              <SafeText variant="bodyMd" color="muted" style={styles.reason}>
                {item.reason_en}
              </SafeText>
            ) : null}

            <View style={styles.metaRow}>
              {item.guide?.is_urgent ? (
                <View style={styles.urgentPill}>
                  <SafeText variant="caption" weight="700">
                    Urgent
                  </SafeText>
                </View>
              ) : null}

              <View style={styles.metaPill}>
                <SafeText variant="caption" weight="700">
                  {item.guide?.read_time_min || '?'} min
                </SafeText>
              </View>
            </View>
          </View>

          <Ionicons name="chevron-forward" size={20} color={colors.textMuted} />
        </TouchableOpacity>
      )}
    />
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    content: {
      padding: spacing.lg,
      paddingBottom: 120,
      backgroundColor: colors.background,
    },

    hero: {
      marginBottom: spacing.xl,
    },

    badge: {
      alignSelf: 'flex-start',
      backgroundColor: colors.primaryLight,
      borderRadius: 999,
      paddingHorizontal: 12,
      paddingVertical: 8,
      marginBottom: spacing.md,
    },

    title: {
      marginBottom: spacing.md,
    },

    description: {
      lineHeight: 26,
    },

    orderNote: {
      marginTop: spacing.md,
      borderRadius: 16,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.md,
      flexDirection: 'row',
      gap: spacing.sm,
      alignItems: 'center',
    },

    orderNoteText: {
      flex: 1,
      lineHeight: 20,
    },

    guideCard: {
      backgroundColor: colors.surface,
      borderRadius: 22,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.lg,
      marginBottom: spacing.md,
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.md,
    },

    stepCircle: {
      minWidth: 34,
      height: 34,
      paddingHorizontal: 10,
      borderRadius: 999,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
      marginTop: 2,
    },

    guideContent: {
      flex: 1,
    },

    reason: {
      marginTop: spacing.sm,
      lineHeight: 24,
    },

    metaRow: {
      flexDirection: 'row',
      gap: spacing.sm,
      marginTop: spacing.md,
      flexWrap: 'wrap',
    },

    metaPill: {
      borderRadius: 999,
      backgroundColor: colors.surfaceSecondary,
      paddingHorizontal: 12,
      paddingVertical: 7,
    },

    urgentPill: {
      borderRadius: 999,
      backgroundColor: colors.dangerLight,
      paddingHorizontal: 12,
      paddingVertical: 7,
    },

    empty: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: colors.background,
    },
  })