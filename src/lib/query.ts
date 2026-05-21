import { Platform } from 'react-native'

export const defaultNetworkMode = Platform.OS === 'web' ? 'always' : 'offlineFirst'
