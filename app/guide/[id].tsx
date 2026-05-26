import {
  Alert,
  RefreshControl,
  ScrollView,
  Share,
  StyleSheet,
  TouchableOpacity,
  View,
} from 'react-native'
import { useEffect } from 'react'
import { useLocalSearchParams, router } from 'expo-router'
import { Ionicons } from '@expo/vector-icons'
import { useGuide } from '../../src/hooks/useGuides'
import { useGuides } from '../../src/hooks/useGuides'
import { useSavedStore } from '../../src/stores/savedStore'
import { useHistoryStore } from '../../src/stores/historyStore'
import { useSessionStore } from '../../src/stores/sessionStore'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { translations } from '../../src/utils/translations'
import { useTheme } from '../../src/hooks/useTheme'
import { spacing } from '../../src/theme/spacing'
import type { ThemeColors } from '../../src/theme/colors'
import SafeText from '../../src/components/ui/SafeText'
import Badge from '../../src/components/ui/Badge'
import GuideCard from '../../src/components/guide/GuideCard'
import GuideCalloutCard from '../../src/components/guide/GuideCalloutCard'
import GuideCompletenessItem from '../../src/components/guide/GuideCompletenessItem'
import GuideDetailSkeleton from '../../src/components/guide/GuideDetailSkeleton'
import GuideMetaPill from '../../src/components/guide/GuideMetaPill'
import GuideOfficialSourcesCard from '../../src/components/guide/GuideOfficialSourcesCard'
import GuideSectionCard from '../../src/components/guide/GuideSectionCard'
import GuideTrustItem from '../../src/components/guide/GuideTrustItem'
import type {
  Guide,
  GuideSection,
} from '../../src/types/guide'
import { useFeedbackStore } from '../../src/stores/feedbackStore'
import { getCategoryAccent } from '../../src/lib/categoryVisuals'
import { analyticsService } from '../../src/services/analyticsService'
import {
  formatGuideUpdatedDate,
  getGuideCategoryName,
  getGuideCostLabel,
  getGuideDifficultyLabel,
  getGuideSectionContent,
  getGuideTagline,
  getGuideTimeLabel,
  getGuideTitle,
} from '../../src/lib/guideDisplay'

export default function GuideDetailsScreen() {
  const { id } = useLocalSearchParams()
  const guideId = Array.isArray(id) ? id[0] : id
  const cachedGuide = useSavedStore((state) =>
    guideId ? state.cachedGuides[guideId] : undefined
  )

  const {
    data: guide,
    isLoading,
    refetch,
    isRefetching,
  } = useGuide(guideId)

  const activeGuide = guide || cachedGuide
  const { data: categoryGuides = [] } = useGuides(activeGuide?.category_id)

  const isGuest = useSessionStore((state) => state.isGuest)
  const toggleSave = useSavedStore((state) => state.toggleSave)
  const saveGuide = useSavedStore((state) => state.save)
  const addToHistory = useHistoryStore((state) => state.addToHistory)
  const { language } = useSettingsStore()
  const { colors } = useTheme()
  const t = translations[language]
  const guideLabels = t.guideDetail
  const styles = createStyles(colors, colors.primary)
  const showFeedback = useFeedbackStore((state) => state.show)

  const isSaved = useSavedStore((state) =>
    activeGuide ? state.isSaved(activeGuide.id) : false
  )
  const isGuideSaved = useSavedStore((state) => state.isSaved)

  const getTitle = (item: Guide) =>
    getGuideTitle(item, language)

  const getTagline = (item: Guide) =>
    getGuideTagline(item, language)

  const getCategoryName = (item: Guide['category']) =>
    item ? getGuideCategoryName(item, language) : guideLabels.unknown

  const getSectionContent = (section: GuideSection) =>
    getGuideSectionContent(section, language)

  const getDifficultyLabel = (value?: string | null) =>
    getGuideDifficultyLabel(value, guideLabels)

  const getCostLabel = (value?: string | null) =>
    getGuideCostLabel(value, guideLabels, language)

  const getTimeLabel = (value?: string | null) =>
    getGuideTimeLabel(value, guideLabels, language)

  const handleSave = () => {
    if (!activeGuide) return

    if (isGuest) {
      Alert.alert(
        guideLabels.loginRequiredTitle,
        guideLabels.loginRequiredMessage,
        [
          {
            text: guideLabels.cancel,
            style: 'cancel',
          },
          {
            text: t.login,
            onPress: () => router.push('/login'),
          },
        ]
      )
      return
    }

    toggleSave(activeGuide)
    showFeedback(
      isSaved
        ? guideLabels.removedFromSaved
        : guideLabels.savedForOffline,
      isSaved ? 'info' : 'success'
    )
  }

  const handleShare = async () => {
    if (!activeGuide) return

    await Share.share({
      message: `${getTitle(activeGuide)}\n\n${getTagline(activeGuide)}\n\nDemoAlam`,
    })
  }

  useEffect(() => {
    if (activeGuide) {
      addToHistory(activeGuide)
    }
  }, [activeGuide?.id])

  useEffect(() => {
    if (guide && isSaved) {
      saveGuide(guide)
    }
  }, [guide?.id, isSaved])

  useEffect(() => {
    if (!guide?.id) return

    analyticsService.logGuideView(guide.id).catch(() => {
      // Analytics should never interrupt guide reading.
    })
  }, [guide?.id])

  if (isLoading && !cachedGuide) {
    return <GuideDetailSkeleton colors={colors} />
  }

  if (!activeGuide) {
    return (
      <ScrollView
        style={styles.container}
        contentContainerStyle={styles.errorContent}
        refreshControl={
          <RefreshControl
            refreshing={isRefetching}
            onRefresh={refetch}
            colors={[colors.primary]}
          />
        }
      >
        <SafeText variant="h2" weight="700" style={styles.errorTitle}>
          {guideLabels.loadErrorTitle}
        </SafeText>
        <SafeText color="muted" style={styles.errorText}>
          {guideLabels.loadErrorMessage}
        </SafeText>
      </ScrollView>
    )
  }

  const categoryColor = getCategoryAccent(activeGuide.category, colors.primary)
  const isShowingCachedGuide = !guide && !!cachedGuide
  const guideStyles = createStyles(
    colors,
    activeGuide.is_urgent ? colors.danger : categoryColor
  )
  const sections = [...(activeGuide.sections || [])].sort(
    (a: GuideSection, b: GuideSection) => (a.order_index || 0) - (b.order_index || 0)
  )
  const officialSources = activeGuide.official_sources || []
  const relatedGuides = categoryGuides
    .filter((item: Guide) => item.id !== activeGuide.id)
    .slice(0, 3)
  const updatedLabel = formatUpdatedDate(activeGuide.updated_at || activeGuide.published_at)
  const sectionContents = sections.map((section) => getSectionContent(section))
  const sourceCount = officialSources.length
  const stepCount = sections.filter((section) => section.section_type === 'step').length
  const warningCount = sections.filter((section) => section.section_type === 'warning').length
  const hasChecklist = sectionContents.some((content) => (content?.items?.length ?? 0) > 0)
  const hasSample = sectionContents.some((content) => Boolean(content?.sample))
  const stepCountLabel =
    stepCount === 1 ? guideLabels.stepCountSingular : guideLabels.stepCountPlural
  const warningCountLabel =
    warningCount === 1
      ? guideLabels.warningCountSingular
      : guideLabels.warningCountPlural
  const sectionCardLabels = {
    avoid: guideLabels.avoid,
    checkFirst: guideLabels.checkFirst,
    commonTimeWaster: guideLabels.commonTimeWaster,
    doBeforeMovingOn: guideLabels.doBeforeMovingOn,
    step: guideLabels.step,
    tip: guideLabels.tip,
    tipToMakeEasier: guideLabels.tipToMakeEasier,
    warning: guideLabels.warning,
    whatToKnow: guideLabels.whatToKnow,
  }

  return (
    <ScrollView
      style={styles.container}
      contentContainerStyle={styles.content}
      showsVerticalScrollIndicator={false}
      refreshControl={
        <RefreshControl
          refreshing={isRefetching}
          onRefresh={refetch}
          colors={[colors.primary]}
        />
      }
    >
      <View style={guideStyles.hero}>
        <View style={styles.navRow}>
          <TouchableOpacity
            activeOpacity={0.82}
            style={styles.iconButton}
            onPress={() => router.back()}
          >
            <Ionicons name="arrow-back" size={21} color={colors.primary} />
          </TouchableOpacity>

          <View style={styles.navActions}>
            <TouchableOpacity
              activeOpacity={0.82}
              style={styles.iconButton}
              onPress={handleShare}
            >
              <Ionicons name="share-social-outline" size={20} color={colors.primary} />
            </TouchableOpacity>

            <TouchableOpacity
              activeOpacity={0.82}
              style={styles.iconButton}
              onPress={handleSave}
            >
              <Ionicons
                name={isSaved ? 'bookmark' : 'bookmark-outline'}
                size={21}
                color={isSaved ? colors.accent : colors.primary}
              />
            </TouchableOpacity>
          </View>
        </View>

        <View style={styles.heroBody}>
          <Badge
            label={
              activeGuide.category
                ? getCategoryName(activeGuide.category)
                : guideLabels.guide
            }
            icon={activeGuide.category?.icon}
            color={categoryColor}
          />

          <SafeText variant="h1" color="surface" style={styles.title}>
            {getTitle(activeGuide)}
          </SafeText>

          <SafeText variant="body" color="surface" style={styles.tagline}>
            {getTagline(activeGuide)}
          </SafeText>

          <View style={styles.metaGrid}>
            <GuideMetaPill
              icon="time-outline"
              label={`${activeGuide.read_time_min} ${guideLabels.minute}`}
            />

            {activeGuide.estimated_cost ? (
              <GuideMetaPill
                icon="wallet-outline"
                label={getCostLabel(activeGuide.estimated_cost)}
              />
            ) : null}

            {activeGuide.difficulty ? (
              <GuideMetaPill
                icon="speedometer-outline"
                label={getDifficultyLabel(activeGuide.difficulty)}
              />
            ) : null}
          </View>
        </View>
      </View>

      {isShowingCachedGuide ? (
        <GuideCalloutCard
          variant="offline"
          title={guideLabels.offlineCopyTitle}
          body={guideLabels.offlineCopyMessage}
        />
      ) : null}

      {activeGuide.is_urgent ? (
        <GuideCalloutCard
          variant="warning"
          title={guideLabels.importantWarning}
          body={guideLabels.urgentWarningMessage}
        />
      ) : null}

      <View style={styles.trustCard}>
        <View style={styles.trustHeader}>
          <View style={styles.trustIcon}>
            <Ionicons name="shield-checkmark" size={17} color={colors.primary} />
          </View>
          <View style={styles.trustCopy}>
            <SafeText variant="label" weight="700" style={styles.compactCardTitle}>
              {guideLabels.quickCheck}
            </SafeText>
            <SafeText variant="caption" color="muted" style={styles.trustSubtitle}>
              {guideLabels.quickCheckSubtitle}
            </SafeText>
          </View>
        </View>

        <View style={styles.trustGrid}>
          <GuideTrustItem
            icon="calendar-outline"
            label={guideLabels.updated}
            value={updatedLabel}
          />
          <GuideTrustItem
            icon="shield-checkmark-outline"
            label={guideLabels.sources}
            value={
              sourceCount > 0
                ? `${sourceCount} ${guideLabels.officialSourceCount}`
                : guideLabels.verifyFirst
            }
          />
          <GuideTrustItem
            icon="time-outline"
            label={guideLabels.time}
            value={getTimeLabel(
              activeGuide.estimated_time || `${activeGuide.read_time_min} min`
            )}
          />
          <GuideTrustItem
            icon="wallet-outline"
            label={guideLabels.cost}
            value={getCostLabel(activeGuide.estimated_cost)}
          />
          <GuideTrustItem
            icon="speedometer-outline"
            label={guideLabels.level}
            value={getDifficultyLabel(activeGuide.difficulty)}
          />
        </View>

        <View style={styles.completenessBlock}>
          <SafeText variant="label" weight="700" style={styles.completenessTitle}>
            {guideLabels.guideIncludes}
          </SafeText>

          <View style={styles.completenessGrid}>
            <GuideCompletenessItem
              done={sourceCount > 0}
              label={guideLabels.sources}
            />
            <GuideCompletenessItem
              done={hasChecklist}
              label={guideLabels.checklist}
            />
            <GuideCompletenessItem
              done={hasSample}
              label={guideLabels.sample}
            />
            <GuideCompletenessItem
              done={stepCount > 0}
              label={
                stepCount > 0
                  ? `${stepCount} ${stepCountLabel}`
                  : guideLabels.stepsFallback
              }
            />
            <GuideCompletenessItem
              done={warningCount > 0}
              label={
                warningCount > 0
                  ? `${warningCount} ${warningCountLabel}`
                  : guideLabels.warningFallback
              }
            />
          </View>
        </View>

        {officialSources.length === 0 ? (
          <View style={styles.officialNote}>
            <Ionicons name="information-circle" size={17} color={colors.warning} />
            <SafeText variant="caption" color="muted" style={styles.officialText}>
              {guideLabels.officialVerificationNote}
            </SafeText>
          </View>
        ) : null}
      </View>

      <GuideOfficialSourcesCard
        sources={officialSources}
        title={guideLabels.officialSourcesTitle}
        subtitle={guideLabels.officialSourcesSubtitle}
        onOpenError={() =>
          showFeedback(guideLabels.unableToOpenSource, 'info')
        }
      />

      <View style={styles.sectionContainer}>
        {sections.length > 0 ? (
          sections.map((section: GuideSection, index: number) => {
            const content = getSectionContent(section)
            return (
              <GuideSectionCard
                key={section.id || index}
                section={section}
                index={index}
                title={content?.title || `Section ${index + 1}`}
                body={content?.body || guideLabels.emptySectionBody}
                language={language}
                labels={sectionCardLabels}
              />
            )
          })
        ) : (
          <View style={styles.emptyCard}>
            <SafeText color="muted" style={styles.emptyText}>
              {isShowingCachedGuide
                ? guideLabels.cachedSummaryOnly
                : guideLabels.noContentAvailable}
            </SafeText>
          </View>
        )}
      </View>

      <TouchableOpacity
        activeOpacity={0.86}
        style={styles.bottomAction}
        onPress={handleShare}
      >
        <Ionicons name="share-social-outline" size={18} color="#FFFFFF" />
        <SafeText color="surface" weight="700">
          {guideLabels.shareGuide}
        </SafeText>
      </TouchableOpacity>

      {relatedGuides.length > 0 ? (
        <View style={styles.relatedSection}>
          <SafeText variant="h3" weight="700" style={styles.relatedTitle}>
            {guideLabels.readNext}
          </SafeText>
          <SafeText variant="caption" color="muted" style={styles.relatedSubtitle}>
            {guideLabels.readNextSubtitle}
          </SafeText>

          {relatedGuides.map((item: Guide) => (
            <GuideCard
              key={item.id}
              guide={item}
              language={language}
              isSaved={isGuideSaved(item.id)}
              onPress={() =>
                router.push({
                  pathname: '/guide/[id]',
                  params: { id: item.id },
                })
              }
              onSave={() => toggleSave(item)}
              compact
            />
          ))}
        </View>
      ) : (
        <View style={styles.nextStepCard}>
          <SafeText variant="h3" weight="700" style={styles.nextStepTitle}>
            {guideLabels.doneHere}
          </SafeText>
          <SafeText variant="bodyMd" color="muted" style={styles.nextStepText}>
            {guideLabels.doneHereSubtitle}
          </SafeText>

          <View style={styles.nextStepActions}>
            <TouchableOpacity
              activeOpacity={0.86}
              style={styles.nextStepPrimary}
              onPress={() => router.push('/search')}
            >
              <SafeText color="surface" weight="700">
                {t.search}
              </SafeText>
            </TouchableOpacity>

            <TouchableOpacity
              activeOpacity={0.86}
              style={styles.nextStepSecondary}
              onPress={() => router.push('/categories')}
            >
              <SafeText color="primary" weight="700">
                {t.categories}
              </SafeText>
            </TouchableOpacity>
          </View>
        </View>
      )}
    </ScrollView>
  )

  function formatUpdatedDate(value?: string | null) {
    return formatGuideUpdatedDate(value, guideLabels, language)
  }
}

const createStyles = (colors: ThemeColors, heroColor: string) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },

    content: {
      paddingBottom: 140,
    },

    errorContent: {
      flexGrow: 1,
      justifyContent: 'center',
      alignItems: 'center',
      padding: spacing.xl,
      paddingBottom: 140,
    },

    errorTitle: {
      marginBottom: spacing.sm,
      textAlign: 'center',
    },

    errorText: {
      textAlign: 'center',
    },

    hero: {
      backgroundColor: heroColor,
      paddingHorizontal: spacing.lg,
      paddingTop: spacing.xl,
      paddingBottom: spacing.xl,
      borderBottomLeftRadius: 28,
      borderBottomRightRadius: 28,
    },

    navRow: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
      marginBottom: spacing.lg,
    },

    navActions: {
      flexDirection: 'row',
      gap: spacing.sm,
    },

    iconButton: {
      width: 42,
      height: 42,
      borderRadius: 21,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
    },

    heroBody: {
      paddingTop: spacing.xs,
    },

    title: {
      marginTop: spacing.md,
      marginBottom: spacing.sm,
      maxWidth: 370,
    },

    tagline: {
      opacity: 0.9,
      maxWidth: 380,
    },

    metaGrid: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.sm,
      marginTop: spacing.lg,
    },

    trustCard: {
      marginHorizontal: spacing.md,
      marginTop: spacing.md,
      borderRadius: 14,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.sm,
    },

    trustHeader: {
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
      marginBottom: spacing.xs,
    },

    trustIcon: {
      width: 32,
      height: 32,
      borderRadius: 12,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
    },

    trustCopy: {
      flex: 1,
    },

    trustSubtitle: {
      marginTop: 1,
    },

    trustGrid: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.xs,
    },

    officialNote: {
      marginTop: spacing.sm,
      borderRadius: 12,
      backgroundColor: colors.warningLight,
      padding: spacing.sm,
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.sm,
    },

    officialText: {
      flex: 1,
    },

    completenessBlock: {
      marginTop: spacing.sm,
      borderRadius: 12,
      backgroundColor: colors.surfaceSecondary,
      padding: spacing.sm,
    },

    completenessTitle: {
      textTransform: 'uppercase',
      marginBottom: spacing.xs,
    },

    completenessGrid: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.xs,
    },

    compactCardTitle: {
      textTransform: 'uppercase',
    },

    sectionContainer: {
      padding: spacing.md,
      paddingTop: spacing.md,
    },

    sectionCard: {
      backgroundColor: colors.surface,
      borderRadius: 14,
      borderWidth: 1,
      borderLeftWidth: 4,
      borderColor: colors.border,
      padding: spacing.md,
      marginBottom: spacing.md,
      elevation: 2,
      shadowColor: colors.shadow,
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.07,
      shadowRadius: 5,
    },

    emptyCard: {
      backgroundColor: colors.surface,
      borderRadius: 16,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.lg,
    },

    emptyText: {
      textAlign: 'center',
    },

    bottomAction: {
      marginHorizontal: spacing.md,
      marginTop: spacing.sm,
      borderRadius: 14,
      minHeight: 52,
      backgroundColor: colors.primary,
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'center',
      gap: spacing.sm,
    },

    relatedSection: {
      paddingHorizontal: spacing.md,
      paddingTop: spacing.lg,
    },

    relatedTitle: {
      marginBottom: spacing.xs,
    },

    relatedSubtitle: {
      marginBottom: spacing.md,
    },

    nextStepCard: {
      marginHorizontal: spacing.md,
      marginTop: spacing.lg,
      borderRadius: 18,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.lg,
    },

    nextStepTitle: {
      marginBottom: spacing.sm,
    },

    nextStepText: {
      marginBottom: spacing.lg,
    },

    nextStepActions: {
      flexDirection: 'row',
      gap: spacing.sm,
    },

    nextStepPrimary: {
      flex: 1,
      minHeight: 48,
      borderRadius: 14,
      backgroundColor: colors.primary,
      alignItems: 'center',
      justifyContent: 'center',
    },

    nextStepSecondary: {
      flex: 1,
      minHeight: 48,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.primary,
      alignItems: 'center',
      justifyContent: 'center',
    },
  })
