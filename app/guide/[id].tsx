import {
  ActivityIndicator,
  Alert,
  RefreshControl,
  ScrollView,
  Share,
  StyleSheet,
  TouchableOpacity,
  View,
} from 'react-native'
import { useEffect } from 'react'
import { useLocalSearchParams, router } from 'expo-router'
import { Ionicons } from '@expo/vector-icons'
import { useGuide } from '../../src/hooks/useGuides'
import { useGuides } from '../../src/hooks/useGuides'
import { useSavedStore } from '../../src/stores/savedStore'
import { useHistoryStore } from '../../src/stores/historyStore'
import { useSessionStore } from '../../src/stores/sessionStore'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { translations } from '../../src/utils/translations'
import { useTheme } from '../../src/hooks/useTheme'
import { spacing } from '../../src/theme/spacing'
import SafeText from '../../src/components/ui/SafeText'
import Badge from '../../src/components/ui/Badge'
import GuideCard from '../../src/components/guide/GuideCard'
import { Guide } from '../../src/types/guide'
import { useFeedbackStore } from '../../src/stores/feedbackStore'
import Skeleton from '../../src/components/ui/Skeleton'

type GuideSection = {
  id?: string
  section_type?: 'what_to_know' | 'mistake' | 'step' | 'warning' | 'tip' | 'related'
  order_index?: number
  content_en?: {
    title?: string
    body?: string
    step_number?: number
    severity?: 'low' | 'medium' | 'high'
  }
  content_fil?: {
    title?: string
    body?: string
    step_number?: number
    severity?: 'low' | 'medium' | 'high'
  }
}

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
  const { data: categoryGuides = [] } = useGuides(guide?.category_id)

  const isGuest = useSessionStore((state) => state.isGuest)
  const toggleSave = useSavedStore((state) => state.toggleSave)
  const addToHistory = useHistoryStore((state) => state.addToHistory)
  const { language } = useSettingsStore()
  const { colors } = useTheme()
  const t = translations[language]
  const styles = createStyles(colors, colors.primary)
  const showFeedback = useFeedbackStore((state) => state.show)

  const isSaved = useSavedStore((state) =>
    guide ? state.isSaved(guide.id) : false
  )
  const isGuideSaved = useSavedStore((state) => state.isSaved)

  const getTitle = (item: any) =>
    language === 'fil' ? item.title_fil : item.title_en

  const getTagline = (item: any) =>
    language === 'fil' ? item.tagline_fil : item.tagline_en

  const getCategoryName = (item: any) =>
    language === 'fil' ? item.name_fil : item.name_en

  const getSectionContent = (section: GuideSection) =>
    language === 'fil' ? section.content_fil : section.content_en

  const handleSave = () => {
    if (!guide) return

    if (isGuest) {
      Alert.alert(
        language === 'fil' ? 'Kailangan mag-login' : 'Login required',
        language === 'fil'
          ? 'Mag-login muna para makapag-save ng guides.'
          : 'Please login first to save guides.',
        [
          {
            text: language === 'fil' ? 'Kanselahin' : 'Cancel',
            style: 'cancel',
          },
          {
            text: t.login,
            onPress: () => router.push('/login'),
          },
        ]
      )
      return
    }

    toggleSave(guide)
    showFeedback(
      isSaved
        ? language === 'fil'
          ? 'Tinanggal sa saved'
          : 'Removed from saved'
        : language === 'fil'
          ? 'Na-save para balikan offline'
          : 'Saved for offline',
      isSaved ? 'info' : 'success'
    )
  }

  const handleShare = async () => {
    if (!guide) return

    await Share.share({
      message: `${getTitle(guide)}\n\n${getTagline(guide)}\n\nDemoAlam`,
    })
  }

  useEffect(() => {
    if (guide) {
      addToHistory(guide)
    }
  }, [guide, addToHistory])

  if (isLoading) {
    return (
      <ScrollView style={styles.container} contentContainerStyle={styles.content}>
        <View style={styles.hero}>
          <View style={styles.navRow}>
            <Skeleton width={42} height={42} radius={21} />
            <View style={styles.navActions}>
              <Skeleton width={42} height={42} radius={21} />
              <Skeleton width={42} height={42} radius={21} />
            </View>
          </View>
          <Skeleton width={124} height={28} radius={999} />
          <Skeleton width="92%" height={30} style={styles.skeletonTitle} />
          <Skeleton width="76%" height={30} style={styles.skeletonLine} />
          <Skeleton width="88%" height={18} style={styles.skeletonLine} />
          <View style={styles.metaGrid}>
            <Skeleton width={92} height={34} radius={999} />
            <Skeleton width={112} height={34} radius={999} />
          </View>
        </View>
        <View style={styles.sectionContainer}>
          {[0, 1, 2].map((item) => (
            <View key={item} style={styles.sectionCard}>
              <Skeleton width="62%" height={24} />
              <Skeleton width="94%" height={16} style={styles.skeletonLine} />
              <Skeleton width="82%" height={16} style={styles.skeletonLine} />
            </View>
          ))}
        </View>
      </ScrollView>
    )
  }

  if (error || !guide) {
    return (
      <ScrollView
        style={styles.container}
        contentContainerStyle={styles.errorContent}
        refreshControl={
          <RefreshControl
            refreshing={isRefetching}
            onRefresh={refetch}
            colors={[colors.primary]}
          />
        }
      >
        <SafeText variant="h2" weight="700" style={styles.errorTitle}>
          {language === 'fil' ? 'May problema 😕' : 'Something went wrong 😕'}
        </SafeText>
        <SafeText color="muted" style={styles.errorText}>
          {language === 'fil'
            ? 'Hindi ma-load ang guide. Hilahin pababa para subukan muli.'
            : 'Unable to load this guide. Pull down to try again.'}
        </SafeText>
      </ScrollView>
    )
  }

  const categoryColor = guide.category?.color || colors.primary
  const guideStyles = createStyles(colors, guide.is_urgent ? colors.danger : categoryColor)
  const sections = [...(guide.sections || [])].sort(
    (a: any, b: any) => (a.order_index || 0) - (b.order_index || 0)
  )
  const relatedGuides = categoryGuides
    .filter((item: Guide) => item.id !== guide.id)
    .slice(0, 3)
  const updatedLabel = formatUpdatedDate(guide.updated_at || guide.published_at)

  return (
    <ScrollView
      style={styles.container}
      contentContainerStyle={styles.content}
      showsVerticalScrollIndicator={false}
      refreshControl={
        <RefreshControl
          refreshing={isRefetching}
          onRefresh={refetch}
          colors={[colors.primary]}
        />
      }
    >
      <View style={guideStyles.hero}>
        <View style={styles.navRow}>
          <TouchableOpacity
            activeOpacity={0.82}
            style={styles.iconButton}
            onPress={() => router.back()}
          >
            <Ionicons name="arrow-back" size={21} color={colors.primary} />
          </TouchableOpacity>

          <View style={styles.navActions}>
            <TouchableOpacity
              activeOpacity={0.82}
              style={styles.iconButton}
              onPress={handleShare}
            >
              <Ionicons name="share-social-outline" size={20} color={colors.primary} />
            </TouchableOpacity>

            <TouchableOpacity
              activeOpacity={0.82}
              style={styles.iconButton}
              onPress={handleSave}
            >
              <Ionicons
                name={isSaved ? 'bookmark' : 'bookmark-outline'}
                size={21}
                color={isSaved ? colors.accent : colors.primary}
              />
            </TouchableOpacity>
          </View>
        </View>

        <View style={styles.heroBody}>
          <Badge
            label={
              guide.category
                ? getCategoryName(guide.category)
                : language === 'fil'
                  ? 'Guide'
                  : 'Guide'
            }
            icon={guide.category?.icon}
            color={categoryColor}
          />

          <SafeText variant="h1" color="surface" style={styles.title}>
            {getTitle(guide)}
          </SafeText>

          <SafeText variant="body" color="surface" style={styles.tagline}>
            {getTagline(guide)}
          </SafeText>

          <View style={styles.metaGrid}>
            <MetaPill
              icon="time-outline"
              label={`${guide.read_time_min} ${language === 'fil' ? 'minuto' : 'min'}`}
            />
            {guide.estimated_cost ? (
              <MetaPill icon="wallet-outline" label={guide.estimated_cost} />
            ) : null}
            {guide.difficulty ? (
              <MetaPill icon="speedometer-outline" label={guide.difficulty} />
            ) : null}
          </View>
        </View>
      </View>

      {guide.is_urgent ? (
        <View style={styles.warningCard}>
          <View style={styles.warningIcon}>
            <Ionicons name="warning" size={20} color={colors.danger} />
          </View>
          <View style={styles.warningCopy}>
            <SafeText variant="label" color="danger" weight="700">
              {language === 'fil' ? 'Mahalagang Babala' : 'Important Warning'}
            </SafeText>
            <SafeText variant="bodyMd" color="muted" style={styles.warningText}>
              {language === 'fil'
                ? 'Basahin muna ang guide bago magpadala ng pera, OTP, o personal information.'
                : 'Read this guide before sending money, OTPs, or personal information.'}
            </SafeText>
          </View>
        </View>
      ) : null}

      <View style={styles.trustCard}>
        <View style={styles.trustHeader}>
          <View style={styles.trustIcon}>
            <Ionicons name="shield-checkmark" size={20} color={colors.primary} />
          </View>
          <View style={styles.trustCopy}>
            <SafeText variant="h3" weight="700">
              {language === 'fil' ? 'Bago ka kumilos' : 'Before you act'}
            </SafeText>
            <SafeText variant="caption" color="muted" style={styles.trustSubtitle}>
              {language === 'fil'
                ? 'Quick check para iwas sayang oras, pera, o maling pila.'
                : 'A quick check to avoid wasted time, money, or wrong steps.'}
            </SafeText>
          </View>
        </View>

        <View style={styles.trustGrid}>
          <TrustItem
            icon="calendar-outline"
            label={language === 'fil' ? 'Updated' : 'Updated'}
            value={updatedLabel}
          />
          <TrustItem
            icon="time-outline"
            label={language === 'fil' ? 'Oras' : 'Time'}
            value={guide.estimated_time || `${guide.read_time_min} min`}
          />
          <TrustItem
            icon="wallet-outline"
            label={language === 'fil' ? 'Gastos' : 'Cost'}
            value={guide.estimated_cost || (language === 'fil' ? 'Depende' : 'Varies')}
          />
          <TrustItem
            icon="speedometer-outline"
            label={language === 'fil' ? 'Level' : 'Level'}
            value={guide.difficulty || (language === 'fil' ? 'Madali' : 'Easy')}
          />
        </View>

        <View style={styles.officialNote}>
          <Ionicons name="information-circle" size={17} color={colors.warning} />
          <SafeText variant="caption" color="muted" style={styles.officialText}>
            {language === 'fil'
              ? 'Kung pera, ID, o government document ang involved, i-verify pa rin sa official office, app, o website.'
              : 'When money, IDs, or government documents are involved, still verify with the official office, app, or website.'}
          </SafeText>
        </View>
      </View>

      <View style={styles.sectionContainer}>
        {sections.length > 0 ? (
          sections.map((section: GuideSection, index: number) => {
            const content = getSectionContent(section)
            return (
              <SectionCard
                key={section.id || index}
                section={section}
                index={index}
                title={content?.title || `Section ${index + 1}`}
                body={
                  content?.body ||
                  (language === 'fil'
                    ? 'Walang content.'
                    : 'No content available.')
                }
              />
            )
          })
        ) : (
          <View style={styles.emptyCard}>
            <SafeText color="muted" style={styles.emptyText}>
              {language === 'fil'
                ? 'Wala pang available na content para sa guide na ito.'
                : 'No content is available for this guide yet.'}
            </SafeText>
          </View>
        )}
      </View>

      <TouchableOpacity
        activeOpacity={0.86}
        style={styles.bottomAction}
        onPress={handleShare}
      >
        <Ionicons name="share-social-outline" size={18} color="#FFFFFF" />
        <SafeText color="surface" weight="700">
          {language === 'fil' ? 'I-share ang guide na ito' : 'Share this guide'}
        </SafeText>
      </TouchableOpacity>

      {relatedGuides.length > 0 ? (
        <View style={styles.relatedSection}>
          <SafeText variant="h3" weight="700" style={styles.relatedTitle}>
            {language === 'fil' ? 'Sunod mong basahin' : 'Read next'}
          </SafeText>
          <SafeText variant="caption" color="muted" style={styles.relatedSubtitle}>
            {language === 'fil'
              ? 'Mga guide sa parehong category'
              : 'More guides in the same category'}
          </SafeText>

          {relatedGuides.map((item: Guide) => (
            <GuideCard
              key={item.id}
              guide={item}
              language={language}
              isSaved={isGuideSaved(item.id)}
              onPress={() =>
                router.push({
                  pathname: '/guide/[id]',
                  params: { id: item.id },
                })
              }
              onSave={() => toggleSave(item)}
              compact
            />
          ))}
        </View>
      ) : (
        <View style={styles.nextStepCard}>
          <SafeText variant="h3" weight="700" style={styles.nextStepTitle}>
            {language === 'fil' ? 'Tapos na dito?' : 'Done here?'}
          </SafeText>
          <SafeText variant="bodyMd" color="muted" style={styles.nextStepText}>
            {language === 'fil'
              ? 'Maghanap pa ng ibang guide o bumalik sa categories para sa susunod mong kailangan.'
              : 'Search another guide or go back to categories for what you need next.'}
          </SafeText>

          <View style={styles.nextStepActions}>
            <TouchableOpacity
              activeOpacity={0.86}
              style={styles.nextStepPrimary}
              onPress={() => router.push('/search')}
            >
              <SafeText color="surface" weight="700">
                {t.search}
              </SafeText>
            </TouchableOpacity>

            <TouchableOpacity
              activeOpacity={0.86}
              style={styles.nextStepSecondary}
              onPress={() => router.push('/categories')}
            >
              <SafeText color="primary" weight="700">
                {t.categories}
              </SafeText>
            </TouchableOpacity>
          </View>
        </View>
      )}
    </ScrollView>
  )

  function MetaPill({ icon, label }: { icon: keyof typeof Ionicons.glyphMap; label: string }) {
    return (
      <View style={styles.metaPill}>
        <Ionicons name={icon} size={15} color="#FFFFFF" />
        <SafeText variant="caption" color="surface" weight="700">
          {label}
        </SafeText>
      </View>
    )
  }

  function SectionCard({
    section,
    index,
    title,
    body,
  }: {
    section: GuideSection
    index: number
    title: string
    body: string
  }) {
    const type = section.section_type || 'what_to_know'
    const isWarning = type === 'warning'
    const isStep = type === 'step'
    const isMistake = type === 'mistake'
    const isTip = type === 'tip'

    const color = isWarning
      ? colors.danger
      : isMistake
        ? colors.warning
        : isTip
          ? colors.success
          : colors.primary

    const icon = isWarning
      ? 'alert-circle'
      : isMistake
        ? 'close-circle'
        : isTip
          ? 'bulb'
          : isStep
            ? 'list-circle'
            : 'information-circle'

    const content = getSectionContent(section)
    const stepNumber = content?.step_number || index + 1

    const toneStyle = {
      backgroundColor: isWarning
        ? colors.dangerLight
        : isMistake
          ? colors.warningLight
          : isTip
            ? colors.successLight
            : colors.surface,
      borderColor: isWarning
        ? `${colors.danger}35`
        : isMistake
          ? `${colors.warning}35`
          : isTip
            ? `${colors.success}35`
            : colors.border,
    }

    return (
      <View
        style={[
          styles.sectionCard,
          toneStyle,
          {
            borderLeftColor: color,
          },
        ]}
      >
        <View style={styles.sectionHeader}>
          <View style={[styles.sectionIcon, { backgroundColor: `${color}18` }]}>
            {isStep ? (
              <SafeText variant="label" weight="700" style={{ color }}>
                {stepNumber}
              </SafeText>
            ) : (
              <Ionicons name={icon as any} size={19} color={color} />
            )}
          </View>

          <View style={styles.sectionTitleWrap}>
            <View style={styles.sectionLabelRow}>
              <SafeText variant="label" weight="700" style={{ color }}>
                {getSectionLabel(type)}
              </SafeText>
              {isWarning ? (
                <SafeText variant="label" color="danger" weight="700">
                  {language === 'fil' ? 'I-check muna' : 'Check first'}
                </SafeText>
              ) : null}
            </View>

            <SafeText variant="h3" weight="700">
              {title}
            </SafeText>
          </View>
        </View>

        <SafeText variant="body" color="muted" style={styles.sectionBody}>
          {body}
        </SafeText>

        {isStep ? (
          <View style={styles.actionHint}>
            <Ionicons name="checkmark-circle" size={17} color={colors.success} />
            <SafeText variant="caption" color="muted" weight="700">
              {language === 'fil' ? 'Gawin ito bago tumuloy' : 'Do this before moving on'}
            </SafeText>
          </View>
        ) : null}

        {isMistake ? (
          <View style={styles.actionHint}>
            <Ionicons name="alert-circle" size={17} color={colors.warning} />
            <SafeText variant="caption" color="muted" weight="700">
              {language === 'fil' ? 'Common na sayang oras' : 'Common time-waster'}
            </SafeText>
          </View>
        ) : null}

        {isTip ? (
          <View style={styles.actionHint}>
            <Ionicons name="sparkles" size={17} color={colors.success} />
            <SafeText variant="caption" color="muted" weight="700">
              {language === 'fil' ? 'Tip para mas madali' : 'Tip to make this easier'}
            </SafeText>
          </View>
        ) : null}
      </View>
    )
  }

  function getSectionLabel(type: string) {
    if (type === 'step') return language === 'fil' ? 'Step' : 'Step'
    if (type === 'warning') return language === 'fil' ? 'Babala' : 'Warning'
    if (type === 'mistake') return language === 'fil' ? 'Iwasan' : 'Avoid'
    if (type === 'tip') return language === 'fil' ? 'Tip' : 'Tip'
    return language === 'fil' ? 'Dapat malaman' : 'What to know'
  }

  function TrustItem({
    icon,
    label,
    value,
  }: {
    icon: keyof typeof Ionicons.glyphMap
    label: string
    value: string
  }) {
    return (
      <View style={styles.trustItem}>
        <Ionicons name={icon} size={17} color={colors.primary} />
        <SafeText variant="caption" color="muted">
          {label}
        </SafeText>
        <SafeText variant="bodyMd" weight="700" numberOfLines={1}>
          {value}
        </SafeText>
      </View>
    )
  }

  function formatUpdatedDate(value?: string | null) {
    if (!value) {
      return language === 'fil' ? 'Hindi pa alam' : 'Unknown'
    }

    try {
      return new Intl.DateTimeFormat(language === 'fil' ? 'fil-PH' : 'en-US', {
        month: 'short',
        day: 'numeric',
        year: 'numeric',
      }).format(new Date(value))
    } catch {
      return language === 'fil' ? 'Hindi pa alam' : 'Unknown'
    }
  }
}

const createStyles = (colors: any, heroColor: string) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },

    content: {
      paddingBottom: 140,
    },

    centered: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      padding: spacing.xl,
      backgroundColor: colors.background,
    },

    loadingText: {
      marginTop: spacing.md,
    },

    errorContent: {
      flexGrow: 1,
      justifyContent: 'center',
      alignItems: 'center',
      padding: spacing.xl,
      paddingBottom: 140,
    },

    errorTitle: {
      marginBottom: spacing.sm,
      textAlign: 'center',
    },

    errorText: {
      textAlign: 'center',
    },

    hero: {
      backgroundColor: heroColor,
      paddingHorizontal: spacing.lg,
      paddingTop: spacing.xl,
      paddingBottom: spacing.lg,
      borderBottomLeftRadius: 28,
      borderBottomRightRadius: 28,
    },

    navRow: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
      marginBottom: spacing.lg,
    },

    navActions: {
      flexDirection: 'row',
      gap: spacing.sm,
    },

    iconButton: {
      width: 42,
      height: 42,
      borderRadius: 21,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
    },

    heroBody: {
      paddingTop: spacing.xs,
    },

    title: {
      marginTop: spacing.md,
      marginBottom: spacing.sm,
    },

    tagline: {
      opacity: 0.9,
    },

    metaGrid: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.sm,
      marginTop: spacing.lg,
    },

    metaPill: {
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
      borderRadius: 999,
      borderWidth: 1,
      borderColor: 'rgba(255,255,255,0.25)',
      backgroundColor: 'rgba(255,255,255,0.12)',
      paddingHorizontal: spacing.md,
      paddingVertical: spacing.sm,
    },

    warningCard: {
      marginHorizontal: spacing.md,
      marginTop: spacing.lg,
      borderRadius: 16,
      borderWidth: 1,
      borderColor: `${colors.danger}35`,
      backgroundColor: colors.dangerLight,
      padding: spacing.md,
      flexDirection: 'row',
      gap: spacing.md,
    },

    warningIcon: {
      width: 38,
      height: 38,
      borderRadius: 19,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
    },

    warningCopy: {
      flex: 1,
    },

    warningText: {
      marginTop: spacing.xs,
    },

    trustCard: {
      marginHorizontal: spacing.md,
      marginTop: spacing.lg,
      borderRadius: 18,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.md,
    },

    trustHeader: {
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.md,
      marginBottom: spacing.md,
    },

    trustIcon: {
      width: 42,
      height: 42,
      borderRadius: 15,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
    },

    trustCopy: {
      flex: 1,
    },

    trustSubtitle: {
      marginTop: 2,
    },

    trustGrid: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.sm,
    },

    trustItem: {
      width: '48%',
      minHeight: 82,
      borderRadius: 14,
      backgroundColor: colors.surfaceSecondary,
      padding: spacing.md,
      justifyContent: 'space-between',
    },

    officialNote: {
      marginTop: spacing.md,
      borderRadius: 14,
      backgroundColor: colors.warningLight,
      padding: spacing.md,
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.sm,
    },

    officialText: {
      flex: 1,
    },

    sectionContainer: {
      padding: spacing.md,
      paddingTop: spacing.lg,
    },

    sectionCard: {
      backgroundColor: colors.surface,
      borderRadius: 16,
      borderWidth: 1,
      borderLeftWidth: 4,
      borderColor: colors.border,
      padding: spacing.lg,
      marginBottom: spacing.md,
      elevation: 2,
      shadowColor: colors.shadow,
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.07,
      shadowRadius: 5,
    },

    sectionHeader: {
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.md,
      marginBottom: spacing.md,
    },

    sectionIcon: {
      width: 40,
      height: 40,
      borderRadius: 20,
      alignItems: 'center',
      justifyContent: 'center',
    },

    sectionTitleWrap: {
      flex: 1,
    },

    sectionLabelRow: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
      gap: spacing.sm,
      marginBottom: spacing.xs,
    },

    sectionBody: {
      lineHeight: 24,
    },

    actionHint: {
      marginTop: spacing.md,
      borderRadius: 12,
      paddingHorizontal: spacing.md,
      paddingVertical: spacing.sm,
      backgroundColor: 'rgba(255,255,255,0.55)',
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    skeletonTitle: {
      marginTop: spacing.md,
      marginBottom: spacing.sm,
    },

    skeletonLine: {
      marginTop: spacing.sm,
    },

    emptyCard: {
      backgroundColor: colors.surface,
      borderRadius: 16,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.lg,
    },

    emptyText: {
      textAlign: 'center',
    },

    bottomAction: {
      marginHorizontal: spacing.md,
      marginTop: spacing.sm,
      borderRadius: 14,
      minHeight: 52,
      backgroundColor: colors.primary,
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'center',
      gap: spacing.sm,
    },

    relatedSection: {
      paddingHorizontal: spacing.md,
      paddingTop: spacing.lg,
    },

    relatedTitle: {
      marginBottom: spacing.xs,
    },

    relatedSubtitle: {
      marginBottom: spacing.md,
    },

    nextStepCard: {
      marginHorizontal: spacing.md,
      marginTop: spacing.lg,
      borderRadius: 18,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.lg,
    },

    nextStepTitle: {
      marginBottom: spacing.sm,
    },

    nextStepText: {
      marginBottom: spacing.lg,
    },

    nextStepActions: {
      flexDirection: 'row',
      gap: spacing.sm,
    },

    nextStepPrimary: {
      flex: 1,
      minHeight: 48,
      borderRadius: 14,
      backgroundColor: colors.primary,
      alignItems: 'center',
      justifyContent: 'center',
    },

    nextStepSecondary: {
      flex: 1,
      minHeight: 48,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.primary,
      alignItems: 'center',
      justifyContent: 'center',
    },
  })
