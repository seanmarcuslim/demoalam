import {
  FlatList,
  StyleSheet,
  TextInput,
  TouchableOpacity,
  View,
} from 'react-native'
import { useMemo, useState } from 'react'
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
import type { ThemeColors } from '../../src/theme/colors'
import SafeText from '../../src/components/ui/SafeText'
import GuideCard from '../../src/components/guide/GuideCard'
import Badge from '../../src/components/ui/Badge'
import LoadingFeed from '../../src/components/layout/LoadingFeed'
import AppHeader from '../../src/components/ui/AppHeader'
import AppCard from '../../src/components/ui/AppCard'
import AppButton from '../../src/components/ui/AppButton'
import EmptyState from '../../src/components/ui/EmptyState'
import { getCategoryAccent } from '../../src/lib/categoryVisuals'

const SUGGESTIONS = [
  'DSWD AICS',
  'student aid',
  'PhilHealth',
  'batas',
  'consumer rights',
  'data privacy act',
  'valid ID',
  'first job',
  'gcash scam',
]

export default function SearchScreen() {
  const {
    searchTerm,
    setSearchTerm,
    results,
    isLoading,
    isError,
    refetch,
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
  const resultCategoryIds = useMemo(
    () => new Set(results.map((guide) => guide.category_id)),
    [results]
  )
  const visibleFilterCategories = showEmptySearch
    ? categories
    : categories.filter((cat) => resultCategoryIds.has(cat.id))

  const filteredResults = selectedCategory
    ? results.filter((guide) => guide.category_id === selectedCategory)
    : results

  const hasFilteredResults = filteredResults.length > 0

  const showNoResults =
    !isLoading &&
    !isError &&
    searchTerm.trim().length > 0 &&
    !hasFilteredResults

  const openGuide = (id: string) => {
    router.push({
      pathname: '/guide/[id]',
      params: { id },
    })
  }

  const updateSearchTerm = (term: string) => {
    setSelectedCategory(null)
    setSearchTerm(term)
  }

  const commitSearch = (term: string) => {
    const cleanTerm = term.trim()

    if (cleanTerm.length > 1) {
      addRecentSearch(cleanTerm)
    }

    updateSearchTerm(term)
  }

  const renderListHeader = () => {
    if (showEmptySearch) {
      return (
        <View style={styles.suggestionWrap}>
          {recentSearches.length > 0 ? (
            <AppCard style={styles.recentBlock}>
              <View style={styles.recentHeader}>
                <SafeText variant="h3" weight="700">
                  {language === 'fil'
                    ? 'Huli mong hinanap'
                    : 'Recent searches'}
                </SafeText>

                <TouchableOpacity
                  activeOpacity={0.82}
                  style={styles.clearButton}
                  onPress={clearRecentSearches}
                >
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
            </AppCard>
          ) : null}

          <AppCard>
            <SafeText variant="h3" weight="700">
              {language === 'fil' ? 'Subukan hanapin' : 'Try searching'}
            </SafeText>

            <SafeText variant="caption" color="muted" style={styles.cardHint}>
              {language === 'fil'
                ? 'Mga topic na madalas nakakalito o hindi naipapaliwanag nang malinaw.'
                : 'Topics that are often confusing, hidden, or poorly explained.'}
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
          </AppCard>
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
            : `${filteredResults.length} ${
                language === 'fil' ? 'nahanap' : 'found'
              }`}
        </SafeText>

        <View style={styles.queryPill}>
          <Ionicons name="search" size={14} color={colors.primary} />
          <SafeText
            variant="caption"
            color="primary"
            weight="700"
            numberOfLines={1}
            style={styles.queryText}
          >
            {searchTerm.trim()}
          </SafeText>
        </View>

        {results.length > 0 ? (
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

          {visibleFilterCategories.map((cat) => {
            const active = selectedCategory === cat.id
            const accent = getCategoryAccent(cat, colors.primary)
            const count = results.filter((guide) => guide.category_id === cat.id).length

            return (
              <TouchableOpacity
                key={cat.id}
                activeOpacity={0.84}
                style={[
                  styles.filterChip,
                  {
                    borderColor: active ? accent : `${accent}35`,
                    backgroundColor: active ? accent : `${accent}12`,
                  },
                ]}
                onPress={() => setSelectedCategory(active ? null : cat.id)}
              >
                <SafeText>{cat.icon}</SafeText>

                <SafeText
                  variant="caption"
                  weight="700"
                  style={{
                    color: active ? '#FFFFFF' : accent,
                  }}
                >
                  {`${language === 'fil' ? cat.name_fil : cat.name_en} ${count}`}
                </SafeText>
              </TouchableOpacity>
            )
          })}
          </View>
        ) : null}
      </View>
    )
  }

  return (
    <View style={styles.container}>
      <AppHeader
        title={t.search}
        subtitle={
          language === 'fil'
            ? 'Hanapin ang benefits, karapatan, IDs, trabaho, pera, at scam warnings.'
            : 'Find guides about benefits, rights, IDs, work, money, and scam warnings.'
        }
      />

      <View style={styles.searchBoxWrap}>
        <View style={styles.searchBox}>
          <Ionicons name="search" size={20} color={colors.textMuted} />

          <TextInput
            style={styles.searchInput}
            placeholder={
              language === 'fil'
                ? 'Halimbawa: DSWD AICS, batas, valid ID...'
                : 'Example: DSWD AICS, rights, valid ID...'
            }
            placeholderTextColor={colors.textLight}
            selectionColor={colors.primary}
            cursorColor={colors.primary}
            value={searchTerm}
            onChangeText={updateSearchTerm}
            onSubmitEditing={() => commitSearch(searchTerm)}
            autoCorrect={false}
            autoCapitalize="none"
            returnKeyType="search"
          />

          {searchTerm.length > 0 ? (
            <TouchableOpacity
              hitSlop={10}
              onPress={() => updateSearchTerm('')}
            >
              <Ionicons
                name="close-circle"
                size={20}
                color={colors.textLight}
              />
            </TouchableOpacity>
          ) : null}
        </View>
      </View>

      <FlatList
        data={showEmptySearch || showNoResults || isError ? [] : filteredResults}
        keyExtractor={(item) => item.id}
        ListHeaderComponent={renderListHeader}
        ListEmptyComponent={
          isError && !showEmptySearch ? (
            <AppCard style={styles.emptyCard}>
              <EmptyState
                icon="!"
                title={
                  language === 'fil'
                    ? 'Hindi ma-search ngayon'
                    : 'Search is unavailable'
                }
                subtitle={
                  language === 'fil'
                    ? 'I-check ang internet connection o subukan ulit.'
                    : 'Check your internet connection or try again.'
                }
              />

              <AppButton
                title={language === 'fil' ? 'Subukan ulit' : 'Try again'}
                onPress={() => refetch()}
                style={styles.emptyAction}
              />
            </AppCard>
          ) : isLoading && !showEmptySearch ? (
            <LoadingFeed count={2} />
          ) : showNoResults ? (
            <AppCard style={styles.emptyCard}>
              <EmptyState
                icon="🔎"
                title={
                  language === 'fil'
                    ? 'Walang resulta'
                    : 'No results found'
                }
                subtitle={
                  language === 'fil'
                    ? 'Subukan ang mas simpleng salita o alisin ang category filter.'
                    : 'Try simpler words or remove the category filter.'
                }
              />

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
            </AppCard>
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

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },

    content: {
      backgroundColor: colors.background,
      paddingBottom: 140,
    },

    searchBoxWrap: {
      backgroundColor: colors.primary,
      paddingHorizontal: spacing.lg,
      paddingBottom: spacing.lg,
      borderBottomLeftRadius: 24,
      borderBottomRightRadius: 24,
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
      elevation: 2,
      shadowColor: colors.shadow,
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.08,
      shadowRadius: 6,
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

    clearButton: {
      minHeight: 34,
      borderRadius: 999,
      paddingHorizontal: spacing.sm,
      alignItems: 'center',
      justifyContent: 'center',
      backgroundColor: colors.primaryLight,
    },

    cardHint: {
      marginTop: spacing.xs,
      maxWidth: 320,
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

    queryPill: {
      alignSelf: 'flex-start',
      minHeight: 32,
      maxWidth: '100%',
      borderRadius: 999,
      paddingHorizontal: spacing.sm,
      marginTop: spacing.sm,
      backgroundColor: colors.primaryLight,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
    },

    queryText: {
      maxWidth: 260,
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

    emptyCard: {
      margin: spacing.md,
      alignItems: 'center',
      borderWidth: 1,
      borderColor: colors.border,
    },

    emptySuggestions: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      justifyContent: 'center',
      gap: spacing.sm,
      marginTop: spacing.lg,
    },

    emptyAction: {
      marginTop: spacing.md,
      alignSelf: 'stretch',
    },
  })
