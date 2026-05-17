import { View, Text, FlatList, StyleSheet, TouchableOpacity } from 'react-native'
import { useSavedStore } from '../../src/stores/savedStore'
import { colors } from '../../src/theme/colors'
import { spacing } from '../../src/theme/spacing'
import { typography } from '../../src/theme/typography'

export default function SavedScreen() {
  const { savedIds, cachedGuides, unsave } = useSavedStore()
  const savedGuides = savedIds.map((id) => cachedGuides[id]).filter(Boolean)

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.title}>Na-save Mo 🔖</Text>
        <Text style={styles.subtitle}>
          {savedGuides.length} na guide
        </Text>
      </View>

      {/* Empty State */}
      {savedGuides.length === 0 ? (
        <View style={styles.emptyState}>
          <Text style={styles.emptyIcon}>🔖</Text>
          <Text style={styles.emptyTitle}>Wala pang na-save</Text>
          <Text style={styles.emptySubtitle}>
            I-save ang mga guides para mabasa offline
          </Text>
        </View>
      ) : (
        <FlatList
          data={savedGuides}
          keyExtractor={(item) => item.id}
          contentContainerStyle={styles.list}
          renderItem={({ item }) => (
            <View style={styles.card}>
              <Text style={styles.cardCategory}>
                {item.category?.icon} {item.category?.name_fil}
              </Text>
              <Text style={styles.cardTitle}>{item.title_fil}</Text>
              <Text style={styles.cardTagline}>{item.tagline_fil}</Text>
              <View style={styles.cardFooter}>
                <Text style={styles.readTime}>
                  🕐 {item.read_time_min} minuto
                </Text>
                <TouchableOpacity onPress={() => unsave(item.id)}>
                  <Text style={styles.unsaveButton}>I-remove</Text>
                </TouchableOpacity>
              </View>
            </View>
          )}
        />
      )}
    </View>
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
  subtitle: {
    ...typography.body,
    color: colors.primaryLight,
    marginTop: spacing.xs,
  },
  emptyState: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: spacing.xl,
  },
  emptyIcon: {
    fontSize: 48,
    marginBottom: spacing.md,
  },
  emptyTitle: {
    ...typography.h3,
    color: colors.text,
    textAlign: 'center',
    marginBottom: spacing.sm,
  },
  emptySubtitle: {
    ...typography.body,
    color: colors.textMuted,
    textAlign: 'center',
  },
  list: {
    padding: spacing.md,
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
  unsaveButton: {
    ...typography.caption,
    color: colors.danger,
    fontWeight: '600',
  },
})