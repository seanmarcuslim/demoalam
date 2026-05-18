import {
  FlatList,
  StyleSheet,
  TouchableOpacity,
  View,
} from 'react-native'
import { router } from 'expo-router'
import { Ionicons } from '@expo/vector-icons'
import { useSavedStore } from '../../src/stores/savedStore'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { translations } from '../../src/utils/translations'
import { useTheme } from '../../src/hooks/useTheme'
import { spacing } from '../../src/theme/spacing'
import SafeText from '../../src/components/ui/SafeText'
import GuideCard from '../../src/components/guide/GuideCard'

export default function SavedScreen() {
  const { savedIds, cachedGuides, toggleSave } = useSavedStore()
  const { language } = useSettingsStore()
  const { colors } = useTheme()
  const t = translations[language]
  const styles = createStyles(colors)

  const savedGuides = savedIds
    .map((id) => cachedGuides[id])
    .filter(Boolean)

  const openGuide = (id: string) => {
    router.push({
      pathname: '/guide/[id]',
      params: { id },
    })
  }

  const renderHeader = () => (
    <View>
      <View style={styles.hero}>
        <View style={styles.heroIcon}>
          <Ionicons name="bookmark" size={24} color={colors.primary} />
        </View>
        <SafeText variant="h1" color="surface">
          {language === 'fil' ? 'Na-save Mo' : 'Saved Guides'}
        </SafeText>
        <SafeText variant="bodyMd" color="surface" style={styles.subtitle}>
          {savedGuides.length} {t.savedCount}
        </SafeText>
      </View>

      {savedGuides.length > 0 ? (
        <View style={styles.notice}>
          <Ionicons name="cloud-offline-outline" size={19} color={colors.success} />
          <SafeText variant="bodyMd" color="muted" style={styles.noticeText}>
            {language === 'fil'
              ? 'Naka-cache ang saved guides para madaling balikan.'
              : 'Saved guides are cached so you can revisit them quickly.'}
          </SafeText>
        </View>
      ) : null}
    </View>
  )

  return (
    <FlatList
      data={savedGuides}
      keyExtractor={(item) => item.id}
      ListHeaderComponent={renderHeader}
      ListEmptyComponent={
        <View style={styles.emptyState}>
          <View style={styles.emptyIcon}>
            <Ionicons name="bookmark-outline" size={32} color={colors.primary} />
          </View>
          <SafeText variant="h3" weight="700" style={styles.emptyTitle}>
            {language === 'fil' ? 'Wala pang na-save' : 'No saved guides yet'}
          </SafeText>
          <SafeText variant="bodyMd" color="muted" style={styles.emptySubtitle}>
            {language === 'fil'
              ? 'I-tap ang bookmark sa kahit anong guide para mabilis mo itong balikan.'
              : 'Tap the bookmark on any guide so it is easy to revisit later.'}
          </SafeText>

          <TouchableOpacity
            activeOpacity={0.86}
            style={styles.emptyAction}
            onPress={() => router.push('/')}
          >
            <SafeText color="surface" weight="700">
              {language === 'fil' ? 'Mag-browse ng guides' : 'Browse guides'}
            </SafeText>
          </TouchableOpacity>
        </View>
      }
      contentContainerStyle={styles.content}
      showsVerticalScrollIndicator={false}
      renderItem={({ item }) => (
        <GuideCard
          guide={item}
          language={language}
          isSaved
          onPress={() => openGuide(item.id)}
          onSave={() => toggleSave(item)}
        />
      )}
      removeClippedSubviews
      maxToRenderPerBatch={5}
      windowSize={5}
    />
  )
}

const createStyles = (colors: any) =>
  StyleSheet.create({
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

    heroIcon: {
      width: 50,
      height: 50,
      borderRadius: 16,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
      marginBottom: spacing.md,
    },

    subtitle: {
      opacity: 0.9,
      marginTop: spacing.sm,
    },

    notice: {
      marginHorizontal: spacing.md,
      marginTop: spacing.lg,
      borderRadius: 14,
      backgroundColor: colors.successLight,
      borderWidth: 1,
      borderColor: `${colors.success}30`,
      padding: spacing.md,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    noticeText: {
      flex: 1,
    },

    emptyState: {
      margin: spacing.md,
      borderRadius: 18,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.xl,
      alignItems: 'center',
    },

    emptyIcon: {
      width: 64,
      height: 64,
      borderRadius: 32,
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
      marginBottom: spacing.lg,
    },

    emptyAction: {
      minHeight: 46,
      borderRadius: 14,
      paddingHorizontal: spacing.lg,
      backgroundColor: colors.primary,
      alignItems: 'center',
      justifyContent: 'center',
    },
  })
