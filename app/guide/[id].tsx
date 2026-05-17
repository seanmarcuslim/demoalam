import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  ActivityIndicator,
  TouchableOpacity,
  Alert,
} from 'react-native'
import { useEffect } from 'react'
import { useLocalSearchParams, router } from 'expo-router'
import { useGuide } from '../../src/hooks/useGuides'
import { useSavedStore } from '../../src/stores/savedStore'
import { useHistoryStore } from '../../src/stores/historyStore'
import { useSessionStore } from '../../src/stores/sessionStore'
import { colors } from '../../src/theme/colors'
import { spacing } from '../../src/theme/spacing'
import { typography } from '../../src/theme/typography'

export default function GuideDetailsScreen() {
  const { id } = useLocalSearchParams()

  const guideId = Array.isArray(id) ? id[0] : id

  const { data: guide, isLoading, error } = useGuide(guideId)

  const isGuest = useSessionStore((state) => state.isGuest)
  const toggleSave = useSavedStore((state) => state.toggleSave)
  const addToHistory = useHistoryStore((state) => state.addToHistory)

  const isSaved = useSavedStore((state) =>
    guide ? state.isSaved(guide.id) : false
  )

  const handleSave = () => {
    if (!guide) return

    if (isGuest) {
      Alert.alert(
        'Login required',
        'Please login first to save guides.',
        [
          { text: 'Cancel', style: 'cancel' },
          {
            text: 'Login',
            onPress: () => router.push('/login'),
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

  if (isLoading) {
    return (
      <View style={styles.centered}>
        <ActivityIndicator size="large" color={colors.primary} />
        <Text style={styles.loadingText}>Naglo-load ng guide...</Text>
      </View>
    )
  }

  if (error || !guide) {
    return (
      <View style={styles.centered}>
        <Text style={styles.errorTitle}>May problema 😕</Text>
        <Text style={styles.errorText}>Hindi ma-load ang guide.</Text>
      </View>
    )
  }

  return (
    <ScrollView
      style={styles.container}
      contentContainerStyle={styles.content}
      showsVerticalScrollIndicator={false}
    >
      <View style={styles.header}>
        <Text style={styles.category}>
          {guide.category?.icon} {guide.category?.name_fil}
        </Text>

        <Text style={styles.title}>{guide.title_fil}</Text>

        <Text style={styles.tagline}>{guide.tagline_fil}</Text>

        <View style={styles.metaRow}>
          <Text style={styles.meta}>🕐 {guide.read_time_min} minuto</Text>

          {guide.is_urgent && (
            <Text style={styles.urgentBadge}>🚨 URGENT</Text>
          )}
        </View>

        <TouchableOpacity
          activeOpacity={0.85}
          style={[styles.saveButton, isSaved && styles.savedButton]}
          onPress={handleSave}
        >
          <Text style={styles.saveButtonText}>
            {isSaved ? '⭐ Saved' : isGuest ? '🔒 Login to Save' : '🤍 Save Guide'}
          </Text>
        </TouchableOpacity>
      </View>

      <View style={styles.sectionContainer}>
        {guide.sections && guide.sections.length > 0 ? (
          guide.sections.map((section: any, index: number) => (
            <View key={section.id || index} style={styles.sectionCard}>
              <Text style={styles.sectionTitle}>
                {section.title_fil || `Section ${index + 1}`}
              </Text>

              <Text style={styles.sectionContent}>
                {section.content_fil || 'Walang content.'}
              </Text>
            </View>
          ))
        ) : (
          <View style={styles.sectionCard}>
            <Text style={styles.sectionContent}>
              Wala pang available na content para sa guide na ito.
            </Text>
          </View>
        )}
      </View>
    </ScrollView>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },

  content: {
    paddingBottom: spacing.xxl,
  },

  centered: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: spacing.xl,
    backgroundColor: colors.background,
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
  },

  errorText: {
    ...typography.body,
    color: colors.textMuted,
    textAlign: 'center',
  },

  header: {
    backgroundColor: colors.primary,
    padding: spacing.lg,
    paddingTop: spacing.xxl,
    borderBottomLeftRadius: 28,
    borderBottomRightRadius: 28,
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
    backgroundColor: 'rgba(255,255,255,0.15)',
    paddingVertical: spacing.md,
    borderRadius: 14,
    alignItems: 'center',
  },

  savedButton: {
    backgroundColor: 'rgba(255,255,255,0.25)',
  },

  saveButtonText: {
    ...typography.body,
    color: colors.surface,
    fontWeight: '700',
  },

  sectionContainer: {
    padding: spacing.md,
  },

  sectionCard: {
    backgroundColor: colors.surface,
    borderRadius: 18,
    padding: spacing.lg,
    marginBottom: spacing.md,

    elevation: 3,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
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