import { StyleSheet, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'

import type { GuideSection, GuideSectionType } from '../../types/guide'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import type { ThemeColors } from '../../theme/colors'
import SafeText from '../ui/SafeText'
import ChecklistBlock from './ChecklistBlock'
import SampleBlock from './SampleBlock'

export interface GuideSectionCardLabels {
  avoid: string
  checkFirst: string
  commonTimeWaster: string
  doBeforeMovingOn: string
  step: string
  tip: string
  tipToMakeEasier: string
  warning: string
  whatToKnow: string
}

interface GuideSectionCardProps {
  section: GuideSection
  index: number
  title: string
  body: string
  language: 'en' | 'fil'
  labels: GuideSectionCardLabels
}

export default function GuideSectionCard({
  section,
  index,
  title,
  body,
  language,
  labels,
}: GuideSectionCardProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors)
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

  const content = language === 'fil' ? section.content_fil : section.content_en
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
        styles.card,
        toneStyle,
        {
          borderLeftColor: color,
        },
      ]}
    >
      <View style={styles.header}>
        <View style={[styles.icon, { backgroundColor: `${color}18` }]}>
          {isStep ? (
            <SafeText variant="label" weight="700" style={{ color }}>
              {stepNumber}
            </SafeText>
          ) : (
            <Ionicons name={icon} size={19} color={color} />
          )}
        </View>

        <View style={styles.titleWrap}>
          <View style={styles.labelRow}>
            <SafeText variant="label" weight="700" style={{ color }}>
              {getSectionLabel(type, labels)}
            </SafeText>
            {isWarning ? (
              <SafeText variant="label" color="danger" weight="700">
                {labels.checkFirst}
              </SafeText>
            ) : null}
          </View>

          <SafeText variant="h3" weight="700">
            {title}
          </SafeText>
        </View>
      </View>

      <SafeText variant="body" color="muted" style={styles.body}>
        {body}
      </SafeText>

      <ChecklistBlock items={checklistItems} language={language} />

      <SampleBlock sample={sample} language={language} />

      {isStep ? (
        <View style={styles.actionHint}>
          <Ionicons name="checkmark-circle" size={17} color={colors.success} />
          <SafeText variant="caption" color="muted" weight="700">
            {labels.doBeforeMovingOn}
          </SafeText>
        </View>
      ) : null}

      {isMistake ? (
        <View style={styles.actionHint}>
          <Ionicons name="alert-circle" size={17} color={colors.warning} />
          <SafeText variant="caption" color="muted" weight="700">
            {labels.commonTimeWaster}
          </SafeText>
        </View>
      ) : null}

      {isTip ? (
        <View style={styles.actionHint}>
          <Ionicons name="sparkles" size={17} color={colors.success} />
          <SafeText variant="caption" color="muted" weight="700">
            {labels.tipToMakeEasier}
          </SafeText>
        </View>
      ) : null}
    </View>
  )
}

function getSectionLabel(
  type: GuideSectionType,
  labels: GuideSectionCardLabels
) {
  if (type === 'step') return labels.step
  if (type === 'warning') return labels.warning
  if (type === 'mistake') return labels.avoid
  if (type === 'tip') return labels.tip
  return labels.whatToKnow
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    card: {
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

    header: {
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.sm,
      marginBottom: spacing.md,
    },

    icon: {
      width: 40,
      height: 40,
      borderRadius: 20,
      alignItems: 'center',
      justifyContent: 'center',
    },

    titleWrap: {
      flex: 1,
    },

    labelRow: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
      gap: spacing.sm,
      marginBottom: spacing.xs,
    },

    body: {
      lineHeight: 24,
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
  })
