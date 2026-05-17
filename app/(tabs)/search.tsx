import AppCard from '../../src/components/ui/AppCard'
import {
  View,
  Text,
  TextInput,
  FlatList,
  StyleSheet,
  TouchableOpacity,
} from 'react-native'
import { router } from 'expo-router'
import { useSearch } from '../../src/hooks/useSearch'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { translations } from '../../src/utils/translations'
import { useTheme } from '../../src/hooks/useTheme'
import { spacing } from '../../src/theme/spacing'
import { typography } from '../../src/theme/typography'

export default function SearchScreen() {
  const {
    searchTerm,
    setSearchTerm,
    results,
    isLoading,
    hasResults,
  } = useSearch()

  const { language } = useSettingsStore()
  const { colors } = useTheme()

  const t = translations[language]

  const openGuide = (id: string) => {
    router.push({
      pathname: '/guide/[id]',
      params: { id },
    })
  }

  const getTitle = (item: any) =>
    language === 'fil' ? item.title_fil : item.title_en

  const getTagline = (item: any) =>
    language === 'fil' ? item.tagline_fil : item.tagline_en

  const getCategoryName = (item: any) =>
    language === 'fil' ? item.name_fil : item.name_en

  const styles = StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
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
      marginBottom: spacing.md,
    },

    searchBar: {
      backgroundColor: colors.surface,
      borderRadius: 16,
      paddingHorizontal: spacing.md,
      paddingVertical: spacing.md,
      ...typography.body,
      color: colors.text,
      borderWidth: 1,
      borderColor: colors.border,
    },

    emptyState: {
      flex: 1,
      alignItems: 'center',
      justifyContent: 'center',
      padding: spacing.xl,
      paddingBottom: 140,
    },

    emptyIcon: {
      fontSize: 52,
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
      lineHeight: 22,
    },

    loadingText: {
      ...typography.body,
      color: colors.textMuted,
      textAlign: 'center',
      padding: spacing.xl,
      paddingBottom: 140,
    },

    resultsList: {
      padding: spacing.md,
      paddingBottom: 140,
    },

    resultCard: {
      backgroundColor: colors.surface,
      borderRadius: 16,
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
      marginBottom: spacing.md,
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

    openText: {
      ...typography.caption,
      color: colors.primary,
      fontWeight: '700',
    },
  })

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>
          {t.search} 🔍
        </Text>

        <Text style={styles.subtitle}>
          {language === 'fil'
            ? 'Hanapin ang guide na kailangan mo'
            : 'Find the guide you need'}
        </Text>

        <TextInput
          style={styles.searchBar}
          placeholder={
            language === 'fil'
              ? 'Halimbawa: valid ID, bank, scam...'
              : 'Example: valid ID, bank, scam...'
          }
          placeholderTextColor={colors.textLight}
          value={searchTerm}
          onChangeText={setSearchTerm}
          autoCorrect={false}
          autoCapitalize="none"
          returnKeyType="search"
        />
      </View>

      {searchTerm.trim().length === 0 ? (
        <View style={styles.emptyState}>
          <Text style={styles.emptyIcon}>🔎</Text>

          <Text style={styles.emptyTitle}>
            {language === 'fil'
              ? 'Ano ang hinahanap mo?'
              : 'What are you looking for?'}
          </Text>

          <Text style={styles.emptySubtitle}>
            {language === 'fil'
              ? 'Subukan maghanap ng guide tungkol sa IDs, pera, trabaho, school, o scam alerts.'
              : 'Try searching guides about IDs, money, jobs, school, or scam alerts.'}
          </Text>
        </View>
      ) : isLoading ? (
        <Text style={styles.loadingText}>
          {language === 'fil'
            ? 'Naghahanap...'
            : 'Searching...'}
        </Text>
      ) : !hasResults ? (
        <View style={styles.emptyState}>
          <Text style={styles.emptyIcon}>😕</Text>

          <Text style={styles.emptyTitle}>
            {language === 'fil'
              ? 'Walang resulta'
              : 'No results found'}
          </Text>

          <Text style={styles.emptySubtitle}>
            {language === 'fil'
              ? 'Subukan ang ibang salita.'
              : 'Try another keyword.'}
          </Text>
        </View>
      ) : (
        <FlatList
          data={results}
          keyExtractor={(item) => item.id}
          contentContainerStyle={styles.resultsList}
          keyboardShouldPersistTaps="handled"
          showsVerticalScrollIndicator={false}
          renderItem={({ item }) => (
            <AppCard
  style={styles.resultCard}
  onPress={() => openGuide(item.id)}
>
  <Text style={styles.resultCategory}>
    {item.category?.icon}{' '}
    {item.category?.name_fil}
  </Text>

  <Text style={styles.resultTitle}>
    {item.title_fil}
  </Text>

  <Text style={styles.resultTagline}>
    {item.tagline_fil}
  </Text>

  <View style={styles.cardFooter}>
    <Text style={styles.readTime}>
      🕐 {item.read_time_min} minuto
    </Text>

    <Text style={styles.openText}>
      Buksan →
    </Text>
  </View>
</AppCard>
          )}
        />
      )}
    </View>
  )
}