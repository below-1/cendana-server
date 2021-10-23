import { prisma } from '@cend/commons/prisma'
import { format, parse, lastDayOfMonth, setMonth, setYear, setDate } from 'date-fns'
import { id as localeId } from 'date-fns/locale'
import * as DTO from '../finance.dto'
import { print } from '@cend/components/printer'
import { rupiah } from '@cend/commons'

export async function perubahanModal(type: 'JSON' | 'WORD', options: DTO.PerubahanModal.Marker) {
  let startDate = new Date()
  startDate = setYear(startDate, options.year)
  startDate = setMonth(startDate, options.month)
  startDate = setDate(startDate, 1)
  const endDate = lastDayOfMonth(startDate)

  const t0 = format(startDate, 'yyyy-MM-dd')
  const t1 = format(endDate, 'yyyy-MM-dd')

  const [ { nominal: modalAwal } ] = await prisma.$queryRaw(`
    select rm.nominal from "RecordModal" as rm where date = '${t0}'
  `)
  const modalAkhir = modalAwal + (options.labaBersih - options.prive)

  const dateLabel = format(endDate, 'dd MMMM, yyyy', { locale: localeId })

  const respData = {
    modalAwal: rupiah(modalAwal),
    modalAkhir: rupiah(modalAkhir),
    prive: rupiah(options.prive),
    labaBersih: rupiah(options.labaBersih),
    dateLabel
  }

  if (type == 'JSON') {
    return respData
  } else {
    const result = await print({ path: 'perubahan-modal', data: respData })
    return result
  }
}
