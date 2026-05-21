import { useState, useEffect } from 'react'
import { useQuery } from '@tanstack/react-query'
import { guidesService } from '../services/guidesService'

export function useSearch() {
  const [searchTerm, setSearchTerm] = useState('')
  const [debouncedTerm, setDebouncedTerm] = useState('')

  // 300ms debounce keeps typing responsive on low-end devices.
  useEffect(() => {
    const timer = setTimeout(() => {
      const cleanTerm = searchTerm.trim()
      setDebouncedTerm(cleanTerm)
    }, 300)
    return () => clearTimeout(timer)
  }, [searchTerm])

  const {
    data: results,
    isLoading,
    isError,
    refetch,
  } = useQuery({
    queryKey: ['search', debouncedTerm],
    queryFn: () => guidesService.searchGuides(debouncedTerm),
    enabled: debouncedTerm.length > 1,
    staleTime: 1000 * 60 * 2,
    networkMode: 'offlineFirst',
  })

  return {
    searchTerm,
    setSearchTerm,
    results: results || [],
    isLoading,
    isError,
    refetch,
    hasResults: (results?.length ?? 0) > 0,
  }
}
