import { StyleSheet, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'

import SafeText from '../ui/SafeText'
import { spacing } from '../../theme/spacing'
import type { ThemeColors } from '../../theme/colors'
import type { TranslationMessages } from '../../utils/translations'
import GuideCompletenessItem from './GuideCompletenessItem'
import GuideTrustItem from './GuideTrustItem'

type GuideDetailLabels = TranslationMessages['guideDetail']

interface GuideTrustSummaryCardProps {
  colors: ThemeColors
  labels: GuideDetailLabels
  updatedLabel: string
  sourceCount: number
  timeLabel: string
  costLabel: string
  difficultyLabel: string
  hasChecklist: boolean
  hasSample: boolean
  stepCount: number
  warningCount: number
}

export default function GuideTrustSummaryCard({
  colors,
  labels,
  updatedLabel,
  sourceCount,
  timeLabel,
  costLabel,
  difficultyLabel,
  hasChecklist,
  hasSample,
  stepCount,
  warningCount,
}: GuideTrustSummaryCardProps) {
  const styles = createStyles(colors)
  const stepCountLabel =
    stepCount === 1 ? labels.stepCountSingular : labels.stepCountPlural
  const warningCountLabel =
    warningCount === 1 ? labels.warningCountSingular : labels.warningCountPlural

  return (
    <View style={styles.card}>
      <View style={styles.header}>
        <View style={styles.icon}>
          <Ionicons name="shield-checkmark" size={17} color={colors.primary} />
        </View>
        <View style={styles.copy}>
          <SafeText variant="label" weight="700" style={styles.compactTitle}>
            {labels.quickCheck}
          </SafeText>
          <SafeText variant="caption" color="muted" style={styles.subtitle}>
            {labels.quickCheckSubtitle}
          </SafeText>
        </View>
      </View>

      <View style={styles.trustGrid}>
        <GuideTrustItem
          icon="calendar-outline"
          label={labels.updated}
          value={updatedLabel}
        />
        <GuideTrustItem
          icon="shield-checkmark-outline"
          label={labels.sources}
          value={
            sourceCount > 0
              ? `${sourceCount} ${labels.officialSourceCount}`
              : labels.verifyFirst
          }
        />
        <GuideTrustItem
          icon="time-outline"
          label={labels.time}
          value={timeLabel}
        />
        <GuideTrustItem
          icon="wallet-outline"
          label={labels.cost}
          value={costLabel}
        />
        <GuideTrustItem
          icon="speedometer-outline"
          label={labels.level}
          value={difficultyLabel}
        />
      </View>

      <View style={styles.completenessBlock}>
        <SafeText variant="label" weight="700" style={styles.completenessTitle}>
          {labels.guideIncludes}
        </SafeText>

        <View style={styles.completenessGrid}>
          <GuideCompletenessItem
            done={sourceCount > 0}
            label={labels.sources}
          />
          <GuideCompletenessItem
            done={hasChecklist}
            label={labels.checklist}
          />
          <GuideCompletenessItem
            done={hasSample}
            label={labels.sample}
          />
          <GuideCompletenessItem
            done={stepCount > 0}
            label={
              stepCount > 0
                ? `${stepCount} ${stepCountLabel}`
                : labels.stepsFallback
            }
          />
          <GuideCompletenessItem
            done={warningCount > 0}
            label={
              warningCount > 0
                ? `${warningCount} ${warningCountLabel}`
                : labels.warningFallback
            }
          />
        </View>
      </View>

      {sourceCount === 0 ? (
        <View style={styles.officialNote}>
          <Ionicons name="information-circle" size={17} color={colors.warning} />
          <SafeText variant="caption" color="muted" style={styles.officialText}>
            {labels.officialVerificationNote}
          </SafeText>
        </View>
      ) : null}
    </View>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    card: {
      marginHorizontal: spacing.md,
      marginTop: spacing.md,
      borderRadius: 14,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.sm,
    },

    header: {
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
      marginBottom: spacing.xs,
    },

    icon: {
      width: 32,
      height: 32,
      borderRadius: 12,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
    },

    copy: {
      flex: 1,
    },

    subtitle: {
      marginTop: 1,
    },

    trustGrid: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.xs,
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
      backgroundColor: colors.surfaceSecondary,
      padding: spacing.sm,
    },

    completenessTitle: {
      textTransform: 'uppercase',
      marginBottom: spacing.xs,
    },

    completenessGrid: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.xs,
    },

    compactTitle: {
      textTransform: 'uppercase',
    },
  })
