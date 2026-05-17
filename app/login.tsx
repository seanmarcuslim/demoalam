import { useState } from 'react'
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  StyleSheet,
  Alert,
  ScrollView,
  KeyboardAvoidingView,
  Platform,
} from 'react-native'
import { router } from 'expo-router'
import { useAuth } from '../src/hooks/useAuth'
import { useTheme } from '../src/hooks/useTheme'
import { spacing } from '../src/theme/spacing'
import { typography } from '../src/theme/typography'

export default function LoginScreen() {
  const { signIn, isLoading } = useAuth()
  const { colors } = useTheme()

  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')

  const handleLogin = async () => {
    if (!email || !password) {
      Alert.alert(
        'Missing fields',
        'Please enter your email and password.'
      )
      return
    }

    try {
      await signIn(email.trim(), password)
      router.replace('/(tabs)')
    } catch (error: any) {
      Alert.alert(
        'Login failed',
        error.message || 'Please try again.'
      )
    }
  }

  const styles = createStyles(colors)

  return (
    <KeyboardAvoidingView
      style={styles.flex}
      behavior={
        Platform.OS === 'ios'
          ? 'padding'
          : undefined
      }
    >
      <ScrollView
        contentContainerStyle={
          styles.container
        }
        keyboardShouldPersistTaps="handled"
      >
        <Text style={styles.logo}>
          DemoAlam 💡
        </Text>

        <Text style={styles.subtitle}>
          Login to continue
        </Text>

        <TextInput
          style={styles.input}
          placeholder="Email"
          placeholderTextColor={
            colors.textLight
          }
          value={email}
          onChangeText={setEmail}
          autoCapitalize="none"
          keyboardType="email-address"
        />

        <TextInput
          style={styles.input}
          placeholder="Password"
          placeholderTextColor={
            colors.textLight
          }
          value={password}
          onChangeText={setPassword}
          secureTextEntry
        />

        <TouchableOpacity
          style={styles.button}
          activeOpacity={0.85}
          onPress={handleLogin}
          disabled={isLoading}
        >
          <Text style={styles.buttonText}>
            {isLoading
              ? 'Logging in...'
              : 'Login'}
          </Text>
        </TouchableOpacity>

        <TouchableOpacity
          onPress={() =>
            router.push('/register')
          }
        >
          <Text style={styles.linkText}>
            Create an account
          </Text>
        </TouchableOpacity>

        <TouchableOpacity
          onPress={() =>
            router.replace('/(tabs)')
          }
        >
          <Text style={styles.guestText}>
            Continue as guest
          </Text>
        </TouchableOpacity>
      </ScrollView>
    </KeyboardAvoidingView>
  )
}

const createStyles = (colors: any) =>
  StyleSheet.create({
    flex: {
      flex: 1,
      backgroundColor:
        colors.background,
    },

    container: {
      flexGrow: 1,
      backgroundColor:
        colors.background,
      padding: spacing.lg,
      justifyContent: 'center',
    },

    logo: {
      ...typography.h1,
      color: colors.primary,
      textAlign: 'center',
      marginBottom: spacing.sm,
    },

    subtitle: {
      ...typography.body,
      color: colors.textMuted,
      textAlign: 'center',
      marginBottom: spacing.xl,
    },

    input: {
      backgroundColor:
        colors.surface,
      borderRadius: 14,
      padding: spacing.md,
      marginBottom: spacing.md,
      ...typography.body,
      color: colors.text,
    },

    button: {
      backgroundColor:
        colors.primary,
      borderRadius: 14,
      padding: spacing.md,
      alignItems: 'center',
      marginTop: spacing.sm,
    },

    buttonText: {
      ...typography.body,
      color: '#FFFFFF',
      fontWeight: '700',
    },

    linkText: {
      ...typography.body,
      color: colors.primary,
      textAlign: 'center',
      marginTop: spacing.lg,
      fontWeight: '700',
    },

    guestText: {
      ...typography.caption,
      color: colors.textMuted,
      textAlign: 'center',
      marginTop: spacing.md,
    },
  })