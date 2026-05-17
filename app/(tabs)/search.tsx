import { View, Text, TextInput, FlatList, StyleSheet, TouchableOpacity } from 'react-native'
import { useSearch } from '../../src/hooks/useSearch'
import { colors } from '../../src/theme/colors'
import { spacing } from '../../src/theme/spacing'
import { typography } from '../../src/theme/typography'

export default function SearchScreen() {
  const { searchTerm, setSearchTerm, results, isLoading, hasResults } = useSearch()

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.title}>Maghanap 🔍</Text>
        <TextInput
          style={styles.searchBar}
          placeholder="Hanapin ang guide..."
          placeholderTextColor={colors.textLight}
          value={searchTerm}
          onChangeText={setSearchTerm}
          autoCorrect={false}
        />
      </View>

      {/* Results */}
      {searchTerm.length === 0 ? (
        <View style={styles.emptyState}>
          <Text style={styles.emptyIcon}>🔍</Text>
          <Text style={styles.emptyTitle}>Ano ang hinahanap mo?</Text>
          <Text style={styles.emptySubtitle}>
            Halimbawa: "valid ID", "bank account", "scam"
          </Text>
        </View>
      ) : isLoading ? (
        <Text style={styles.loadingText}>Naghahanap...</Text>
      ) : !hasResults ? (
        <View style={styles.emptyState}>
          <Text style={styles.emptyIcon}>😕</Text>
          <Text style={styles.emptyTitle}>Walang resulta</Text>
          <Text style={styles.emptySubtitle}>
            Subukan ang ibang salita
          </Text>
        </View>
      ) : (
        <FlatList
          data={results}
          keyExtractor={(item) => item.id}
          contentContainerStyle={styles.resultsList}
          renderItem={({ item }) => (
            <TouchableOpacity style={styles.resultCard}>
              <Text style={styles.resultCategory}>
                {item.category?.icon} {item.category?.name_fil}
              </Text>
              <Text style={styles.resultTitle}>{item.title_fil}</Text>
              <Text style={styles.resultTagline}>{item.tagline_fil}</Text>
              <Text style={styles.readTime}>🕐 {item.read_time_min} minuto</Text>
            </TouchableOpacity>
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
    marginBottom: spacing.md,
  },
  searchBar: {
    backgroundColor: colors.surface,
    borderRadius: 12,
    padding: spacing.md,
    ...typography.body,
    color: colors.text,
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
  loadingText: {
    ...typography.body,
    color: colors.textMuted,
    textAlign: 'center',
    padding: spacing.lg,
  },
  resultsList: {
    padding: spacing.md,
  },
  resultCard: {
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
  resultCategory: {
    ...typography.caption,
    color: colors.textMuted,
    marginBottom: spacing.xs,
  },
  resultTitle: {
    ...typography.h3,
    color: colors.text,
    marginBottom: spacing.xs,
  },
  resultTagline: {
    ...typography.body,
    color: colors.textMuted,
    marginBottom: spacing.sm,
  },
  readTime: {
    ...typography.caption,
    color: colors.textLight,
  },
})