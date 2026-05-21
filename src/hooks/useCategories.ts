import { useQuery } from '@tanstack/react-query'
import { categoriesService } from '../services/categoriesService'
import { defaultNetworkMode } from '../lib/query'

export function useCategories() {
  return useQuery({
    queryKey: ['categories'],
    queryFn: () => categoriesService.fetchCategories(),
    staleTime: 1000 * 60 * 10,
    networkMode: defaultNetworkMode,
  })
}
