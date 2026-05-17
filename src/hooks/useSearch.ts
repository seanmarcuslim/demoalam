import { useState, useEffect } from 'react'
import { useQuery } from '@tanstack/react-query'
import { guidesService } from '../services/guidesService'

export function useSearch() {
  const [searchTerm, setSearchTerm] = useState('')
  const [debouncedTerm, setDebouncedTerm] = useState('')

  // 300ms debounce — don't search on every keystroke
  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedTerm(searchTerm)
    }, 300)
    return () => clearTimeout(timer)
  }, [searchTerm])

  const { data: results, isLoading } = useQuery({
    queryKey: ['search', debouncedTerm],
    queryFn: () => guidesService.searchGuides(debouncedTerm),
    enabled: debouncedTerm.length > 1,
    staleTime: 1000 * 60 * 2,
  })

  return {
    searchTerm,
    setSearchTerm,
    results: results || [],
    isLoading,
    hasResults: (results?.length ?? 0) > 0,
  }
}