import {
  View,
  Text,
  StyleSheet,
  RefreshControl,
  ScrollView,
  TouchableOpacity,
} from 'react-native'
import { router } from 'expo-router'
import {
  useGuides,
  useFeaturedGuides,
  useUrgentGuides,
} from '../../src/hooks/useGuides'
import { useCategories } from '../../src/hooks/useCategories'
import { useHistoryStore } from '../../src/stores/historyStore'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { useTheme } from '../../src/hooks/useTheme'
import { translations } from '../../src/utils/translations'
import { spacing } from '../../src/theme/spacing'
import { typography } from '../../src/theme/typography'
import AppHeader from '../../src/components/ui/AppHeader'
export default function HomeScreen() {
  const { colors } = useTheme()

  const { data: guides, isLoading, refetch, isRefetching } =
    useGuides()

  const { data: featured } = useFeaturedGuides()
  const { data: urgent } = useUrgentGuides()
  const { data: categories } = useCategories()

  const { language } = useSettingsStore()

  const t = translations[language]

  const { recentIds, cachedGuides } =
    useHistoryStore()

  const recentGuides = recentIds
    .map((id) => cachedGuides[id])
    .filter(Boolean)
    .slice(0, 5)

  const openGuide = (id: string) => {
    router.push({
      pathname: '/guide/[id]',
      params: { id },
    })
  }

  const getTitle = (item: any) =>
    language === 'fil'
      ? item.title_fil
      : item.title_en

  const getTagline = (item: any) =>
    language === 'fil'
      ? item.tagline_fil
      : item.tagline_en

  const getCategoryName = (item: any) =>
    language === 'fil'
      ? item.name_fil
      : item.name_en

  const styles = createStyles(colors)

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
          tintColor={colors.primary}
        />
      }
    >
<AppHeader
  title="DemoAlam 💡"
  subtitle={
    language === 'fil'
      ? 'Ano ang hindi mo pa alam?'
      : 'What do you not know yet?'
  }
/>

      {recentGuides.length > 0 && (
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>
            👀 {t.recentlyViewed}
          </Text>

          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
          >
            {recentGuides.map((guide) => (
              <TouchableOpacity
                key={guide.id}
                activeOpacity={0.85}
                style={styles.recentCard}
                onPress={() => openGuide(guide.id)}
              >
                <Text style={styles.recentCategory}>
                  {guide.category?.icon}{' '}
                  {guide.category
                    ? getCategoryName(guide.category)
                    : ''}
                </Text>

                <Text
                  style={styles.recentTitle}
                  numberOfLines={2}
                >
                  {getTitle(guide)}
                </Text>

                <Text style={styles.readTime}>
                  🕐 {guide.read_time_min}{' '}
                  {language === 'fil'
                    ? 'minuto'
                    : 'min'}
                </Text>
              </TouchableOpacity>
            ))}
          </ScrollView>
        </View>
      )}

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>
          {t.categories}
        </Text>

        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
        >
          {categories &&
          categories.length > 0 ? (
            categories.map((cat) => (
              <View
                key={cat.id}
                style={[
                  styles.categoryChip,
                  {
                    backgroundColor:
                      cat.color + '20',
                  },
                ]}
              >
                <Text style={styles.categoryIcon}>
                  {cat.icon}
                </Text>

                <Text
                  style={[
                    styles.categoryLabel,
                    { color: cat.color },
                  ]}
                >
                  {getCategoryName(cat)}
                </Text>
              </View>
            ))
          ) : (
            <Text style={styles.emptyText}>
              {language === 'fil'
                ? 'Wala pang categories.'
                : 'No categories yet.'}
            </Text>
          )}
        </ScrollView>
      </View>

      {urgent && urgent.length > 0 && (
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>
            🚨 {t.scamAlerts}
          </Text>

          {urgent.map((guide) => (
            <TouchableOpacity
              key={guide.id}
              style={[
                styles.card,
                styles.urgentCard,
              ]}
              activeOpacity={0.85}
              onPress={() => openGuide(guide.id)}
            >
              <Text style={styles.urgentBadge}>
                URGENT
              </Text>

              <Text style={styles.cardTitle}>
                {getTitle(guide)}
              </Text>

              <Text style={styles.cardTagline}>
                {getTagline(guide)}
              </Text>

              <View style={styles.cardFooter}>
                <Text style={styles.readTime}>
                  🕐 {guide.read_time_min}{' '}
                  {language === 'fil'
                    ? 'minuto'
                    : 'min'}
                </Text>

                <Text style={styles.openText}>
                  {t.open}
                </Text>
              </View>
            </TouchableOpacity>
          ))}
        </View>
      )}

      {featured && featured.length > 0 && (
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>
            ⭐ {t.featured}
          </Text>

          {featured.map((guide) => (
            <TouchableOpacity
              key={guide.id}
              style={styles.card}
              activeOpacity={0.85}
              onPress={() => openGuide(guide.id)}
            >
              <Text style={styles.cardCategory}>
                {guide.category?.icon}{' '}
                {guide.category
                  ? getCategoryName(
                      guide.category
                    )
                  : ''}
              </Text>

              <Text style={styles.cardTitle}>
                {getTitle(guide)}
              </Text>

              <Text style={styles.cardTagline}>
                {getTagline(guide)}
              </Text>

              <View style={styles.cardFooter}>
                <Text style={styles.readTime}>
                  🕐 {guide.read_time_min}{' '}
                  {language === 'fil'
                    ? 'minuto'
                    : 'min'}
                </Text>

                <Text style={styles.openText}>
                  {t.open}
                </Text>
              </View>
            </TouchableOpacity>
          ))}
        </View>
      )}

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>
          📚 {t.allGuides}
        </Text>

        {isLoading ? (
          <Text style={styles.loadingText}>
            {t.loading}
          </Text>
        ) : guides &&
          guides.length > 0 ? (
          guides.map((guide) => (
            <TouchableOpacity
              key={guide.id}
              style={styles.card}
              activeOpacity={0.85}
              onPress={() => openGuide(guide.id)}
            >
              <Text style={styles.cardCategory}>
                {guide.category?.icon}{' '}
                {guide.category
                  ? getCategoryName(
                      guide.category
                    )
                  : ''}
              </Text>

              <Text style={styles.cardTitle}>
                {getTitle(guide)}
              </Text>

              <Text style={styles.cardTagline}>
                {getTagline(guide)}
              </Text>

              <View style={styles.cardFooter}>
                <Text style={styles.readTime}>
                  🕐 {guide.read_time_min}{' '}
                  {language === 'fil'
                    ? 'minuto'
                    : 'min'}
                </Text>

                <Text style={styles.openText}>
                  {t.open}
                </Text>
              </View>
            </TouchableOpacity>
          ))
        ) : (
          <Text style={styles.emptyText}>
            {language === 'fil'
              ? 'Wala pang guides na available.'
              : 'No guides available yet.'}
          </Text>
        )}
      </View>
    </ScrollView>
  )
}

const createStyles = (colors: any) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },

    content: {
      paddingBottom: 140,
    },

    header: {
      backgroundColor: colors.primary,
      padding: spacing.lg,
      paddingTop: spacing.xxl,
    },

    logo: {
      ...typography.h1,
      color: colors.surface,
    },

    tagline: {
      ...typography.body,
      color: colors.primaryLight,
      marginTop: spacing.xs,
    },

    section: {
      padding: spacing.md,
    },

    sectionTitle: {
      ...typography.h3,
      color: colors.text,
      marginBottom: spacing.md,
    },

    recentCard: {
      width: 220,
      backgroundColor: colors.surface,
      borderRadius: 16,
      padding: spacing.md,
      marginRight: spacing.md,

      elevation: 3,
      shadowColor: '#000',
      shadowOffset: {
        width: 0,
        height: 2,
      },
      shadowOpacity: 0.08,
      shadowRadius: 4,
    },

    recentCategory: {
      ...typography.caption,
      color: colors.textMuted,
      marginBottom: spacing.xs,
    },

    recentTitle: {
      ...typography.h3,
      color: colors.text,
      marginBottom: spacing.md,
    },

    categoryChip: {
      flexDirection: 'row',
      alignItems: 'center',
      paddingHorizontal: spacing.md,
      paddingVertical: spacing.sm,
      borderRadius: 20,
      marginRight: spacing.sm,
    },

    categoryIcon: {
      fontSize: 16,
      marginRight: 4,
    },

    categoryLabel: {
      ...typography.label,
      fontWeight: '600',
    },

    card: {
      backgroundColor: colors.surface,
      borderRadius: 12,
      padding: spacing.md,
      marginBottom: spacing.md,

      elevation: 3,
      shadowColor: '#000',
      shadowOffset: {
        width: 0,
        height: 2,
      },
      shadowOpacity: 0.08,
      shadowRadius: 4,
    },

    urgentCard: {
      borderLeftWidth: 4,
      borderLeftColor: colors.danger,
    },

    urgentBadge: {
      ...typography.label,
      color: colors.danger,
      marginBottom: spacing.xs,
    },

    cardCategory: {
      ...typography.caption,
      color: colors.textMuted,
      marginBottom: spacing.xs,
    },

    cardTitle: {
      ...typography.h3,
      color: colors.text,
      marginBottom: spacing.xs,
    },

    cardTagline: {
      ...typography.body,
      color: colors.textMuted,
      marginBottom: spacing.sm,
    },

    cardFooter: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
    },

    readTime: {
      ...typography.caption,
      color: colors.textLight,
    },

    openText: {
      ...typography.caption,
      color: colors.primary,
      fontWeight: '700',
    },

    loadingText: {
      ...typography.body,
      color: colors.textMuted,
      textAlign: 'center',
      padding: spacing.lg,
    },

    emptyText: {
      ...typography.body,
      color: colors.textMuted,
      paddingVertical: spacing.sm,
    },
  })