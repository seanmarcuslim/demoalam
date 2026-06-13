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
  useFeaturedGuides,
  useGuides,
  useTrendingGuides,
  useUrgentGuides,
} from '../../src/hooks/useGuides'
import { useCategories } from '../../src/hooks/useCategories'
import { useHistoryStore } from '../../src/stores/historyStore'
import { useSavedStore } from '../../src/stores/savedStore'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { translations } from '../../src/utils/translations'
import { useTheme } from '../../src/hooks/useTheme'
import { spacing } from '../../src/theme/spacing'
import type { ThemeColors } from '../../src/theme/colors'
import SafeText from '../../src/components/ui/SafeText'
import Badge from '../../src/components/ui/Badge'
import AppButton from '../../src/components/ui/AppButton'
import GuideCard from '../../src/components/guide/GuideCard'
import HomeCuratedSection from '../../src/components/home/HomeCuratedSection'
import { Guide } from '../../src/types/guide'
import LoadingFeed from '../../src/components/layout/LoadingFeed'
import { getCategoryAccent } from '../../src/lib/categoryVisuals'
import { isGovernmentAidGuide } from '../../src/lib/guideCollections'
import {
  getGuideCategoryName,
  getGuideTagline,
  getGuideTitle,
} from '../../src/lib/guideDisplay'

type GuidancePath = {
  id: string
  zone: 'today' | 'future'
  icon: keyof typeof Ionicons.glyphMap
  slugs: string[]
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

  const {
    data: guides = [],
    isLoading,
    isError,
    refetch,
    isRefetching,
  } = useGuides()
  const { data: featured = [] } = useFeaturedGuides()
  const { data: featuredBundles = [] } = useFeaturedGuideBundles()
  const { data: urgent = [] } = useUrgentGuides()
  const { data: trending = [] } = useTrendingGuides()
  const { data: categories = [] } = useCategories()
  const { recentIds, cachedGuides } = useHistoryStore()
  const toggleSave = useSavedStore((state) => state.toggleSave)
  const isSaved = useSavedStore((state) => state.isSaved)

  const recentGuides = recentIds
    .map((id) => cachedGuides[id])
    .filter(Boolean)
    .slice(0, 5)

  const featuredGuide = featured[0]
  const trendingGuides = (trending.length > 0 ? trending : guides).slice(0, 4)
  const visibleGuideCount = Math.max(guides.length, trendingGuides.length, recentGuides.length)
  const visibleAlertCount = Math.max(
    urgent.length,
    guides.filter((guide) => guide.is_urgent).length
  )
  const firstTimerGuides = guides
    .filter((guide) =>
      guide.tags?.some((tag) =>
        ['first job', 'first-time', 'valid id', 'requirements'].some((needle) =>
          tag.toLowerCase().includes(needle)
        )
      )
    )
    .slice(0, 4)
  const moneyGuides = guides
    .filter((guide) => guide.category?.slug === 'money')
    .slice(0, 4)
  const governmentAidGuides = guides
    .filter(isGovernmentAidGuide)
    .slice(0, 8)
  const governmentGuides = guides
    .filter((guide) => guide.category?.slug === 'gov')
    .slice(0, 4)

  const guidancePaths: GuidancePath[] = [
    {
      id: 'scam',
      zone: 'today',
      icon: 'shield-checkmark-outline',
      slugs: ['gcash-scam-red-flags', 'phishing-link-checklist', 'fake-job-offer-red-flags'],
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
      ],
      title: labels.guidancePaths.scholarship.title,
      subtitle: labels.guidancePaths.scholarship.subtitle,
      start: labels.guidancePaths.scholarship.start,
    },
    {
      id: 'first-job',
      zone: 'today',
      icon: 'briefcase-outline',
      slugs: ['first-job-requirements', 'resume-no-experience', 'job-interview-basic-answers'],
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
        'lost-wallet-first-steps',
        'lost-atm-debit-card-checklist',
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
        'student-financial-aid-philippines-checklist',
        'first-job-requirements',
      ],
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
      ],
      title: labels.guidancePaths.study.title,
      subtitle: labels.guidancePaths.study.subtitle,
      start: labels.guidancePaths.study.start,
    },
    {
      id: 'work-life',
      zone: 'future',
      icon: 'people-outline',
      slugs: ['first-job-requirements', 'resume-no-experience', 'job-interview-basic-answers'],
      title: labels.guidancePaths.workLife.title,
      subtitle: labels.guidancePaths.workLife.subtitle,
      start: labels.guidancePaths.workLife.start,
    },
    {
      id: 'lessons',
      zone: 'future',
      icon: 'sparkles-outline',
      slugs: [
        'loan-red-flags-before-borrowing',
        'emergency-fund-starter-checklist',
        'everyday-rights-philippines-checklist',
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

  const openCategory = (id: string, name: string) => {
    router.push({
      pathname: '/category/[id]',
      params: { id, name },
    })
  }

  const openSearch = () => {
    router.push('/search')
  }

  const getTitle = (guide: Guide) =>
    getGuideTitle(guide, language)

  const getTagline = (guide: Guide) =>
    getGuideTagline(guide, language)

  const getCategoryName = (category: NonNullable<Guide['category']>) =>
    getGuideCategoryName(category, language)

  const renderCuratedSection = (props: {
    title: string
    subtitle: string
    items: Guide[]
    icon?: string
    priority?: boolean
  }) => (
    <HomeCuratedSection
      {...props}
      language={language}
      priorityPillLabel={labels.priorityPill}
      isSaved={isSaved}
      onOpenGuide={openGuide}
      onSaveGuide={toggleSave}
    />
  )

  const renderGuidanceZone = (
    zone: GuidancePath['zone'],
    title: string,
    subtitle: string
  ) => (
    <View style={styles.guidanceZone}>
      <View style={styles.sectionHeader}>
        <SafeText variant="h3" weight="700">
          {title}
        </SafeText>
        <SafeText variant="caption" color="muted" style={styles.sectionSubtitle}>
          {subtitle}
        </SafeText>
      </View>

      <View style={styles.guidanceGrid}>
        {guidancePaths
          .filter((path) => path.zone === zone)
          .map((path) => {
            const isSelected = selectedGuidanceId === path.id
            const pathGuides = path.slugs
              .map((slug) => guides.find((guide) => guide.slug === slug))
              .filter((guide): guide is Guide => Boolean(guide))
              .slice(0, 3)
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
                        <View key={guide.id} style={styles.guidanceGuideChip}>
                          <SafeText variant="caption" color="primary" weight="700" numberOfLines={1}>
                            {getTitle(guide)}
                          </SafeText>
                        </View>
                      ))}
                    </View>
                    <AppButton
                      title={firstGuide ? labels.guidanceOpenFirstGuide : labels.guidanceOpenSearch}
                      onPress={() => {
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
    </View>
  )

  const renderHeader = () => (
    <View>
      <View style={styles.hero}>
        <View style={styles.heroGlow} />

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
            <Ionicons name="bulb-outline" size={25} color={colors.primary} />
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

      <View style={styles.section}>
        {renderGuidanceZone('today', labels.guidanceTodayTitle, labels.guidanceTodaySubtitle)}
        {renderGuidanceZone('future', labels.guidanceFutureTitle, labels.guidanceFutureSubtitle)}
      </View>

      <View style={styles.section}>
        <View style={styles.sectionHeader}>
          <SafeText variant="h3" weight="700">
            {t.categories}
          </SafeText>
          <SafeText variant="caption" color="muted">
            {labels.browseTopics}
          </SafeText>
        </View>

        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          contentContainerStyle={styles.categoryRow}
        >
          {categories.map((cat) => {
            const accent = getCategoryAccent(cat, colors.primary)

            return (
              <TouchableOpacity
                key={cat.id}
                activeOpacity={0.86}
                style={[
                  styles.categoryChip,
                  {
                    borderColor: `${accent}35`,
                    backgroundColor: `${accent}12`,
                  },
                ]}
                onPress={() => openCategory(cat.id, getCategoryName(cat))}
              >
                <SafeText style={styles.categoryIcon}>{cat.icon}</SafeText>
                <SafeText variant="label" style={{ color: accent }}>
                  {getCategoryName(cat)}
                </SafeText>
              </TouchableOpacity>
            )
          })}
        </ScrollView>
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
      {featuredGuide ? (
        <TouchableOpacity
          activeOpacity={0.88}
          style={styles.featured}
          onPress={() => openGuide(featuredGuide.id)}
        >
          <View style={styles.featuredCopy}>
            <Badge label={t.featured} color={colors.accent} />
            <SafeText variant="h2" color="surface" style={styles.featuredTitle} numberOfLines={2}>
              {getTitle(featuredGuide)}
            </SafeText>
            <SafeText variant="bodyMd" color="surface" style={styles.featuredText} numberOfLines={2}>
              {getTagline(featuredGuide)}
            </SafeText>
          </View>

          <View style={styles.featuredAction}>
            <Ionicons name="arrow-forward" size={20} color={colors.primary} />
          </View>
        </TouchableOpacity>
      ) : null}

      {urgent.length > 0 ? (
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <SafeText variant="h3" weight="700">
              {t.scamAlerts}
            </SafeText>
            <SafeText variant="caption" color="muted">
              {labels.urgentSubtitle}
            </SafeText>
          </View>

          {urgent.map((guide) => (
            <GuideCard
              key={guide.id}
              guide={guide}
              language={language}
              isSaved={isSaved(guide.id)}
              onPress={() => openGuide(guide.id)}
              onSave={() => toggleSave(guide)}
              compact
            />
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

      {renderCuratedSection({
        title: labels.dswdAidTitle,
        subtitle: labels.dswdAidSubtitle,
        items: governmentAidGuides,
        icon: '',
        priority: true,
      })}

      {renderCuratedSection({
        title: labels.trendingTitle,
        subtitle:
          trending.length > 0
            ? labels.trendingSubtitle
            : labels.trendingFallbackSubtitle,
        items: trendingGuides,
        icon: '',
      })}

      {renderCuratedSection({
        title: labels.firstTimersTitle,
        subtitle: labels.firstTimersSubtitle,
        items: firstTimerGuides,
        icon: '',
      })}

      {renderCuratedSection({
        title: labels.moneyTitle,
        subtitle: labels.moneySubtitle,
        items: moneyGuides,
        icon: '',
      })}

      {renderCuratedSection({
        title: labels.governmentTitle,
        subtitle: labels.governmentSubtitle,
        items: governmentGuides,
        icon: '',
      })}

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
      backgroundColor: colors.primary,
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
      backgroundColor: colors.surface,
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

    sectionHeader: {
      marginBottom: spacing.md,
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
      borderColor: colors.primary,
      backgroundColor: `${colors.primary}18`,
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
      borderColor: `${colors.primary}35`,
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

    categoryRow: {
      gap: spacing.sm,
      paddingRight: spacing.md,
    },

    categoryChip: {
      minHeight: 44,
      borderRadius: 999,
      borderWidth: 1,
      paddingHorizontal: spacing.md,
      paddingVertical: spacing.sm,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
    },

    categoryIcon: {
      fontSize: 16,
    },

    featured: {
      marginHorizontal: spacing.md,
      marginTop: spacing.lg,
      backgroundColor: colors.primaryDark,
      borderRadius: 18,
      padding: spacing.lg,
      minHeight: 188,
      overflow: 'hidden',
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'flex-end',
      elevation: 4,
      shadowColor: colors.shadow,
      shadowOffset: { width: 0, height: 4 },
      shadowOpacity: 0.14,
      shadowRadius: 8,
    },

    featuredCopy: {
      flex: 1,
      paddingRight: spacing.md,
    },

    featuredTitle: {
      marginTop: spacing.md,
      marginBottom: spacing.sm,
    },

    featuredText: {
      opacity: 0.86,
    },

    featuredAction: {
      width: 44,
      height: 44,
      borderRadius: 22,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
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
