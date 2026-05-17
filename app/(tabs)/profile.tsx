import { View, Text, StyleSheet, TouchableOpacity, Switch } from 'react-native'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { useSavedStore } from '../../src/stores/savedStore'
import { colors } from '../../src/theme/colors'
import { spacing } from '../../src/theme/spacing'
import { typography } from '../../src/theme/typography'

export default function ProfileScreen() {
  const { language, setLanguage } = useSettingsStore()
  const { savedIds } = useSavedStore()

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.avatar}>👤</Text>
        <Text style={styles.title}>Guest User</Text>
        <Text style={styles.subtitle}>Nagba-browse bilang bisita</Text>
      </View>

      {/* Stats */}
      <View style={styles.statsRow}>
        <View style={styles.statCard}>
          <Text style={styles.statNumber}>{savedIds.length}</Text>
          <Text style={styles.statLabel}>Na-save</Text>
        </View>
      </View>

      {/* Settings */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Mga Setting</Text>

        {/* Language Toggle */}
        <View style={styles.settingRow}>
          <View>
            <Text style={styles.settingLabel}>Wika</Text>
            <Text style={styles.settingSubtitle}>
              {language === 'fil' ? 'Filipino' : 'English'}
            </Text>
          </View>
          <Switch
            value={language === 'fil'}
            onValueChange={(val) => setLanguage(val ? 'fil' : 'en')}
            trackColor={{ false: colors.border, true: colors.primary }}
            thumbColor={colors.surface}
          />
        </View>
      </View>

      {/* About */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Tungkol sa App</Text>
        <View style={styles.aboutCard}>
          <Text style={styles.appName}>DemoAlam 💡</Text>
          <Text style={styles.appTagline}>
            "Sayang, ngayon ko lang nalaman."
          </Text>
          <Text style={styles.appVersion}>Version 1.0.0</Text>
        </View>
      </View>
    </View>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  header: {
    backgroundColor: colors.primary,
    padding: spacing.lg,
    paddingTop: spacing.xxl,
    alignItems: 'center',
  },
  avatar: {
    fontSize: 48,
    marginBottom: spacing.sm,
  },
  title: {
    ...typography.h2,
    color: colors.surface,
  },
  subtitle: {
    ...typography.body,
    color: colors.primaryLight,
    marginTop: spacing.xs,
  },
  statsRow: {
    flexDirection: 'row',
    padding: spacing.md,
    gap: spacing.md,
  },
  statCard: {
    backgroundColor: colors.surface,
    borderRadius: 12,
    padding: spacing.md,
    alignItems: 'center',
    flex: 1,
    elevation: 2,
  },
  statNumber: {
    ...typography.h1,
    color: colors.primary,
  },
  statLabel: {
    ...typography.caption,
    color: colors.textMuted,
    marginTop: spacing.xs,
  },
  section: {
    padding: spacing.md,
  },
  sectionTitle: {
    ...typography.h3,
    color: colors.text,
    marginBottom: spacing.md,
  },
  settingRow: {
    backgroundColor: colors.surface,
    borderRadius: 12,
    padding: spacing.md,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    elevation: 2,
  },
  settingLabel: {
    ...typography.body,
    color: colors.text,
    fontWeight: '600',
  },
  settingSubtitle: {
    ...typography.caption,
    color: colors.textMuted,
    marginTop: 2,
  },
  aboutCard: {
    backgroundColor: colors.surface,
    borderRadius: 12,
    padding: spacing.lg,
    alignItems: 'center',
    elevation: 2,
  },
  appName: {
    ...typography.h2,
    color: colors.primary,
  },
  appTagline: {
    ...typography.body,
    color: colors.textMuted,
    textAlign: 'center',
    marginTop: spacing.sm,
    fontStyle: 'italic',
  },
  appVersion: {
    ...typography.caption,
    color: colors.textLight,
    marginTop: spacing.md,
  },
})