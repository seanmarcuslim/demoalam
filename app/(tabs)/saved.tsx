import {
  FlatList,
  StyleSheet,
  View,
} from 'react-native'
import { router } from 'expo-router'
import { Ionicons } from '@expo/vector-icons'
import { useSavedStore } from '../../src/stores/savedStore'
import { useSettingsStore } from '../../src/stores/settingsStore'
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

  const styles = createStyles(colors)

  const savedGuides = savedIds
    .map((id) => cachedGuides[id])
    .filter(Boolean)
  const hasCachedGuides = savedGuides.length > 0
  const needsRefresh = savedIds.length > 0 && !hasCachedGuides
  const savedCountLabel =
    savedIds.length === 1
      ? language === 'fil'
        ? '1 gabay'
        : '1 guide'
      : language === 'fil'
        ? `${savedIds.length} gabay`
        : `${savedIds.length} guides`

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
        title={language === 'fil' ? 'Na-save Mo' : 'Saved Guides'}
        subtitle={
          language === 'fil'
            ? `${savedCountLabel} na pwede mong balikan kapag kailangan.`
            : `${savedCountLabel} ready when you need them again.`
        }
      />

      <View style={styles.valueStrip}>
        <View style={styles.valuePill}>
          <Ionicons name="bookmark" size={15} color={colors.primary} />
          <SafeText variant="caption" color="primary" weight="700">
            {savedCountLabel}
          </SafeText>
        </View>

        <View style={styles.valuePill}>
          <Ionicons name="cloud-offline-outline" size={15} color={colors.success} />
          <SafeText variant="caption" weight="700" style={{ color: colors.success }}>
            {language === 'fil' ? 'Offline-ready' : 'Offline-ready'}
          </SafeText>
        </View>
      </View>

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
              ? 'Naka-cache ang saved guides para mas madaling balikan kahit mahina ang signal.'
              : 'Saved guides are cached so they are easier to revisit when connection is weak.'}
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
              ? 'May saved guides ka, pero kailangan munang mag-online para makuha ang offline copies.'
              : 'You have saved guides, but you need to go online once to fetch the offline copies.'}
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
                  ? 'Wala ka pang saved guides'
                  : 'No saved guides yet'
            }
            subtitle={
              needsRefresh
                ? language === 'fil'
                  ? 'Bumalik online at buksan ulit ang guides para ma-save ang latest offline copy.'
                  : 'Go online and reopen your guides to save the latest offline copy.'
                : language === 'fil'
                  ? 'I-save ang guides tungkol sa benefits, IDs, karapatan, o scam warnings para mabilis balikan.'
                  : 'Save guides about benefits, IDs, rights, or scam warnings so they are easy to revisit.'
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

    valueStrip: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.sm,
      paddingHorizontal: spacing.md,
      paddingTop: spacing.md,
    },

    valuePill: {
      minHeight: 34,
      borderRadius: 999,
      paddingHorizontal: spacing.md,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
    },

    notice: {
      marginHorizontal: spacing.md,
      marginTop: spacing.md,
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
