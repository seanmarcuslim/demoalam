import { Linking, StyleSheet, TouchableOpacity, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'

import SafeText from '../ui/SafeText'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import type { ThemeColors } from '../../theme/colors'

interface OfficialSource {
  title: string
  url: string
}

interface OfficialSourcesBlockProps {
  sources?: OfficialSource[]
  language: 'en' | 'fil'
}

export default function OfficialSourcesBlock({
  sources,
  language,
}: OfficialSourcesBlockProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors)

  if (!sources?.length) {
    return null
  }

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Ionicons
          name="shield-checkmark"
          size={18}
          color={colors.success}
        />

        <SafeText variant="label" weight="700" style={styles.title}>
          {language === 'fil'
            ? 'Opisyal na sanggunian'
            : 'Official sources'}
        </SafeText>
      </View>

      {sources.map((source, index) => (
        <TouchableOpacity
          key={`${source.url}-${index}`}
          style={styles.linkCard}
          activeOpacity={0.8}
          onPress={() => Linking.openURL(source.url)}
        >
          <View style={styles.linkContent}>
            <Ionicons
              name="open-outline"
              size={18}
              color={colors.primary}
            />

            <View style={styles.textContainer}>
              <SafeText variant="bodyMd" weight="600">
                {source.title}
              </SafeText>

              <SafeText
                variant="caption"
                color="muted"
                numberOfLines={1}
              >
                {source.url}
              </SafeText>
            </View>
          </View>
        </TouchableOpacity>
      ))}
    </View>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      marginTop: spacing.lg,
      gap: spacing.md,
    },

    header: {
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
    },

    title: {
      color: colors.text,
    },

    linkCard: {
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.border,
      backgroundColor: colors.surfaceSecondary,
      padding: spacing.md,
    },

    linkContent: {
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.md,
    },

    textContainer: {
      flex: 1,
      gap: 2,
    },
  })
