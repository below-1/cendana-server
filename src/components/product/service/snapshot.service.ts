import { prisma } from '@cend/commons/prisma'
import { RecordProduct } from '@prisma/client'
import { format } from 'date-fns'

export async function snapshot(target: Date) {
  // console.log('target = ', target)
  // return []
  const t1 = format(target, 'yyyy-MM-dd')
  const [ { total: hpp } ] = await prisma.$queryRaw(`
    select coalesce(sum(p.available * p."sellPrice"), 0) as total from "Product" p`)
  const [ { total: persediaan } ] = await prisma.$queryRaw(`
    select coalesce(sum(p.available * p."sellPrice"), 0) as total from "Product" p`)

  await prisma.$executeRaw`delete from "RecordProduct" where "date" = ${target}`
  await prisma.recordProduct.create({
    data: {
      date: target,
      hpp: hpp ? hpp : 0,
      persediaan: persediaan ? persediaan : 0
    }
  })
}

export async function checkSnapshot(target: Date) {
  const total = await prisma.recordProduct.count({
    where: {
      date: target
    }
  })
  return total > 0
}
