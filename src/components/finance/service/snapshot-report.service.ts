import { prisma } from '@cend/commons/prisma'
import { format, parse, lastDayOfMonth, setMonth, setYear, setDate } from 'date-fns'
import { id as localeId } from 'date-fns/locale'

interface ReportOptions {
  month: number;
  year: number;
  pajak: number;
}

export async function snapshotReport(options: ReportOptions) {
  let startDate = new Date()
  startDate = setYear(startDate, options.year)
  startDate = setMonth(startDate, options.month)
  startDate = setDate(startDate, 1)
  const endDate = lastDayOfMonth(startDate)
  const dateLabel = format(endDate, 'dd MMMM, yyyy', { locale: localeId })

  const t0 = format(startDate, 'yyyy-MM-dd')
  const t1 = format(endDate, 'yyyy-MM-dd')

  const [ { total: totalSale } ] = await prisma.$queryRaw(`
    select sum(t."nominal") as total from "Order" o 
      join "Transaction" t on t."orderId" = o.id
      where o."orderType" = 'SALE'
      and o."createdAt" between '${t0}' and '${t1}'`)

  const [ { total: piutang } ] = await prisma.$queryRaw(`
    select coalesce(sum(d.total), 0) as total
      from "Delay" d
      where 
        d.type = 'RECEIVABLE'
        and d."createdAt" between '${t0}' and '${t1}'`)  

  const [ { total: hppStart } ] = await prisma.$queryRaw(`
    select coalesce(sum(rp.available * rp."sellPrice"), 0) as total 
      from "RecordProduct" rp where rp."date" = '${t0}'`)

  const [ { total: hppEnd } ] = await prisma.$queryRaw(`
    select sum(rp.available * rp."sellPrice") total from "RecordProduct" rp where rp."date" = '${t1}'`)

  const [ { total: persediaan } ] = await prisma.$queryRaw(`
    select sum(p.available * p."sellPrice") as total from "Product" p`)

  const [ { total: pembelianBarangDagang } ] = await prisma.$queryRaw(`
    select sum(p.available * p."buyPrice") as total from "Product" p`)

  const [ { total: totalOpex } ] = await prisma.$queryRaw(`
    select coalesce(sum(t.nominal), 0) as total from "Transaction" t 
      where t."createdAt" >= '${t0}' and t."createdAt" <= '${t1}' and t."opexId" > 0`)

  const [ { nominal: modalAwal } ] = await prisma.$queryRaw(` 
    select re.nominal from "RecordEquity" as re
      where re."createdAt" <= '${t0}'
  `)

  const [ { total: utangDagang } ] = await prisma.$queryRaw(`
    select coalesce(sum(o."grandTotal"), 0) as total from "Order" o 
      where o."orderType" = 'BUY'
      and o."createdAt" between '${t0}' and '${t1}'`)

  const [ { total: prive } ] = await prisma.$queryRaw(` 
    select coalesce(sum(t.nominal), 0) as total from "EquityChange" as ec
      left join "Transaction" t on t."equityChangeId" = ec.id
      where 
        t."createdAt" >= '${t0}' 
        AND t."createdAt" <= '${t1}'
  `)

  const [ { total: penambahanModalUsaha } ] = await prisma.$queryRaw(` 
    select coalesce(sum(t.nominal), 0) as total from "EquityChange" as ec
      left join "Transaction" t on t."equityChangeId" = ec.id
      where 
        t."createdAt" >= '${t0}' 
        AND t."createdAt" <= '${t1}'
        AND t."type" = 'DEBIT'
  `)

  const [ { total: pengembalianModal } ] = await prisma.$queryRaw(` 
    select coalesce(sum(t.nominal), 0)
      from join "Transaction" t on t."equityChangeId" = ec.id
      where 
        t."createdAt" >= '${t0}' 
        AND t."createdAt" <= '${t1}'
        AND t."type" = 'DEBIT'
        AND t."pengembalianModalFlag" > 0
  `)

  const [ { total: peralatan } ] = await prisma.$queryRaw(`   
    select coalesce(sum(t.nominal), 0) as total from "Transaction" t 
      where t."createdAt" >= '${t0}' and t."createdAt" <= '${t1}' and t."toolId" > 0`)

  const [ { total: investment } ] = await prisma.$queryRaw(`   
    select coalesce(sum(t.nominal), 0) as total from "Transaction" t 
      where t."createdAt" >= '${t0}' and t."createdAt" <= '${t1}' and t."investmentId" > 0`)

  // console.log('totalSale = ', totalSale)
  // console.log('hppStart = ', hppStart)
  const hpp = hppStart - hppEnd
  // console.log('hpp = ', hpp)
  const labaKotor = totalSale - hpp
  // console.log('labaKotor = ', labaKotor)
  const labaSebelumPajak = labaKotor - totalOpex
  // console.log('labaSebelumPajak = ', labaSebelumPajak)
  const labaBersih = labaSebelumPajak - options.pajak
  // console.log(`labaBersih = ${labaBersih}`)

  console.log('modalAwal = ', modalAwal)
  const modalAkhir = modalAwal + labaBersih

  const penyusutanTool = peralatan / endDate.getDate()

  const aktivaLancar = totalSale + piutang + persediaan
  const aktivaTetap = peralatan - penyusutanTool
  const passiva = utangDagang + modalAkhir

  const totalRetur = 0
  const arusKasOperasional = totalSale + totalRetur - (pembelianBarangDagang + totalOpex + options.pajak)
  const arusKasInvestasi = investment + peralatan

  try {
    await prisma.financeReport.delete({
      where: {
        target: endDate
      }
    })
  } catch (err) {
    // console.log(err)
  }

  const report = await prisma.financeReport.create({
    data: {
      target: endDate,
      totalPenjualan: totalSale,
      hpp,
      labaKotor,
      labaSebelumPajak,
      labaBersih,

      modalAwal,
      modalAkhir,

      kas: totalSale,
      piutang,
      persediaan,

      peralatan,
      akumulasiPeralatan: penyusutanTool,

      aktivaTetap,
      aktivaLancar,
      passiva,

      utangDagang,

      totalRetur: 0,
      pembelianBarangDagang,
      totalBiayaPengeluaran: totalOpex,
      pajak: options.pajak,

      investasi: investment,

      arusKasInvestasi,
      arusKasOperasional
    }
  })
  console.log(report)
}