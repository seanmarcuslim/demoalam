import { TouchableOpacity, View } from 'react-native'
import { Ionicons } from '@expo/vector-icons'
import { router } from 'expo-router'

import type { GuideBundleWithItems } from '../../types/bundle'
import SafeText from '../ui/SafeText'

interface BundleCardProps {
  bundle: GuideBundleWithItems
}

export function BundleCard({ bundle }: BundleCardProps) {
  const guideCount = bundle.items.length
  const urgentCount = bundle.items.filter((item) => item.guide?.is_urgent).length

  return (
    <TouchableOpacity
      activeOpacity={0.9}
      onPress={() =>
        router.push({
          pathname: '/bundle/[slug]',
          params: { slug: bundle.slug },
        })
      }
      style={{
        backgroundColor: '#132033',
        borderRadius: 22,
        padding: 18,
        marginTop: 14,
        borderWidth: 1,
        borderColor: '#223047',
      }}
    >
      <View
        style={{
          flexDirection: 'row',
          justifyContent: 'space-between',
          alignItems: 'center',
          marginBottom: 12,
        }}
      >
        <View
          style={{
            backgroundColor: '#1f3550',
            borderRadius: 999,
            paddingHorizontal: 12,
            paddingVertical: 8,
          }}
        >
          <SafeText variant="caption" weight="700">
            Preparedness Bundle
          </SafeText>
        </View>

        <Ionicons name="arrow-forward" size={18} color="#7cb8ff" />
      </View>

      <SafeText variant="h3" weight="700" style={{ marginBottom: 10 }}>
        {bundle.title_en}
      </SafeText>

      {bundle.description_en ? (
        <SafeText
          variant="bodyMd"
          color="muted"
          style={{ marginBottom: 14, lineHeight: 24 }}
        >
          {bundle.description_en}
        </SafeText>
      ) : null}

      <View style={{ flexDirection: 'row', gap: 10, flexWrap: 'wrap' }}>
        <View
          style={{
            backgroundColor: '#1c2d44',
            borderRadius: 999,
            paddingHorizontal: 12,
            paddingVertical: 8,
          }}
        >
          <SafeText variant="caption" weight="700">
            {guideCount} guides
          </SafeText>
        </View>

        {urgentCount > 0 ? (
          <View
            style={{
              backgroundColor: '#3f241f',
              borderRadius: 999,
              paddingHorizontal: 12,
              paddingVertical: 8,
            }}
          >
            <SafeText variant="caption" weight="700">
              {urgentCount} urgent
            </SafeText>
          </View>
        ) : null}
      </View>
    </TouchableOpacity>
  )
}