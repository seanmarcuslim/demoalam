import { useSettingsStore } from '../stores/settingsStore'
import { lightColors, darkColors } from '../theme/colors'

export function useTheme() {
  const theme = useSettingsStore((state) => state.theme)

  const colors = theme === 'dark'
    ? darkColors
    : lightColors

  return {
    theme,
    colors,
    isDark: theme === 'dark',
  }
}