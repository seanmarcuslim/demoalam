import {
  FlatList,
  StyleSheet,
  View,
} from 'react-native'
import { router } from 'expo-router'
import { Ionicons } from '@expo/vector-icons'
import { useSavedStore } from '../../src/stores/savedStore'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { translations } from '../../src/utils/translations'
import { useTheme } from '../../src/hooks/useTheme'
import { spacing } from '../../src/theme/spacing'
import type { ThemeColors } from '../../src/theme/colors'
import SafeText from '../../src/components/ui/SafeText'
import GuideCard from '../../src/components/guide/GuideCard'
import AppHeader from '../../src/components/ui/AppHeader'
import AppCard from '../../src/components/ui/AppCard'
import AppButton from '../../src/components/ui/AppButton'
import EmptyState from '../../src/components/ui/EmptyState'
import { useGuides } from '../../src/hooks/useGuides'
import { useEffect } from 'react'

export default function SavedScreen() {
  const {
    savedIds,
    cachedGuides,
    toggleSave,
    hydrateSavedGuides,
  } = useSavedStore()
  const { data: guides = [] } = useGuides()
  const { language } = useSettingsStore()
  const { colors } = useTheme()

  const t = translations[language]
  const styles = createStyles(colors)

  const savedGuides = savedIds
    .map((id) => cachedGuides[id])
    .filter(Boolean)
  const hasCachedGuides = savedGuides.length > 0
  const needsRefresh = savedIds.length > 0 && !hasCachedGuides

  useEffect(() => {
    if (guides.length > 0 && savedIds.length > 0) {
      hydrateSavedGuides(guides)
    }
  }, [guides, hydrateSavedGuides, savedIds.length])

  const openGuide = (id: string) => {
    router.push({
      pathname: '/guide/[id]',
      params: { id },
    })
  }

  const renderHeader = () => (
    <View>
      <AppHeader
        title={language === 'fil' ? 'Na-save Mo 🔖' : 'Saved Guides 🔖'}
        subtitle={`${savedIds.length} ${t.savedCount}`}
      />

      {hasCachedGuides ? (
        <AppCard style={styles.notice}>
          <Ionicons
            name="cloud-offline-outline"
            size={19}
            color={colors.success}
          />

          <SafeText
            variant="bodyMd"
            color="muted"
            style={styles.noticeText}
          >
            {language === 'fil'
              ? 'Naka-cache ang saved guides para madaling balikan.'
              : 'Saved guides are cached so you can revisit them quickly.'}
          </SafeText>
        </AppCard>
      ) : null}

      {needsRefresh ? (
        <AppCard style={styles.refreshNotice}>
          <Ionicons
            name="sync-circle-outline"
            size={22}
            color={colors.warning}
          />

          <SafeText
            variant="bodyMd"
            color="muted"
            style={styles.noticeText}
          >
            {language === 'fil'
              ? 'May saved guides ka, pero kailangan munang mag-online para ma-refresh ang offline copies.'
              : 'You have saved guides, but you need to go online once to refresh the offline copies.'}
          </SafeText>
        </AppCard>
      ) : null}
    </View>
  )

  return (
    <FlatList
      data={savedGuides}
      keyExtractor={(item) => item.id}
      ListHeaderComponent={renderHeader}
      ListEmptyComponent={
        <AppCard style={styles.emptyCard}>
          <EmptyState
            icon={needsRefresh ? '↻' : '🔖'}
            title={
              needsRefresh
                ? language === 'fil'
                  ? 'I-refresh ang saved guides'
                  : 'Refresh saved guides'
                : language === 'fil'
                  ? 'Wala pang na-save'
                  : 'No saved guides yet'
            }
            subtitle={
              needsRefresh
                ? language === 'fil'
                  ? 'Bumalik online at buksan ulit ang guides para ma-save ang latest offline copy.'
                  : 'Go online and reopen your guides to save the latest offline copy.'
                : language === 'fil'
                  ? 'I-tap ang bookmark sa kahit anong guide para mabilis mo itong balikan.'
                  : 'Tap the bookmark on any guide so it is easy to revisit later.'
            }
          />

          <AppButton
            title={
              needsRefresh
                ? language === 'fil'
                  ? 'Pumunta sa Home'
                  : 'Go to Home'
                : language === 'fil'
                  ? 'Mag-browse ng guides'
                  : 'Browse guides'
            }
            onPress={() => router.push('/')}
            style={styles.emptyAction}
          />
        </AppCard>
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

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    content: {
      backgroundColor: colors.background,
      paddingBottom: 140,
    },

    notice: {
      marginHorizontal: spacing.md,
      marginTop: spacing.lg,
      backgroundColor: colors.successLight,
      borderWidth: 1,
      borderColor: `${colors.success}30`,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    noticeText: {
      flex: 1,
    },

    refreshNotice: {
      marginHorizontal: spacing.md,
      marginTop: spacing.lg,
      backgroundColor: colors.warningLight,
      borderWidth: 1,
      borderColor: `${colors.warning}30`,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    emptyCard: {
      margin: spacing.md,
      alignItems: 'center',
      borderWidth: 1,
      borderColor: colors.border,
    },

    emptyAction: {
      marginTop: spacing.md,
      alignSelf: 'stretch',
    },
  })
