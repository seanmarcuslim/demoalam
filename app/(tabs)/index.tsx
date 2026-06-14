import { BundleCard } from '../../src/components/bundles/BundleCard'
import { useFeaturedGuideBundles } from '../../src/hooks/useGuideBundles'
import { useState } from 'react'
import {
  RefreshControl,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  View,
} from 'react-native'
import { router } from 'expo-router'
import { Ionicons } from '@expo/vector-icons'
import {
  useGuides,
  useUrgentGuides,
} from '../../src/hooks/useGuides'
import { useHistoryStore } from '../../src/stores/historyStore'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { useCourseFitProgressStore } from '../../src/stores/courseFitProgressStore'
import { translations } from '../../src/utils/translations'
import { useTheme } from '../../src/hooks/useTheme'
import { spacing } from '../../src/theme/spacing'
import type { ThemeColors } from '../../src/theme/colors'
import SafeText from '../../src/components/ui/SafeText'
import AppButton from '../../src/components/ui/AppButton'
import { Guide } from '../../src/types/guide'
import LoadingFeed from '../../src/components/layout/LoadingFeed'
import {
  getGuideCategoryName,
  getGuideTitle,
} from '../../src/lib/guideDisplay'
import { analyticsService } from '../../src/services/analyticsService'

type GuidancePath = {
  id: string
  zone: 'today' | 'future'
  icon: keyof typeof Ionicons.glyphMap
  slugs: string[]
  flowPath?: '/flow/course-fit'
  flowSlug?: 'course-fit'
  title: string
  subtitle: string
  start: string
}

export default function HomeScreen() {
  const { colors } = useTheme()
  const { language } = useSettingsStore()
  const t = translations[language]
  const labels = t.homeScreen
  const styles = createStyles(colors)
  const [selectedGuidanceId, setSelectedGuidanceId] = useState<string | null>(null)
  const [collapsedGuidanceZones, setCollapsedGuidanceZones] = useState({
    today: false,
    future: false,
  })
  const [nextMoveCollapsed, setNextMoveCollapsed] = useState(false)

  const {
    data: guides = [],
    isLoading,
    isError,
    refetch,
    isRefetching,
  } = useGuides()
  const { data: featuredBundles = [] } = useFeaturedGuideBundles()
  const { data: urgent = [] } = useUrgentGuides()
  const { recentIds, cachedGuides } = useHistoryStore()
  const courseFitOpened = useCourseFitProgressStore((state) => state.courseFitOpened)
  const courseFitStarted = useCourseFitProgressStore((state) => state.courseFitStarted)
  const courseFitCompleted = useCourseFitProgressStore((state) => state.courseFitCompleted)
  const courseFitGuideViewed = useCourseFitProgressStore((state) => state.courseFitGuideViewed)
  const courseFitNextMoveDismissed = useCourseFitProgressStore(
    (state) => state.courseFitNextMoveDismissed
  )
  const markCourseFitOpened = useCourseFitProgressStore(
    (state) => state.markCourseFitOpened
  )
  const dismissCourseFitNextMove = useCourseFitProgressStore(
    (state) => state.dismissCourseFitNextMove
  )

  const recentGuides = recentIds
    .map((id) => cachedGuides[id])
    .filter(Boolean)
    .slice(0, 5)

  const visibleGuideCount = Math.max(guides.length, recentGuides.length)
  const visibleAlertCount = Math.max(
    urgent.length,
    guides.filter((guide) => guide.is_urgent).length
  )
  const guidancePaths: GuidancePath[] = [
    {
      id: 'scam',
      zone: 'today',
      icon: 'shield-checkmark-outline',
      slugs: [
        'gcash-scam-red-flags',
        'gcash-maya-account-recovery-first-hour',
        'wrong-send-gcash-checklist',
        'phishing-link-checklist',
        'fake-job-offer-red-flags',
        'loan-red-flags-before-borrowing',
        'loan-app-harassment-evidence-checklist',
      ],
      title: labels.guidancePaths.scam.title,
      subtitle: labels.guidancePaths.scam.subtitle,
      start: labels.guidancePaths.scam.start,
    },
    {
      id: 'scholarship',
      zone: 'today',
      icon: 'school-outline',
      slugs: [
        'student-financial-aid-philippines-checklist',
        'student-cash-for-work-dswd-checklist',
        'dswd-aics-assistance-checklist',
        'cash-for-training',
      ],
      title: labels.guidancePaths.scholarship.title,
      subtitle: labels.guidancePaths.scholarship.subtitle,
      start: labels.guidancePaths.scholarship.start,
    },
    {
      id: 'first-job',
      zone: 'today',
      icon: 'briefcase-outline',
      slugs: [
        'first-job-requirements',
        'resume-no-experience',
        'job-interview-basic-answers',
        'nbi-clearance-first-timers',
        'sss-number-first-job',
        'philhealth-pagibig-tin-basics',
        'bank-account-first-time',
        'fast-valid-id',
      ],
      title: labels.guidancePaths.firstJob.title,
      subtitle: labels.guidancePaths.firstJob.subtitle,
      start: labels.guidancePaths.firstJob.start,
    },
    {
      id: 'emergency',
      zone: 'today',
      icon: 'alert-circle-outline',
      slugs: [
        'phone-stolen-first-hour',
        'medical-emergency-documents',
        'public-hospital-social-service-desk-guide',
        'pcso-medical-assistance-checklist',
        'philhealth-hospital-benefits-checklist',
        'road-accident-first-steps',
        'emergency-cash-transfer-disaster-aid-checklist',
        'lost-wallet-first-steps',
        'lost-atm-debit-card-checklist',
        'lost-sim-replacement-checklist',
      ],
      title: labels.guidancePaths.emergency.title,
      subtitle: labels.guidancePaths.emergency.subtitle,
      start: labels.guidancePaths.emergency.start,
    },
    {
      id: 'course',
      zone: 'future',
      icon: 'compass-outline',
      slugs: [
        'choose-course-fit-checklist',
        'compare-3-course-options-checklist',
        'student-financial-aid-philippines-checklist',
        'study-smarter-when-behind-checklist',
      ],
      flowPath: '/flow/course-fit',
      flowSlug: 'course-fit',
      title: labels.guidancePaths.course.title,
      subtitle: labels.guidancePaths.course.subtitle,
      start: labels.guidancePaths.course.start,
    },
    {
      id: 'study',
      zone: 'future',
      icon: 'book-outline',
      slugs: [
        'study-smarter-when-behind-checklist',
        'student-financial-aid-philippines-checklist',
        'student-cash-for-work-dswd-checklist',
        'resume-no-experience',
      ],
      title: labels.guidancePaths.study.title,
      subtitle: labels.guidancePaths.study.subtitle,
      start: labels.guidancePaths.study.start,
    },
    {
      id: 'work-life',
      zone: 'future',
      icon: 'people-outline',
      slugs: [
        'first-job-requirements',
        'sss-number-first-job',
        'salary-paycheck-checklist',
        'unpaid-salary-kulang-sahod-checklist',
        'payday-budget-simple-split',
        'bank-account-first-time',
      ],
      title: labels.guidancePaths.workLife.title,
      subtitle: labels.guidancePaths.workLife.subtitle,
      start: labels.guidancePaths.workLife.start,
    },
    {
      id: 'lessons',
      zone: 'future',
      icon: 'sparkles-outline',
      slugs: [
        'choose-course-fit-checklist',
        'compare-3-course-options-checklist',
        'study-smarter-when-behind-checklist',
        'loan-red-flags-before-borrowing',
        'salary-paycheck-checklist',
        'emergency-fund-starter-checklist',
        'everyday-rights-philippines-checklist',
        'fake-job-offer-red-flags',
        'tenant-deposit-refund-checklist',
        'renting-first-time-checklist',
      ],
      title: labels.guidancePaths.lessons.title,
      subtitle: labels.guidancePaths.lessons.subtitle,
      start: labels.guidancePaths.lessons.start,
    },
  ]

  const openGuide = (id: string) => {
    router.push({
      pathname: '/guide/[id]',
      params: { id },
    })
  }

  const openSearch = () => {
    router.push('/search')
  }

  const openGuidanceFlow = (path: GuidancePath) => {
    if (!path.flowPath || !path.flowSlug) {
      return
    }

    if (path.flowSlug === 'course-fit') {
      markCourseFitOpened()
    }

    analyticsService.logFlowEvent({
      flowSlug: path.flowSlug,
      eventName: 'flow_opened',
      language,
    }).catch(() => {
      // Analytics should never interrupt Home navigation.
    })

    router.push(path.flowPath)
  }

  const openCourseFitNextMove = () => {
    const nextMoveGuide = guides.find(
      (guide) => guide.slug === 'compare-3-course-options-checklist'
    )
    const courseFitGuide = guides.find(
      (guide) => guide.slug === 'choose-course-fit-checklist'
    )

    const selectedGuide = nextMoveGuide || courseFitGuide

    if ((courseFitCompleted || courseFitGuideViewed) && selectedGuide) {
      openGuide(selectedGuide.id)
      return
    }

    markCourseFitOpened()
    router.push('/flow/course-fit')
  }

  const getTitle = (guide: Guide) =>
    getGuideTitle(guide, language)

  const getCategoryName = (category: NonNullable<Guide['category']>) =>
    getGuideCategoryName(category, language)

  const renderGuidanceZone = (
    zone: GuidancePath['zone'],
    title: string,
    subtitle: string
  ) => {
    const isCollapsed = collapsedGuidanceZones[zone]

    return (
      <View style={styles.guidanceZone}>
        <TouchableOpacity
          activeOpacity={0.84}
          style={styles.collapsibleHeader}
          onPress={() =>
            setCollapsedGuidanceZones((current) => ({
              ...current,
              [zone]: !current[zone],
            }))
          }
          accessibilityRole="button"
        >
          <View style={styles.collapsibleHeaderCopy}>
            <SafeText variant="h3" weight="700">
              {title}
            </SafeText>
            <SafeText variant="caption" color="muted" style={styles.sectionSubtitle}>
              {subtitle}
            </SafeText>
          </View>

          <View style={styles.collapseButton}>
            <Ionicons
              name={isCollapsed ? 'chevron-down' : 'chevron-up'}
              size={18}
              color={colors.accent}
            />
          </View>
        </TouchableOpacity>

        {!isCollapsed ? (
          <View style={styles.guidanceGrid}>
            {guidancePaths
              .filter((path) => path.zone === zone)
              .map((path) => {
                const isSelected = selectedGuidanceId === path.id
                const pathGuides = path.slugs
                  .map((slug) => guides.find((guide) => guide.slug === slug))
                  .filter((guide): guide is Guide => Boolean(guide))
                const firstGuide = pathGuides[0]

                return (
                  <TouchableOpacity
                    key={path.id}
                    activeOpacity={0.86}
                    style={[
                      styles.guidanceCard,
                      isSelected ? styles.guidanceCardSelected : null,
                    ]}
                    onPress={() => setSelectedGuidanceId(isSelected ? null : path.id)}
                  >
                    <View style={styles.guidanceIcon}>
                      <Ionicons name={path.icon} size={20} color={colors.primary} />
                    </View>
                    <SafeText variant="body" weight="700" numberOfLines={2}>
                      {path.title}
                    </SafeText>
                    <SafeText
                      variant="caption"
                      color="muted"
                      style={styles.guidanceCardText}
                      numberOfLines={3}
                    >
                      {path.subtitle}
                    </SafeText>

                    {isSelected ? (
                      <View style={styles.guidanceInlinePanel}>
                        <SafeText variant="caption" color="primary" weight="700">
                          {labels.guidanceStartHere}
                        </SafeText>
                        <SafeText
                          variant="caption"
                          color="muted"
                          style={styles.guidanceInlineText}
                          numberOfLines={4}
                        >
                          {path.start}
                        </SafeText>
                        <View style={styles.guidanceInlineChips}>
                          {pathGuides.map((guide) => (
                            <TouchableOpacity
                              key={guide.id}
                              activeOpacity={0.82}
                              style={styles.guidanceGuideChip}
                              onPress={() => openGuide(guide.id)}
                            >
                              <SafeText variant="caption" color="primary" weight="700" numberOfLines={1}>
                                {getTitle(guide)}
                              </SafeText>
                            </TouchableOpacity>
                          ))}
                        </View>
                        <AppButton
                          title={
                            path.flowPath
                              ? language === 'fil'
                                ? 'Simulan ang check'
                                : 'Start quick check'
                              : firstGuide
                                ? labels.guidanceOpenFirstGuide
                                : labels.guidanceOpenSearch
                          }
                          onPress={() => {
                            if (path.flowPath) {
                              openGuidanceFlow(path)
                              return
                            }

                            if (firstGuide) {
                              openGuide(firstGuide.id)
                              return
                            }

                            openSearch()
                          }}
                          style={styles.guidanceInlineAction}
                        />
                      </View>
                    ) : null}
                  </TouchableOpacity>
                )
              })}
          </View>
        ) : null}
      </View>
    )
  }

  const renderYourNextMove = () => {
    const shouldShow =
      !courseFitNextMoveDismissed &&
      (courseFitOpened ||
        courseFitStarted ||
        courseFitCompleted ||
        courseFitGuideViewed)

    if (!shouldShow) {
      return null
    }

    const isGuideStep = courseFitCompleted || courseFitGuideViewed

    if (nextMoveCollapsed) {
      return (
        <View style={styles.nextMoveSection}>
          <TouchableOpacity
            activeOpacity={0.86}
            style={[styles.nextMoveCard, styles.nextMoveCompactCard]}
            onPress={() => setNextMoveCollapsed(false)}
            accessibilityRole="button"
          >
            <View style={styles.nextMoveIcon}>
              <Ionicons name="compass-outline" size={20} color={colors.accent} />
            </View>

            <View style={styles.nextMoveCopy}>
              <SafeText variant="caption" color="primary" weight="700">
                {language === 'fil' ? 'Susunod Mong Hakbang' : 'Your Next Move'}
              </SafeText>
              <SafeText variant="body" weight="700" style={styles.nextMoveTitle}>
                {language === 'fil' ? 'I-tap para buksan ulit.' : 'Tap to expand again.'}
              </SafeText>
            </View>

            <Ionicons name="chevron-down" size={18} color={colors.accent} />
          </TouchableOpacity>
        </View>
      )
    }

    return (
      <View style={styles.nextMoveSection}>
        <TouchableOpacity
          activeOpacity={0.88}
          style={styles.nextMoveCard}
          onPress={openCourseFitNextMove}
          accessibilityRole="button"
        >
          <View style={styles.nextMoveIcon}>
            <Ionicons name="compass-outline" size={20} color={colors.primary} />
          </View>

          <View style={styles.nextMoveCopy}>
            <SafeText variant="caption" color="primary" weight="700">
              {language === 'fil' ? 'Susunod Mong Hakbang' : 'Your Next Move'}
            </SafeText>
            <SafeText variant="body" weight="700" style={styles.nextMoveTitle}>
              {language === 'fil'
                ? 'Pumipili ka ng course.'
                : "You're choosing a course."}
            </SafeText>
            <SafeText variant="caption" color="muted" style={styles.nextMoveText}>
              {language === 'fil'
                ? isGuideStep
                  ? 'Next: Ikumpara ang 3 course options bago magdesisyon.'
                  : 'Next: Alamin kung ano ang dapat i-check bago magdesisyon.'
                : isGuideStep
                  ? 'Next: Compare 3 course options before deciding.'
                  : 'Next: Find out what you should verify before deciding.'}
            </SafeText>
          </View>

          <View style={styles.nextMoveActions}>
            <TouchableOpacity
              activeOpacity={0.82}
              style={styles.nextMoveSecondaryAction}
              onPress={() => setNextMoveCollapsed(true)}
              accessibilityRole="button"
            >
              <SafeText variant="label" color="primary" weight="700">
                {language === 'fil' ? 'I-minimize' : 'Minimize'}
              </SafeText>
            </TouchableOpacity>

            <TouchableOpacity
              activeOpacity={0.82}
              style={styles.nextMoveSecondaryAction}
              onPress={dismissCourseFitNextMove}
              accessibilityRole="button"
            >
              <SafeText variant="label" color="primary" weight="700">
                {language === 'fil' ? 'Mamaya' : 'Not now'}
              </SafeText>
            </TouchableOpacity>

            <AppButton
              title={language === 'fil' ? 'Magpatuloy' : 'Continue'}
              onPress={openCourseFitNextMove}
              style={styles.nextMoveAction}
            />
          </View>
        </TouchableOpacity>
      </View>
    )
  }

  const renderHeader = () => (
    <View>
      <View style={styles.hero}>
        <View style={styles.heroGlow} />
        <View style={styles.heroGoldGlow} />
        <View style={styles.heroAccentRail} />

        <View style={styles.heroTop}>
          <View>
            <SafeText variant="caption" color="surface" style={styles.eyebrow}>
              DemoAlam
            </SafeText>
            <SafeText variant="h1" color="surface" style={styles.heroTitle}>
              {labels.heroTitle}
            </SafeText>
          </View>

          <View style={styles.logoMark}>
            <Ionicons name="bulb-outline" size={25} color={colors.accent} />
          </View>
        </View>

        <SafeText variant="bodyMd" color="surface" style={styles.heroSubtitle}>
          {labels.heroSubtitle}
        </SafeText>

        <View style={styles.heroStats}>
          <View style={styles.statPill}>
            <SafeText variant="label" color="surface">
              {visibleGuideCount} {labels.guideCount}
            </SafeText>
          </View>
          <View style={styles.statPill}>
            <SafeText variant="label" color="surface">
              {visibleAlertCount} {labels.alertCount}
            </SafeText>
          </View>
        </View>
      </View>

      {renderYourNextMove()}

      <View style={styles.section}>
        {renderGuidanceZone('today', labels.guidanceTodayTitle, labels.guidanceTodaySubtitle)}
        {renderGuidanceZone('future', labels.guidanceFutureTitle, labels.guidanceFutureSubtitle)}
      </View>

      {featuredBundles.length > 0 ? (
        <View style={styles.section}>
          <SafeText variant="h3" weight="700">
            {labels.preparednessTitle}
          </SafeText>

          <SafeText variant="caption" color="muted" style={styles.sectionSubtitle}>
            {labels.preparednessSubtitle}
          </SafeText>

          {featuredBundles.map((bundle) => (
            <BundleCard key={bundle.id} bundle={bundle} />
          ))}
        </View>
      ) : null}

      {recentGuides.length > 0 ? (
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <SafeText variant="h3" weight="700">
              {t.recentlyViewed}
            </SafeText>
          </View>

          <ScrollView horizontal showsHorizontalScrollIndicator={false}>
            {recentGuides.map((guide) => (
              <TouchableOpacity
                key={guide.id}
                activeOpacity={0.86}
                style={styles.recentCard}
                onPress={() => openGuide(guide.id)}
              >
                <SafeText variant="caption" color="muted" numberOfLines={1}>
                  {guide.category?.icon} {guide.category ? getCategoryName(guide.category) : ''}
                </SafeText>
                <SafeText variant="body" weight="700" numberOfLines={2} style={styles.recentTitle}>
                  {getTitle(guide)}
                </SafeText>
              </TouchableOpacity>
            ))}
          </ScrollView>
        </View>
      ) : null}

      <View style={styles.browseAllPanel}>
        <SafeText variant="h3" weight="700">
          {labels.browseAllTitle}
        </SafeText>
        <SafeText variant="bodyMd" color="muted" style={styles.browseAllText}>
          {labels.browseAllSubtitle}
        </SafeText>
        <AppButton
          title={labels.browseAllAction}
          onPress={openSearch}
          style={styles.browseAllAction}
        />
      </View>
    </View>
  )

  const renderStatusBlock = () => {
    if (!isLoading && !isError && guides.length > 0) {
      return null
    }

    return (
      <View style={styles.empty}>
        {isLoading ? (
          <LoadingFeed count={3} />
        ) : isError ? (
          <>
            <Ionicons
              name="cloud-offline-outline"
              size={34}
              color={colors.warning}
            />
            <SafeText variant="h3" weight="700" style={styles.emptyTitle}>
              {labels.loadErrorTitle}
            </SafeText>
            <SafeText variant="bodyMd" color="muted" style={styles.emptyText}>
              {labels.loadErrorSubtitle}
            </SafeText>
            <AppButton
              title={labels.tryAgain}
              onPress={() => refetch()}
              style={styles.emptyAction}
            />
          </>
        ) : (
          <>
            <SafeText variant="h3" weight="700">
              {labels.emptyTitle}
            </SafeText>
            <SafeText variant="bodyMd" color="muted" style={styles.emptyText}>
              {labels.emptySubtitle}
            </SafeText>
          </>
        )}
      </View>
    )
  }

  return (
    <ScrollView
      contentContainerStyle={styles.listContent}
      showsVerticalScrollIndicator={false}
      refreshControl={
        <RefreshControl
          refreshing={isRefetching}
          onRefresh={refetch}
          colors={[colors.primary]}
          tintColor={colors.primary}
        />
      }
    >
      {renderHeader()}
      {renderStatusBlock()}
    </ScrollView>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    listContent: {
      backgroundColor: colors.background,
      paddingBottom: 140,
    },

    hero: {
      backgroundColor: colors.primaryDark,
      paddingHorizontal: spacing.lg,
      paddingTop: spacing.xxl,
      paddingBottom: spacing.lg,
      borderBottomLeftRadius: 24,
      borderBottomRightRadius: 24,
      overflow: 'hidden',
    },

    heroGlow: {
      position: 'absolute',
      right: -48,
      top: -52,
      width: 152,
      height: 152,
      borderRadius: 76,
      backgroundColor: 'rgba(255,255,255,0.13)',
    },

    heroGoldGlow: {
      position: 'absolute',
      right: 26,
      bottom: -58,
      width: 150,
      height: 150,
      borderRadius: 75,
      backgroundColor: `${colors.accent}2B`,
    },

    heroAccentRail: {
      position: 'absolute',
      left: 0,
      bottom: 0,
      width: '100%',
      height: 4,
      backgroundColor: colors.accent,
      opacity: 0.78,
    },

    heroTop: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      gap: spacing.md,
    },

    eyebrow: {
      textTransform: 'uppercase',
      opacity: 0.82,
      marginBottom: spacing.sm,
    },

    heroTitle: {
      maxWidth: 290,
    },

    heroSubtitle: {
      opacity: 0.9,
      marginTop: spacing.md,
      maxWidth: 330,
    },

    logoMark: {
      width: 48,
      height: 48,
      borderRadius: 14,
      backgroundColor: colors.accentLight,
      alignItems: 'center',
      justifyContent: 'center',
    },

    heroStats: {
      flexDirection: 'row',
      gap: spacing.sm,
      marginTop: spacing.lg,
    },

    statPill: {
      borderRadius: 999,
      borderWidth: 1,
      borderColor: 'rgba(255,255,255,0.28)',
      paddingHorizontal: spacing.md,
      paddingVertical: spacing.sm,
      backgroundColor: 'rgba(255,255,255,0.12)',
    },

    section: {
      paddingHorizontal: spacing.md,
      paddingTop: spacing.lg,
    },

    nextMoveSection: {
      paddingHorizontal: spacing.md,
      paddingTop: spacing.lg,
    },

    nextMoveCard: {
      borderRadius: 16,
      borderWidth: 1,
      borderColor: `${colors.accent}55`,
      backgroundColor: colors.accentLight,
      padding: spacing.md,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    nextMoveIcon: {
      width: 40,
      height: 40,
      borderRadius: 14,
      backgroundColor: `${colors.accent}22`,
      alignItems: 'center',
      justifyContent: 'center',
    },

    nextMoveCopy: {
      flex: 1,
      minWidth: 0,
    },

    nextMoveTitle: {
      marginTop: spacing.xs,
    },

    nextMoveText: {
      marginTop: spacing.xs,
    },

    nextMoveAction: {
      minWidth: 104,
    },

    nextMoveActions: {
      alignItems: 'flex-end',
      gap: spacing.xs,
    },

    nextMoveCompactCard: {
      minHeight: 72,
    },

    nextMoveSecondaryAction: {
      minHeight: 36,
      paddingHorizontal: spacing.sm,
      alignItems: 'center',
      justifyContent: 'center',
    },

    sectionHeader: {
      marginBottom: spacing.md,
    },

    collapsibleHeader: {
      marginBottom: spacing.md,
      minHeight: 48,
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'space-between',
      gap: spacing.md,
    },

    collapsibleHeaderCopy: {
      flex: 1,
      minWidth: 0,
    },

    collapseButton: {
      width: 36,
      height: 36,
      borderRadius: 18,
      borderWidth: 1,
      borderColor: `${colors.accent}45`,
      backgroundColor: colors.accentLight,
      alignItems: 'center',
      justifyContent: 'center',
    },

    sectionSubtitle: {
      marginTop: spacing.xs,
    },

    guidanceZone: {
      marginBottom: spacing.md,
    },

    guidanceGrid: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.sm,
    },

    guidanceCard: {
      flexGrow: 1,
      flexBasis: '47%',
      maxWidth: 460,
      minHeight: 112,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.border,
      backgroundColor: colors.surface,
      padding: spacing.sm,
    },

    guidanceCardSelected: {
      flexBasis: '100%',
      maxWidth: '100%',
      borderColor: colors.accent,
      backgroundColor: colors.accentLight,
    },

    guidanceIcon: {
      width: 34,
      height: 34,
      borderRadius: 12,
      backgroundColor: `${colors.primary}18`,
      alignItems: 'center',
      justifyContent: 'center',
      marginBottom: spacing.sm,
    },

    guidanceCardText: {
      marginTop: spacing.xs,
    },

    guidanceInlinePanel: {
      borderTopWidth: 1,
      borderTopColor: colors.border,
      marginTop: spacing.sm,
      paddingTop: spacing.sm,
    },

    guidanceInlineText: {
      marginTop: spacing.xs,
    },

    guidanceInlineChips: {
      gap: spacing.xs,
      marginTop: spacing.sm,
    },

    guidanceGuideChip: {
      alignSelf: 'flex-start',
      maxWidth: '100%',
      borderRadius: 999,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: `${colors.accent}45`,
      paddingHorizontal: spacing.sm,
      paddingVertical: spacing.xs,
    },

    guidanceInlineAction: {
      marginTop: spacing.sm,
    },

    browseAllPanel: {
      paddingHorizontal: spacing.md,
      paddingTop: spacing.lg,
      paddingBottom: spacing.md,
    },

    browseAllText: {
      marginTop: spacing.xs,
      marginBottom: spacing.md,
    },

    browseAllAction: {
      alignSelf: 'flex-start',
      minWidth: 180,
    },

    recentCard: {
      width: 210,
      backgroundColor: colors.surface,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.md,
      marginRight: spacing.sm,
      minHeight: 104,
    },

    recentTitle: {
      marginTop: spacing.sm,
    },

    empty: {
      margin: spacing.md,
      borderRadius: 16,
      backgroundColor: colors.surface,
      padding: spacing.xl,
      alignItems: 'center',
      borderWidth: 1,
      borderColor: colors.border,
    },

    emptyText: {
      marginTop: spacing.sm,
      textAlign: 'center',
    },

    emptyTitle: {
      marginTop: spacing.md,
      textAlign: 'center',
    },

    emptyAction: {
      marginTop: spacing.lg,
      alignSelf: 'stretch',
    },
  })
