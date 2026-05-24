import { BundleCard } from '../../src/components/bundles/BundleCard'
import { useFeaturedGuideBundles } from '../../src/hooks/useGuideBundles'
import {
  FlatList,
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
import { Guide } from '../../src/types/guide'
import { Category } from '../../src/types/category'
import LoadingFeed from '../../src/components/layout/LoadingFeed'
import { getCategoryAccent } from '../../src/lib/categoryVisuals'

const GOVERNMENT_AID_TERMS = [
  'dswd',
  'aics',
  'social pension',
  'walang gutom',
  '4ps',
  'emergency cash transfer',
  'sustainable livelihood',
  'livelihood assistance',
  'student cash for work',
  'cash-for-work',
  'tara basa',
  'kalahi',
]

const guideSearchText = (guide: Guide) =>
  [
    guide.slug,
    guide.title_en,
    guide.title_fil,
    guide.tagline_en,
    guide.tagline_fil,
    guide.keywords_en,
    guide.keywords_fil,
    ...(guide.tags || []),
  ]
    .filter(Boolean)
    .join(' ')
    .toLowerCase()

const isGovernmentAidGuide = (guide: Guide) => {
  const searchText = guideSearchText(guide)

  return GOVERNMENT_AID_TERMS.some((term) => searchText.includes(term))
}

export default function HomeScreen() {
  const { colors } = useTheme()
  const { language } = useSettingsStore()
  const t = translations[language]
  const styles = createStyles(colors)

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

  const getTitle = (guide: Guide) =>
    language === 'fil' ? guide.title_fil : guide.title_en

  const getTagline = (guide: Guide) =>
    language === 'fil' ? guide.tagline_fil : guide.tagline_en

  const getCategoryName = (category: Category) =>
    language === 'fil' ? category.name_fil : category.name_en

  const renderGuide = ({ item }: { item: Guide }) => (
    <GuideCard
      guide={item}
      language={language}
      isSaved={isSaved(item.id)}
      onPress={() => openGuide(item.id)}
      onSave={() => toggleSave(item)}
    />
  )

  const renderCuratedSection = ({
    title,
    subtitle,
    items,
    icon,
    priority = false,
  }: {
    title: string
    subtitle: string
    items: Guide[]
    icon: string
    priority?: boolean
  }) => {
    if (items.length === 0) {
      return null
    }

    return (
      <View style={styles.section}>
        <View style={[styles.sectionHeaderRow, priority && styles.priorityHeaderRow]}>
          <View>
            {priority ? (
              <View style={styles.priorityPill}>
                <SafeText variant="caption" color="primary" weight="700">
                  {language === 'fil' ? 'Unahin kung kailangan' : 'Start here if needed'}
                </SafeText>
              </View>
            ) : null}

            <SafeText variant="h3" weight="700">
              {icon ? `${icon} ${title}` : title}
            </SafeText>
            <SafeText variant="caption" color="muted" style={styles.sectionSubtitle}>
              {subtitle}
            </SafeText>
          </View>
        </View>

        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          contentContainerStyle={styles.curatedRow}
        >
          {items.map((guide) => (
            <View key={guide.id} style={styles.curatedCardWrap}>
              <GuideCard
                guide={guide}
                language={language}
                isSaved={isSaved(guide.id)}
                onPress={() => openGuide(guide.id)}
                onSave={() => toggleSave(guide)}
                compact
              />
            </View>
          ))}
        </ScrollView>
      </View>
    )
  }

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
              {language === 'fil'
                ? 'Sayang, ngayon ko lang nalaman.'
                : 'Useful things worth knowing earlier.'}
            </SafeText>
          </View>

          <View style={styles.logoMark}>
            <Ionicons name="bulb-outline" size={25} color={colors.primary} />
          </View>
        </View>

        <SafeText variant="bodyMd" color="surface" style={styles.heroSubtitle}>
          {language === 'fil'
            ? 'Praktikal na gabay para sa ayuda, benefits, karapatan, IDs, pera, trabaho, gobyerno, at iwas-scam.'
            : 'Practical guides for aid, benefits, rights, IDs, money, work, government tasks, and scam safety.'}
        </SafeText>

        <View style={styles.heroStats}>
          <View style={styles.statPill}>
            <SafeText variant="label" color="surface">
              {visibleGuideCount} {language === 'fil' ? 'gabay' : 'guides'}
            </SafeText>
          </View>
          <View style={styles.statPill}>
            <SafeText variant="label" color="surface">
              {visibleAlertCount} {language === 'fil' ? 'babala' : 'alerts'}
            </SafeText>
          </View>
        </View>
      </View>

      <View style={styles.section}>
        <View style={styles.sectionHeader}>
          <SafeText variant="h3" weight="700">
            {t.categories}
          </SafeText>
          <SafeText variant="caption" color="muted">
            {language === 'fil' ? 'Piliin ang topic' : 'Browse topics'}
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
      {language === 'fil' ? 'Maghanda para dito' : 'Guided preparedness'}
    </SafeText>

    <SafeText variant="caption" color="muted" style={styles.sectionSubtitle}>
      {language === 'fil'
        ? 'Sunod-sunod na guides para sa stressful na sitwasyon.'
        : 'Step-by-step guides for stressful situations.'}
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
              {language === 'fil' ? 'Basahin muna bago magpadala' : 'Read before sending money'}
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
        title: language === 'fil' ? 'DSWD at Ayuda Guides' : 'DSWD & Aid Guides',
        subtitle:
          language === 'fil'
            ? 'Alamin muna ang tamang programa bago magtanong, magpasa, o maniwala sa post.'
            : 'Check the right program before asking, applying, or trusting a post.',
        items: governmentAidGuides,
        icon: '',
        priority: true,
      })}

      {renderCuratedSection({
        title: language === 'fil' ? 'Trending Ngayon' : 'Trending Now',
        subtitle:
          trending.length > 0
            ? language === 'fil'
              ? 'Pinakabinabasa nitong mga araw'
              : 'Most viewed in the last few days'
            : language === 'fil'
              ? 'Mga guide na magandang unahin'
              : 'Useful guides to start with',
        items: trendingGuides,
        icon: '',
      })}

      {renderCuratedSection({
        title: language === 'fil' ? 'Para sa First-Timers' : 'For First-Timers',
        subtitle:
          language === 'fil'
            ? 'Unang trabaho, unang ID, unang requirements'
            : 'First job, first ID, first requirements',
        items: firstTimerGuides,
        icon: '',
      })}

      {renderCuratedSection({
        title: language === 'fil' ? 'Money Moves' : 'Money Moves',
        subtitle:
          language === 'fil'
            ? 'Bago magbayad, umutang, o mag-open ng account'
            : 'Before paying, borrowing, or opening an account',
        items: moneyGuides,
        icon: '',
      })}

      {renderCuratedSection({
        title: language === 'fil' ? 'Government Basics' : 'Government Basics',
        subtitle:
          language === 'fil'
            ? 'Benefits, forms, opisina, at appointments'
            : 'Benefits, forms, offices, and appointments',
        items: governmentGuides,
        icon: '',
      })}

      <View style={styles.sectionHeaderBlock}>
        <SafeText variant="h3" weight="700">
          {t.allGuides}
        </SafeText>
        <SafeText variant="caption" color="muted">
          {language === 'fil' ? 'Para sa first-timers at everyday decisions' : 'For first-timers and everyday decisions'}
        </SafeText>
      </View>
    </View>
  )

  return (
    <FlatList
      data={guides}
      renderItem={renderGuide}
      keyExtractor={(item) => item.id}
      ListHeaderComponent={renderHeader}
      ListEmptyComponent={
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
                {language === 'fil'
                  ? 'Hindi ma-load ang guides'
                  : 'Unable to load guides'}
              </SafeText>
              <SafeText variant="bodyMd" color="muted" style={styles.emptyText}>
                {language === 'fil'
                  ? 'I-check ang internet connection o subukan ulit.'
                  : 'Check your internet connection or try again.'}
              </SafeText>
              <AppButton
                title={language === 'fil' ? 'Subukan ulit' : 'Try again'}
                onPress={() => refetch()}
                style={styles.emptyAction}
              />
            </>
          ) : (
            <>
              <SafeText variant="h3" weight="700">
                {language === 'fil' ? 'Wala pang guides' : 'No guides yet'}
              </SafeText>
              <SafeText variant="bodyMd" color="muted" style={styles.emptyText}>
                {language === 'fil'
                  ? 'Kapag may Supabase data na, lalabas dito ang mga gabay.'
                  : 'Guides will appear here once Supabase has data.'}
              </SafeText>
            </>
          )}
        </View>
      }
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
      removeClippedSubviews
      maxToRenderPerBatch={5}
      updateCellsBatchingPeriod={50}
      windowSize={5}
      initialNumToRender={4}
    />
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

    sectionHeaderRow: {
      marginBottom: spacing.md,
    },

    priorityHeaderRow: {
      borderLeftWidth: 4,
      borderLeftColor: colors.primary,
      paddingLeft: spacing.sm,
    },

    priorityPill: {
      alignSelf: 'flex-start',
      minHeight: 24,
      borderRadius: 999,
      backgroundColor: colors.primaryLight,
      paddingHorizontal: spacing.sm,
      justifyContent: 'center',
      marginBottom: spacing.xs,
    },

    sectionSubtitle: {
      marginTop: spacing.xs,
    },

    sectionHeaderBlock: {
      paddingHorizontal: spacing.md,
      paddingTop: spacing.lg,
      paddingBottom: spacing.md,
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

    curatedRow: {
      paddingRight: spacing.md,
      gap: spacing.sm,
    },

    curatedCardWrap: {
      width: 286,
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
