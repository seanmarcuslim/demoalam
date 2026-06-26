import { Ionicons } from '@expo/vector-icons'
import { router } from 'expo-router'
import { useMemo, useState } from 'react'
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
import { getGuideTitle } from '../../src/lib/guideDisplay'
import { evaluateTrustScenario } from '../../src/lib/trustShield/evaluateTrustScenario'
import { trustShieldScenarios } from '../../src/lib/trustShield/rules'
import type { RiskLevel, TrustScenarioId } from '../../src/lib/trustShield/types'
import { useSettingsStore } from '../../src/stores/settingsStore'
import type { ThemeColors } from '../../src/theme/colors'
import { spacing } from '../../src/theme/spacing'
import type { Guide } from '../../src/types/guide'

export default function TrustShieldScreen() {
  const { language } = useSettingsStore()
  const { colors } = useTheme()
  const { data: guides = [] } = useGuides()
  const [selectedScenarioId, setSelectedScenarioId] =
    useState<TrustScenarioId | null>(null)

  const styles = createStyles(colors)
  const decision = selectedScenarioId
    ? evaluateTrustScenario(selectedScenarioId, language)
    : null
  const guideMap = useMemo(() => {
    return guides.reduce<Record<string, Guide>>((items, guide) => {
      items[guide.slug] = guide
      return items
    }, {})
  }, [guides])

  const openGuideBySlug = (slug: string) => {
    const guide = guideMap[slug]

    if (!guide) {
      router.push({
        pathname: '/search',
        params: { q: slug.replace(/-/g, ' ') },
      })
      return
    }

    router.push({
      pathname: '/guide/[id]',
      params: { id: guide.id },
    })
  }

  const riskMeta = getRiskMeta(decision?.riskLevel, language, colors)

  return (
    <View style={styles.container}>
      <AppHeader
        title={language === 'fil' ? 'Trust Shield' : 'Trust Shield'}
        subtitle={
          language === 'fil'
            ? 'Suriin muna bago maniwala, mag-click, magbayad, o mag-share.'
            : 'Check before you believe, click, pay, or share.'
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

        <AppCard style={styles.heroCard}>
          <View style={styles.iconCircle}>
            <Ionicons
              name="shield-checkmark-outline"
              size={28}
              color={colors.primary}
            />
          </View>

          <SafeText variant="h2" weight="700" style={styles.cardTitle}>
            {language === 'fil'
              ? 'Ano ang kailangan mong i-check?'
              : 'What do you need to check?'}
          </SafeText>

          <SafeText variant="body" color="muted" style={styles.cardBody}>
            {language === 'fil'
              ? 'Pumili ng sitwasyon. Bibigyan ka ng risk level, dahilan, at unang dapat gawin.'
              : 'Choose a situation. DemoAlam will show the risk level, why it matters, and what to do first.'}
          </SafeText>
        </AppCard>

        <View style={styles.scenarioList}>
          {trustShieldScenarios.map((scenario) => {
            const isSelected = selectedScenarioId === scenario.id
            return (
              <TouchableOpacity
                key={scenario.id}
                activeOpacity={0.84}
                style={[
                  styles.scenarioCard,
                  isSelected ? styles.scenarioCardSelected : null,
                ]}
                onPress={() => setSelectedScenarioId(scenario.id)}
                accessibilityRole="button"
              >
                <View style={styles.scenarioIcon}>
                  <Ionicons
                    name={getScenarioIcon(scenario.id)}
                    size={20}
                    color={colors.primary}
                  />
                </View>

                <View style={styles.scenarioCopy}>
                  <SafeText variant="body" weight="700">
                    {language === 'fil' ? scenario.label_fil : scenario.label_en}
                  </SafeText>

                  <SafeText variant="caption" color="muted" numberOfLines={2}>
                    {language === 'fil' ? scenario.short_fil : scenario.short_en}
                  </SafeText>
                </View>

                <Ionicons
                  name={isSelected ? 'checkmark-circle' : 'chevron-forward'}
                  size={20}
                  color={isSelected ? colors.success : colors.primary}
                />
              </TouchableOpacity>
            )
          })}
        </View>

        {decision ? (
          <View>
            <AppCard style={styles.resultCard}>
              <View
                style={[
                  styles.riskPill,
                  { backgroundColor: riskMeta.backgroundColor },
                ]}
              >
                <Ionicons
                  name={riskMeta.icon}
                  size={15}
                  color={riskMeta.color}
                />
                <SafeText
                  variant="caption"
                  weight="700"
                  style={{ color: riskMeta.color }}
                  numberOfLines={1}
                >
                  {riskMeta.label}
                </SafeText>
              </View>

              <SafeText variant="h2" weight="700" style={styles.resultTitle}>
                {decision.situation}
              </SafeText>

              <View style={styles.explainBox}>
                <SafeText variant="bodyMd" weight="700">
                  {language === 'fil' ? 'Bakit delikado?' : 'Why this is risky'}
                </SafeText>
                <SafeText variant="bodyMd" color="muted" style={styles.cardBody}>
                  {decision.why}
                </SafeText>
              </View>

              <DecisionList
                title={language === 'fil' ? 'Warning signs' : 'Warning signs'}
                items={decision.warningSigns}
                icon="warning-outline"
                iconColor={colors.warning}
              />

              <DecisionList
                title={language === 'fil' ? 'Gawin ngayon' : 'What to do now'}
                items={decision.recommendedAction}
                icon="checkmark-circle"
                iconColor={colors.success}
              />

              {decision.recoverySteps && decision.recoverySteps.length > 0 ? (
                <DecisionList
                  title={
                    language === 'fil'
                      ? 'Kung may naibigay ka na'
                      : 'If you already acted'
                  }
                  items={decision.recoverySteps}
                  icon="medkit-outline"
                  iconColor={colors.danger}
                />
              ) : null}

              {decision.shareText ? (
                <View style={styles.shareBox}>
                  <Ionicons
                    name="megaphone-outline"
                    size={18}
                    color={colors.accent}
                  />
                  <SafeText
                    variant="bodyMd"
                    color="muted"
                    style={styles.shareText}
                  >
                    {decision.shareText}
                  </SafeText>
                </View>
              ) : null}
            </AppCard>

            <AppCard>
              <SafeText variant="h3" weight="700">
                {language === 'fil' ? 'Kaugnay na gabay' : 'Related guides'}
              </SafeText>

              <View style={styles.relatedList}>
                {decision.relatedGuides.map((slug) => {
                  const guide = guideMap[slug]
                  return (
                    <TouchableOpacity
                      key={slug}
                      activeOpacity={0.84}
                      style={styles.relatedItem}
                      onPress={() => openGuideBySlug(slug)}
                      accessibilityRole="button"
                    >
                      <View style={styles.relatedCopy}>
                        <SafeText variant="bodyMd" weight="700" numberOfLines={2}>
                          {guide ? getGuideTitle(guide, language) : readableSlug(slug)}
                        </SafeText>
                        <SafeText variant="caption" color="muted" numberOfLines={1}>
                          {guide
                            ? language === 'fil'
                              ? guide.tagline_fil
                              : guide.tagline_en
                            : language === 'fil'
                              ? 'Hanapin ang gabay'
                              : 'Find this guide'}
                        </SafeText>
                      </View>

                      <Ionicons
                        name="chevron-forward"
                        size={18}
                        color={colors.primary}
                      />
                    </TouchableOpacity>
                  )
                })}
              </View>
            </AppCard>

            <AppCard>
              <SafeText variant="h3" weight="700">
                {language === 'fil' ? 'Saan i-verify' : 'Where to verify'}
              </SafeText>

              <View style={styles.sourceList}>
                {decision.sources.map((source) => (
                  <View key={source} style={styles.sourceRow}>
                    <Ionicons
                      name="shield-outline"
                      size={15}
                      color={colors.primary}
                    />
                    <SafeText variant="bodyMd" color="muted" style={styles.listText}>
                      {source}
                    </SafeText>
                  </View>
                ))}
              </View>
            </AppCard>

            <View style={styles.resultActions}>
              <AppButton
                title={language === 'fil' ? 'Pumili ulit' : 'Check another'}
                variant="secondary"
                onPress={() => setSelectedScenarioId(null)}
                style={styles.secondaryAction}
              />
              <AppButton
                title={language === 'fil' ? 'Maghanap ng gabay' : 'Search guides'}
                variant="secondary"
                onPress={() => router.push('/search')}
                style={styles.secondaryAction}
              />
            </View>
          </View>
        ) : null}
      </ScrollView>
    </View>
  )
}

function DecisionList({
  title,
  items,
  icon,
  iconColor,
}: {
  title: string
  items: string[]
  icon: keyof typeof Ionicons.glyphMap
  iconColor: string
}) {
  const { colors } = useTheme()
  const styles = createStyles(colors)

  return (
    <View style={styles.decisionBlock}>
      <SafeText variant="bodyMd" weight="700">
        {title}
      </SafeText>

      <View style={styles.list}>
        {items.map((item) => (
          <View key={item} style={styles.listRow}>
            <Ionicons name={icon} size={15} color={iconColor} />
            <SafeText variant="bodyMd" color="muted" style={styles.listText}>
              {item}
            </SafeText>
          </View>
        ))}
      </View>
    </View>
  )
}

function getScenarioIcon(id: TrustScenarioId): keyof typeof Ionicons.glyphMap {
  switch (id) {
    case 'otp_request':
      return 'keypad-outline'
    case 'advance_payment':
      return 'cash-outline'
    case 'suspicious_link':
      return 'link-outline'
    case 'bank_ewallet_message':
      return 'chatbubble-ellipses-outline'
  }
}

function getRiskMeta(
  riskLevel: RiskLevel | undefined,
  language: 'en' | 'fil',
  colors: ThemeColors
) {
  if (riskLevel === 'HIGH_RISK') {
    return {
      label: language === 'fil' ? 'Mataas ang risk' : 'High risk',
      color: colors.danger,
      backgroundColor: colors.dangerLight,
      icon: 'alert-circle' as const,
    }
  }

  if (riskLevel === 'VERIFY_FIRST') {
    return {
      label: language === 'fil' ? 'I-verify muna' : 'Verify first',
      color: colors.warning,
      backgroundColor: colors.warningLight,
      icon: 'warning' as const,
    }
  }

  return {
    label: language === 'fil' ? 'Mababang risk' : 'Low risk',
    color: colors.success,
    backgroundColor: colors.successLight,
    icon: 'checkmark-circle' as const,
  }
}

function readableSlug(slug: string) {
  return slug
    .split('-')
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ')
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
      width: 54,
      height: 54,
      borderRadius: 27,
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

    scenarioList: {
      gap: spacing.sm,
      marginBottom: spacing.md,
    },

    scenarioCard: {
      minHeight: 76,
      borderRadius: 16,
      borderWidth: 1,
      borderColor: colors.border,
      backgroundColor: colors.surface,
      padding: spacing.md,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.md,
    },

    scenarioCardSelected: {
      borderColor: colors.primary,
      backgroundColor: colors.primaryLight,
    },

    scenarioIcon: {
      width: 42,
      height: 42,
      borderRadius: 21,
      backgroundColor: colors.surfaceSecondary,
      alignItems: 'center',
      justifyContent: 'center',
    },

    scenarioCopy: {
      flex: 1,
      gap: spacing.xs,
    },

    resultCard: {
      padding: spacing.lg,
    },

    riskPill: {
      alignSelf: 'flex-start',
      borderRadius: 999,
      paddingHorizontal: spacing.sm,
      paddingVertical: spacing.xs,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
      marginBottom: spacing.md,
    },

    resultTitle: {
      marginBottom: spacing.md,
    },

    explainBox: {
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.border,
      backgroundColor: colors.surfaceSecondary,
      padding: spacing.md,
      marginBottom: spacing.md,
    },

    decisionBlock: {
      borderTopWidth: 1,
      borderTopColor: colors.border,
      paddingTop: spacing.md,
      marginTop: spacing.md,
      gap: spacing.sm,
    },

    list: {
      gap: spacing.sm,
    },

    listRow: {
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.sm,
    },

    listText: {
      flex: 1,
    },

    shareBox: {
      marginTop: spacing.md,
      borderRadius: 14,
      backgroundColor: colors.accentLight,
      padding: spacing.md,
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.sm,
    },

    shareText: {
      flex: 1,
    },

    relatedList: {
      marginTop: spacing.md,
      gap: spacing.sm,
    },

    relatedItem: {
      minHeight: 58,
      borderRadius: 12,
      borderWidth: 1,
      borderColor: colors.border,
      backgroundColor: colors.surfaceSecondary,
      padding: spacing.sm,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    relatedCopy: {
      flex: 1,
      gap: spacing.xs,
    },

    sourceList: {
      marginTop: spacing.md,
      gap: spacing.sm,
    },

    sourceRow: {
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.sm,
    },

    resultActions: {
      gap: spacing.sm,
      marginBottom: spacing.md,
    },

    secondaryAction: {
      alignSelf: 'stretch',
    },
  })
