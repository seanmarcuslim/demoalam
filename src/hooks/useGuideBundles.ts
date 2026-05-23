import { useQuery } from '@tanstack/react-query'

import { guidesService } from '../services/guidesService'
import { defaultNetworkMode } from '../lib/query'

export function useFeaturedGuideBundles() {
  return useQuery({
    queryKey: ['guide-bundles', 'featured'],
    queryFn: () => guidesService.fetchFeaturedBundles(),
    staleTime: 1000 * 60 * 5,
    networkMode: defaultNetworkMode,
  })
}

export function useGuideBundle(slug?: string) {
  return useQuery({
    queryKey: ['guide-bundle', slug],
    queryFn: () =>
      guidesService.fetchBundleBySlug(slug || ''),
    enabled: Boolean(slug),
    staleTime: 1000 * 60 * 5,
    networkMode: defaultNetworkMode,
  })
}