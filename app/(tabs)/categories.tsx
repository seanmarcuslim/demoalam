import {
  View,
  Text,
  ScrollView,
  TouchableOpacity,
  StyleSheet,
  RefreshControl,
} from 'react-native'
import { router } from 'expo-router'
import { useCategories } from '../../src/hooks/useCategories'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { translations } from '../../src/utils/translations'
import { useTheme } from '../../src/hooks/useTheme'
import { spacing } from '../../src/theme/spacing'
import { typography } from '../../src/theme/typography'

export default function CategoriesScreen() {
  const {
    data: categories,
    isLoading,
    refetch,
    isRefetching,
  } = useCategories()

  const { language } = useSettingsStore()
  const { colors } = useTheme()

  const t = translations[language]

  const openCategory = (id: string, name: string) => {
    router.push({
      pathname: '/category/[id]',
      params: { id, name },
    })
  }

  const getCategoryName = (cat: any) =>
    language === 'fil' ? cat.name_fil : cat.name_en

  const getSecondaryName = (cat: any) =>
    language === 'fil' ? cat.name_en : cat.name_fil

  const styles = StyleSheet.create({
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
      borderBottomLeftRadius: 24,
      borderBottomRightRadius: 24,
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

    loadingContainer: {
      padding: spacing.xl,
      alignItems: 'center',
    },

    loadingText: {
      ...typography.body,
      color: colors.textMuted,
    },

    grid: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      justifyContent: 'space-between',
      padding: spacing.md,
    },

    categoryCard: {
      width: '47%',
      borderRadius: 18,
      padding: spacing.lg,
      marginBottom: spacing.md,
      alignItems: 'center',
      borderWidth: 2,

      elevation: 3,
      shadowColor: '#000',
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.08,
      shadowRadius: 4,
    },

    iconContainer: {
      width: 70,
      height: 70,
      borderRadius: 35,
      justifyContent: 'center',
      alignItems: 'center',
      marginBottom: spacing.md,
    },

    categoryIcon: {
      fontSize: 34,
    },

    categoryName: {
      ...typography.h3,
      textAlign: 'center',
    },

    categoryNameEn: {
      ...typography.caption,
      color: colors.textMuted,
      textAlign: 'center',
      marginTop: spacing.xs,
    },

    openText: {
      ...typography.caption,
      color: colors.primary,
      fontWeight: '700',
      marginTop: spacing.sm,
    },

    emptyContainer: {
      alignItems: 'center',
      justifyContent: 'center',
      padding: spacing.xxl,
    },

    emptyIcon: {
      fontSize: 48,
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
        <Text style={styles.title}>
          {t.categories} 📚
        </Text>

        <Text style={styles.subtitle}>
          {language === 'fil'
            ? 'Piliin ang gusto mong matutunan'
            : 'Choose what you want to learn'}
        </Text>
      </View>

      {isLoading ? (
        <View style={styles.loadingContainer}>
          <Text style={styles.loadingText}>
            {t.loading}
          </Text>
        </View>
      ) : categories && categories.length > 0 ? (
        <View style={styles.grid}>
          {categories.map((cat) => (
            <TouchableOpacity
              activeOpacity={0.85}
              key={cat.id}
              onPress={() =>
                openCategory(cat.id, getCategoryName(cat))
              }
              style={[
                styles.categoryCard,
                {
                  borderColor: cat.color,
                  backgroundColor: cat.color + '10',
                },
              ]}
            >
              <View
                style={[
                  styles.iconContainer,
                  { backgroundColor: cat.color + '20' },
                ]}
              >
                <Text style={styles.categoryIcon}>
                  {cat.icon}
                </Text>
              </View>

              <Text
                style={[
                  styles.categoryName,
                  { color: cat.color },
                ]}
              >
                {getCategoryName(cat)}
              </Text>

              <Text style={styles.categoryNameEn}>
                {getSecondaryName(cat)}
              </Text>

              <Text style={styles.openText}>
                {language === 'fil'
                  ? 'Tingnan →'
                  : 'View →'}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      ) : (
        <View style={styles.emptyContainer}>
          <Text style={styles.emptyIcon}>📭</Text>

          <Text style={styles.emptyTitle}>
            {language === 'fil'
              ? 'Walang categories'
              : 'No categories'}
          </Text>

          <Text style={styles.emptyText}>
            {language === 'fil'
              ? 'Wala pang available na categories.'
              : 'No categories available yet.'}
          </Text>
        </View>
      )}
    </ScrollView>
  )
}