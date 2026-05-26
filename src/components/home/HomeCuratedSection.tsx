import { ScrollView, StyleSheet, View } from 'react-native'

import type { Guide } from '../../types/guide'
import type { Language } from '../../utils/translations'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import type { ThemeColors } from '../../theme/colors'
import SafeText from '../ui/SafeText'
import GuideCard from '../guide/GuideCard'

interface HomeCuratedSectionProps {
  title: string
  subtitle: string
  items: Guide[]
  language: Language
  priorityPillLabel: string
  isSaved: (id: string) => boolean
  onOpenGuide: (id: string) => void
  onSaveGuide: (guide: Guide) => void
  icon?: string
  priority?: boolean
}

export default function HomeCuratedSection({
  title,
  subtitle,
  items,
  language,
  priorityPillLabel,
  isSaved,
  onOpenGuide,
  onSaveGuide,
  icon = '',
  priority = false,
}: HomeCuratedSectionProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors)

  if (items.length === 0) {
    return null
  }

  return (
    <View style={styles.section}>
      <View style={[styles.headerRow, priority && styles.priorityHeaderRow]}>
        <View>
          {priority ? (
            <View style={styles.priorityPill}>
              <SafeText variant="caption" color="primary" weight="700">
                {priorityPillLabel}
              </SafeText>
            </View>
          ) : null}

          <SafeText variant="h3" weight="700">
            {icon ? `${icon} ${title}` : title}
          </SafeText>
          <SafeText variant="caption" color="muted" style={styles.subtitle}>
            {subtitle}
          </SafeText>
        </View>
      </View>

      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.curatedRow}
      >
        {items.map((guide) => (
          <View key={guide.id} style={styles.cardWrap}>
            <GuideCard
              guide={guide}
              language={language}
              isSaved={isSaved(guide.id)}
              onPress={() => onOpenGuide(guide.id)}
              onSave={() => onSaveGuide(guide)}
              compact
            />
          </View>
        ))}
      </ScrollView>
    </View>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    section: {
      paddingHorizontal: spacing.md,
      paddingTop: spacing.lg,
    },

    headerRow: {
      marginBottom: spacing.md,
    },

    priorityHeaderRow: {
      borderLeftWidth: 4,
      borderLeftColor: colors.primary,
      paddingLeft: spacing.sm,
    },

    priorityPill: {
      alignSelf: 'flex-start',
      minHeight: 24,
      borderRadius: 999,
      backgroundColor: colors.primaryLight,
      paddingHorizontal: spacing.sm,
      justifyContent: 'center',
      marginBottom: spacing.xs,
    },

    subtitle: {
      marginTop: spacing.xs,
    },

    curatedRow: {
      paddingRight: spacing.md,
      gap: spacing.sm,
    },

    cardWrap: {
      width: 286,
    },
  })
