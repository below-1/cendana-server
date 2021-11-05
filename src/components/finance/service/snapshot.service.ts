import { prisma } from '@cend/commons/prisma'
import { RecordProduct, RecordEquity } from '@prisma/client'
import { format } from 'date-fns'
import { Decimal } from '@prisma/client/runtime';

async function snapshotInventory(target: Date) {
  const products = await prisma.product.findMany()  
  const snapshotData = products.map(it => {
    const { id, createdAt, updatedAt, name, ...recordData } = it
    const date = target
    return {
      ...recordData,
      date,
      productId: id
    }
  })
  await prisma.$executeRaw`delete from "RecordProduct" where "date" = ${target}`
  await prisma.recordProduct.createMany({
    data: snapshotData
  })
}

async function snapshotEquity(target: Date) {
  // Get previous snaphshot of equity
  let initial = new Decimal('0')
  let t0 = new Date(2015, 0, 1)
  const t1 = target
  const previousRecord = await prisma.recordEquity.findFirst({
    where: {
      createdAt: {
        lt: target
      }
    },
    orderBy: {
      createdAt: 'desc'
    }
  })
  if (previousRecord) {
    initial = initial.plus(previousRecord.nominal)
    t0 = previousRecord.createdAt
  }

  const [ { total } ] = await prisma.$queryRaw`select 
    sum(ec.nominal) as total 
    from "EquityChange" as ec 
    where "createdAt" > ${t0} and "createdAt" <= ${t1}`
  const nominal = initial.plus(new Decimal(total))

  await prisma.recordEquity.deleteMany({
    where: {
      createdAt: target
    }
  })
  await prisma.recordEquity.create({
    data: {
      createdAt: target,
      nominal
    }
  })
}

export async function snapshot(target: Date) {
  await snapshotEquity(target)
  await snapshotInventory(target)
}
