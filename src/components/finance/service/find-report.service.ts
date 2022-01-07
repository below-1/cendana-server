import { prisma } from '@cend/commons/prisma'
import { Decimal } from '@prisma/client/runtime';
import { format, parse, lastDayOfMonth, setMonth, setYear, setDate } from 'date-fns'
import { id as localeId } from 'date-fns/locale'
import createError from 'fastify-error'

const ReportNotFound = createError('FST_REPORT_NOT_FOUND', "Laporan untuk %s tidak ditemukan")

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

  if (!report) {
    const targetLabel = format(endDate, 'MMMM yyyy', { locale: localeId })
    throw new ReportNotFound(targetLabel)
  }

  let aktiva = report.aktivaLancar ? report.aktivaLancar : new Decimal('0');
  if (report.aktivaTetap) {
    aktiva = aktiva.add(report.aktivaTetap)
  }

  return {
    ...report,
    aktiva
  }
}