import {
  FlatList,
  RefreshControl,
  StyleSheet,
  TouchableOpacity,
  View,
} from 'react-native'
import { useLocalSearchParams, router } from 'expo-router'
import { Ionicons } from '@expo/vector-icons'
import { useGuides } from '../../src/hooks/useGuides'
import { useCategories } from '../../src/hooks/useCategories'
import { useSavedStore } from '../../src/stores/savedStore'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { translations } from '../../src/utils/translations'
import { useTheme } from '../../src/hooks/useTheme'
import { spacing } from '../../src/theme/spacing'
import type { ThemeColors } from '../../src/theme/colors'
import SafeText from '../../src/components/ui/SafeText'
import GuideCard from '../../src/components/guide/GuideCard'
import Badge from '../../src/components/ui/Badge'
import { Guide } from '../../src/types/guide'
import { Category } from '../../src/types/category'
import { getCategoryAccent } from '../../src/lib/categoryVisuals'
import LoadingFeed from '../../src/components/layout/LoadingFeed'

const CATEGORY_RECOMMENDATIONS: Record<string, string[]> = {
  ids: ['gov', 'work'],
  work: ['ids', 'money'],
  money: ['gov', 'scams'],
  gov: ['ids', 'healthcare'],
  healthcare: ['gov', 'emergency'],
  education: ['work', 'gov'],
  scams: ['digital-safety', 'money'],
  'digital-safety': ['scams', 'emergency'],
  emergency: ['healthcare', 'digital-safety'],
  adulting: ['money', 'work'],
}

export default function CategoryDetailsScreen() {
  const { id, name } = useLocalSearchParams()
  const categoryId = Array.isArray(id) ? id[0] : id
  const categoryName = Array.isArray(name) ? name[0] : name

  const {
    data: guides = [],
    isLoading,
    isError,
    refetch,
    isRefetching,
  } = useGuides(categoryId)
  const { data: categories = [] } = useCategories()

  const { language } = useSettingsStore()
  const { colors } = useTheme()
  const t = translations[language]
  const toggleSave = useSavedStore((state) => state.toggleSave)
  const isSaved = useSavedStore((state) => state.isSaved)

  const displayName =
    categoryName || (language === 'fil' ? 'Kategorya' : 'Category')
  const currentCategory =
    categories.find((cat) => cat.id === categoryId) || guides[0]?.category
  const firstCategory = currentCategory
  const categoryColor = getCategoryAccent(firstCategory, colors.primary)
  const categoryIcon = firstCategory?.icon || '📚'
  const styles = createStyles(colors, categoryColor)
  const suggestedCategories = getSuggestedCategories()

  const openGuide = (guideId: string) => {
    router.push({
      pathname: '/guide/[id]',
      params: { id: guideId },
    })
  }

  const openCategory = (nextCategoryId: string, nextCategoryName: string) => {
    router.push({
      pathname: '/category/[id]',
      params: { id: nextCategoryId, name: nextCategoryName },
    })
  }

  const getCategoryName = (category: Category) =>
    language === 'fil' ? category.name_fil : category.name_en

  const getGuideCountLabel = (count: number) => {
    if (count === 0) return language === 'fil' ? 'Wala pang gabay' : 'No guides yet'
    if (count === 1) return language === 'fil' ? '1 gabay' : '1 guide'
    return language === 'fil' ? `${count} gabay` : `${count} guides`
  }

  const renderHeader = () => (
    <View>
      <View style={styles.hero}>
        <View style={styles.heroGlow} />

        <View style={styles.navRow}>
          <TouchableOpacity
            activeOpacity={0.82}
            style={styles.iconButton}
            onPress={() => router.back()}
          >
            <Ionicons name="arrow-back" size={21} color={colors.primary} />
          </TouchableOpacity>
        </View>

        <View style={styles.categoryMark}>
          <SafeText style={styles.categoryMarkIcon}>{categoryIcon}</SafeText>
        </View>

        <SafeText variant="caption" color="surface" style={styles.eyebrow}>
          {language === 'fil' ? 'Mga gabay sa paksa' : 'Topic guides'}
        </SafeText>

        <SafeText variant="h1" color="surface" style={styles.title}>
          {displayName}
        </SafeText>

        <SafeText variant="bodyMd" color="surface" style={styles.subtitle}>
          {language === 'fil'
            ? 'Mga gabay na pinili para mas mabilis makita ang dapat gawin.'
            : 'A focused set of guides built around what you may need next.'}
        </SafeText>

        <View style={styles.metaRow}>
          <View style={styles.statPill}>
            <SafeText variant="label" color="surface">
              {getGuideCountLabel(guides.length)}
            </SafeText>
          </View>

          <View style={styles.statPill}>
            <SafeText variant="label" color="surface">
              {language === 'fil' ? 'Pwedeng i-save' : 'Save-ready'}
            </SafeText>
          </View>
        </View>
      </View>

      <View style={styles.listIntro}>
        <View>
          <SafeText variant="h3" weight="700">
            {language === 'fil' ? 'Mga available na gabay' : 'Available guides'}
          </SafeText>
          <SafeText variant="caption" color="muted" style={styles.introSubtitle}>
            {language === 'fil'
              ? 'Piliin ang guide na pinakakapit sa sitwasyon mo.'
              : 'Choose the guide that fits your situation best.'}
          </SafeText>
        </View>

        <Badge
          label={displayName}
          icon={categoryIcon}
          color={categoryColor}
        />
      </View>
    </View>
  )

  if (isLoading) {
    return (
      <View style={styles.centered}>
        <LoadingFeed count={3} />
      </View>
    )
  }

  return (
    <FlatList
      data={guides}
      keyExtractor={(item) => item.id}
      ListHeaderComponent={renderHeader}
      ListEmptyComponent={
        <View style={styles.emptyCard}>
          <View style={styles.emptyIcon}>
            <Ionicons
              name={isError ? 'cloud-offline-outline' : 'file-tray-outline'}
              size={30}
              color={isError ? colors.warning : colors.primary}
            />
          </View>

          <SafeText variant="h3" weight="700" style={styles.emptyTitle}>
            {isError
              ? language === 'fil'
                ? 'Hindi ma-load ang guides'
                : 'Unable to load guides'
              : language === 'fil'
                ? 'Wala pang guides'
                : 'No guides yet'}
          </SafeText>

          <SafeText variant="bodyMd" color="muted" style={styles.emptyText}>
            {isError
              ? language === 'fil'
                ? 'I-check ang internet connection o subukan ulit.'
                : 'Check your internet connection or try again.'
              : language === 'fil'
                ? 'Wala pang guides sa category na ito. Subukan ang ibang category muna.'
                : 'There are no guides under this category yet. Try another category first.'}
          </SafeText>

          {!isError && suggestedCategories.length > 0 ? (
            <View style={styles.suggestionBlock}>
              <SafeText variant="caption" color="muted" style={styles.suggestionLabel}>
                {language === 'fil' ? 'Subukan muna' : 'Try instead'}
              </SafeText>

              <View style={styles.suggestionRow}>
                {suggestedCategories.map((cat) => {
                  const accent = getCategoryAccent(cat, colors.primary)

                  return (
                  <TouchableOpacity
                    key={cat.id}
                    activeOpacity={0.86}
                    style={[
                      styles.suggestionChip,
                      {
                        borderColor: `${accent}35`,
                        backgroundColor: `${accent}12`,
                      },
                    ]}
                    onPress={() => openCategory(cat.id, getCategoryName(cat))}
                  >
                    <SafeText>{cat.icon}</SafeText>
                    <SafeText
                      variant="caption"
                      weight="700"
                      style={{ color: accent }}
                    >
                      {getCategoryName(cat)}
                    </SafeText>
                  </TouchableOpacity>
                  )
                })}
              </View>
            </View>
          ) : null}

          {isError ? (
            <TouchableOpacity
              activeOpacity={0.86}
              style={styles.emptyAction}
              onPress={() => refetch()}
            >
              <SafeText color="surface" weight="700">
                {language === 'fil' ? 'Subukan ulit' : 'Try again'}
              </SafeText>
            </TouchableOpacity>
          ) : (
            <TouchableOpacity
              activeOpacity={0.86}
              style={styles.searchAction}
              onPress={() => router.push('/search')}
            >
              <SafeText color="primary" weight="700">
                {language === 'fil' ? 'Mag-search ng guide' : 'Search guides'}
              </SafeText>
            </TouchableOpacity>
          )}

          {!isError ? (
            <TouchableOpacity
              activeOpacity={0.86}
              style={styles.emptyAction}
              onPress={() => router.back()}
            >
              <SafeText color="surface" weight="700">
                {language === 'fil' ? 'Bumalik sa categories' : 'Back to categories'}
              </SafeText>
            </TouchableOpacity>
          ) : null}
        </View>
      }
      contentContainerStyle={styles.content}
      refreshControl={
        <RefreshControl
          refreshing={isRefetching}
          onRefresh={refetch}
          colors={[colors.primary]}
        />
      }
      showsVerticalScrollIndicator={false}
      renderItem={({ item }: { item: Guide }) => (
        <GuideCard
          guide={item}
          language={language}
          isSaved={isSaved(item.id)}
          onPress={() => openGuide(item.id)}
          onSave={() => toggleSave(item)}
        />
      )}
      removeClippedSubviews
      maxToRenderPerBatch={5}
      windowSize={5}
    />
  )

  function getSuggestedCategories() {
    const currentSlug = firstCategory?.slug

    if (!currentSlug) {
      return []
    }

    const slugs = CATEGORY_RECOMMENDATIONS[currentSlug] || []

    return slugs
      .map((slug) => categories.find((cat) => cat.slug === slug))
      .filter((cat): cat is NonNullable<typeof cat> => Boolean(cat))
  }
}

const createStyles = (colors: ThemeColors, heroColor: string) =>
  StyleSheet.create({
    content: {
      backgroundColor: colors.background,
      paddingBottom: 140,
    },

    centered: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: colors.background,
      padding: spacing.xl,
    },

    loadingText: {
      marginTop: spacing.md,
    },

    hero: {
      backgroundColor: heroColor,
      paddingHorizontal: spacing.lg,
      paddingTop: spacing.xl,
      paddingBottom: spacing.lg,
      borderBottomLeftRadius: 24,
      borderBottomRightRadius: 24,
      overflow: 'hidden',
    },

    heroGlow: {
      position: 'absolute',
      right: -46,
      top: -48,
      width: 150,
      height: 150,
      borderRadius: 75,
      backgroundColor: 'rgba(255,255,255,0.14)',
    },

    navRow: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
      marginBottom: spacing.md,
    },

    iconButton: {
      width: 40,
      height: 40,
      borderRadius: 20,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
    },

    categoryMark: {
      width: 58,
      height: 58,
      borderRadius: 20,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
      marginBottom: spacing.sm,
    },

    categoryMarkIcon: {
      fontSize: 30,
    },

    eyebrow: {
      textTransform: 'uppercase',
      opacity: 0.82,
      marginBottom: spacing.sm,
    },

    title: {
      maxWidth: 330,
    },

    subtitle: {
      opacity: 0.9,
      marginTop: spacing.sm,
      maxWidth: 340,
    },

    metaRow: {
      flexDirection: 'row',
      flexWrap: 'wrap',
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

    listIntro: {
      paddingHorizontal: spacing.md,
      paddingTop: spacing.md,
      paddingBottom: spacing.sm,
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'flex-start',
      gap: spacing.md,
    },

    introSubtitle: {
      marginTop: spacing.xs,
      maxWidth: 230,
    },

    emptyCard: {
      margin: spacing.md,
      borderRadius: 18,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.xl,
      alignItems: 'center',
    },

    emptyIcon: {
      width: 64,
      height: 64,
      borderRadius: 32,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
      marginBottom: spacing.md,
    },

    emptyTitle: {
      textAlign: 'center',
      marginBottom: spacing.sm,
    },

    emptyText: {
      textAlign: 'center',
      marginBottom: spacing.lg,
    },

    suggestionBlock: {
      width: '100%',
      marginBottom: spacing.md,
      alignItems: 'center',
    },

    suggestionLabel: {
      marginBottom: spacing.sm,
    },

    suggestionRow: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      justifyContent: 'center',
      gap: spacing.sm,
    },

    suggestionChip: {
      minHeight: 40,
      borderRadius: 999,
      borderWidth: 1,
      paddingHorizontal: spacing.md,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
    },

    searchAction: {
      minHeight: 46,
      borderRadius: 14,
      paddingHorizontal: spacing.lg,
      borderWidth: 1,
      borderColor: colors.primary,
      alignItems: 'center',
      justifyContent: 'center',
      marginBottom: spacing.sm,
    },

    emptyAction: {
      minHeight: 46,
      borderRadius: 14,
      paddingHorizontal: spacing.lg,
      backgroundColor: colors.primary,
      alignItems: 'center',
      justifyContent: 'center',
    },
  })
