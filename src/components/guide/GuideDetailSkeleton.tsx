import { ScrollView, StyleSheet, View } from 'react-native'

import Skeleton from '../ui/Skeleton'
import { spacing } from '../../theme/spacing'
import type { ThemeColors } from '../../theme/colors'

interface GuideDetailSkeletonProps {
  colors: ThemeColors
}

export default function GuideDetailSkeleton({ colors }: GuideDetailSkeletonProps) {
  const styles = createStyles(colors)

  return (
    <ScrollView style={styles.container} contentContainerStyle={styles.content}>
      <View style={styles.hero}>
        <View style={styles.navRow}>
          <Skeleton width={42} height={42} radius={21} />
          <View style={styles.navActions}>
            <Skeleton width={42} height={42} radius={21} />
            <Skeleton width={42} height={42} radius={21} />
          </View>
        </View>
        <Skeleton width={124} height={28} radius={999} />
        <Skeleton width="92%" height={30} style={styles.skeletonTitle} />
        <Skeleton width="76%" height={30} style={styles.skeletonLine} />
        <Skeleton width="88%" height={18} style={styles.skeletonLine} />
        <View style={styles.metaGrid}>
          <Skeleton width={92} height={34} radius={999} />
          <Skeleton width={112} height={34} radius={999} />
        </View>
      </View>
      <View style={styles.sectionContainer}>
        {[0, 1, 2].map((item) => (
          <View key={item} style={styles.sectionCard}>
            <Skeleton width="62%" height={24} />
            <Skeleton width="94%" height={16} style={styles.skeletonLine} />
            <Skeleton width="82%" height={16} style={styles.skeletonLine} />
          </View>
        ))}
      </View>
    </ScrollView>
  )
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },

    content: {
      paddingBottom: 140,
    },

    hero: {
      backgroundColor: colors.primary,
      paddingHorizontal: spacing.lg,
      paddingTop: spacing.xl,
      paddingBottom: spacing.xl,
      borderBottomLeftRadius: 28,
      borderBottomRightRadius: 28,
    },

    navRow: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
      marginBottom: spacing.lg,
    },

    navActions: {
      flexDirection: 'row',
      gap: spacing.sm,
    },

    metaGrid: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: spacing.sm,
      marginTop: spacing.lg,
    },

    sectionContainer: {
      padding: spacing.md,
      paddingTop: spacing.md,
    },

    sectionCard: {
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

    skeletonTitle: {
      marginTop: spacing.md,
      marginBottom: spacing.sm,
    },

    skeletonLine: {
      marginTop: spacing.sm,
    },
  })
