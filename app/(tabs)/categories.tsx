import { View, Text, ScrollView, TouchableOpacity, StyleSheet } from 'react-native'
import { useCategories } from '../../src/hooks/useCategories'
import { colors } from '../../src/theme/colors'
import { spacing } from '../../src/theme/spacing'
import { typography } from '../../src/theme/typography'

export default function CategoriesScreen() {
  const { data: categories, isLoading } = useCategories()

  return (
    <ScrollView
      style={styles.container}
      contentContainerStyle={styles.content}
      showsVerticalScrollIndicator={false}
    >
      <View style={styles.header}>
        <Text style={styles.title}>Mga Kategorya 📚</Text>
        <Text style={styles.subtitle}>
          Piliin ang gusto mong matutunan
        </Text>
      </View>

      {isLoading ? (
        <Text style={styles.loadingText}>Naglo-load...</Text>
      ) : categories && categories.length > 0 ? (
        <View style={styles.grid}>
          {categories.map((cat) => (
            <TouchableOpacity
              activeOpacity={0.85}
              key={cat.id}
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
                <Text style={styles.categoryIcon}>{cat.icon}</Text>
              </View>

              <Text style={[styles.categoryName, { color: cat.color }]}>
                {cat.name_fil}
              </Text>

              <Text style={styles.categoryNameEn}>
                {cat.name_en}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      ) : (
        <Text style={styles.emptyText}>
          Wala pang available na categories.
        </Text>
      )}
    </ScrollView>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },

  content: {
    paddingBottom: spacing.xxl,
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

  loadingText: {
    ...typography.body,
    color: colors.textMuted,
    textAlign: 'center',
    padding: spacing.xl,
  },

  emptyText: {
    ...typography.body,
    color: colors.textMuted,
    textAlign: 'center',
    padding: spacing.xl,
  },
})