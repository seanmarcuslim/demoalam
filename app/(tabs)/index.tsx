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
  audiences: Array<'student' | 'life'>
  icon: keyof typeof Ionicons.glyphMap
  slugs: string[]
  searchQuery: string
  flowPath?: '/flow/course-fit'
  flowSlug?: 'course-fit'
  title: string
  subtitle: string
  start: string
}

type HomeFocus = 'study' | 'work' | 'everyday'
const GUIDANCE_PREVIEW_LIMIT = 3

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
  const [homeFocus, setHomeFocus] = useState<HomeFocus>('study')

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
      audiences: ['student', 'life'],
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
      searchQuery: 'scam warning signs',
    },
    {
      id: 'scholarship',
      zone: 'today',
      audiences: ['student'],
      icon: 'school-outline',
      slugs: [
        'student-financial-aid-philippines-checklist',
        'student-cash-for-work-dswd-checklist',
        'dswd-aics-assistance-checklist',
        'four-ps-validation-checklist',
        'walang-gutom-food-credits-checklist',
        'solo-parent-benefits-checklist',
        'sustainable-livelihood-program-checklist',
        'dswd-burial-assistance-checklist',
      ],
      title: labels.guidancePaths.scholarship.title,
      subtitle: labels.guidancePaths.scholarship.subtitle,
      start: labels.guidancePaths.scholarship.start,
      searchQuery: 'student aid scholarship',
    },
    {
      id: 'first-job',
      zone: 'today',
      audiences: ['student'],
      icon: 'briefcase-outline',
      slugs: [
        'first-job-requirements',
        'resume-no-experience',
        'job-interview-basic-answers',
        'nbi-clearance-first-timers',
        'sss-number-first-job',
        'philhealth-pagibig-tin-basics',
        'bank-account-first-time',
        'national-id-problems-checklist',
      ],
      title: labels.guidancePaths.firstJob.title,
      subtitle: labels.guidancePaths.firstJob.subtitle,
      start: labels.guidancePaths.firstJob.start,
      searchQuery: 'first job requirements',
    },
    {
      id: 'emergency',
      zone: 'today',
      audiences: ['student', 'life'],
      icon: 'alert-circle-outline',
      slugs: [
        'phone-stolen-first-hour',
        'medical-emergency-documents',
        'public-hospital-social-service-desk-guide',
        'pcso-medical-assistance-checklist',
        'philhealth-hospital-benefits-checklist',
        'road-accident-first-steps',
        'emergency-cash-transfer-disaster-aid-checklist',
        'generic-medicine-buying-checklist',
        'dswd-burial-assistance-checklist',
        'lost-wallet-first-steps',
        'lost-atm-debit-card-checklist',
        'lost-sim-replacement-checklist',
      ],
      title: labels.guidancePaths.emergency.title,
      subtitle: labels.guidancePaths.emergency.subtitle,
      start: labels.guidancePaths.emergency.start,
      searchQuery: 'emergency help',
    },
    {
      id: 'money',
      zone: 'today',
      audiences: ['life'],
      icon: 'wallet-outline',
      slugs: [
        'gcash-maya-account-recovery-first-hour',
        'wrong-send-gcash-checklist',
        'payday-budget-simple-split',
        'emergency-fund-starter-checklist',
        'loan-red-flags-before-borrowing',
        'salary-paycheck-checklist',
        'bank-account-first-time',
        'monthly-budget-checklist-families',
        'utility-bill-disconnection-checklist',
        'sustainable-livelihood-program-checklist',
      ],
      title: labels.guidancePaths.money.title,
      subtitle: labels.guidancePaths.money.subtitle,
      start: labels.guidancePaths.money.start,
      searchQuery: 'money problem',
    },
    {
      id: 'documents',
      zone: 'today',
      audiences: ['life'],
      icon: 'document-text-outline',
      slugs: [
        'national-id-problems-checklist',
        'nbi-clearance-first-timers',
        'philhealth-pagibig-tin-basics',
        'first-job-requirements',
        'bank-account-first-time',
        'office-help-message-checklist',
      ],
      title: labels.guidancePaths.documents.title,
      subtitle: labels.guidancePaths.documents.subtitle,
      start: labels.guidancePaths.documents.start,
      searchQuery: 'valid id documents',
    },
    {
      id: 'course',
      zone: 'future',
      audiences: ['student'],
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
      searchQuery: 'choose course',
    },
    {
      id: 'study',
      zone: 'future',
      audiences: ['student'],
      icon: 'book-outline',
      slugs: [
        'study-smarter-when-behind-checklist',
        'student-financial-aid-philippines-checklist',
        'student-cash-for-work-dswd-checklist',
        'choose-course-fit-checklist',
        'emergency-fund-starter-checklist',
      ],
      title: labels.guidancePaths.study.title,
      subtitle: labels.guidancePaths.study.subtitle,
      start: labels.guidancePaths.study.start,
      searchQuery: 'study smarter',
    },
    {
      id: 'work-life',
      zone: 'future',
      audiences: ['student', 'life'],
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
      searchQuery: 'first job work life',
    },
    {
      id: 'lessons',
      zone: 'future',
      audiences: ['student', 'life'],
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
      searchQuery: 'life lessons before problems',
    },
  ]
  const guidancePathGroups = {
    studyFuture: guidancePaths.filter((path) =>
      ['course', 'study', 'scholarship', 'first-job'].includes(path.id)
    ),
    studyToday: guidancePaths.filter((path) =>
      ['scam', 'emergency'].includes(path.id)
    ),
    workFuture: guidancePaths.filter((path) =>
      ['first-job', 'work-life', 'lessons'].includes(path.id)
    ),
    workToday: guidancePaths.filter((path) =>
      ['documents', 'money', 'scam'].includes(path.id)
    ),
    everydayToday: guidancePaths.filter((path) =>
      ['scam', 'emergency', 'money', 'documents'].includes(path.id)
    ),
    everydayFuture: guidancePaths.filter((path) =>
      ['lessons'].includes(path.id)
    ),
  }

  const openGuide = (id: string) => {
    router.push({
      pathname: '/guide/[id]',
      params: { id },
    })
  }

  const openSearch = () => {
    router.push('/search')
  }

  const openGuidanceSearch = (path: GuidancePath) => {
    router.push({
      pathname: '/search',
      params: {
        q: path.searchQuery,
        guidanceTitle: path.title,
        guidanceSlugs: path.slugs.join(','),
      },
    })
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
    subtitle: string,
    paths: GuidancePath[]
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
            {paths
              .map((path) => {
                const isSelected = selectedGuidanceId === path.id
                const pathGuides = path.slugs
                  .map((slug) => guides.find((guide) => guide.slug === slug))
                  .filter((guide): guide is Guide => Boolean(guide))
                const previewGuides = pathGuides.slice(0, GUIDANCE_PREVIEW_LIMIT)
                const firstGuide = pathGuides[0]
                const seeAllGuideLabel =
                  pathGuides.length > previewGuides.length
                    ? language === 'fil'
                      ? `Tingnan lahat (${pathGuides.length})`
                      : `See all ${pathGuides.length} guides`
                    : labels.guidanceSeeAllGuides

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
                          numberOfLines={3}
                        >
                          {path.start}
                        </SafeText>
                        <SafeText
                          variant="caption"
                          color="primary"
                          weight="700"
                          style={styles.guidanceInlineLabel}
                        >
                          {labels.guidanceRecommendedGuides}
                        </SafeText>
                        <View style={styles.guidanceInlineChips}>
                          {previewGuides.map((guide, index) => (
                            <TouchableOpacity
                              key={guide.id}
                              activeOpacity={0.82}
                              style={styles.guidanceGuideChip}
                              onPress={() => openGuide(guide.id)}
                            >
                              <SafeText
                                variant="caption"
                                color="primary"
                                weight="700"
                                numberOfLines={1}
                              >
                                {`${index + 1}. ${getTitle(guide)}`}
                              </SafeText>
                            </TouchableOpacity>
                          ))}
                        </View>
                        <TouchableOpacity
                          activeOpacity={0.82}
                          style={styles.guidanceSeeAllAction}
                          onPress={() => openGuidanceSearch(path)}
                          accessibilityRole="button"
                        >
                          <SafeText variant="caption" color="primary" weight="700">
                            {seeAllGuideLabel}
                          </SafeText>
                          <Ionicons name="arrow-forward" size={14} color={colors.primary} />
                        </TouchableOpacity>
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

  const renderFocusSelector = () => {
    const options: Array<{
      id: HomeFocus
      icon: keyof typeof Ionicons.glyphMap
      title: string
      subtitle: string
    }> = [
      {
        id: 'study',
        icon: 'school-outline',
        title: labels.guidanceFocusStudy,
        subtitle: labels.guidanceFocusStudySubtitle,
      },
      {
        id: 'work',
        icon: 'briefcase-outline',
        title: labels.guidanceFocusWork,
        subtitle: labels.guidanceFocusWorkSubtitle,
      },
      {
        id: 'everyday',
        icon: 'shield-checkmark-outline',
        title: labels.guidanceFocusEveryday,
        subtitle: labels.guidanceFocusEverydaySubtitle,
      },
    ]

    return (
      <View style={styles.focusPanel}>
        <SafeText variant="h3" weight="700">
          {labels.guidanceFocusTitle}
        </SafeText>
        <SafeText variant="caption" color="muted" style={styles.sectionSubtitle}>
          {labels.guidanceFocusSubtitle}
        </SafeText>

        <View style={styles.focusOptions}>
          {options.map((option) => {
            const isActive = homeFocus === option.id

            return (
              <TouchableOpacity
                key={option.id}
                activeOpacity={0.86}
                style={[
                  styles.focusOption,
                  isActive ? styles.focusOptionActive : null,
                ]}
                onPress={() => setHomeFocus(option.id)}
                accessibilityRole="button"
              >
                <View style={styles.focusIcon}>
                  <Ionicons
                    name={option.icon}
                    size={20}
                    color={isActive ? colors.accent : colors.primary}
                  />
                </View>
                <View style={styles.focusCopy}>
                  <SafeText variant="body" weight="700" style={styles.focusLabel}>
                    {option.title}
                  </SafeText>
                  <SafeText variant="caption" color="muted" style={styles.focusText}>
                    {option.subtitle}
                  </SafeText>
                </View>
              </TouchableOpacity>
            )
          })}
        </View>
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
        <View style={styles.heroSunMotif}>
          {Array.from({ length: 8 }).map((_, index) => (
            <View
              key={index}
              style={[styles.heroSunRayArm, { transform: [{ rotate: `${index * 45}deg` }] }]}
            >
              <View style={styles.heroSunRay} />
            </View>
          ))}
          <View style={styles.heroSunCore} />
        </View>
        <View style={styles.heroStarOne} />
        <View style={styles.heroStarTwo} />
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

      {renderFocusSelector()}

      <View style={styles.section}>
        {homeFocus === 'study' ? (
          <>
            {renderGuidanceZone(
              'future',
              labels.guidanceStudentTitle,
              labels.guidanceStudentSubtitle,
              guidancePathGroups.studyFuture
            )}
            {renderGuidanceZone(
              'today',
              labels.guidanceTodayTitle,
              labels.guidanceTodaySubtitle,
              guidancePathGroups.studyToday
            )}
          </>
        ) : homeFocus === 'work' ? (
          <>
            {renderGuidanceZone(
              'future',
              labels.guidanceWorkTitle,
              labels.guidanceWorkSubtitle,
              guidancePathGroups.workFuture
            )}
            {renderGuidanceZone(
              'today',
              labels.guidanceTodayTitle,
              labels.guidanceTodaySubtitle,
              guidancePathGroups.workToday
            )}
          </>
        ) : (
          <>
            {renderGuidanceZone(
              'today',
              labels.guidanceLifeTitle,
              labels.guidanceLifeSubtitle,
              guidancePathGroups.everydayToday
            )}
            {renderGuidanceZone(
              'future',
              labels.guidanceFutureTitle,
              labels.guidanceFutureSubtitle,
              guidancePathGroups.everydayFuture
            )}
          </>
        )}
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

    heroSunMotif: {
      position: 'absolute',
      right: -42,
      bottom: -48,
      width: 154,
      height: 154,
      alignItems: 'center',
      justifyContent: 'center',
      opacity: 0.18,
    },

    heroSunCore: {
      width: 52,
      height: 52,
      borderRadius: 26,
      backgroundColor: '#FCD116',
      borderWidth: 1,
      borderColor: 'rgba(255,255,255,0.34)',
    },

    heroSunRayArm: {
      position: 'absolute',
      width: 154,
      height: 154,
      alignItems: 'center',
    },

    heroSunRay: {
      width: 18,
      height: 44,
      marginTop: 2,
      borderRadius: 6,
      backgroundColor: '#FCD116',
      transform: [{ rotate: '45deg' }],
    },

    heroStarOne: {
      position: 'absolute',
      right: 112,
      top: 52,
      width: 5,
      height: 5,
      borderRadius: 3,
      backgroundColor: colors.accent,
      opacity: 0.58,
    },

    heroStarTwo: {
      position: 'absolute',
      right: 142,
      top: 100,
      width: 4,
      height: 4,
      borderRadius: 2,
      backgroundColor: 'rgba(255,255,255,0.72)',
      opacity: 0.64,
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

    focusPanel: {
      marginHorizontal: spacing.md,
      marginTop: spacing.lg,
      borderRadius: 16,
      borderWidth: 1,
      borderColor: `${colors.accent}35`,
      backgroundColor: colors.surface,
      padding: spacing.md,
    },

    focusOptions: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.sm,
      marginTop: spacing.md,
    },

    focusOption: {
      flexGrow: 1,
      flexShrink: 1,
      flexBasis: 280,
      minHeight: 96,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.border,
      backgroundColor: colors.background,
      padding: spacing.sm,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    focusOptionActive: {
      borderColor: colors.accent,
      backgroundColor: colors.accentLight,
    },

    focusIcon: {
      width: 38,
      height: 38,
      borderRadius: 13,
      backgroundColor: `${colors.primary}18`,
      alignItems: 'center',
      justifyContent: 'center',
    },

    focusCopy: {
      flex: 1,
      minWidth: 0,
    },

    focusLabel: {
      flexShrink: 1,
      flexWrap: 'wrap',
    },

    focusText: {
      marginTop: spacing.xs,
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

    guidanceInlineLabel: {
      marginTop: spacing.sm,
    },

    guidanceInlineChips: {
      gap: spacing.xs,
      marginTop: spacing.xs,
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

    guidanceSeeAllAction: {
      alignSelf: 'flex-start',
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
      marginTop: spacing.sm,
      paddingVertical: spacing.xs,
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
