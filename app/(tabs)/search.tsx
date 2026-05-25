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
  'first job',
  'resume',
  'interview',
  'payroll',
  'ayuda',
  'DSWD AICS',
  '4Ps',
  'Walang Gutom',
  'student aid',
  'livelihood',
  'social pension',
  'batas',
  'consumer rights',
  'gcash scam',
]

const SUGGESTION_GROUPS = [
  {
    title_en: 'First job flow',
    title_fil: 'Unang trabaho',
    subtitle_en: 'Resume, interview, requirements, payroll, and payday basics.',
    subtitle_fil: 'Resume, interview, requirements, payroll, at payday basics.',
    colorKey: 'success' as const,
    items: ['first job', 'resume', 'interview', 'job requirements', 'payroll'],
  },
  {
    title_en: 'Aid & benefits',
    title_fil: 'Ayuda at benefits',
    subtitle_en: 'Start here for DSWD, cash assistance, and public programs.',
    subtitle_fil: 'Unahin ito para sa DSWD, cash assistance, at public programs.',
    colorKey: 'primary' as const,
    items: ['ayuda', 'DSWD AICS', '4Ps', 'Walang Gutom', 'social pension'],
  },
  {
    title_en: 'Rights & protection',
    title_fil: 'Karapatan at proteksyon',
    subtitle_en: 'Useful when money, accounts, privacy, or complaints are involved.',
    subtitle_fil: 'Useful kapag pera, account, privacy, o reklamo ang involved.',
    colorKey: 'danger' as const,
    items: ['batas', 'consumer rights', 'data privacy act', 'gcash scam'],
  },
  {
    title_en: 'Student & livelihood',
    title_fil: 'Student at kabuhayan',
    subtitle_en: 'Find education aid, cash-for-work, and livelihood support.',
    subtitle_fil: 'Hanapin ang education aid, cash-for-work, at kabuhayan support.',
    colorKey: 'accent' as const,
    items: ['student aid', 'livelihood', 'scholarship', 'cash-for-work'],
  },
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
                    <Badge label={item} color={colors.accent} />
                  </TouchableOpacity>
                ))}
              </View>
            </AppCard>
          ) : null}

          <View style={styles.discoveryIntro}>
            <SafeText variant="h3" weight="700">
              {language === 'fil'
                ? 'Ano ang kailangan mong malinawan?'
                : 'What do you need clarified?'}
            </SafeText>

            <SafeText variant="bodyMd" color="muted" style={styles.cardHint}>
              {language === 'fil'
                ? 'Maghanap gamit ang simpleng salita. DemoAlam hahanapin ang mas tamang guide.'
                : 'Search in plain words. DemoAlam will look for the closest useful guide.'}
            </SafeText>
          </View>

          {SUGGESTION_GROUPS.map((group) => {
            const groupColor = colors[group.colorKey]

            return (
              <AppCard key={group.title_en} style={styles.suggestionGroup}>
                <View style={styles.groupHeader}>
                  <View
                    style={[
                      styles.groupAccent,
                      { backgroundColor: groupColor },
                    ]}
                  />

                  <View style={styles.groupCopy}>
                    <SafeText variant="h3" weight="700">
                      {language === 'fil' ? group.title_fil : group.title_en}
                    </SafeText>

                    <SafeText variant="caption" color="muted" style={styles.cardHint}>
                      {language === 'fil' ? group.subtitle_fil : group.subtitle_en}
                    </SafeText>
                  </View>
                </View>

                <View style={styles.suggestions}>
                  {group.items.map((item) => (
                    <TouchableOpacity
                      key={item}
                      activeOpacity={0.84}
                      onPress={() => commitSearch(item)}
                    >
                      <Badge label={item} color={groupColor} />
                    </TouchableOpacity>
                  ))}
                </View>
              </AppCard>
            )
          })}
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
                icon="?"
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

    discoveryIntro: {
      marginBottom: spacing.md,
    },

    suggestionGroup: {
      marginBottom: spacing.md,
    },

    groupHeader: {
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.sm,
    },

    groupAccent: {
      width: 4,
      minHeight: 46,
      borderRadius: 999,
      marginTop: 2,
    },

    groupCopy: {
      flex: 1,
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
