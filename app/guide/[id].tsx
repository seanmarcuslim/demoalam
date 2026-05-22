import {
  ActivityIndicator,
  Alert,
  Linking,
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
import type { ThemeColors } from '../../src/theme/colors'
import SafeText from '../../src/components/ui/SafeText'
import Badge from '../../src/components/ui/Badge'
import GuideCard from '../../src/components/guide/GuideCard'
import {
  Guide,
  GuideOfficialSource,
  GuideSection,
  GuideSectionType,
} from '../../src/types/guide'
import { Category } from '../../src/types/category'
import { useFeedbackStore } from '../../src/stores/feedbackStore'
import Skeleton from '../../src/components/ui/Skeleton'
import { getCategoryAccent } from '../../src/lib/categoryVisuals'
import { analyticsService } from '../../src/services/analyticsService'

export default function GuideDetailsScreen() {
  const { id } = useLocalSearchParams()
  const guideId = Array.isArray(id) ? id[0] : id
  const cachedGuide = useSavedStore((state) =>
    guideId ? state.cachedGuides[guideId] : undefined
  )

  const {
    data: guide,
    isLoading,
    error,
    refetch,
    isRefetching,
  } = useGuide(guideId)
  const activeGuide = guide || cachedGuide
  const { data: categoryGuides = [] } = useGuides(activeGuide?.category_id)

  const isGuest = useSessionStore((state) => state.isGuest)
  const toggleSave = useSavedStore((state) => state.toggleSave)
  const saveGuide = useSavedStore((state) => state.save)
  const addToHistory = useHistoryStore((state) => state.addToHistory)
  const { language } = useSettingsStore()
  const { colors } = useTheme()
  const t = translations[language]
  const styles = createStyles(colors, colors.primary)
  const showFeedback = useFeedbackStore((state) => state.show)

  const isSaved = useSavedStore((state) =>
    activeGuide ? state.isSaved(activeGuide.id) : false
  )
  const isGuideSaved = useSavedStore((state) => state.isSaved)

  const getTitle = (item: Guide) =>
    language === 'fil' ? item.title_fil : item.title_en

  const getTagline = (item: Guide) =>
    language === 'fil' ? item.tagline_fil : item.tagline_en

  const getCategoryName = (item: Category) =>
    language === 'fil' ? item.name_fil : item.name_en

  const getSectionContent = (section: GuideSection) =>
    language === 'fil' ? section.content_fil : section.content_en

  const handleSave = () => {
    if (!activeGuide) return

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

    toggleSave(activeGuide)
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
    if (!activeGuide) return

    await Share.share({
      message: `${getTitle(activeGuide)}\n\n${getTagline(activeGuide)}\n\nDemoAlam`,
    })
  }

useEffect(() => {
  if (activeGuide) {
    addToHistory(activeGuide)
  }
}, [activeGuide?.id])

useEffect(() => {
  if (guide && isSaved) {
    saveGuide(guide)
  }
}, [guide?.id, isSaved])

  useEffect(() => {
    if (!guide?.id) {
      return
    }

    analyticsService.logGuideView(guide.id).catch(() => {
      // Analytics should never interrupt guide reading.
    })
  }, [guide?.id])

  if (isLoading && !cachedGuide) {
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

  if (!activeGuide) {
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

  const categoryColor = getCategoryAccent(activeGuide.category, colors.primary)
  const isShowingCachedGuide = !guide && !!cachedGuide
  const guideStyles = createStyles(
    colors,
    activeGuide.is_urgent ? colors.danger : categoryColor
  )
  const sections = [...(activeGuide.sections || [])].sort(
    (a: GuideSection, b: GuideSection) => (a.order_index || 0) - (b.order_index || 0)
  )
  const officialSources = activeGuide.official_sources || []
  const relatedGuides = categoryGuides
    .filter((item: Guide) => item.id !== activeGuide.id)
    .slice(0, 3)
  const updatedLabel = formatUpdatedDate(activeGuide.updated_at || activeGuide.published_at)
  const sectionContents = sections.map((section) => getSectionContent(section))
  const sourceCount = officialSources.length
  const stepCount = sections.filter((section) => section.section_type === 'step').length
  const warningCount = sections.filter((section) => section.section_type === 'warning').length
  const hasChecklist = sectionContents.some((content) => (content?.items?.length ?? 0) > 0)
  const hasSample = sectionContents.some((content) => Boolean(content?.sample))

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
              activeGuide.category
                ? getCategoryName(activeGuide.category)
                : language === 'fil'
                  ? 'Guide'
                  : 'Guide'
            }
            icon={activeGuide.category?.icon}
            color={categoryColor}
          />

          <SafeText variant="h1" color="surface" style={styles.title}>
            {getTitle(activeGuide)}
          </SafeText>

          <SafeText variant="body" color="surface" style={styles.tagline}>
            {getTagline(activeGuide)}
          </SafeText>

          <View style={styles.metaGrid}>
            <MetaPill
              icon="time-outline"
              label={`${activeGuide.read_time_min} ${language === 'fil' ? 'minuto' : 'min'}`}
            />
            {activeGuide.estimated_cost ? (
              <MetaPill icon="wallet-outline" label={activeGuide.estimated_cost} />
            ) : null}
            {activeGuide.difficulty ? (
              <MetaPill icon="speedometer-outline" label={activeGuide.difficulty} />
            ) : null}
          </View>
        </View>
      </View>

      {isShowingCachedGuide ? (
        <View style={styles.offlineCard}>
          <View style={styles.offlineIcon}>
            <Ionicons name="cloud-offline-outline" size={19} color={colors.warning} />
          </View>

          <View style={styles.offlineCopy}>
            <SafeText variant="label" color="warning" weight="700">
              {language === 'fil' ? 'Saved offline copy' : 'Saved offline copy'}
            </SafeText>

            <SafeText variant="bodyMd" color="muted" style={styles.offlineText}>
              {language === 'fil'
                ? 'Ito ang naka-save na version sa phone mo. Mag-online ulit para ma-refresh ang latest details.'
                : 'This is the version saved on your phone. Go online again to refresh the latest details.'}
            </SafeText>
          </View>
        </View>
      ) : null}

      {activeGuide.is_urgent ? (
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
            <Ionicons name="shield-checkmark" size={17} color={colors.primary} />
          </View>
          <View style={styles.trustCopy}>
            <SafeText variant="label" weight="700" style={styles.compactCardTitle}>
              {language === 'fil' ? 'Suriin muna' : 'Quick check'}
            </SafeText>
            <SafeText variant="caption" color="muted" style={styles.trustSubtitle}>
              {language === 'fil'
                ? 'Tingnan ang oras, gastos, at source bago kumilos.'
                : 'A quick check to avoid wasted time, money, or wrong steps.'}
            </SafeText>
          </View>
        </View>

        <View style={styles.trustGrid}>
          <TrustItem
            icon="calendar-outline"
            label={language === 'fil' ? 'Na-update' : 'Updated'}
            value={updatedLabel}
          />
          <TrustItem
            icon="shield-checkmark-outline"
            label={language === 'fil' ? 'Source' : 'Sources'}
            value={
              sourceCount > 0
                ? language === 'fil'
                  ? `${sourceCount} opisyal`
                  : `${sourceCount} official`
                : language === 'fil'
                  ? 'I-verify pa'
                  : 'Verify first'
            }
          />
          <TrustItem
            icon="time-outline"
            label={language === 'fil' ? 'Oras' : 'Time'}
            value={activeGuide.estimated_time || `${activeGuide.read_time_min} min`}
          />
          <TrustItem
            icon="wallet-outline"
            label={language === 'fil' ? 'Gastos' : 'Cost'}
            value={activeGuide.estimated_cost || (language === 'fil' ? 'Depende' : 'Varies')}
          />
          <TrustItem
            icon="speedometer-outline"
            label={language === 'fil' ? 'Antas' : 'Level'}
            value={activeGuide.difficulty || (language === 'fil' ? 'Madali' : 'Easy')}
          />
        </View>

        <View style={styles.completenessBlock}>
          <SafeText variant="label" weight="700" style={styles.completenessTitle}>
            {language === 'fil' ? 'Kumpleto ba?' : 'Completeness check'}
          </SafeText>

          <View style={styles.completenessGrid}>
            <CompletenessItem
              done={sourceCount > 0}
              label={language === 'fil' ? 'Opisyal na source' : 'Official sources'}
            />
            <CompletenessItem
              done={hasChecklist}
              label={language === 'fil' ? 'Checklist' : 'Checklist'}
            />
            <CompletenessItem
              done={hasSample}
              label={language === 'fil' ? 'Sample' : 'Sample'}
            />
            <CompletenessItem
              done={stepCount > 0}
              label={
                stepCount > 0
                  ? language === 'fil'
                    ? `${stepCount} hakbang`
                    : `${stepCount} steps`
                  : language === 'fil'
                    ? 'Hakbang'
                    : 'Steps'
              }
            />
            <CompletenessItem
              done={warningCount > 0}
              label={
                warningCount > 0
                  ? language === 'fil'
                    ? `${warningCount} babala`
                    : `${warningCount} warning`
                  : language === 'fil'
                    ? 'Babala'
                    : 'Warnings'
              }
            />
          </View>
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

      {officialSources.length > 0 ? (
        <View style={styles.sourceCard}>
          <View style={styles.sourceHeader}>
            <View style={styles.sourceIcon}>
              <Ionicons name="checkmark-done-circle" size={17} color={colors.success} />
            </View>

            <View style={styles.sourceCopy}>
              <SafeText variant="label" weight="700" style={styles.compactCardTitle}>
                {language === 'fil' ? 'Official na sources' : 'Official sources'}
              </SafeText>

              <SafeText variant="caption" color="muted" style={styles.sourceSubtitle}>
                {language === 'fil'
                  ? 'Helpful guide ito, pero official links pa rin ang final reference.'
                  : 'This guide helps you prepare; official links remain the final reference.'}
              </SafeText>
            </View>
          </View>

          <View style={styles.officialSources}>
            {officialSources.map((source) => (
              <OfficialSourceRow
                key={source.url}
                source={source}
              />
            ))}
          </View>
        </View>
      ) : null}

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
              {isShowingCachedGuide
                ? language === 'fil'
                  ? 'Summary pa lang ang naka-cache. Buksan ulit ito kapag online para ma-save ang buong guide.'
                  : 'Only the summary is cached. Open this again while online to save the full guide.'
                : language === 'fil'
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

    const icon: keyof typeof Ionicons.glyphMap = isWarning
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
    const checklistItems = content?.items || []
    const sample = content?.sample

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
              <Ionicons name={icon} size={19} color={color} />
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

        {checklistItems.length > 0 ? (
          <View style={styles.checklistBox}>
            <View style={styles.checklistHeader}>
              <SafeText variant="label" weight="700" style={styles.checklistTitle}>
                {language === 'fil' ? 'Checklist' : 'Checklist'}
              </SafeText>

              <SafeText variant="caption" color="muted">
                {checklistItems.length}
              </SafeText>
            </View>

            {checklistItems.map((item) => (
              <View key={item} style={styles.checklistRow}>
                <Ionicons name="checkmark-circle" size={16} color={colors.success} />
                <SafeText variant="bodyMd" color="muted" style={styles.checklistText}>
                  {item}
                </SafeText>
              </View>
            ))}
          </View>
        ) : null}

        {sample ? (
          <View style={styles.sampleBox}>
            <View style={styles.sampleHeader}>
              <Ionicons name="chatbox-ellipses-outline" size={16} color={colors.primary} />
              <SafeText variant="label" color="primary" weight="700">
                {language === 'fil' ? 'Sample na pwede itanong' : 'Sample you can ask'}
              </SafeText>
            </View>
            <SafeText variant="bodyMd" color="muted" style={styles.sampleText}>
              {sample}
            </SafeText>
          </View>
        ) : null}

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

  function getSectionLabel(type: GuideSectionType) {
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

  function CompletenessItem({
    done,
    label,
  }: {
    done: boolean
    label: string
  }) {
    return (
      <View
        style={[
          styles.completenessItem,
          done ? styles.completenessItemDone : styles.completenessItemPending,
        ]}
      >
        <Ionicons
          name={done ? 'checkmark-circle' : 'ellipse-outline'}
          size={15}
          color={done ? colors.success : colors.textLight}
        />
        <SafeText
          variant="caption"
          weight="700"
          style={{ color: done ? colors.success : colors.textMuted }}
          numberOfLines={1}
        >
          {label}
        </SafeText>
      </View>
    )
  }

  function OfficialSourceRow({
    source,
  }: {
    source: GuideOfficialSource
  }) {
    const openSource = () => {
      Linking.openURL(source.url).catch(() => {
        showFeedback(
          language === 'fil'
            ? 'Hindi mabuksan ang source ngayon'
            : 'Unable to open source right now',
          'info'
        )
      })
    }

    return (
      <TouchableOpacity
        activeOpacity={0.86}
        style={styles.officialSourceRow}
        onPress={openSource}
      >
        <View style={styles.sourceRowIcon}>
          <Ionicons name="open-outline" size={17} color={colors.primary} />
        </View>

        <View style={styles.sourceRowCopy}>
          <SafeText variant="bodyMd" weight="700" numberOfLines={1}>
            {source.title}
          </SafeText>
          {source.publisher ? (
            <SafeText variant="caption" color="muted" numberOfLines={1}>
              {source.publisher}
            </SafeText>
          ) : null}
        </View>

        <Ionicons name="chevron-forward" size={17} color={colors.textLight} />
      </TouchableOpacity>
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

const createStyles = (colors: ThemeColors, heroColor: string) =>
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
      paddingBottom: spacing.xl,
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
      maxWidth: 370,
    },

    tagline: {
      opacity: 0.9,
      maxWidth: 380,
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

    offlineCard: {
      marginHorizontal: spacing.md,
      marginTop: spacing.lg,
      borderRadius: 16,
      borderWidth: 1,
      borderColor: `${colors.warning}35`,
      backgroundColor: colors.warningLight,
      padding: spacing.md,
      flexDirection: 'row',
      gap: spacing.md,
    },

    offlineIcon: {
      width: 38,
      height: 38,
      borderRadius: 19,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
    },

    offlineCopy: {
      flex: 1,
    },

    offlineText: {
      marginTop: spacing.xs,
    },

    trustCard: {
      marginHorizontal: spacing.md,
      marginTop: spacing.md,
      borderRadius: 12,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.md,
    },

    trustHeader: {
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
      marginBottom: spacing.sm,
    },

    trustIcon: {
      width: 32,
      height: 32,
      borderRadius: 12,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
    },

    trustCopy: {
      flex: 1,
    },

    trustSubtitle: {
      marginTop: 1,
    },

    trustGrid: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.xs,
    },

    trustItem: {
      flexBasis: '48.8%',
      flexGrow: 1,
      minHeight: 66,
      borderRadius: 12,
      backgroundColor: colors.surfaceSecondary,
      padding: spacing.sm,
      justifyContent: 'space-between',
    },

    officialNote: {
      marginTop: spacing.sm,
      borderRadius: 12,
      backgroundColor: colors.warningLight,
      padding: spacing.sm,
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.sm,
    },

    officialText: {
      flex: 1,
    },

    completenessBlock: {
      marginTop: spacing.sm,
      borderRadius: 12,
      borderWidth: 1,
      borderColor: colors.border,
      backgroundColor: colors.surface,
      padding: spacing.sm,
    },

    completenessTitle: {
      textTransform: 'uppercase',
      marginBottom: spacing.sm,
    },

    completenessGrid: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.xs,
    },

    completenessItem: {
      minHeight: 30,
      borderRadius: 999,
      borderWidth: 1,
      paddingHorizontal: spacing.sm,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
    },

    completenessItemDone: {
      borderColor: `${colors.success}30`,
      backgroundColor: colors.successLight,
    },

    completenessItemPending: {
      borderColor: colors.border,
      backgroundColor: colors.surfaceSecondary,
    },

    sourceCard: {
      marginHorizontal: spacing.md,
      marginTop: spacing.md,
      borderRadius: 12,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.md,
    },

    sourceHeader: {
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
      marginBottom: spacing.sm,
    },

    sourceIcon: {
      width: 32,
      height: 32,
      borderRadius: 12,
      backgroundColor: colors.successLight,
      alignItems: 'center',
      justifyContent: 'center',
    },

    sourceCopy: {
      flex: 1,
    },

    sourceSubtitle: {
      marginTop: 1,
    },

    compactCardTitle: {
      textTransform: 'uppercase',
    },

    officialSources: {
      gap: spacing.sm,
    },

    sourceRow: {
      minHeight: 56,
      borderRadius: 14,
      backgroundColor: colors.surfaceSecondary,
      paddingHorizontal: spacing.md,
      paddingVertical: spacing.sm,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.md,
    },

    officialSourceRow: {
      minHeight: 50,
      borderRadius: 12,
      borderWidth: 1,
      borderColor: colors.border,
      backgroundColor: colors.surface,
      paddingHorizontal: spacing.sm,
      paddingVertical: spacing.sm,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    sourceRowIcon: {
      width: 30,
      height: 30,
      borderRadius: 15,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
    },

    sourceRowCopy: {
      flex: 1,
    },

    sectionContainer: {
      padding: spacing.md,
      paddingTop: spacing.md,
    },

    sectionCard: {
      backgroundColor: colors.surface,
      borderRadius: 14,
      borderWidth: 1,
      borderLeftWidth: 4,
      borderColor: colors.border,
      padding: spacing.md,
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
      gap: spacing.sm,
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

    checklistBox: {
      marginTop: spacing.md,
      borderRadius: 12,
      borderWidth: 1,
      borderColor: colors.border,
      backgroundColor: colors.surfaceSecondary,
      padding: spacing.md,
      gap: spacing.sm,
    },

    checklistHeader: {
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'space-between',
      gap: spacing.sm,
    },

    checklistTitle: {
      textTransform: 'uppercase',
    },

    checklistRow: {
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.sm,
    },

    checklistText: {
      flex: 1,
      lineHeight: 21,
    },

    sampleBox: {
      marginTop: spacing.md,
      borderRadius: 12,
      borderWidth: 1,
      borderColor: `${colors.primary}25`,
      backgroundColor: colors.primaryLight,
      padding: spacing.md,
      gap: spacing.sm,
    },

    sampleHeader: {
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    sampleText: {
      lineHeight: 22,
    },

    actionHint: {
      marginTop: spacing.md,
      borderRadius: 12,
      paddingHorizontal: spacing.md,
      paddingVertical: spacing.sm,
      backgroundColor: colors.surfaceSecondary,
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
