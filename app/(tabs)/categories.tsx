import {
  ActivityIndicator,
  FlatList,
  RefreshControl,
  StyleSheet,
  TouchableOpacity,
  View,
} from 'react-native'
import { router } from 'expo-router'
import { Ionicons } from '@expo/vector-icons'
import { useCategories } from '../../src/hooks/useCategories'
import { useGuides } from '../../src/hooks/useGuides'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { translations } from '../../src/utils/translations'
import { useTheme } from '../../src/hooks/useTheme'
import { spacing } from '../../src/theme/spacing'
import SafeText from '../../src/components/ui/SafeText'
import Skeleton from '../../src/components/ui/Skeleton'

const CATEGORY_COPY: Record<
  string,
  {
    en: string
    fil: string
    accent: string
  }
> = {
  ids: {
    en: 'Valid IDs, documents, and first-time requirements',
    fil: 'Valid IDs, dokumento, at first-time requirements',
    accent: '#1A6BCC',
  },
  work: {
    en: 'Job hunting, requirements, interviews, and workplace basics',
    fil: 'Trabaho, requirements, interview, at workplace basics',
    accent: '#188038',
  },
  money: {
    en: 'Banking, e-wallets, fees, loans, and everyday money moves',
    fil: 'Bank, e-wallet, fees, utang, at pang-araw-araw na pera',
    accent: '#F5A623',
  },
  gov: {
    en: 'Government forms, benefits, offices, and appointments',
    fil: 'Government forms, benefits, opisina, at appointments',
    accent: '#6F42C1',
  },
  scams: {
    en: 'Red flags before sending money or personal information',
    fil: 'Warning signs bago magpadala ng pera o personal info',
    accent: '#D93025',
  },
  emergency: {
    en: 'Fast actions for urgent documents, safety, and help',
    fil: 'Mabilis na steps para sa urgent documents, safety, at tulong',
    accent: '#E37400',
  },
  adulting: {
    en: 'Practical life tasks no one explained clearly',
    fil: 'Practical life tasks na bihirang ipaliwanag nang malinaw',
    accent: '#00897B',
  },
}

export default function CategoriesScreen() {
  const {
    data: categories = [],
    isLoading,
    refetch,
    isRefetching,
  } = useCategories()
  const { data: guides = [] } = useGuides()

  const { language } = useSettingsStore()
  const { colors } = useTheme()
  const t = translations[language]
  const styles = createStyles(colors)

  const openCategory = (id: string, name: string) => {
    router.push({
      pathname: '/category/[id]',
      params: { id, name },
    })
  }

  const getCategoryName = (cat: any) =>
    language === 'fil' ? cat.name_fil : cat.name_en

  const getSecondaryName = (cat: any) =>
    language === 'fil' ? cat.name_en : cat.name_fil

  const getCategoryDescription = (cat: any) => {
    const copy = CATEGORY_COPY[cat.slug]
    if (!copy) {
      return language === 'fil'
        ? 'Mga practical guide para sa topic na ito'
        : 'Practical guides for this topic'
    }

    return language === 'fil' ? copy.fil : copy.en
  }

  const getGuideCount = (categoryId: string) =>
    guides.filter((guide) => guide.category_id === categoryId).length

  const getCountLabel = (count: number) => {
    if (count === 0) {
      return language === 'fil' ? 'Coming soon' : 'Coming soon'
    }

    if (count === 1) {
      return language === 'fil' ? '1 guide' : '1 guide'
    }

    return `${count} guides`
  }

  const renderHeader = () => (
    <View>
      <View style={styles.hero}>
        <View style={styles.heroIcon}>
          <Ionicons name="albums" size={24} color={colors.primary} />
        </View>
        <SafeText variant="h1" color="surface">
          {t.categories} 📚
        </SafeText>
        <SafeText variant="bodyMd" color="surface" style={styles.subtitle}>
          {language === 'fil'
            ? 'Pitong practical na lugar para magsimula kapag hindi mo alam ang unang step.'
            : 'Seven practical starting points when you do not know the first step yet.'}
        </SafeText>

        <View style={styles.statRow}>
          <View style={styles.statPill}>
            <SafeText variant="label" color="surface">
              {categories.length || 7} {language === 'fil' ? 'categories' : 'categories'}
            </SafeText>
          </View>
          <View style={styles.statPill}>
            <SafeText variant="label" color="surface">
              {language === 'fil' ? 'Mobile-first' : 'Mobile-first'}
            </SafeText>
          </View>
        </View>
      </View>

      <View style={styles.sectionIntro}>
        <SafeText variant="h3" weight="700">
          {language === 'fil' ? 'Piliin ang kailangan mo' : 'Choose what you need'}
        </SafeText>
        <SafeText variant="caption" color="muted" style={styles.introText}>
          {language === 'fil'
            ? 'Bawat banner ay shortcut papunta sa focused guides.'
            : 'Each banner is a shortcut into focused guides.'}
        </SafeText>
      </View>
    </View>
  )

  return (
    <FlatList
      data={isLoading ? [] : categories}
      keyExtractor={(item) => item.id}
      ListHeaderComponent={renderHeader}
      ListEmptyComponent={
        isLoading ? (
          <View style={styles.loadingCard}>
            {Array.from({ length: 4 }).map((_, index) => (
              <View key={index} style={styles.skeletonBanner}>
                <Skeleton width={66} height={66} radius={22} />
                <View style={styles.skeletonCopy}>
                  <Skeleton width="60%" height={22} />
                  <Skeleton width="88%" height={16} style={styles.skeletonLine} />
                  <Skeleton width={90} height={22} radius={999} style={styles.skeletonLine} />
                </View>
              </View>
            ))}
          </View>
        ) : (
          <View style={styles.emptyCard}>
            <View style={styles.emptyIcon}>
              <Ionicons name="file-tray-outline" size={30} color={colors.primary} />
            </View>
            <SafeText variant="h3" weight="700" style={styles.emptyTitle}>
              {language === 'fil' ? 'Walang categories' : 'No categories'}
            </SafeText>
            <SafeText variant="bodyMd" color="muted" style={styles.emptyText}>
              {language === 'fil'
                ? 'Wala pang available na categories.'
                : 'No categories available yet.'}
            </SafeText>
          </View>
        )
      }
      contentContainerStyle={styles.content}
      refreshControl={
        <RefreshControl
          refreshing={isRefetching}
          onRefresh={refetch}
          colors={[colors.primary]}
        />
      }
      showsVerticalScrollIndicator={false}
      renderItem={({ item, index }) => {
        const accent = CATEGORY_COPY[item.slug]?.accent || item.color || colors.primary
        const guideCount = getGuideCount(item.id)
        const hasGuides = guideCount > 0

        return (
          <TouchableOpacity
            activeOpacity={hasGuides ? 0.88 : 0.72}
            style={[
              styles.banner,
              {
                borderColor: `${accent}35`,
                opacity: hasGuides ? 1 : 0.72,
              },
            ]}
            onPress={() => openCategory(item.id, getCategoryName(item))}
          >
            <View style={[styles.bannerStripe, { backgroundColor: accent }]} />

            <View style={[styles.iconContainer, { backgroundColor: `${accent}18` }]}>
              <SafeText style={styles.categoryIcon}>{item.icon}</SafeText>
            </View>

            <View style={styles.bannerCopy}>
              <View style={styles.bannerTitleRow}>
                <SafeText
                  variant="h3"
                  weight="700"
                  numberOfLines={1}
                  style={{ color: accent }}
                >
                  {getCategoryName(item)}
                </SafeText>
                <SafeText variant="caption" color="light">
                  {String(index + 1).padStart(2, '0')}
                </SafeText>
              </View>

              <SafeText variant="caption" color="muted" numberOfLines={1}>
                {getSecondaryName(item)}
              </SafeText>

              <SafeText
                variant="bodyMd"
                color="muted"
                numberOfLines={2}
                style={styles.description}
              >
                {getCategoryDescription(item)}
              </SafeText>

              <View
                style={[
                  styles.countPill,
                  {
                    backgroundColor: hasGuides
                      ? `${accent}16`
                      : colors.surfaceSecondary,
                  },
                ]}
              >
                <SafeText
                  variant="caption"
                  weight="700"
                  style={{ color: hasGuides ? accent : colors.textMuted }}
                >
                  {getCountLabel(guideCount)}
                </SafeText>
              </View>
            </View>

            <View
              style={[
                styles.arrowButton,
                {
                  backgroundColor: hasGuides
                    ? colors.primaryLight
                    : colors.surfaceSecondary,
                },
              ]}
            >
              <Ionicons
                name={hasGuides ? 'arrow-forward' : 'time-outline'}
                size={18}
                color={hasGuides ? colors.primary : colors.textLight}
              />
            </View>
          </TouchableOpacity>
        )
      }}
    />
  )
}

const createStyles = (colors: any) =>
  StyleSheet.create({
    content: {
      backgroundColor: colors.background,
      paddingBottom: 140,
    },

    hero: {
      backgroundColor: colors.primary,
      paddingHorizontal: spacing.lg,
      paddingTop: spacing.xxl,
      paddingBottom: spacing.lg,
      borderBottomLeftRadius: 28,
      borderBottomRightRadius: 28,
    },

    heroIcon: {
      width: 50,
      height: 50,
      borderRadius: 16,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
      marginBottom: spacing.md,
    },

    subtitle: {
      opacity: 0.9,
      marginTop: spacing.sm,
      maxWidth: 340,
    },

    statRow: {
      flexDirection: 'row',
      gap: spacing.sm,
      marginTop: spacing.lg,
    },

    statPill: {
      borderRadius: 999,
      borderWidth: 1,
      borderColor: 'rgba(255,255,255,0.28)',
      paddingHorizontal: spacing.md,
      paddingVertical: spacing.sm,
      backgroundColor: 'rgba(255,255,255,0.12)',
    },

    sectionIntro: {
      paddingHorizontal: spacing.md,
      paddingTop: spacing.lg,
      paddingBottom: spacing.md,
    },

    introText: {
      marginTop: spacing.xs,
    },

    banner: {
      marginHorizontal: spacing.md,
      marginBottom: spacing.md,
      minHeight: 132,
      borderRadius: 18,
      borderWidth: 1,
      backgroundColor: colors.surface,
      overflow: 'hidden',
      flexDirection: 'row',
      alignItems: 'center',
      padding: spacing.md,
      elevation: 2,
      shadowColor: colors.shadow,
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.07,
      shadowRadius: 5,
    },

    bannerStripe: {
      position: 'absolute',
      left: 0,
      top: 0,
      bottom: 0,
      width: 5,
    },

    iconContainer: {
      width: 66,
      height: 66,
      borderRadius: 22,
      alignItems: 'center',
      justifyContent: 'center',
      marginRight: spacing.md,
    },

    categoryIcon: {
      fontSize: 32,
    },

    bannerCopy: {
      flex: 1,
      minWidth: 0,
    },

    bannerTitleRow: {
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'space-between',
      gap: spacing.sm,
    },

    description: {
      marginTop: spacing.sm,
    },

    countPill: {
      alignSelf: 'flex-start',
      borderRadius: 999,
      paddingHorizontal: spacing.sm,
      paddingVertical: spacing.xs,
      marginTop: spacing.sm,
    },

    arrowButton: {
      width: 38,
      height: 38,
      borderRadius: 19,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
      marginLeft: spacing.sm,
    },

    loadingCard: {
      margin: spacing.md,
      borderRadius: 16,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.xl,
      alignItems: 'center',
    },

    skeletonBanner: {
      width: '100%',
      borderRadius: 16,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.md,
      marginBottom: spacing.md,
      flexDirection: 'row',
      alignItems: 'center',
      backgroundColor: colors.surface,
    },

    skeletonCopy: {
      flex: 1,
      marginLeft: spacing.md,
    },

    skeletonLine: {
      marginTop: spacing.sm,
    },

    loadingText: {
      marginTop: spacing.md,
    },

    emptyCard: {
      margin: spacing.md,
      borderRadius: 18,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.xl,
      alignItems: 'center',
    },

    emptyIcon: {
      width: 64,
      height: 64,
      borderRadius: 32,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
      marginBottom: spacing.md,
    },

    emptyTitle: {
      textAlign: 'center',
      marginBottom: spacing.sm,
    },

    emptyText: {
      textAlign: 'center',
    },
  })
