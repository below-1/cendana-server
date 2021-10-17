import { prisma } from '@cend/commons/prisma'
import { format, parse, lastDayOfMonth, setMonth, setYear, setDate } from 'date-fns'
import * as DTO from '../finance.dto'

export async function labaRugi(options: DTO.LabaRugi.Marker) {
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


  const hpp = hppStart - hppEnd
  const labaKotor = totalSale - hpp
  // const labaBersih = labaKotor - totalOpex

  console.log(`labaKotor = ${labaKotor}`)
  return 'OK'
}
