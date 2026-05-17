import {
  View,
  Text,
  FlatList,
  StyleSheet,
  TouchableOpacity,
} from 'react-native'
import { router } from 'expo-router'
import { useSavedStore } from '../../src/stores/savedStore'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { translations } from '../../src/utils/translations'
import { colors } from '../../src/theme/colors'
import { spacing } from '../../src/theme/spacing'
import { typography } from '../../src/theme/typography'

export default function SavedScreen() {
  const { savedIds, cachedGuides, unsave } = useSavedStore()
  const { language } = useSettingsStore()

  const t = translations[language]

  const savedGuides = savedIds
    .map((id) => cachedGuides[id])
    .filter(Boolean)

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

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>
          {language === 'fil' ? 'Na-save Mo 🔖' : 'Saved Guides 🔖'}
        </Text>

        <Text style={styles.subtitle}>
          {savedGuides.length}{' '}
          {language === 'fil' ? 'na guide' : 'saved guides'}
        </Text>
      </View>

      {savedGuides.length === 0 ? (
        <View style={styles.emptyState}>
          <Text style={styles.emptyIcon}>🔖</Text>

          <Text style={styles.emptyTitle}>
            {language === 'fil'
              ? 'Wala pang na-save'
              : 'No saved guides yet'}
          </Text>

          <Text style={styles.emptySubtitle}>
            {language === 'fil'
              ? 'I-save ang mga guides para madaling balikan.'
              : 'Save guides so you can easily revisit them later.'}
          </Text>
        </View>
      ) : (
        <FlatList
          data={savedGuides}
          keyExtractor={(item) => item.id}
          contentContainerStyle={styles.list}
          showsVerticalScrollIndicator={false}
          renderItem={({ item }) => (
            <TouchableOpacity
              activeOpacity={0.85}
              style={styles.card}
              onPress={() => openGuide(item.id)}
            >
              <Text style={styles.cardCategory}>
                {item.category?.icon}{' '}
                {item.category
                  ? getCategoryName(item.category)
                  : ''}
              </Text>

              <Text style={styles.cardTitle}>
                {getTitle(item)}
              </Text>

              <Text style={styles.cardTagline}>
                {getTagline(item)}
              </Text>

              <View style={styles.cardFooter}>
                <Text style={styles.readTime}>
                  🕐 {item.read_time_min}{' '}
                  {language === 'fil' ? 'minuto' : 'min'}
                </Text>

                <TouchableOpacity
                  onPress={() => unsave(item.id)}
                >
                  <Text style={styles.unsaveButton}>
                    {language === 'fil'
                      ? 'I-remove'
                      : 'Remove'}
                  </Text>
                </TouchableOpacity>
              </View>
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

  list: {
    padding: spacing.md,
    paddingBottom: 140,
  },

  card: {
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
    fontWeight: '700',
  },
})