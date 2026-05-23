import { memo } from 'react'
import { StyleSheet, TouchableOpacity, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'
import { Guide } from '../../types/guide'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import { ThemeColors } from '../../theme/colors'
import { getCategoryAccent } from '../../lib/categoryVisuals'
import SafeText from '../ui/SafeText'
import Badge from '../ui/Badge'
import { useFeedbackStore } from '../../stores/feedbackStore'

interface GuideCardProps {
  guide: Guide
  language: 'en' | 'fil'
  isSaved: boolean
  onPress: () => void
  onSave: () => void
  compact?: boolean
}

function GuideCard({
  guide,
  language,
  isSaved,
  onPress,
  onSave,
  compact = false,
}: GuideCardProps) {
  const { colors } = useTheme()
  const showFeedback = useFeedbackStore((state) => state.show)
  const styles = createStyles(colors, guide.is_urgent, compact)
  const title = language === 'fil' ? guide.title_fil : guide.title_en
  const tagline = language === 'fil' ? guide.tagline_fil : guide.tagline_en
  const categoryName = guide.category
    ? language === 'fil'
      ? guide.category.name_fil
      : guide.category.name_en
    : ''
  const categoryColor = getCategoryAccent(guide.category, colors.primary)
  const accentColor = guide.is_urgent ? colors.danger : categoryColor
  const officialSourceCount = guide.official_sources?.length ?? 0
  const hasOfficialSources = officialSourceCount > 0
  const sourceLabel =
    officialSourceCount > 1
      ? `${officialSourceCount} sources`
      : language === 'fil'
        ? 'May source'
        : 'Verified'
  const urgentLabel = language === 'fil' ? 'Babala' : 'Scam Alert'

  const handleSave = () => {
    onSave()
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

  return (
    <TouchableOpacity
      activeOpacity={0.86}
      style={styles.card}
      onPress={onPress}
    >
      <View style={[styles.accentBar, { backgroundColor: accentColor }]} />

      <View style={styles.topRow}>
        <Badge
          label={guide.is_urgent ? urgentLabel : categoryName}
          icon={guide.is_urgent ? '🚨' : guide.category?.icon}
          color={accentColor}
        />

        <TouchableOpacity
          hitSlop={10}
          style={[
            styles.saveButton,
            isSaved && styles.saveButtonActive,
          ]}
          onPress={handleSave}
        >
          <Ionicons
            name={isSaved ? 'bookmark' : 'bookmark-outline'}
            size={20}
            color={isSaved ? colors.accent : colors.textMuted}
          />
        </TouchableOpacity>
      </View>

      <SafeText
        variant={compact ? 'body' : 'h3'}
        weight="700"
        numberOfLines={2}
        style={styles.title}
      >
        {title}
      </SafeText>

      <SafeText
        variant="bodyMd"
        color="muted"
        numberOfLines={2}
        style={styles.tagline}
      >
        {tagline}
      </SafeText>

      <View style={styles.footer}>
        <View style={styles.meta}>
          <Ionicons name="time-outline" size={15} color={colors.textLight} />
          <SafeText variant="caption" color="light">
            {guide.read_time_min} {language === 'fil' ? 'minuto' : 'min'}
          </SafeText>

          {hasOfficialSources ? (
            <View style={styles.sourcePill}>
              <Ionicons
                name="shield-checkmark"
                size={13}
                color={colors.success}
              />
              <SafeText
                variant="caption"
                weight="700"
                style={{ color: colors.success }}
              >
                {sourceLabel}
              </SafeText>
            </View>
          ) : null}
        </View>

        <View style={styles.action}>
          <SafeText variant="caption" color="primary" weight="700">
            {language === 'fil' ? 'Basahin' : 'Read'}
          </SafeText>
          <Ionicons name="arrow-forward" size={15} color={colors.primary} />
        </View>
      </View>
    </TouchableOpacity>
  )
}

const createStyles = (colors: ThemeColors, urgent: boolean, compact: boolean) =>
  StyleSheet.create({
    card: {
      backgroundColor: colors.surface,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: urgent ? `${colors.danger}55` : colors.border,
      padding: spacing.md,
      marginBottom: spacing.md,
      minHeight: compact ? 136 : 164,
      overflow: 'hidden',
      elevation: 3,
      shadowColor: colors.shadow,
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.08,
      shadowRadius: 6,
    },

    accentBar: {
      position: 'absolute',
      left: 0,
      top: 0,
      bottom: 0,
      width: 4,
    },

    topRow: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'flex-start',
      gap: spacing.sm,
    },

    saveButton: {
      width: 36,
      height: 36,
      borderRadius: 18,
      alignItems: 'center',
      justifyContent: 'center',
      backgroundColor: colors.surfaceSecondary,
    },

    saveButtonActive: {
      backgroundColor: colors.accentLight,
    },

    title: {
      marginTop: spacing.md,
      marginBottom: spacing.xs,
    },

    tagline: {
      marginBottom: spacing.md,
    },

    footer: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
      marginTop: 'auto',
    },

    meta: {
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
      flexWrap: 'wrap',
      flex: 1,
      paddingRight: spacing.sm,
    },

    sourcePill: {
      minHeight: 24,
      borderRadius: 999,
      backgroundColor: colors.successLight,
      paddingHorizontal: spacing.sm,
      flexDirection: 'row',
      alignItems: 'center',
      gap: 3,
    },

    action: {
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.xs,
    },
  })

export default memo(GuideCard)
