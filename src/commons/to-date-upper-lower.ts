import { lastDayOfMonth }  from 'date-fns'

export function toDateUpperLower(year: number, month: number) {
  const firstDay = 1
  const lower = new Date(year, month, firstDay)
  const upper = lastDayOfMonth(lower)
  return {
    lower,
    upper
  }
}