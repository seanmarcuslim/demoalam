import {
  FlatList,
  StyleSheet,
  TextInput,
  TouchableOpacity,
  View,
} from 'react-native'
import { useState } from 'react'
import { router } from 'expo-router'
import { Ionicons } from '@expo/vector-icons'
import { useSearch } from '../../src/hooks/useSearch'
import { useSavedStore } from '../../src/stores/savedStore'
import { useSearchStore } from '../../src/stores/searchStore'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { useCategories } from '../../src/hooks/useCategories'
import { translations } from '../../src/utils/translations'
import { useTheme } from '../../src/hooks/useTheme'
import { spacing } from '../../src/theme/spacing'
import SafeText from '../../src/components/ui/SafeText'
import GuideCard from '../../src/components/guide/GuideCard'
import Badge from '../../src/components/ui/Badge'
import LoadingFeed from '../../src/components/layout/LoadingFeed'

const SUGGESTIONS = ['valid ID', 'trabaho', 'gcash scam', 'NBI', 'rent', 'budget', 'SSS']

export default function SearchScreen() {
  const {
    searchTerm,
    setSearchTerm,
    results,
    isLoading,
    hasResults,
  } = useSearch()
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null)

  const { language } = useSettingsStore()
  const { colors } = useTheme()
  const { data: categories = [] } = useCategories()
  const t = translations[language]
  const toggleSave = useSavedStore((state) => state.toggleSave)
  const isSaved = useSavedStore((state) => state.isSaved)
  const recentSearches = useSearchStore((state) => state.recentSearches)
  const addRecentSearch = useSearchStore((state) => state.addRecentSearch)
  const clearRecentSearches = useSearchStore((state) => state.clearRecentSearches)
  const styles = createStyles(colors)

  const showEmptySearch = searchTerm.trim().length === 0
  const filteredResults = selectedCategory
    ? results.filter((guide) => guide.category_id === selectedCategory)
    : results
  const hasFilteredResults = filteredResults.length > 0
  const showNoResults = !isLoading && searchTerm.trim().length > 0 && !hasFilteredResults

  const openGuide = (id: string) => {
    router.push({
      pathname: '/guide/[id]',
      params: { id },
    })
  }

  const commitSearch = (term: string) => {
    const cleanTerm = term.trim()

    if (cleanTerm.length > 1) {
      addRecentSearch(cleanTerm)
    }

    setSearchTerm(term)
  }

  const renderListHeader = () => {
    if (showEmptySearch) {
      return (
        <View style={styles.suggestionWrap}>
          {recentSearches.length > 0 ? (
            <View style={styles.recentBlock}>
              <View style={styles.recentHeader}>
                <SafeText variant="h3" weight="700">
                  {language === 'fil' ? 'Huli mong hinanap' : 'Recent searches'}
                </SafeText>
                <TouchableOpacity activeOpacity={0.82} onPress={clearRecentSearches}>
                  <SafeText variant="caption" color="primary" weight="700">
                    {language === 'fil' ? 'Burahin' : 'Clear'}
                  </SafeText>
                </TouchableOpacity>
              </View>

              <View style={styles.suggestions}>
                {recentSearches.map((item) => (
                  <TouchableOpacity
                    key={item}
                    activeOpacity={0.84}
                    onPress={() => commitSearch(item)}
                  >
                    <Badge label={item} color={colors.accent} icon="🕘" />
                  </TouchableOpacity>
                ))}
              </View>
            </View>
          ) : null}

          <SafeText variant="h3" weight="700" style={styles.tryTitle}>
            {language === 'fil' ? 'Subukan hanapin' : 'Try searching'}
          </SafeText>
          <View style={styles.suggestions}>
            {SUGGESTIONS.map((item) => (
              <TouchableOpacity
                key={item}
                activeOpacity={0.84}
                onPress={() => commitSearch(item)}
              >
                <Badge label={item} color={colors.primary} />
              </TouchableOpacity>
            ))}
          </View>
        </View>
      )
    }

    return (
      <View style={styles.resultsHeader}>
        <SafeText variant="h3" weight="700">
          {language === 'fil' ? 'Mga Resulta' : 'Results'}
        </SafeText>
        <SafeText variant="caption" color="muted">
          {isLoading
            ? language === 'fil'
              ? 'Naghahanap...'
              : 'Searching...'
            : `${filteredResults.length} ${language === 'fil' ? 'nahanap' : 'found'}`}
        </SafeText>

        <View style={styles.filterRow}>
          <TouchableOpacity
            activeOpacity={0.84}
            style={[
              styles.filterChip,
              !selectedCategory && styles.filterChipActive,
            ]}
            onPress={() => setSelectedCategory(null)}
          >
            <SafeText
              variant="caption"
              weight="700"
              color={!selectedCategory ? 'surface' : 'primary'}
            >
              {language === 'fil' ? 'Lahat' : 'All'}
            </SafeText>
          </TouchableOpacity>

          {categories.slice(0, 7).map((cat) => {
            const active = selectedCategory === cat.id

            return (
              <TouchableOpacity
                key={cat.id}
                activeOpacity={0.84}
                style={[
                  styles.filterChip,
                  {
                    borderColor: active ? cat.color : `${cat.color}35`,
                    backgroundColor: active ? cat.color : `${cat.color}12`,
                  },
                ]}
                onPress={() => setSelectedCategory(active ? null : cat.id)}
              >
                <SafeText>{cat.icon}</SafeText>
                <SafeText
                  variant="caption"
                  weight="700"
                  style={{ color: active ? '#FFFFFF' : cat.color }}
                >
                  {language === 'fil' ? cat.name_fil : cat.name_en}
                </SafeText>
              </TouchableOpacity>
            )
          })}
        </View>
      </View>
    )
  }

  return (
    <View style={styles.container}>
      <View style={styles.hero}>
        <SafeText variant="caption" color="surface" style={styles.eyebrow}>
          {language === 'fil' ? 'Hanapin agad' : 'Find it fast'}
        </SafeText>
        <SafeText variant="h1" color="surface">
          {t.search} 🔍
        </SafeText>
        <SafeText variant="bodyMd" color="surface" style={styles.subtitle}>
          {language === 'fil'
            ? 'Type mo lang ang kailangan mo. IDs, pera, trabaho, scam alerts.'
            : 'Search practical guides about IDs, money, work, and scam alerts.'}
        </SafeText>

        <View style={styles.searchBox}>
          <Ionicons name="search" size={20} color={colors.textMuted} />
          <TextInput
            style={styles.searchInput}
            placeholder={
              language === 'fil'
                ? 'Halimbawa: valid ID, bank, scam...'
                : 'Example: valid ID, bank, scam...'
            }
            placeholderTextColor={colors.textLight}
            value={searchTerm}
            onChangeText={setSearchTerm}
            onSubmitEditing={() => commitSearch(searchTerm)}
            autoCorrect={false}
            autoCapitalize="none"
            returnKeyType="search"
          />
          {searchTerm.length > 0 ? (
            <TouchableOpacity hitSlop={10} onPress={() => setSearchTerm('')}>
              <Ionicons name="close-circle" size={20} color={colors.textLight} />
            </TouchableOpacity>
          ) : null}
        </View>
      </View>

      <FlatList
        data={showEmptySearch || showNoResults ? [] : filteredResults}
        keyExtractor={(item) => item.id}
        ListHeaderComponent={renderListHeader}
        ListEmptyComponent={
          isLoading && !showEmptySearch ? (
            <LoadingFeed count={2} />
          ) : showNoResults ? (
            <View style={styles.emptyState}>
              <View style={styles.emptyIcon}>
                <Ionicons name="search-outline" size={30} color={colors.primary} />
              </View>
              <SafeText variant="h3" weight="700" style={styles.emptyTitle}>
                {language === 'fil' ? 'Walang resulta' : 'No results found'}
              </SafeText>
              <SafeText variant="bodyMd" color="muted" style={styles.emptySubtitle}>
                {language === 'fil'
                  ? 'Subukan ang mas simpleng salita o alisin ang category filter.'
                  : 'Try simpler words or remove the category filter.'}
              </SafeText>

              <View style={styles.emptySuggestions}>
                {SUGGESTIONS.slice(0, 4).map((item) => (
                  <TouchableOpacity
                    key={item}
                    activeOpacity={0.84}
                    onPress={() => {
                      setSelectedCategory(null)
                      commitSearch(item)
                    }}
                  >
                    <Badge label={item} color={colors.primary} />
                  </TouchableOpacity>
                ))}
              </View>
            </View>
          ) : null
        }
        contentContainerStyle={styles.content}
        keyboardShouldPersistTaps="handled"
        keyboardDismissMode="none"
        showsVerticalScrollIndicator={false}
        renderItem={({ item }) => (
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
    </View>
  )
}

const createStyles = (colors: any) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },

    content: {
      backgroundColor: colors.background,
      paddingBottom: 140,
    },

    hero: {
      backgroundColor: colors.primary,
      paddingHorizontal: spacing.lg,
      paddingTop: spacing.xxl,
      paddingBottom: spacing.lg,
      borderBottomLeftRadius: 28,
      borderBottomRightRadius: 28,
    },

    eyebrow: {
      textTransform: 'uppercase',
      opacity: 0.82,
      marginBottom: spacing.sm,
    },

    subtitle: {
      opacity: 0.9,
      marginTop: spacing.sm,
      marginBottom: spacing.lg,
    },

    searchBox: {
      minHeight: 54,
      borderRadius: 16,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      paddingHorizontal: spacing.md,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    searchInput: {
      flex: 1,
      minHeight: 52,
      color: colors.text,
      fontSize: 16,
      lineHeight: 22,
      fontWeight: '400',
    },

    suggestionWrap: {
      padding: spacing.md,
      paddingTop: spacing.lg,
    },

    recentBlock: {
      marginBottom: spacing.lg,
    },

    recentHeader: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
      gap: spacing.md,
    },

    tryTitle: {
      marginTop: spacing.xs,
    },

    suggestions: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.sm,
      marginTop: spacing.md,
    },

    resultsHeader: {
      paddingHorizontal: spacing.md,
      paddingTop: spacing.lg,
      paddingBottom: spacing.md,
    },

    filterRow: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.sm,
      marginTop: spacing.md,
    },

    filterChip: {
      minHeight: 38,
      borderRadius: 999,
      borderWidth: 1,
      borderColor: colors.primary,
      backgroundColor: colors.surface,
      paddingHorizontal: spacing.md,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
    },

    filterChipActive: {
      backgroundColor: colors.primary,
    },

    emptyState: {
      margin: spacing.md,
      borderRadius: 16,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.xl,
      alignItems: 'center',
    },

    emptyIcon: {
      width: 58,
      height: 58,
      borderRadius: 29,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
      marginBottom: spacing.md,
    },

    emptyTitle: {
      textAlign: 'center',
      marginBottom: spacing.sm,
    },

    emptySubtitle: {
      textAlign: 'center',
    },

    emptySuggestions: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      justifyContent: 'center',
      gap: spacing.sm,
      marginTop: spacing.lg,
    },
  })
