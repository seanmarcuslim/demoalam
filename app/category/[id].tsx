import {
  ActivityIndicator,
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
import SafeText from '../../src/components/ui/SafeText'
import GuideCard from '../../src/components/guide/GuideCard'
import Badge from '../../src/components/ui/Badge'
import { Guide } from '../../src/types/guide'

const CATEGORY_RECOMMENDATIONS: Record<string, string[]> = {
  ids: ['gov', 'work'],
  work: ['ids', 'money'],
  money: ['scams', 'work'],
  gov: ['ids', 'emergency'],
  scams: ['money', 'emergency'],
  emergency: ['scams', 'gov'],
  adulting: ['money', 'work'],
}
import LoadingFeed from '../../src/components/layout/LoadingFeed'

export default function CategoryDetailsScreen() {
  const { id, name } = useLocalSearchParams()
  const categoryId = Array.isArray(id) ? id[0] : id
  const categoryName = Array.isArray(name) ? name[0] : name

  const {
    data: guides = [],
    isLoading,
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
  const categoryColor = firstCategory?.color || colors.primary
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

  const getCategoryName = (category: any) =>
    language === 'fil' ? category.name_fil : category.name_en

  const renderHeader = () => (
    <View>
      <View style={styles.hero}>
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
          {language === 'fil' ? 'Category guides' : 'Category guides'}
        </SafeText>

        <SafeText variant="h1" color="surface" style={styles.title}>
          {displayName}
        </SafeText>

        <SafeText variant="bodyMd" color="surface" style={styles.subtitle}>
          {language === 'fil'
            ? 'Mga gabay na pinagsama para mabilis mong mahanap ang kailangan.'
            : 'A focused set of guides so you can get to the useful answer faster.'}
        </SafeText>

        <View style={styles.metaRow}>
          <View style={styles.statPill}>
            <SafeText variant="label" color="surface">
              {guides.length} {language === 'fil' ? 'guides' : 'guides'}
            </SafeText>
          </View>

          <View style={styles.statPill}>
            <SafeText variant="label" color="surface">
              {language === 'fil' ? 'Offline-save ready' : 'Offline-save ready'}
            </SafeText>
          </View>
        </View>
      </View>

      <View style={styles.listIntro}>
        <View>
          <SafeText variant="h3" weight="700">
            {language === 'fil' ? 'Basahin ang kailangan' : 'Read what you need'}
          </SafeText>
          <SafeText variant="caption" color="muted" style={styles.introSubtitle}>
            {language === 'fil'
              ? 'I-save ang importanteng guide para balikan mamaya.'
              : 'Save important guides so you can return to them later.'}
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
            <Ionicons name="file-tray-outline" size={30} color={colors.primary} />
          </View>

          <SafeText variant="h3" weight="700" style={styles.emptyTitle}>
            {language === 'fil' ? 'Wala pang guides' : 'No guides yet'}
          </SafeText>

          <SafeText variant="bodyMd" color="muted" style={styles.emptyText}>
            {language === 'fil'
              ? 'Wala pang guides sa category na ito. Subukan ang ibang category muna.'
              : 'There are no guides under this category yet. Try another category first.'}
          </SafeText>

          {suggestedCategories.length > 0 ? (
            <View style={styles.suggestionBlock}>
              <SafeText variant="caption" color="muted" style={styles.suggestionLabel}>
                {language === 'fil' ? 'Subukan muna' : 'Try instead'}
              </SafeText>

              <View style={styles.suggestionRow}>
                {suggestedCategories.map((cat) => (
                  <TouchableOpacity
                    key={cat.id}
                    activeOpacity={0.86}
                    style={[
                      styles.suggestionChip,
                      {
                        borderColor: `${cat.color}35`,
                        backgroundColor: `${cat.color}12`,
                      },
                    ]}
                    onPress={() => openCategory(cat.id, getCategoryName(cat))}
                  >
                    <SafeText>{cat.icon}</SafeText>
                    <SafeText
                      variant="caption"
                      weight="700"
                      style={{ color: cat.color }}
                    >
                      {getCategoryName(cat)}
                    </SafeText>
                  </TouchableOpacity>
                ))}
              </View>
            </View>
          ) : null}

          <TouchableOpacity
            activeOpacity={0.86}
            style={styles.searchAction}
            onPress={() => router.push('/search')}
          >
            <SafeText color="primary" weight="700">
              {language === 'fil' ? 'Mag-search ng guide' : 'Search guides'}
            </SafeText>
          </TouchableOpacity>

          <TouchableOpacity
            activeOpacity={0.86}
            style={styles.emptyAction}
            onPress={() => router.back()}
          >
            <SafeText color="surface" weight="700">
              {language === 'fil' ? 'Bumalik sa categories' : 'Back to categories'}
            </SafeText>
          </TouchableOpacity>
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

const createStyles = (colors: any, heroColor: string) =>
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
      borderBottomLeftRadius: 28,
      borderBottomRightRadius: 28,
    },

    navRow: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
      marginBottom: spacing.lg,
    },

    iconButton: {
      width: 42,
      height: 42,
      borderRadius: 21,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
    },

    categoryMark: {
      width: 64,
      height: 64,
      borderRadius: 22,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
      marginBottom: spacing.md,
    },

    categoryMarkIcon: {
      fontSize: 32,
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
      paddingTop: spacing.lg,
      paddingBottom: spacing.md,
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
