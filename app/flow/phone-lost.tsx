import { Ionicons } from '@expo/vector-icons'
import { router } from 'expo-router'
import { useEffect, useMemo, useRef, useState } from 'react'
import {
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  View,
} from 'react-native'
import AppButton from '../../src/components/ui/AppButton'
import AppCard from '../../src/components/ui/AppCard'
import AppHeader from '../../src/components/ui/AppHeader'
import SafeText from '../../src/components/ui/SafeText'
import { useGuides } from '../../src/hooks/useGuides'
import { useTheme } from '../../src/hooks/useTheme'
import { useSettingsStore } from '../../src/stores/settingsStore'
import {
  getLocalizedValue,
  getPhoneLostOutcome,
  phoneLostFlow,
  type PhoneLostAnswers,
  type PhoneLostQuestion,
} from '../../src/lib/decisionFlows/phoneLostFlow'
import { analyticsService } from '../../src/services/analyticsService'
import type { ThemeColors } from '../../src/theme/colors'
import { spacing } from '../../src/theme/spacing'
import type { Guide } from '../../src/types/guide'

export default function PhoneLostFlowScreen() {
  const { language } = useSettingsStore()
  const { colors } = useTheme()
  const { data: guides = [] } = useGuides()

  const [started, setStarted] = useState(false)
  const [currentIndex, setCurrentIndex] = useState(0)
  const [answers, setAnswers] = useState<PhoneLostAnswers>({})
  const [showResult, setShowResult] = useState(false)
  const [openingRecommendedGuide, setOpeningRecommendedGuide] = useState(false)
  const loggedOutcomeId = useRef<string | null>(null)
  const loggedRecommendedGuideOpen = useRef(false)

  const styles = createStyles(colors)
  const currentQuestion = phoneLostFlow.questions[currentIndex]
  const result = useMemo(() => getPhoneLostOutcome(answers), [answers])
  const guideMap = useMemo(() => {
    return guides.reduce<Record<string, Guide>>((items, guide) => {
      items[guide.slug] = guide
      return items
    }, {})
  }, [guides])

  useEffect(() => {
    if (!showResult || loggedOutcomeId.current === result.outcome.id) {
      return
    }

    loggedOutcomeId.current = result.outcome.id

    analyticsService.logFlowEvent({
      flowSlug: 'phone-lost',
      eventName: 'flow_outcome_shown',
      outcomeId: result.outcome.id,
      language,
    }).catch(() => {
      // Analytics should never interrupt the flow.
    })
  }, [language, result.outcome.id, showResult])

  const openGuideBySlug = (slug: string, trackRecommendedGuide = false) => {
    const guide = guideMap[slug]

    if (!guide) {
      router.push('/search')
      return
    }

    if (trackRecommendedGuide && !loggedRecommendedGuideOpen.current) {
      loggedRecommendedGuideOpen.current = true
      setOpeningRecommendedGuide(true)

      analyticsService.logFlowEvent({
        flowSlug: 'phone-lost',
        eventName: 'flow_guide_opened',
        outcomeId: result.outcome.id,
        guideSlug: slug,
        language,
      }).catch(() => {
        // Analytics should never interrupt guide routing.
      })
    }

    router.push({
      pathname: '/guide/[id]',
      params: { id: guide.id },
    })
  }

  const handleAnswer = (question: PhoneLostQuestion, optionId: string) => {
    setAnswers((currentAnswers) => ({
      ...currentAnswers,
      [question.id]: optionId,
    }))

    if (currentIndex >= phoneLostFlow.questions.length - 1) {
      analyticsService.logFlowEvent({
        flowSlug: 'phone-lost',
        eventName: 'flow_completed',
        language,
      }).catch(() => {
        // Analytics should never interrupt the flow.
      })

      setShowResult(true)
      return
    }

    setCurrentIndex((value) => value + 1)
  }

  const restart = () => {
    setStarted(false)
    setCurrentIndex(0)
    setAnswers({})
    setShowResult(false)
    setOpeningRecommendedGuide(false)
    loggedOutcomeId.current = null
    loggedRecommendedGuideOpen.current = false
  }

  const renderIntro = () => (
    <AppCard style={styles.heroCard}>
      <View style={styles.iconCircle}>
        <Ionicons
          name="phone-portrait-outline"
          size={26}
          color={colors.primary}
        />
      </View>

      <SafeText variant="h2" weight="700" style={styles.cardTitle}>
        {getLocalizedValue(phoneLostFlow, 'title', language)}
      </SafeText>

      <SafeText variant="body" color="muted" style={styles.cardBody}>
        {getLocalizedValue(phoneLostFlow, 'intro', language)}
      </SafeText>

      <AppButton
        title={getLocalizedValue(phoneLostFlow, 'cta', language)}
        onPress={() => setStarted(true)}
        style={styles.primaryAction}
      />
    </AppCard>
  )

  const renderQuestion = () => {
    const progress = `${currentIndex + 1}/${phoneLostFlow.questions.length}`

    return (
      <AppCard style={styles.questionCard}>
        <View style={styles.progressRow}>
          <SafeText variant="caption" color="primary" weight="700">
            {language === 'fil' ? 'Mabilisang check' : 'Quick check'}
          </SafeText>

          <SafeText variant="caption" color="muted">
            {progress}
          </SafeText>
        </View>

        <SafeText variant="h3" weight="700" style={styles.questionText}>
          {getLocalizedValue(currentQuestion, 'question', language)}
        </SafeText>

        <View style={styles.optionList}>
          {currentQuestion.options.map((option) => (
            <TouchableOpacity
              key={option.id}
              activeOpacity={0.84}
              style={styles.optionCard}
              onPress={() => handleAnswer(currentQuestion, option.id)}
              accessibilityRole="button"
            >
              <SafeText variant="body" weight="700" style={styles.optionText}>
                {getLocalizedValue(option, 'label', language)}
              </SafeText>

              <Ionicons
                name="chevron-forward"
                size={18}
                color={colors.primary}
              />
            </TouchableOpacity>
          ))}
        </View>
      </AppCard>
    )
  }

  const renderResult = () => {
    const outcome = result.outcome
    const reasons = language === 'fil' ? result.reason_fil : result.reason_en
    const primaryGuide = guideMap[outcome.primary_guide_slug]
    const priorityLabel =
      outcome.priority === 'HIGH'
        ? language === 'fil'
          ? 'Mataas'
          : 'High'
        : language === 'fil'
          ? 'Katamtaman'
          : 'Medium'
    const relatedGuides = outcome.related_guide_slugs
      .map((slug) => guideMap[slug])
      .filter(Boolean)

    return (
      <View>
        <AppCard style={styles.resultCard}>
          <View
            style={[
              styles.priorityPill,
              outcome.priority === 'HIGH'
                ? styles.priorityHigh
                : styles.priorityMedium,
            ]}
          >
            <SafeText
              variant="caption"
              weight="700"
              numberOfLines={1}
              style={styles.priorityText}
            >
              {priorityLabel}
            </SafeText>
          </View>

          <SafeText
            variant="caption"
            color="muted"
            weight="700"
            style={styles.eyebrow}
          >
            {language === 'fil' ? 'Unang hakbang' : 'First action'}
          </SafeText>

          <SafeText variant="h2" weight="700" style={styles.resultTitle}>
            {getLocalizedValue(outcome, 'first_action', language)}
          </SafeText>

          <View style={styles.explainBox}>
            <SafeText variant="bodyMd" weight="700">
              {language === 'fil'
                ? 'Bakit ito ang recommendation?'
                : 'Why this recommendation?'}
            </SafeText>

            {reasons.map((reason) => (
              <View key={reason} style={styles.reasonRow}>
                <Ionicons
                  name="checkmark-circle"
                  size={16}
                  color={colors.success}
                />
                <SafeText
                  variant="bodyMd"
                  color="muted"
                  style={styles.reasonText}
                >
                  {reason}
                </SafeText>
              </View>
            ))}
          </View>

          <SafeText variant="bodyMd" color="muted" style={styles.cardBody}>
            {getLocalizedValue(outcome, 'why', language)}
          </SafeText>

          {outcome.safety_warning_en ? (
            <View style={styles.warningBox}>
              <Ionicons
                name="warning-outline"
                size={18}
                color={colors.warning}
              />
              <SafeText
                variant="bodyMd"
                color="warning"
                weight="700"
                style={styles.warningText}
              >
                {getLocalizedValue(outcome, 'safety_warning', language)}
              </SafeText>
            </View>
          ) : null}

          <AppButton
            title={
              primaryGuide
                ? language === 'fil'
                  ? 'Buksan ang gabay'
                  : 'Open recommended guide'
                : language === 'fil'
                  ? 'Maghanap ng gabay'
                  : 'Find in Search'
            }
            onPress={() => openGuideBySlug(outcome.primary_guide_slug, true)}
            disabled={openingRecommendedGuide}
            style={styles.primaryAction}
          />
        </AppCard>

        {relatedGuides.length > 0 ? (
          <AppCard>
            <SafeText variant="h3" weight="700">
              {language === 'fil' ? 'Kaugnay na gabay' : 'Related guides'}
            </SafeText>

            <View style={styles.relatedList}>
              {relatedGuides.map((guide) => (
                <TouchableOpacity
                  key={guide.id}
                  activeOpacity={0.84}
                  style={styles.relatedItem}
                  onPress={() => openGuideBySlug(guide.slug)}
                  accessibilityRole="button"
                >
                  <View style={styles.relatedCopy}>
                    <SafeText variant="bodyMd" weight="700" numberOfLines={2}>
                      {language === 'fil' ? guide.title_fil : guide.title_en}
                    </SafeText>

                    <SafeText variant="caption" color="muted" numberOfLines={1}>
                      {language === 'fil' ? guide.tagline_fil : guide.tagline_en}
                    </SafeText>
                  </View>

                  <Ionicons
                    name="chevron-forward"
                    size={18}
                    color={colors.primary}
                  />
                </TouchableOpacity>
              ))}
            </View>
          </AppCard>
        ) : null}

        <View style={styles.resultActions}>
          <AppButton
            title={language === 'fil' ? 'Ulitin ang check' : 'Restart check'}
            variant="secondary"
            onPress={restart}
            style={styles.secondaryAction}
          />

          <AppButton
            title={language === 'fil' ? 'Bumalik sa paghahanap' : 'Back to Search'}
            variant="secondary"
            onPress={() => router.push('/search')}
            style={styles.secondaryAction}
          />
        </View>
      </View>
    )
  }

  return (
    <View style={styles.container}>
      <AppHeader
        title={language === 'fil' ? 'Check sa nawawalang phone' : 'First-hour check'}
        subtitle={
          language === 'fil'
            ? 'Alamin ang uunahin.'
            : 'Choose the safest first step.'
        }
      />

      <ScrollView
        contentContainerStyle={styles.content}
        showsVerticalScrollIndicator={false}
      >
        <TouchableOpacity
          activeOpacity={0.82}
          style={styles.backButton}
          onPress={() => router.back()}
          accessibilityRole="button"
        >
          <Ionicons name="arrow-back" size={18} color={colors.primary} />
          <SafeText variant="bodyMd" color="primary" weight="700">
            {language === 'fil' ? 'Bumalik' : 'Back'}
          </SafeText>
        </TouchableOpacity>

        {!started
          ? renderIntro()
          : showResult
            ? renderResult()
            : renderQuestion()}
      </ScrollView>
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
      padding: spacing.md,
      paddingBottom: 120,
    },

    backButton: {
      minHeight: 40,
      alignSelf: 'flex-start',
      borderRadius: 999,
      paddingHorizontal: spacing.sm,
      marginBottom: spacing.sm,
      backgroundColor: colors.primaryLight,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
    },

    heroCard: {
      padding: spacing.lg,
    },

    iconCircle: {
      width: 52,
      height: 52,
      borderRadius: 26,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
      marginBottom: spacing.md,
    },

    cardTitle: {
      marginBottom: spacing.sm,
    },

    cardBody: {
      marginTop: spacing.sm,
    },

    primaryAction: {
      marginTop: spacing.lg,
      alignSelf: 'stretch',
    },

    questionCard: {
      padding: spacing.lg,
    },

    progressRow: {
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'space-between',
      gap: spacing.md,
      marginBottom: spacing.md,
    },

    questionText: {
      marginBottom: spacing.lg,
    },

    optionList: {
      gap: spacing.sm,
    },

    optionCard: {
      minHeight: 56,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.border,
      backgroundColor: colors.surfaceSecondary,
      padding: spacing.md,
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'space-between',
      gap: spacing.md,
    },

    optionText: {
      flex: 1,
    },

    resultCard: {
      padding: spacing.lg,
    },

    priorityPill: {
      alignSelf: 'flex-start',
      maxWidth: '100%',
      minHeight: 32,
      borderRadius: 999,
      paddingHorizontal: spacing.sm,
      alignItems: 'center',
      justifyContent: 'center',
      marginBottom: spacing.md,
    },

    priorityHigh: {
      backgroundColor: colors.danger,
    },

    priorityMedium: {
      backgroundColor: colors.warning,
    },

    priorityText: {
      color: '#FFFFFF',
      flexShrink: 1,
    },

    eyebrow: {
      textTransform: 'uppercase',
    },

    resultTitle: {
      marginTop: spacing.xs,
    },

    explainBox: {
      borderRadius: 14,
      backgroundColor: colors.surfaceSecondary,
      padding: spacing.md,
      marginTop: spacing.lg,
      gap: spacing.sm,
    },

    reasonRow: {
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.sm,
    },

    reasonText: {
      flex: 1,
    },

    warningBox: {
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.warning,
      backgroundColor: colors.warningLight,
      padding: spacing.md,
      marginTop: spacing.md,
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.sm,
    },

    warningText: {
      flex: 1,
    },

    relatedList: {
      marginTop: spacing.md,
      gap: spacing.sm,
    },

    relatedItem: {
      minHeight: 62,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.border,
      backgroundColor: colors.surfaceSecondary,
      padding: spacing.md,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    relatedCopy: {
      flex: 1,
    },

    resultActions: {
      gap: spacing.sm,
      marginBottom: spacing.lg,
    },

    secondaryAction: {
      alignSelf: 'stretch',
      backgroundColor: colors.surface,
    },
  })
