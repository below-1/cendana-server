import { prisma } from '@cend/commons/prisma'
import { format, parse, lastDayOfMonth, setMonth, setYear, setDate } from 'date-fns'
import { id as localeId } from 'date-fns/locale'
import * as DTO from '../finance.dto'
import { print } from '@cend/components/printer'
import { rupiah } from '@cend/commons'
import { hpp } from './hpp.service'

export async function perubahanModal(type: 'JSON' | 'WORD', options: DTO.PerubahanModal.Marker) {
  let startDate = new Date()
  startDate = setYear(startDate, options.year)
  startDate = setMonth(startDate, options.month)
  startDate = setDate(startDate, 1)
  const endDate = lastDayOfMonth(startDate)

  const t0 = format(startDate, 'yyyy-MM-dd')
  const t1 = format(endDate, 'yyyy-MM-dd')

  const [ { total: totalSale } ] = await prisma.$queryRaw(`
    select sum(o."grandTotal") as total from "Order" o 
      where o."orderType" = 'SALE'
      and o."createdAt" between '${t0}' and '${t1}'`)

  const [ { total: totalPurchase } ] = await prisma.$queryRaw(`
    select sum(o."grandTotal") as total from "Order" o 
      where o."orderType" = 'PURCHASE'
      and o."createdAt" between '${t0}' and '${t1}'`)

  const hppEnd = hpp(t1)

  const [ { total: totalTool } ] = await prisma.$queryRaw(`   
    select sum(t.nominal) as total from "Transaction" t 
      where t."createdAt" >= '${t0}' and t."createdAt" <= '${t1}' and t."opexId" > 0`)

  const aktivaLancar = totalSale + totalPurchase + hppEnd
  const penyusutanTool = totalTool / endDate.getDate()
  const aktivaTetap = totalTool - penyusutanTool

  const aktiva = aktivaLancar - aktivaTetap
  console.log('aktiva = ', aktiva)
}