import { useQuery } from '@tanstack/react-query'
import { guidesService } from '../services/guidesService'

export function useGuides(categoryId?: string) {
  return useQuery({
    queryKey: ['guides', categoryId],
    queryFn: () => guidesService.fetchGuides(categoryId),
    staleTime: 1000 * 60 * 5,
  })
}

export function useFeaturedGuides() {
  return useQuery({
    queryKey: ['guides', 'featured'],
    queryFn: () => guidesService.fetchFeatured(),
    staleTime: 1000 * 60 * 5,
  })
}

export function useUrgentGuides() {
  return useQuery({
    queryKey: ['guides', 'urgent'],
    queryFn: () => guidesService.fetchUrgent(),
    staleTime: 1000 * 60 * 5,
  })
}

export function useGuide(id: string) {
  return useQuery({
    queryKey: ['guide', id],
    queryFn: () => guidesService.fetchGuide(id),
    staleTime: 1000 * 60 * 5,
    enabled: !!id,
  })
}