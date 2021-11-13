import { prisma } from '@cend/commons/prisma'
import { Decimal } from '@prisma/client/runtime';
import { 
  format, 
  parse, 
  lastDayOfMonth, 
  setMonth, 
  setYear, 
  setDate, 
  addMonths
} from 'date-fns'
import { id as localeId } from 'date-fns/locale'

interface ReportOptions {
  month: number;
  year: number;
  pajak: string;
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

  let [ { total: hppStart } ] = await prisma.$queryRaw(`
    select hpp as total 
      from "RecordProduct" rp where rp."date" = '${t0}'`)

  let [ { total: hppEnd } ] = await prisma.$queryRaw(`
    select hpp as total 
      from "RecordProduct" rp where rp."date" = '${t1}'`)

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
      limit 1
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

  const [ { total: roc } ] = await prisma.$queryRaw(` 
    select coalesce(sum(t.nominal), 0) as total
      from "Transaction" t
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

  const hppStart_dec = new Decimal(hppStart)
  const hppEnd_dec = new Decimal(hppEnd)
  const totalSale_dec = new Decimal(totalSale)
  const totalOpex_dec = new Decimal(totalOpex)
  const pajak_dec = new Decimal(options.pajak)
  const modalAwal_dec = new Decimal(modalAwal)
  const peralatan_dec = new Decimal(peralatan)
  const piutang_dec = new Decimal(piutang)
  const persediaan_dec = new Decimal(persediaan)
  const utangDagang_dec = new Decimal(utangDagang)
  const pembelianBarangDagang_dec = new Decimal(pembelianBarangDagang)
  const investment_dec = new Decimal(investment)

  const hpp = hppStart_dec.sub(hppEnd_dec)
  const labaKotor = totalSale_dec.sub(hpp)
  const labaSebelumPajak = labaKotor.sub(totalOpex_dec)
  const labaBersih = labaSebelumPajak.sub(pajak_dec)
  const modalAkhir = modalAwal_dec.add(labaBersih)
  const penyusutanTool = peralatan_dec.div( endDate.getDate() )
  const totalRetur = new Decimal(0)

  const aktivaLancar = totalSale_dec.add(piutang_dec).add(persediaan_dec)
  const aktivaTetap = peralatan_dec.sub(penyusutanTool)
  const passiva = utangDagang_dec.add(modalAkhir)
  const arusKasOperasional = totalSale_dec
    .add(totalRetur)
    .sub(pembelianBarangDagang_dec
        .add(totalOpex_dec)
        .add(pajak_dec))
  const arusKasInvestasi = investment_dec.add(peralatan_dec)

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
      totalPenjualan: totalSale_dec,
      hpp,
      labaKotor,
      labaSebelumPajak,
      labaBersih,

      modalAwal: modalAwal_dec,
      modalAkhir,

      kas: totalSale_dec,
      piutang: piutang_dec,
      persediaan: persediaan_dec,

      peralatan: peralatan_dec,
      akumulasiPeralatan: penyusutanTool,

      aktivaTetap,
      aktivaLancar,
      passiva,

      utangDagang: utangDagang_dec,

      totalRetur: 0,
      pembelianBarangDagang: pembelianBarangDagang_dec,
      totalBiayaPengeluaran: totalOpex_dec,
      pajak: pajak_dec,

      investasi: investment_dec,

      arusKasInvestasi,
      arusKasOperasional,

      roc
    }
  })

  // Save next month
  const nextMonth = addMonths(endDate, 1)
  console.log(nextMonth)
  try {
    await prisma.recordEquity.deleteMany({
      where: {
        createdAt: nextMonth
      }
    })
  } catch (err) {
  }

  try {
    const recordEquity = await prisma.recordEquity.create({
      data: {
        createdAt: nextMonth,
        nominal: modalAkhir
      }
    })
    console.log(recordEquity)
  } catch (err) {
    console.log(err)
  }
}