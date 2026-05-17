import { View, Text, StyleSheet, RefreshControl, ScrollView } from 'react-native'
import { useGuides, useFeaturedGuides, useUrgentGuides } from '../../src/hooks/useGuides'
import { useCategories } from '../../src/hooks/useCategories'
import { colors } from '../../src/theme/colors'
import { spacing } from '../../src/theme/spacing'
import { typography } from '../../src/theme/typography'

export default function HomeScreen() {
  const { data: guides, isLoading, refetch, isRefetching } = useGuides()
  const { data: featured } = useFeaturedGuides()
  const { data: urgent } = useUrgentGuides()
  const { data: categories } = useCategories()

  return (
    <ScrollView
      style={styles.container}
      contentContainerStyle={styles.content}
      refreshControl={
        <RefreshControl
          refreshing={isRefetching}
          onRefresh={refetch}
          colors={[colors.primary]}
        />
      }
    >
      <View style={styles.header}>
        <Text style={styles.logo}>DemoAlam 💡</Text>
        <Text style={styles.tagline}>Ano ang hindi mo pa alam?</Text>
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Mga Kategorya</Text>

        <ScrollView horizontal showsHorizontalScrollIndicator={false}>
          {categories && categories.length > 0 ? (
            categories.map((cat) => (
              <View key={cat.id} style={[styles.categoryChip, { backgroundColor: cat.color + '20' }]}>
                <Text style={styles.categoryIcon}>{cat.icon}</Text>
                <Text style={[styles.categoryLabel, { color: cat.color }]}>{cat.name_fil}</Text>
              </View>
            ))
          ) : (
            <Text style={styles.emptyText}>Wala pang categories.</Text>
          )}
        </ScrollView>
      </View>

      {urgent && urgent.length > 0 && (
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>🚨 Scam Alerts</Text>

          {urgent.map((guide) => (
            <View key={guide.id} style={[styles.card, styles.urgentCard]}>
              <Text style={styles.urgentBadge}>URGENT</Text>
              <Text style={styles.cardTitle}>{guide.title_fil}</Text>
              <Text style={styles.cardTagline}>{guide.tagline_fil}</Text>
              <Text style={styles.readTime}>🕐 {guide.read_time_min} minuto</Text>
            </View>
          ))}
        </View>
      )}

      {featured && featured.length > 0 && (
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>⭐ Featured</Text>

          {featured.map((guide) => (
            <View key={guide.id} style={styles.card}>
              <Text style={styles.cardCategory}>
                {guide.category?.icon} {guide.category?.name_fil}
              </Text>
              <Text style={styles.cardTitle}>{guide.title_fil}</Text>
              <Text style={styles.cardTagline}>{guide.tagline_fil}</Text>
              <Text style={styles.readTime}>🕐 {guide.read_time_min} minuto</Text>
            </View>
          ))}
        </View>
      )}

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>📚 Lahat ng Guides</Text>

        {isLoading ? (
          <Text style={styles.loadingText}>Naglo-load...</Text>
        ) : guides && guides.length > 0 ? (
          guides.map((guide) => (
            <View key={guide.id} style={styles.card}>
              <Text style={styles.cardCategory}>
                {guide.category?.icon} {guide.category?.name_fil}
              </Text>
              <Text style={styles.cardTitle}>{guide.title_fil}</Text>
              <Text style={styles.cardTagline}>{guide.tagline_fil}</Text>
              <Text style={styles.readTime}>🕐 {guide.read_time_min} minuto</Text>
            </View>
          ))
        ) : (
          <Text style={styles.emptyText}>Wala pang guides na available.</Text>
        )}
      </View>
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
    shadowOffset: { width: 0, height: 2 },
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
  readTime: {
    ...typography.caption,
    color: colors.textLight,
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