import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  ActivityIndicator,
} from 'react-native'
import { useLocalSearchParams, router } from 'expo-router'
import { useGuides } from '../../src/hooks/useGuides'
import { colors } from '../../src/theme/colors'
import { spacing } from '../../src/theme/spacing'
import { typography } from '../../src/theme/typography'

export default function CategoryDetailsScreen() {
  const { id, name } = useLocalSearchParams()

  const categoryId = Array.isArray(id) ? id[0] : id
  const categoryName = Array.isArray(name) ? name[0] : name

  const { data: guides, isLoading } = useGuides(categoryId)

  const openGuide = (guideId: string) => {
    router.push({
      pathname: '/guide/[id]',
      params: { id: guideId },
    })
  }

  if (isLoading) {
    return (
      <View style={styles.centered}>
        <ActivityIndicator size="large" color={colors.primary} />
        <Text style={styles.loadingText}>Naglo-load...</Text>
      </View>
    )
  }

  return (
    <ScrollView
      style={styles.container}
      contentContainerStyle={styles.content}
    >
      <View style={styles.header}>
        <Text style={styles.title}>
          {categoryName || 'Category'}
        </Text>

        <Text style={styles.subtitle}>
          Mga guides sa kategoryang ito
        </Text>
      </View>

      <View style={styles.guidesContainer}>
        {guides && guides.length > 0 ? (
          guides.map((guide) => (
            <TouchableOpacity
              key={guide.id}
              activeOpacity={0.85}
              style={styles.card}
              onPress={() => openGuide(guide.id)}
            >
              <Text style={styles.cardCategory}>
                {guide.category?.icon} {guide.category?.name_fil}
              </Text>

              <Text style={styles.cardTitle}>
                {guide.title_fil}
              </Text>

              <Text style={styles.cardTagline}>
                {guide.tagline_fil}
              </Text>

              <View style={styles.cardFooter}>
                <Text style={styles.readTime}>
                  🕐 {guide.read_time_min} minuto
                </Text>

                <Text style={styles.openText}>
                  Buksan →
                </Text>
              </View>
            </TouchableOpacity>
          ))
        ) : (
          <Text style={styles.emptyText}>
            Wala pang guides sa category na ito.
          </Text>
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
    backgroundColor: colors.background,
  },

  loadingText: {
    ...typography.body,
    color: colors.textMuted,
    marginTop: spacing.md,
  },

  header: {
    backgroundColor: colors.primary,
    padding: spacing.lg,
    paddingTop: spacing.xxl,
    borderBottomLeftRadius: 24,
    borderBottomRightRadius: 24,
  },

  title: {
    ...typography.h1,
    color: colors.surface,
  },

  subtitle: {
    ...typography.body,
    color: colors.primaryLight,
    marginTop: spacing.xs,
  },

  guidesContainer: {
    padding: spacing.md,
  },

  card: {
    backgroundColor: colors.surface,
    borderRadius: 16,
    padding: spacing.md,
    marginBottom: spacing.md,

    elevation: 3,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 4,
  },

  cardCategory: {
    ...typography.caption,
    color: colors.textMuted,
    marginBottom: spacing.xs,
  },

  cardTitle: {
    ...typography.h3,
    color: colors.text,
    marginBottom: spacing.xs,
  },

  cardTagline: {
    ...typography.body,
    color: colors.textMuted,
    marginBottom: spacing.md,
  },

  cardFooter: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },

  readTime: {
    ...typography.caption,
    color: colors.textLight,
  },

  openText: {
    ...typography.caption,
    color: colors.primary,
    fontWeight: '700',
  },

  emptyText: {
    ...typography.body,
    color: colors.textMuted,
    textAlign: 'center',
    padding: spacing.xl,
  },
})