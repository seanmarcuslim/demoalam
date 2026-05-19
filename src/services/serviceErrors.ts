export function throwServiceError(message: string, error: unknown): never {
  if (__DEV__) {
    console.error(message, error)
  }

  throw error
}
