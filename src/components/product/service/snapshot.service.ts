import { prisma } from '@cend/commons/prisma'
import { RecordProduct } from '@prisma/client'
import { format } from 'date-fns'

export async function snapshot(target: Date) {
  // console.log('target = ', target)
  // return []
  const t1 = format(target, 'yyyy-MM-dd')
  const [ { hpp } ] = await prisma.$queryRaw(`
    select sum(p.available * p."sellPrice") total from "Product" p`)

  await prisma.$executeRaw`delete from "RecordProduct" where "date" = ${target}`
  await prisma.recordProduct.create({
    data: {
      date: target,
      hpp: hpp ? hpp : 0
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
