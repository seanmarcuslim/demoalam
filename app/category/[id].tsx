import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  ActivityIndicator,
  RefreshControl,
} from 'react-native'
import { useLocalSearchParams, router } from 'expo-router'
import { useGuides } from '../../src/hooks/useGuides'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { translations } from '../../src/utils/translations'
import { useTheme } from '../../src/hooks/useTheme'
import { spacing } from '../../src/theme/spacing'
import { typography } from '../../src/theme/typography'

export default function CategoryDetailsScreen() {
  const { id, name } = useLocalSearchParams()

  const categoryId = Array.isArray(id) ? id[0] : id
  const categoryName = Array.isArray(name) ? name[0] : name

  const {
    data: guides,
    isLoading,
    refetch,
    isRefetching,
  } = useGuides(categoryId)

  const { language } = useSettingsStore()
  const { colors } = useTheme()

  const t = translations[language]

  const openGuide = (guideId: string) => {
    router.push({
      pathname: '/guide/[id]',
      params: { id: guideId },
    })
  }

  const getTitle = (item: any) =>
    language === 'fil' ? item.title_fil : item.title_en

  const getTagline = (item: any) =>
    language === 'fil' ? item.tagline_fil : item.tagline_en

  const getCategoryName = (item: any) =>
    language === 'fil' ? item.name_fil : item.name_en

  const styles = createStyles(colors)

  if (isLoading) {
    return (
      <View style={styles.centered}>
        <ActivityIndicator
          size="large"
          color={colors.primary}
        />

        <Text style={styles.loadingText}>
          {t.loading}
        </Text>
      </View>
    )
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
      <View style={styles.header}>
        <Text
          style={styles.backText}
          onPress={() => router.back()}
        >
          ← {language === 'fil' ? 'Bumalik' : 'Back'}
        </Text>

        <Text style={styles.title}>
          {categoryName ||
            (language === 'fil'
              ? 'Kategorya'
              : 'Category')}
        </Text>

        <Text style={styles.subtitle}>
          {language === 'fil'
            ? 'Mga guides sa kategoryang ito'
            : 'Guides under this category'}
        </Text>
      </View>

      <View style={styles.guidesContainer}>
        {guides && guides.length > 0 ? (
          <>
            <Text style={styles.countText}>
              {guides.length}{' '}
              {language === 'fil'
                ? 'guide na available'
                : 'guides available'}
            </Text>

            {guides.map((guide) => (
              <TouchableOpacity
                key={guide.id}
                activeOpacity={0.85}
                style={styles.card}
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
          </>
        ) : (
          <View style={styles.emptyCard}>
            <Text style={styles.emptyIcon}>
              📭
            </Text>

            <Text style={styles.emptyTitle}>
              {language === 'fil'
                ? 'Wala pang guides'
                : 'No guides yet'}
            </Text>

            <Text style={styles.emptyText}>
              {language === 'fil'
                ? 'Wala pang guides sa category na ito.'
                : 'There are no guides under this category yet.'}
            </Text>
          </View>
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

    centered: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: colors.background,
      padding: spacing.xl,
    },

    loadingText: {
      ...typography.body,
      color: colors.textMuted,
      marginTop: spacing.md,
    },

    header: {
      backgroundColor: colors.primary,
      padding: spacing.lg,
      paddingTop: spacing.xxl,
      borderBottomLeftRadius: 24,
      borderBottomRightRadius: 24,
    },

    backText: {
      ...typography.caption,
      color: colors.primaryLight,
      marginBottom: spacing.md,
      fontWeight: '700',
    },

    title: {
      ...typography.h1,
      color: colors.surface,
    },

    subtitle: {
      ...typography.body,
      color: colors.primaryLight,
      marginTop: spacing.xs,
    },

    guidesContainer: {
      padding: spacing.md,
    },

    countText: {
      ...typography.caption,
      color: colors.textMuted,
      marginBottom: spacing.md,
    },

    card: {
      backgroundColor: colors.surface,
      borderRadius: 16,
      padding: spacing.md,
      marginBottom: spacing.md,

      elevation: 3,
      shadowColor: colors.shadow,
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.08,
      shadowRadius: 4,
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
      marginBottom: spacing.md,
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

    emptyCard: {
      backgroundColor: colors.surface,
      borderRadius: 18,
      padding: spacing.xl,
      alignItems: 'center',
      elevation: 2,
    },

    emptyIcon: {
      fontSize: 44,
      marginBottom: spacing.md,
    },

    emptyTitle: {
      ...typography.h3,
      color: colors.text,
      marginBottom: spacing.sm,
      textAlign: 'center',
    },

    emptyText: {
      ...typography.body,
      color: colors.textMuted,
      textAlign: 'center',
      lineHeight: 22,
    },
  })