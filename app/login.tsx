import { useState } from 'react'
import {
  Alert,
  KeyboardAvoidingView,
  Platform,
  ScrollView,
  StyleSheet,
  TextInput,
  TouchableOpacity,
  View,
} from 'react-native'
import { router } from 'expo-router'
import { Ionicons } from '@expo/vector-icons'
import { useAuth } from '../src/hooks/useAuth'
import { useSettingsStore } from '../src/stores/settingsStore'
import { useTheme } from '../src/hooks/useTheme'
import { spacing } from '../src/theme/spacing'
import SafeText from '../src/components/ui/SafeText'

export default function LoginScreen() {
  const { signIn, isLoading } = useAuth()
  const { language } = useSettingsStore()
  const { colors } = useTheme()
  const styles = createStyles(colors)

  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')

  const isFilipino = language === 'fil'

  const handleLogin = async () => {
    if (!email || !password) {
      Alert.alert(
        isFilipino ? 'Kulang ang fields' : 'Missing fields',
        isFilipino
          ? 'Ilagay ang email at password.'
          : 'Please enter your email and password.'
      )
      return
    }

    try {
      await signIn(email.trim(), password)
      router.replace('/(tabs)')
    } catch (error: any) {
      Alert.alert(
        isFilipino ? 'Hindi maka-login' : 'Login failed',
        error.message || (isFilipino ? 'Subukan muli.' : 'Please try again.')
      )
    }
  }

  return (
    <KeyboardAvoidingView
      style={styles.flex}
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}
    >
      <ScrollView
        contentContainerStyle={styles.container}
        keyboardShouldPersistTaps="handled"
        showsVerticalScrollIndicator={false}
      >
        <TouchableOpacity
          activeOpacity={0.82}
          style={styles.backButton}
          onPress={() => router.back()}
        >
          <Ionicons name="arrow-back" size={20} color={colors.primary} />
        </TouchableOpacity>

        <View style={styles.heroIcon}>
          <SafeText variant="h1">💡</SafeText>
        </View>

        <SafeText variant="h1" color="primary" style={styles.title}>
          DemoAlam
        </SafeText>

        <SafeText variant="bodyMd" color="muted" style={styles.subtitle}>
          {isFilipino
            ? 'Optional ang login. Gamitin ito kapag gusto mong i-sync ang saved guides sa future.'
            : 'Login is optional. Use it when you want future sync for saved guides.'}
        </SafeText>

        <View style={styles.formCard}>
          <InputRow
            icon="mail-outline"
            placeholder="Email"
            value={email}
            onChangeText={setEmail}
            keyboardType="email-address"
          />

          <InputRow
            icon="lock-closed-outline"
            placeholder={isFilipino ? 'Password' : 'Password'}
            value={password}
            onChangeText={setPassword}
            secureTextEntry
          />

          <TouchableOpacity
            style={styles.primaryButton}
            activeOpacity={0.86}
            onPress={handleLogin}
            disabled={isLoading}
          >
            <SafeText color="surface" weight="700">
              {isLoading
                ? isFilipino
                  ? 'Naglo-login...'
                  : 'Logging in...'
                : isFilipino
                  ? 'Mag-login'
                  : 'Login'}
            </SafeText>
          </TouchableOpacity>

          <TouchableOpacity
            activeOpacity={0.86}
            style={styles.secondaryButton}
            onPress={() => router.push('/register')}
          >
            <SafeText color="primary" weight="700">
              {isFilipino ? 'Gumawa ng account' : 'Create an account'}
            </SafeText>
          </TouchableOpacity>
        </View>

        <TouchableOpacity
          activeOpacity={0.86}
          onPress={() => router.replace('/(tabs)')}
        >
          <SafeText variant="bodyMd" color="muted" weight="700" style={styles.guestText}>
            {isFilipino ? 'Magpatuloy bilang guest' : 'Continue as guest'}
          </SafeText>
        </TouchableOpacity>
      </ScrollView>
    </KeyboardAvoidingView>
  )

  function InputRow(props: any) {
    return (
      <View style={styles.inputRow}>
        <Ionicons name={props.icon} size={19} color={colors.textMuted} />
        <TextInput
          style={styles.input}
          placeholder={props.placeholder}
          placeholderTextColor={colors.textLight}
          autoCapitalize="none"
          {...props}
        />
      </View>
    )
  }
}

const createStyles = (colors: any) =>
  StyleSheet.create({
    flex: {
      flex: 1,
      backgroundColor: colors.background,
    },

    container: {
      flexGrow: 1,
      backgroundColor: colors.background,
      padding: spacing.lg,
      paddingTop: spacing.xl,
      justifyContent: 'center',
    },

    backButton: {
      position: 'absolute',
      top: spacing.xl,
      left: spacing.lg,
      width: 42,
      height: 42,
      borderRadius: 21,
      backgroundColor: colors.surface,
      borderWidth: 1,
      borderColor: colors.border,
      alignItems: 'center',
      justifyContent: 'center',
    },

    heroIcon: {
      width: 70,
      height: 70,
      borderRadius: 24,
      backgroundColor: colors.primaryLight,
      alignItems: 'center',
      justifyContent: 'center',
      alignSelf: 'center',
      marginBottom: spacing.md,
    },

    title: {
      textAlign: 'center',
    },

    subtitle: {
      textAlign: 'center',
      marginTop: spacing.sm,
      marginBottom: spacing.xl,
    },

    formCard: {
      backgroundColor: colors.surface,
      borderRadius: 18,
      borderWidth: 1,
      borderColor: colors.border,
      padding: spacing.md,
      marginBottom: spacing.lg,
    },

    inputRow: {
      minHeight: 54,
      borderRadius: 14,
      backgroundColor: colors.surfaceSecondary,
      paddingHorizontal: spacing.md,
      flexDirection: 'row',
      alignItems: 'center',
      gap: spacing.sm,
      marginBottom: spacing.md,
    },

    input: {
      flex: 1,
      minHeight: 52,
      color: colors.text,
      fontSize: 16,
      lineHeight: 22,
    },

    primaryButton: {
      minHeight: 52,
      borderRadius: 14,
      backgroundColor: colors.primary,
      alignItems: 'center',
      justifyContent: 'center',
      marginTop: spacing.xs,
    },

    secondaryButton: {
      minHeight: 50,
      borderRadius: 14,
      borderWidth: 1,
      borderColor: colors.primary,
      alignItems: 'center',
      justifyContent: 'center',
      marginTop: spacing.sm,
    },

    guestText: {
      textAlign: 'center',
    },
  })
