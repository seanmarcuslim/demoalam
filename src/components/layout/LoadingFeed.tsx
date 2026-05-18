import { StyleSheet, View } from 'react-native'
import { useTheme } from '../../hooks/useTheme'
import { spacing } from '../../theme/spacing'
import Skeleton from '../ui/Skeleton'

interface LoadingFeedProps {
  count?: number
}

export default function LoadingFeed({ count = 3 }: LoadingFeedProps) {
  const { colors } = useTheme()
  const styles = createStyles(colors)

  return (
    <View style={styles.wrap}>
      {Array.from({ length: count }).map((_, index) => (
        <View key={index} style={styles.card}>
          <View style={styles.topRow}>
            <Skeleton width={104} height={28} radius={999} />
            <Skeleton width={36} height={36} radius={18} />
          </View>
          <Skeleton width="88%" height={22} style={styles.lineLg} />
          <Skeleton width="68%" height={22} style={styles.lineSm} />
          <Skeleton width="42%" height={16} style={styles.footer} />
        </View>
      ))}
    </View>
  )
}

const createStyles = (colors: any) =>
  StyleSheet.create({
    wrap: {
      paddingHorizontal: spacing.md,
      paddingBottom: spacing.md,
    },

    card: {
      backgroundColor: colors.surface,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.md,
      marginBottom: spacing.md,
    },

    topRow: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
      marginBottom: spacing.md,
    },

    lineLg: {
      marginBottom: spacing.sm,
    },

    lineSm: {
      marginBottom: spacing.lg,
    },

    footer: {
      marginTop: spacing.sm,
    },
  })
