import {
  FlatList,
  StyleSheet,
  TextInput,
  TouchableOpacity,
  View,
} from 'react-native'
import { useEffect, useMemo, useRef, useState } from 'react'
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
import { getCategoryName } from '../../src/lib/categoryCopy'
import {
  SEARCH_SUGGESTION_GROUPS,
  SEARCH_SUGGESTIONS,
  getSuggestionGroupTitle,
  getSuggestionGroupSubtitle,
} from '../../src/lib/searchSuggestions'
import { analyticsService } from '../../src/services/analyticsService'
import {
  phoneLostFlow,
  shouldShowPhoneLostFlow,
} from '../../src/lib/decisionFlows/phoneLostFlow'

export default function SearchScreen() {
  const {
    searchTerm,
    debouncedTerm,
    setSearchTerm,
    results,
    isLoading,
    isError,
    refetch,
  } = useSearch()

  const [selectedCategory, setSelectedCategory] = useState<string | null>(null)
  const [committedSearchTerm, setCommittedSearchTerm] = useState('')
  const lastLoggedSearchKey = useRef('')

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
  const labels = t.searchScreen

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
  const showPhoneLostFlowCard = shouldShowPhoneLostFlow(searchTerm)

  const openGuide = (id: string) => {
    router.push({
      pathname: '/guide/[id]',
      params: { id },
    })
  }

  const openPhoneLostFlow = () => {
    analyticsService.logFlowEvent({
      flowSlug: 'phone-lost',
      eventName: 'flow_opened',
      searchQuery: searchTerm.trim(),
      language,
    }).catch(() => {
      // Analytics should never interrupt search.
    })

    router.push('/flow/phone-lost')
  }

  const updateSearchTerm = (term: string) => {
    setSelectedCategory(null)
    setSearchTerm(term)
  }

  const commitSearch = (term: string) => {
    const cleanTerm = term.trim()

    if (cleanTerm.length > 1) {
      addRecentSearch(cleanTerm)
      setCommittedSearchTerm(cleanTerm)
    }

    updateSearchTerm(term)
  }

  useEffect(() => {
    const cleanTerm = committedSearchTerm.trim()

    if (
      cleanTerm.length < 2 ||
      debouncedTerm !== cleanTerm ||
      isLoading ||
      isError ||
      searchTerm.trim() !== cleanTerm
    ) {
      return
    }

    const searchKey = `${language}:${cleanTerm.toLowerCase()}:${results.length}:${results[0]?.slug ?? ''}`

    if (lastLoggedSearchKey.current === searchKey) {
      return
    }

    lastLoggedSearchKey.current = searchKey

    analyticsService.logSearchEvent({
      query: cleanTerm,
      resultCount: results.length,
      topResultSlug: results[0]?.slug,
      language,
    }).catch(() => {
      // Analytics should never interrupt search.
    })
  }, [committedSearchTerm, debouncedTerm, isError, isLoading, language, results, searchTerm])

  const renderListHeader = () => {
    if (showEmptySearch) {
      return (
        <View style={styles.suggestionWrap}>
          {recentSearches.length > 0 ? (
            <AppCard style={styles.recentBlock}>
              <View style={styles.recentHeader}>
                <SafeText variant="h3" weight="700">
                  {labels.recentSearches}
                </SafeText>

                <TouchableOpacity
                  activeOpacity={0.82}
                  style={styles.clearButton}
                  onPress={clearRecentSearches}
                >
                  <SafeText variant="caption" color="primary" weight="700">
                    {labels.clear}
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
              {labels.discoveryTitle}
            </SafeText>

            <SafeText variant="bodyMd" color="muted" style={styles.cardHint}>
              {labels.discoverySubtitle}
            </SafeText>
          </View>

          {SEARCH_SUGGESTION_GROUPS.map((group, index) => {
            const groupColor = colors[group.colorKey]
            const compact = index > 1
            const visibleItems = compact ? group.items.slice(0, 4) : group.items

            return (
              <AppCard
                key={group.title_en}
                style={[
                  styles.suggestionGroup,
                  compact && styles.suggestionGroupCompact,
                ]}
              >
                <View style={styles.groupHeader}>
                  <View
                    style={[
                      styles.groupAccent,
                      compact && styles.groupAccentCompact,
                      { backgroundColor: groupColor },
                    ]}
                  />

                  <View style={styles.groupCopy}>
                    <SafeText variant={compact ? 'body' : 'h3'} weight="700">
                      {getSuggestionGroupTitle(group, language)}
                    </SafeText>

                    {!compact ? (
                      <SafeText variant="caption" color="muted" style={styles.cardHint}>
                        {getSuggestionGroupSubtitle(group, language)}
                      </SafeText>
                    ) : null}
                  </View>
                </View>

                <View style={[styles.suggestions, compact && styles.suggestionsCompact]}>
                  {visibleItems.map((item) => (
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
          {labels.results}
        </SafeText>

        <SafeText variant="caption" color="muted">
          {isLoading
            ? labels.searching
            : `${filteredResults.length} ${labels.found}`}
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

        {showPhoneLostFlowCard ? (
          <AppCard
            style={styles.flowCard}
            onPress={openPhoneLostFlow}
            accessibilityRole="button"
            accessibilityLabel={
              language === 'fil'
                ? phoneLostFlow.entry_title_fil
                : phoneLostFlow.entry_title_en
            }
          >
            <View style={styles.flowCardHeader}>
              <View style={styles.flowIcon}>
                <Ionicons
                  name="phone-portrait-outline"
                  size={22}
                  color={colors.primary}
                />
              </View>

              <View style={styles.flowCopy}>
                <SafeText variant="h3" weight="700">
                  {language === 'fil'
                    ? phoneLostFlow.entry_title_fil
                    : phoneLostFlow.entry_title_en}
                </SafeText>

                <SafeText
                  variant="bodyMd"
                  color="muted"
                  style={styles.cardHint}
                >
                  {language === 'fil'
                    ? phoneLostFlow.entry_body_fil
                    : phoneLostFlow.entry_body_en}
                </SafeText>
              </View>
            </View>

            <View style={styles.flowActionRow}>
              <SafeText variant="bodyMd" color="primary" weight="700">
                {language === 'fil'
                  ? phoneLostFlow.cta_fil
                  : phoneLostFlow.cta_en}
              </SafeText>

              <Ionicons name="arrow-forward" size={18} color={colors.primary} />
            </View>
          </AppCard>
        ) : null}

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
              {labels.all}
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
                  {`${getCategoryName(cat, language)} ${count}`}
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
        subtitle={labels.headerSubtitle}
      />

      <View style={styles.searchBoxWrap}>
        <View style={styles.searchBox}>
          <Ionicons name="search" size={20} color={colors.textMuted} />

          <TextInput
            style={styles.searchInput}
            placeholder={
              labels.placeholder
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
                title={labels.searchUnavailableTitle}
                subtitle={labels.searchUnavailableSubtitle}
              />

              <AppButton
                title={labels.tryAgain}
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
                title={labels.noResultsTitle}
                subtitle={labels.noResultsSubtitle}
              />

              <View style={styles.emptySuggestions}>
                {SEARCH_SUGGESTIONS.slice(0, 4).map((item) => (
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

    suggestionGroupCompact: {
      marginBottom: spacing.sm,
      paddingVertical: spacing.md,
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

    groupAccentCompact: {
      minHeight: 28,
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

    suggestionsCompact: {
      marginTop: spacing.sm,
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

    flowCard: {
      marginTop: spacing.md,
      marginBottom: 0,
      borderColor: colors.primary,
      backgroundColor: colors.surface,
    },

    flowCardHeader: {
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.md,
    },

    flowIcon: {
      width: 44,
      height: 44,
      borderRadius: 22,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
    },

    flowCopy: {
      flex: 1,
    },

    flowActionRow: {
      minHeight: 36,
      marginTop: spacing.md,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
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
