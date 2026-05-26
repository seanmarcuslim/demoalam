import { FlatList, StyleSheet, View } from 'react-native'
import { router } from 'expo-router'
import { Ionicons } from '@expo/vector-icons'
import { useEffect } from 'react'

import { useSavedStore } from '../../src/stores/savedStore'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { useTheme } from '../../src/hooks/useTheme'
import { useGuides, useSavedGuideDetails } from '../../src/hooks/useGuides'
import { translations } from '../../src/utils/translations'
import { spacing } from '../../src/theme/spacing'
import type { ThemeColors } from '../../src/theme/colors'
import type { Guide } from '../../src/types/guide'

import SafeText from '../../src/components/ui/SafeText'
import GuideCard from '../../src/components/guide/GuideCard'
import AppCard from '../../src/components/ui/AppCard'
import AppButton from '../../src/components/ui/AppButton'
import EmptyState from '../../src/components/ui/EmptyState'

export default function SavedScreen() {
  const { savedIds, cachedGuides, toggleSave, hydrateSavedGuides } =
    useSavedStore()

  const { data: guides = [] } = useGuides()
  const { data: savedGuideDetails = [] } = useSavedGuideDetails(savedIds)
  const { language } = useSettingsStore()
  const { colors } = useTheme()
  const labels = translations[language].savedScreen
  const styles = createStyles(colors)

  const savedGuides = savedIds
    .map((id) => cachedGuides[id])
    .filter((guide): guide is Guide => Boolean(guide))

  const hasCachedGuides = savedGuides.length > 0
  const needsRefresh = savedIds.length > 0 && !hasCachedGuides

  const urgentCount = savedGuides.filter((guide) => guide.is_urgent).length
  const offlineCount = savedGuides.filter(
    (guide) => guide.sections?.length
  ).length
  const sourceCount = savedGuides.filter(
    (guide) => (guide.official_sources?.length ?? 0) > 0
  ).length

  const priorityGuides = savedGuides
    .filter((guide) => {
      const title = `${guide.title_en} ${guide.title_fil}`.toLowerCase()
      const categorySlug = guide.category?.slug?.toLowerCase() || ''

      return (
        guide.is_urgent ||
        categorySlug.includes('scam') ||
        categorySlug.includes('emergency') ||
        title.includes('wallet') ||
        title.includes('stolen') ||
        title.includes('scam') ||
        title.includes('phishing')
      )
    })
    .slice(0, 3)

  const priorityGuideIds = new Set(priorityGuides.map((guide) => guide.id))
  const remainingGuides = savedGuides.filter(
    (guide) => !priorityGuideIds.has(guide.id)
  )

  const savedCountLabel =
    savedIds.length === 1
      ? labels.guideSingular
      : `${savedIds.length} ${labels.guidePlural}`

  const offlineCountLabel =
    offlineCount === 1
      ? labels.offlineSingular
      : `${offlineCount} ${labels.offlinePlural}`

  const sourceCountLabel =
    sourceCount === 1
      ? labels.sourceSingular
      : `${sourceCount} ${labels.sourcePlural}`

  const urgentCountLabel =
    urgentCount === 1
      ? labels.urgentSingular
      : `${urgentCount} ${labels.urgentPlural}`

  useEffect(() => {
    if (guides.length > 0 && savedIds.length > 0) {
      hydrateSavedGuides(guides)
    }
  }, [guides, hydrateSavedGuides, savedIds.length])

  useEffect(() => {
    if (savedGuideDetails.length > 0) {
      hydrateSavedGuides(savedGuideDetails)
    }
  }, [savedGuideDetails, hydrateSavedGuides])

  const openGuide = (id: string) => {
    router.push({
      pathname: '/guide/[id]',
      params: { id },
    })
  }

  const renderHeader = () => (
    <View>
      <View style={styles.hero}>
        <View style={styles.heroIcon}>
          <Ionicons name="library" size={22} color={colors.primary} />
        </View>

        <SafeText variant="h1" weight="700">
          {labels.heroTitle}
        </SafeText>

        <SafeText variant="bodyMd" color="muted" style={styles.heroSubtitle}>
          {labels.heroSubtitle}
        </SafeText>

        <View style={styles.summaryRow}>
          <SummaryPill label={savedCountLabel} icon="bookmark" />
          <SummaryPill label={offlineCountLabel} icon="cloud-offline" />
          <SummaryPill label={sourceCountLabel} icon="shield-checkmark" />
          <SummaryPill label={urgentCountLabel} icon="warning" />
        </View>
      </View>

      {hasCachedGuides ? (
        <AppCard style={styles.notice}>
          <Ionicons name="cloud-offline-outline" size={19} color={colors.success} />

          <SafeText variant="bodyMd" color="muted" style={styles.noticeText}>
            {labels.offlineNotice}
          </SafeText>
        </AppCard>
      ) : null}

      {needsRefresh ? (
        <AppCard style={styles.refreshNotice}>
          <Ionicons name="sync-circle-outline" size={22} color={colors.warning} />

          <SafeText variant="bodyMd" color="muted" style={styles.noticeText}>
            {labels.refreshNotice}
          </SafeText>
        </AppCard>
      ) : null}

      {priorityGuides.length > 0 ? (
        <View style={styles.prioritySection}>
          <SafeText variant="h3" weight="700">
            {labels.priorityTitle}
          </SafeText>

          <SafeText variant="caption" color="muted" style={styles.sectionSubtitle}>
            {labels.prioritySubtitle}
          </SafeText>

          {priorityGuides.map((item) => (
            <GuideCard
              key={`priority-${item.id}`}
              guide={item}
              language={language}
              isSaved
              onPress={() => openGuide(item.id)}
              onSave={() => toggleSave(item)}
              compact
            />
          ))}
        </View>
      ) : null}

      {remainingGuides.length > 0 ? (
        <View style={styles.allSavedHeader}>
          <SafeText variant="h3" weight="700">
            {priorityGuides.length > 0 ? labels.moreSaved : labels.allSaved}
          </SafeText>
        </View>
      ) : null}
    </View>
  )

  function SummaryPill({
    label,
    icon,
  }: {
    label: string
    icon: keyof typeof Ionicons.glyphMap
  }) {
    return (
      <View style={styles.summaryPill}>
        <Ionicons name={icon} size={14} color={colors.primary} />
        <SafeText variant="caption" weight="700">
          {label}
        </SafeText>
      </View>
    )
  }

  return (
    <FlatList
      data={remainingGuides}
      keyExtractor={(item) => item.id}
      ListHeaderComponent={renderHeader}
      ListEmptyComponent={
        savedGuides.length > 0 ? null : (
          <AppCard style={styles.emptyCard}>
            <EmptyState
              iconName={needsRefresh ? 'sync-circle-outline' : 'bookmark-outline'}
              title={
                needsRefresh
                  ? labels.refreshTitle
                  : labels.emptyTitle
              }
              subtitle={
                needsRefresh
                  ? labels.refreshSubtitle
                  : labels.emptySubtitle
              }
            />

            <AppButton
              title={
                needsRefresh
                  ? labels.goHome
                  : labels.browseGuides
              }
              onPress={() => router.push('/')}
              style={styles.emptyAction}
            />
          </AppCard>
        )
      }
      contentContainerStyle={styles.content}
      showsVerticalScrollIndicator={false}
      renderItem={({ item }) => (
        <GuideCard
          guide={item}
          language={language}
          isSaved
          onPress={() => openGuide(item.id)}
          onSave={() => toggleSave(item)}
        />
      )}
      removeClippedSubviews
      maxToRenderPerBatch={5}
      windowSize={5}
    />
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    content: {
      backgroundColor: colors.background,
      paddingBottom: 140,
    },

    hero: {
      paddingHorizontal: spacing.md,
      paddingTop: spacing.xl,
      paddingBottom: spacing.md,
    },

    heroIcon: {
      width: 46,
      height: 46,
      borderRadius: 16,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
      marginBottom: spacing.md,
    },

    heroSubtitle: {
      marginTop: spacing.sm,
      lineHeight: 22,
      maxWidth: 440,
    },

    summaryRow: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.sm,
      marginTop: spacing.md,
    },

    summaryPill: {
      minHeight: 34,
      borderRadius: 999,
      borderWidth: 1,
      borderColor: colors.border,
      backgroundColor: colors.surfaceSecondary,
      paddingHorizontal: spacing.md,
      paddingVertical: spacing.sm,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
    },

    notice: {
      marginHorizontal: spacing.md,
      marginTop: spacing.md,
      backgroundColor: colors.successLight,
      borderWidth: 1,
      borderColor: `${colors.success}30`,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    noticeText: {
      flex: 1,
    },

    refreshNotice: {
      marginHorizontal: spacing.md,
      marginTop: spacing.md,
      backgroundColor: colors.warningLight,
      borderWidth: 1,
      borderColor: `${colors.warning}30`,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    prioritySection: {
      paddingHorizontal: spacing.md,
      paddingTop: spacing.lg,
    },

    sectionSubtitle: {
      marginTop: spacing.xs,
      marginBottom: spacing.md,
    },

    allSavedHeader: {
      paddingHorizontal: spacing.md,
      paddingTop: spacing.lg,
      paddingBottom: spacing.sm,
    },

    emptyCard: {
      margin: spacing.md,
      alignItems: 'center',
      borderWidth: 1,
      borderColor: colors.border,
    },

    emptyAction: {
      marginTop: spacing.md,
      alignSelf: 'stretch',
    },
  })
