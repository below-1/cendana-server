import { prisma } from '@cend/commons/prisma'
import { format, parse, lastDayOfMonth, setMonth, setYear, setDate } from 'date-fns'
import { id as localeId } from 'date-fns/locale'

interface ReportOptions {
  month: number;
  year: number;
}

export async function findReport(options: ReportOptions) {
  let startDate = new Date()
  startDate = setYear(startDate, options.year)
  startDate = setMonth(startDate, options.month)
  startDate = setDate(startDate, 1)
  const endDate = lastDayOfMonth(startDate)

  const report = await prisma.financeReport.findFirst({
    where: {
      target: endDate
    }
  })

  return report
}