import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  ActivityIndicator,
  TouchableOpacity,
  Alert,
  RefreshControl,
} from 'react-native'
import { useEffect } from 'react'
import { useLocalSearchParams, router } from 'expo-router'
import { useGuide } from '../../src/hooks/useGuides'
import { useSavedStore } from '../../src/stores/savedStore'
import { useHistoryStore } from '../../src/stores/historyStore'
import { useSessionStore } from '../../src/stores/sessionStore'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { translations } from '../../src/utils/translations'
import { useTheme } from '../../src/hooks/useTheme'
import { spacing } from '../../src/theme/spacing'
import { typography } from '../../src/theme/typography'

export default function GuideDetailsScreen() {
  const { id } = useLocalSearchParams()

  const guideId = Array.isArray(id) ? id[0] : id

  const {
    data: guide,
    isLoading,
    error,
    refetch,
    isRefetching,
  } = useGuide(guideId)

  const isGuest = useSessionStore((state) => state.isGuest)
  const toggleSave = useSavedStore((state) => state.toggleSave)
  const addToHistory = useHistoryStore((state) => state.addToHistory)

  const { language } = useSettingsStore()
  const { colors } = useTheme()

  const t = translations[language]

  const isSaved = useSavedStore((state) =>
    guide ? state.isSaved(guide.id) : false
  )

  const getTitle = (item: any) =>
    language === 'fil'
      ? item.title_fil
      : item.title_en

  const getTagline = (item: any) =>
    language === 'fil'
      ? item.tagline_fil
      : item.tagline_en

  const getCategoryName = (item: any) =>
    language === 'fil'
      ? item.name_fil
      : item.name_en

  const getSectionTitle = (
    section: any,
    index: number
  ) => {
    const title =
      language === 'fil'
        ? section.title_fil
        : section.title_en

    return title || `Section ${index + 1}`
  }

  const getSectionContent = (section: any) => {
    const content =
      language === 'fil'
        ? section.content_fil
        : section.content_en

    return (
      content ||
      (language === 'fil'
        ? 'Walang content.'
        : 'No content available.')
    )
  }

  const handleSave = () => {
    if (!guide) return

    if (isGuest) {
      Alert.alert(
        language === 'fil'
          ? 'Kailangan mag-login'
          : 'Login required',

        language === 'fil'
          ? 'Mag-login muna para makapag-save ng guides.'
          : 'Please login first to save guides.',

        [
          {
            text:
              language === 'fil'
                ? 'Kanselahin'
                : 'Cancel',
            style: 'cancel',
          },
          {
            text: 'Login',
            onPress: () =>
              router.push('/login'),
          },
        ]
      )

      return
    }

    toggleSave(guide)
  }

  useEffect(() => {
    if (guide) {
      addToHistory(guide)
    }
  }, [guide, addToHistory])

  const styles = createStyles(colors)

  if (isLoading) {
    return (
      <View style={styles.centered}>
        <ActivityIndicator
          size="large"
          color={colors.primary}
        />

        <Text style={styles.loadingText}>
          {language === 'fil'
            ? 'Naglo-load ng guide...'
            : 'Loading guide...'}
        </Text>
      </View>
    )
  }

  if (error || !guide) {
    return (
      <ScrollView
        style={styles.container}
        contentContainerStyle={
          styles.errorContent
        }
        refreshControl={
          <RefreshControl
            refreshing={isRefetching}
            onRefresh={refetch}
            colors={[colors.primary]}
          />
        }
      >
        <Text style={styles.errorTitle}>
          {language === 'fil'
            ? 'May problema 😕'
            : 'Something went wrong 😕'}
        </Text>

        <Text style={styles.errorText}>
          {language === 'fil'
            ? 'Hindi ma-load ang guide. Hilahin pababa para subukan muli.'
            : 'Unable to load this guide. Pull down to try again.'}
        </Text>
      </ScrollView>
    )
  }

  return (
    <ScrollView
      style={styles.container}
      contentContainerStyle={
        styles.content
      }
      showsVerticalScrollIndicator={false}
      refreshControl={
        <RefreshControl
          refreshing={isRefetching}
          onRefresh={refetch}
          colors={[colors.primary]}
        />
      }
    >
      <View style={styles.header}>
        <Text
          style={styles.backText}
          onPress={() => router.back()}
        >
          ←{' '}
          {language === 'fil'
            ? 'Bumalik'
            : 'Back'}
        </Text>

        <Text style={styles.category}>
          {guide.category?.icon}{' '}
          {guide.category
            ? getCategoryName(
                guide.category
              )
            : ''}
        </Text>

        <Text style={styles.title}>
          {getTitle(guide)}
        </Text>

        <Text style={styles.tagline}>
          {getTagline(guide)}
        </Text>

        <View style={styles.metaRow}>
          <Text style={styles.meta}>
            🕐 {guide.read_time_min}{' '}
            {language === 'fil'
              ? 'minuto'
              : 'min'}
          </Text>

          {guide.is_urgent && (
            <Text style={styles.urgentBadge}>
              🚨 URGENT
            </Text>
          )}
        </View>

        <TouchableOpacity
          activeOpacity={0.85}
          style={[
            styles.saveButton,
            isSaved &&
              styles.savedButton,
          ]}
          onPress={handleSave}
        >
          <Text
            style={styles.saveButtonText}
          >
            {isSaved
              ? t.savedGuide
              : isGuest
                ? t.loginToSave
                : t.saveGuide}
          </Text>
        </TouchableOpacity>
      </View>

      <View style={styles.sectionContainer}>
        {guide.sections &&
        guide.sections.length > 0 ? (
          guide.sections.map(
            (
              section: any,
              index: number
            ) => (
              <View
                key={
                  section.id || index
                }
                style={styles.sectionCard}
              >
                <Text
                  style={
                    styles.sectionTitle
                  }
                >
                  {getSectionTitle(
                    section,
                    index
                  )}
                </Text>

                <Text
                  style={
                    styles.sectionContent
                  }
                >
                  {getSectionContent(
                    section
                  )}
                </Text>
              </View>
            )
          )
        ) : (
          <View style={styles.sectionCard}>
            <Text
              style={
                styles.sectionContent
              }
            >
              {language === 'fil'
                ? 'Wala pang available na content para sa guide na ito.'
                : 'No content is available for this guide yet.'}
            </Text>
          </View>
        )}
      </View>
    </ScrollView>
  )
}

const createStyles = (colors: any) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor:
        colors.background,
    },

    content: {
      paddingBottom: 140,
    },

    errorContent: {
      flexGrow: 1,
      justifyContent: 'center',
      alignItems: 'center',
      padding: spacing.xl,
      paddingBottom: 140,
    },

    centered: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      padding: spacing.xl,
      backgroundColor:
        colors.background,
    },

    loadingText: {
      ...typography.body,
      color: colors.textMuted,
      marginTop: spacing.md,
    },

    errorTitle: {
      ...typography.h2,
      color: colors.text,
      marginBottom: spacing.sm,
      textAlign: 'center',
    },

    errorText: {
      ...typography.body,
      color: colors.textMuted,
      textAlign: 'center',
      lineHeight: 22,
    },

    header: {
      backgroundColor:
        colors.primary,
      padding: spacing.lg,
      paddingTop: spacing.xxl,
      borderBottomLeftRadius: 28,
      borderBottomRightRadius: 28,
    },

    backText: {
      ...typography.caption,
      color: colors.primaryLight,
      marginBottom: spacing.md,
      fontWeight: '700',
    },

    category: {
      ...typography.caption,
      color: colors.primaryLight,
      marginBottom: spacing.sm,
    },

    title: {
      ...typography.h1,
      color: colors.surface,
      marginBottom: spacing.sm,
    },

    tagline: {
      ...typography.body,
      color: colors.primaryLight,
      lineHeight: 22,
    },

    metaRow: {
      flexDirection: 'row',
      alignItems: 'center',
      marginTop: spacing.md,
    },

    meta: {
      ...typography.caption,
      color: colors.surface,
      marginRight: spacing.md,
    },

    urgentBadge: {
      ...typography.caption,
      color: '#ffdddd',
      fontWeight: '700',
    },

    saveButton: {
      marginTop: spacing.lg,
      backgroundColor:
        'rgba(255,255,255,0.15)',
      paddingVertical:
        spacing.md,
      borderRadius: 14,
      alignItems: 'center',
    },

    savedButton: {
      backgroundColor:
        'rgba(255,255,255,0.25)',
    },

    saveButtonText: {
      ...typography.body,
      color: '#FFFFFF',
      fontWeight: '700',
    },

    sectionContainer: {
      padding: spacing.md,
    },

    sectionCard: {
      backgroundColor:
        colors.surface,
      borderRadius: 18,
      padding: spacing.lg,
      marginBottom: spacing.md,

      elevation: 3,
      shadowColor: colors.shadow,
      shadowOffset: {
        width: 0,
        height: 2,
      },
      shadowOpacity: 0.08,
      shadowRadius: 4,
    },

    sectionTitle: {
      ...typography.h3,
      color: colors.text,
      marginBottom: spacing.sm,
    },

    sectionContent: {
      ...typography.body,
      color: colors.textMuted,
      lineHeight: 24,
    },
  })