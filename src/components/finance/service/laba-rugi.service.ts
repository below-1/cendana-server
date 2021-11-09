import { prisma } from '@cend/commons/prisma'
import { format, parse, lastDayOfMonth, setMonth, setYear, setDate } from 'date-fns'
import { id as localeId } from 'date-fns/locale'
import * as DTO from '../finance.dto'
import { print } from '@cend/components/printer'
import { rupiah } from '@cend/commons'

export interface LabaRugiResult {
  totalSale: number
  hpp: number
  labaKotor: number
  labaSebelumPajak: number
  labaBersih: number
  pajak: number
  totalOpex: number
}


export async function labaRugi(type: 'JSON' | 'WORD', options: DTO.LabaRugi.Marker) : Promise<LabaRugiResult | Buffer> {
  let startDate = new Date()
  startDate = setYear(startDate, options.year)
  startDate = setMonth(startDate, options.month)
  startDate = setDate(startDate, 1)
  const endDate = lastDayOfMonth(startDate)

  const t0 = format(startDate, 'yyyy-MM-dd')
  const t1 = format(endDate, 'yyyy-MM-dd')

  // const startDate = new Date(options.year, options.month, 1)
  const [ { total: totalSale } ] = await prisma.$queryRaw(`
    select sum(o."grandTotal") as total from "Order" o 
      where o."orderType" = 'SALE'
      and o."createdAt" between '${t0}' and '${t1}'`)

  const [ { total: hppStart } ] = await prisma.$queryRaw(`
    select sum(rp.available * rp."sellPrice") as total from "RecordProduct" rp where rp."date" = '${t0}'`)

  const [ { total: hppEnd } ] = await prisma.$queryRaw(`
    select sum(rp.available * rp."sellPrice") total from "RecordProduct" rp where rp."date" = '${t1}'`)

  const [ { total: totalOpex } ] = await prisma.$queryRaw(`
    select sum(t.nominal) as total from "Transaction" t 
      where t."createdAt" >= '${t0}' and t."createdAt" <= '${t1}' and t."opexId" > 0`)

  // console.log('hppStart = ', hppStart)
  const hpp = hppStart - hppEnd
  console.log('hpp = ', hpp)
  const labaKotor = totalSale - hpp
  // console.log('labaKotor = ', labaKotor)
  const labaSebelumPajak = labaKotor - totalOpex
  // console.log('labaSebelumPajak = ', labaSebelumPajak)
  const labaBersih = labaSebelumPajak - options.pajak
  // console.log(`labaBersih = ${labaBersih}`)

  const dateLabel = format(endDate, 'dd MMMM, yyyy', { locale: localeId })

  // prisma.financeReport.create({
  //   data: {
      
  //   }
  // })

  const respData = {
    totalSale,
    hpp,
    labaKotor,
    labaSebelumPajak,
    labaBersih,
    pajak: options.pajak,
    totalOpex
  }

  if (type == 'JSON') {
    return respData
  } else {
    const result = await print({ path: 'laba-rugi', data: respData })
    return result
  }
}

