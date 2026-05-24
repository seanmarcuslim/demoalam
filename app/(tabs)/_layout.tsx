import { Tabs } from 'expo-router'
import { Ionicons } from '@expo/vector-icons'
import { useSafeAreaInsets } from 'react-native-safe-area-context'
import { useTheme } from '../../src/hooks/useTheme'
import { useSettingsStore } from '../../src/stores/settingsStore'
import { translations } from '../../src/utils/translations'

export default function TabLayout() {
  const insets = useSafeAreaInsets()

  const { colors } = useTheme()
  const { language } = useSettingsStore()
  const t = translations[language]

  return (
    <Tabs
      screenOptions={{
        headerShown: false,

        tabBarActiveTintColor: colors.primary,
        tabBarInactiveTintColor: colors.textMuted,

        tabBarStyle: {
          backgroundColor: colors.surface,
          borderTopColor: colors.border,

          height: 64 + insets.bottom,
          paddingBottom: Math.max(insets.bottom, 10),
          paddingTop: 6,
        },

        tabBarLabelStyle: {
          fontSize: 11,
          fontWeight: '600',
        },

        tabBarItemStyle: {
          paddingVertical: 2,
        },

        tabBarHideOnKeyboard: true,

        sceneStyle: {
          backgroundColor: colors.background,
        },

        tabBarBackground: () => null,
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          title: t.home,
          tabBarIcon: ({ color, size }) => (
            <Ionicons
              name="home"
              size={size}
              color={color}
            />
          ),
        }}
      />

      <Tabs.Screen
        name="categories"
        options={{
          title: t.categories,
          tabBarIcon: ({ color, size }) => (
            <Ionicons
              name="grid"
              size={size}
              color={color}
            />
          ),
        }}
      />

      <Tabs.Screen
        name="search"
        options={{
          title: t.search,
          tabBarIcon: ({ color, size }) => (
            <Ionicons
              name="search"
              size={size}
              color={color}
            />
          ),
        }}
      />

      <Tabs.Screen
        name="saved"
        options={{
          title: t.saved,
          tabBarIcon: ({ color, size }) => (
            <Ionicons
              name="bookmark"
              size={size}
              color={color}
            />
          ),
        }}
      />

      <Tabs.Screen
        name="profile"
        options={{
          title: t.profile,
          tabBarIcon: ({ color, size }) => (
            <Ionicons
              name="person"
              size={size}
              color={color}
            />
          ),
        }}
      />
    </Tabs>
  )
}
