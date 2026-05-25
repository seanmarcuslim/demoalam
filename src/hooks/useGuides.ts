import { useQuery } from '@tanstack/react-query'
import { guidesService } from '../services/guidesService'
import { defaultNetworkMode } from '../lib/query'

export function useGuides(categoryId?: string) {
  return useQuery({
    queryKey: ['guides', categoryId],
    queryFn: () => guidesService.fetchGuides(categoryId),
    staleTime: 1000 * 60 * 5,
    networkMode: defaultNetworkMode,
  })
}

export function useFeaturedGuides() {
  return useQuery({
    queryKey: ['guides', 'featured'],
    queryFn: () => guidesService.fetchFeatured(),
    staleTime: 1000 * 60 * 5,
    networkMode: defaultNetworkMode,
  })
}

export function useUrgentGuides() {
  return useQuery({
    queryKey: ['guides', 'urgent'],
    queryFn: () => guidesService.fetchUrgent(),
    staleTime: 1000 * 60 * 5,
    networkMode: defaultNetworkMode,
  })
}

export function useTrendingGuides() {
  return useQuery({
    queryKey: ['guides', 'trending'],
    queryFn: () => guidesService.fetchTrending(),
    staleTime: 1000 * 60 * 5,
    networkMode: defaultNetworkMode,
  })
}

export function useGuide(id: string) {
  return useQuery({
    queryKey: ['guide', id],
    queryFn: () => guidesService.fetchGuide(id),
    staleTime: 1000 * 60 * 5,
    enabled: !!id,
    networkMode: defaultNetworkMode,
  })
}

export function useSavedGuideDetails(ids: string[]) {
  const sortedIds = [...ids].sort()

  return useQuery({
    queryKey: ['guides', 'saved-details', sortedIds],
    queryFn: () => guidesService.fetchGuidesByIds(sortedIds),
    staleTime: 1000 * 60 * 5,
    enabled: sortedIds.length > 0,
    networkMode: defaultNetworkMode,
  })
}
