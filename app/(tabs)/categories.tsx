import { View, Text, ScrollView, TouchableOpacity, StyleSheet } from 'react-native'
import { useCategories } from '../../src/hooks/useCategories'
import { colors } from '../../src/theme/colors'
import { spacing } from '../../src/theme/spacing'
import { typography } from '../../src/theme/typography'

export default function CategoriesScreen() {
  const { data: categories, isLoading } = useCategories()

  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Mga Kategorya 📚</Text>
      </View>

      {isLoading ? (
        <Text style={styles.loadingText}>Naglo-load...</Text>
      ) : (
        <View style={styles.grid}>
          {categories?.map((cat) => (
            <TouchableOpacity
              key={cat.id}
              style={[styles.categoryCard, { borderColor: cat.color }]}
            >
              <Text style={styles.categoryIcon}>{cat.icon}</Text>
              <Text style={[styles.categoryName, { color: cat.color }]}>
                {cat.name_fil}
              </Text>
              <Text style={styles.categoryNameEn}>{cat.name_en}</Text>
            </TouchableOpacity>
          ))}
        </View>
      )}
    </ScrollView>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  header: {
    backgroundColor: colors.primary,
    padding: spacing.lg,
    paddingTop: spacing.xxl,
  },
  title: {
    ...typography.h1,
    color: colors.surface,
  },
  grid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    padding: spacing.md,
    gap: spacing.md,
  },
  categoryCard: {
    backgroundColor: colors.surface,
    borderRadius: 12,
    padding: spacing.lg,
    width: '45%',
    alignItems: 'center',
    borderWidth: 2,
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 4,
  },
  categoryIcon: {
    fontSize: 36,
    marginBottom: spacing.sm,
  },
  categoryName: {
    ...typography.h3,
    textAlign: 'center',
  },
  categoryNameEn: {
    ...typography.caption,
    color: colors.textMuted,
    textAlign: 'center',
    marginTop: 2,
  },
  loadingText: {
    ...typography.body,
    color: colors.textMuted,
    textAlign: 'center',
    padding: spacing.lg,
  },
})