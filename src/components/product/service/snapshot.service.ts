import { prisma } from '@cend/commons/prisma'
import { RecordProduct } from '@prisma/client'
import { format } from 'date-fns'

export async function snapshot(target: Date) {
  // console.log('target = ', target)
  // return []
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
  // const pgDate = format(target, 'yyyy-MM-dd')
  // console.log(pgDate)
  // console.log(pgDate)
  // throw new Error('fatal')
  await prisma.$executeRaw`delete from "RecordProduct" where "date" = ${target}`
  await prisma.recordProduct.createMany({
    data: snapshotData
  })
}
