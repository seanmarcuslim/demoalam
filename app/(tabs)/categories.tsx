import {
  FlatList,
  RefreshControl,
  StyleSheet,
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
import type { ThemeColors } from '../../src/theme/colors'
import SafeText from '../../src/components/ui/SafeText'
import Skeleton from '../../src/components/ui/Skeleton'
import AppCard from '../../src/components/ui/AppCard'
import AppButton from '../../src/components/ui/AppButton'
import EmptyState from '../../src/components/ui/EmptyState'
import { Category, CategoryCopy } from '../../src/types/category'
import { getCategoryAccent } from '../../src/lib/categoryVisuals'

const CATEGORY_COPY: Record<string, CategoryCopy> = {
  ids: {
    en: 'Valid IDs, documents, and first-time requirements',
    fil: 'Valid IDs, dokumento, at first-time requirements',
    accent: '#2563A9',
  },
  work: {
    en: 'Job hunting, requirements, interviews, and workplace basics',
    fil: 'Trabaho, requirements, interview, at workplace basics',
    accent: '#267A4D',
  },
  money: {
    en: 'Banking, e-wallets, fees, loans, and everyday money moves',
    fil: 'Bank, e-wallet, fees, utang, at pang-araw-araw na pera',
    accent: '#D9902F',
  },
  gov: {
    en: 'Aid, benefits, forms, offices, and appointments',
    fil: 'Ayuda, benefits, forms, opisina, at appointments',
    accent: '#6D5BA8',
  },
  healthcare: {
    en: 'Medical access, benefits, hospital documents, and patient support',
    fil: 'Medical access, benefits, hospital documents, at patient support',
    accent: '#2F8F83',
  },
  education: {
    en: 'Scholarships, school documents, student aid, and learning pathways',
    fil: 'Scholarships, school documents, student aid, at learning pathways',
    accent: '#4F73C7',
  },
  scams: {
    en: 'Red flags before sending money or personal information',
    fil: 'Warning signs bago magpadala ng pera o personal info',
    accent: '#C83E3A',
  },
  'digital-safety': {
    en: 'Protect accounts, e-wallets, passwords, phones, and online identity',
    fil: 'Proteksyon sa accounts, e-wallets, passwords, phone, at online identity',
    accent: '#3A7CA5',
  },
  emergency: {
    en: 'Fast actions for urgent documents, safety, and help',
    fil: 'Mabilis na steps para sa urgent documents, safety, at tulong',
    accent: '#B86B16',
  },
  adulting: {
    en: 'Practical life tasks no one explained clearly',
    fil: 'Practical life tasks na bihirang ipaliwanag nang malinaw',
    accent: '#2F8277',
  },
}

export default function CategoriesScreen() {
  const {
    data: categories = [],
    isLoading,
    isError,
    refetch,
    isRefetching,
  } = useCategories()

  const { data: guides = [] } = useGuides()

  const { language } = useSettingsStore()
  const { colors } = useTheme()

  const t = translations[language]
  const styles = createStyles(colors)
  const categoryTotal = categories.length || Object.keys(CATEGORY_COPY).length

  const openCategory = (id: string, name: string) => {
    router.push({
      pathname: '/category/[id]',
      params: { id, name },
    })
  }

  const getCategoryName = (cat: Category) =>
    language === 'fil' ? cat.name_fil : cat.name_en

  const getSecondaryName = (cat: Category) =>
    language === 'fil' ? cat.name_en : cat.name_fil

  const getCategoryDescription = (cat: Category) => {
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
    if (count === 0) return language === 'fil' ? 'Susunod' : 'Coming soon'
    if (count === 1) return language === 'fil' ? '1 gabay' : '1 guide'
    return language === 'fil' ? `${count} gabay` : `${count} guides`
  }

  const renderHeader = () => (
    <View>
      <View style={styles.hero}>
        <View style={styles.heroGlow} />

        <View style={styles.heroTop}>
          <View style={styles.heroIcon}>
            <Ionicons name="albums" size={25} color={colors.primary} />
          </View>

          <View style={styles.heroCopy}>
            <SafeText variant="h1" color="surface">
              {t.categories}
            </SafeText>

            <SafeText
              variant="bodyMd"
              color="surface"
              style={styles.heroSubtitle}
            >
              {language === 'fil'
                ? 'Hanapin ang tamang guide bago pumila, magbayad, o magbigay ng personal info.'
                : 'Find the right guide before you line up, pay, or share personal information.'}
            </SafeText>
          </View>
        </View>

        <View style={styles.statRow}>
          <View style={styles.statPill}>
            <SafeText variant="label" color="surface">
              {language === 'fil'
                ? `${categoryTotal} paksa`
                : `${categoryTotal} topics`}
            </SafeText>
          </View>

          <View style={styles.statPill}>
            <SafeText variant="label" color="surface">
              {language === 'fil' ? 'Praktikal' : 'Practical'}
            </SafeText>
          </View>
        </View>
      </View>

      <View style={styles.sectionIntro}>
        <SafeText variant="h3" weight="700">
          {language === 'fil'
            ? 'Piliin ang kailangan mo'
            : 'Choose what you need'}
        </SafeText>

        <SafeText variant="caption" color="muted" style={styles.introText}>
          {language === 'fil'
            ? 'Mas mabilis magsimula kapag malinaw ang topic.'
            : 'A clear topic makes the next step easier.'}
        </SafeText>
      </View>
    </View>
  )

  return (
    <FlatList<Category>
      data={isLoading ? [] : categories}
      keyExtractor={(item) => item.id}
      ListHeaderComponent={renderHeader}
      ListEmptyComponent={
        isLoading ? (
          <AppCard style={styles.loadingCard}>
            {Array.from({ length: 4 }).map((_, index) => (
              <View key={index} style={styles.skeletonBanner}>
                <Skeleton width={66} height={66} radius={22} />

                <View style={styles.skeletonCopy}>
                  <Skeleton width="60%" height={22} />
                  <Skeleton
                    width="88%"
                    height={16}
                    style={styles.skeletonLine}
                  />
                  <Skeleton
                    width={90}
                    height={22}
                    radius={999}
                    style={styles.skeletonLine}
                  />
                </View>
              </View>
            ))}
          </AppCard>
        ) : isError ? (
          <AppCard style={styles.emptyCard}>
            <EmptyState
              icon="!"
              title={
                language === 'fil'
                  ? 'Hindi ma-load ang categories'
                  : 'Unable to load categories'
              }
              subtitle={
                language === 'fil'
                  ? 'I-check ang internet connection o subukan ulit.'
                  : 'Check your internet connection or try again.'
              }
            />

            <AppButton
              title={language === 'fil' ? 'Subukan ulit' : 'Try again'}
              onPress={() => refetch()}
              style={styles.emptyAction}
            />
          </AppCard>
        ) : (
          <AppCard style={styles.emptyCard}>
            <EmptyState
              icon="📭"
              title={
                language === 'fil'
                  ? 'Walang categories'
                  : 'No categories'
              }
              subtitle={
                language === 'fil'
                  ? 'Wala pang available na categories.'
                  : 'No categories available yet.'
              }
            />
          </AppCard>
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
        const accent =
          CATEGORY_COPY[item.slug]?.accent || getCategoryAccent(item, colors.primary)

        const guideCount = getGuideCount(item.id)
        const hasGuides = guideCount > 0
        const position = String(index + 1).padStart(2, '0')

        return (
          <AppCard
            style={[
              styles.banner,
              {
                borderColor: `${accent}35`,
                opacity: hasGuides ? 1 : 0.72,
              },
            ]}
            onPress={() => openCategory(item.id, getCategoryName(item))}
          >
            <View
              style={[
                styles.bannerTone,
                { backgroundColor: `${accent}0F` },
              ]}
            />

            <View style={[styles.bannerStripe, { backgroundColor: accent }]} />

            <View
              style={[
                styles.iconContainer,
                { backgroundColor: `${accent}18` },
              ]}
            >
              <SafeText style={styles.categoryIcon}>{item.icon}</SafeText>
            </View>

            <View style={styles.bannerCopy}>
              <View style={styles.eyebrowRow}>
                <SafeText variant="label" style={{ color: accent }}>
                  {position}
                </SafeText>

                {!hasGuides ? (
                  <SafeText variant="caption" color="light">
                    {language === 'fil' ? 'Pinaplano' : 'Planned'}
                  </SafeText>
                ) : null}
              </View>

              <View style={styles.bannerTitleRow}>
                <SafeText
                  variant="h3"
                  weight="700"
                  numberOfLines={1}
                  style={{ color: accent }}
                >
                  {getCategoryName(item)}
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
                  style={{
                    color: hasGuides ? accent : colors.textMuted,
                  }}
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
          </AppCard>
        )
      }}
    />
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    content: {
      backgroundColor: colors.background,
      paddingBottom: 140,
    },

    hero: {
      minHeight: 198,
      backgroundColor: colors.primary,
      paddingHorizontal: spacing.lg,
      paddingTop: spacing.xxl,
      paddingBottom: spacing.lg,
      borderBottomLeftRadius: 24,
      borderBottomRightRadius: 24,
      justifyContent: 'space-between',
      overflow: 'hidden',
    },

    heroGlow: {
      position: 'absolute',
      right: -44,
      top: -42,
      width: 142,
      height: 142,
      borderRadius: 71,
      backgroundColor: 'rgba(255,255,255,0.12)',
    },

    heroTop: {
      flexDirection: 'row',
      alignItems: 'flex-start',
      gap: spacing.md,
    },

    heroIcon: {
      width: 54,
      height: 54,
      borderRadius: 18,
      backgroundColor: colors.surface,
      alignItems: 'center',
      justifyContent: 'center',
    },

    heroCopy: {
      flex: 1,
      minWidth: 0,
      paddingTop: 2,
    },

    heroSubtitle: {
      opacity: 0.9,
      marginTop: spacing.sm,
      maxWidth: 340,
    },

    statRow: {
      flexDirection: 'row',
      flexWrap: 'wrap',
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
      paddingTop: spacing.md,
      paddingBottom: spacing.sm,
    },

    introText: {
      marginTop: spacing.xs,
    },

    banner: {
      marginHorizontal: spacing.md,
      minHeight: 124,
      borderWidth: 1,
      overflow: 'hidden',
      flexDirection: 'row',
      alignItems: 'center',
      paddingVertical: spacing.md,
    },

    bannerTone: {
      position: 'absolute',
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
    },

    bannerStripe: {
      position: 'absolute',
      left: 0,
      top: 0,
      bottom: 0,
      width: 5,
    },

    iconContainer: {
      width: 60,
      height: 60,
      borderRadius: 20,
      alignItems: 'center',
      justifyContent: 'center',
      marginRight: spacing.md,
    },

    categoryIcon: {
      fontSize: 30,
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

    eyebrowRow: {
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'space-between',
      marginBottom: 2,
    },

    description: {
      marginTop: spacing.xs,
    },

    countPill: {
      alignSelf: 'flex-start',
      borderRadius: 999,
      paddingHorizontal: spacing.sm,
      paddingVertical: spacing.xs,
      marginTop: spacing.sm,
    },

    arrowButton: {
      width: 36,
      height: 36,
      borderRadius: 18,
      alignItems: 'center',
      justifyContent: 'center',
      marginLeft: spacing.sm,
    },

    loadingCard: {
      margin: spacing.md,
      alignItems: 'center',
      borderWidth: 1,
      borderColor: colors.border,
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

    emptyCard: {
      margin: spacing.md,
      alignItems: 'center',
      borderWidth: 1,
      borderColor: colors.border,
    },

    emptyAction: {
      marginTop: spacing.md,
      alignSelf: 'stretch',
    },
  })
