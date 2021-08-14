import { prisma } from '@cend/commons/prisma'

export async function findLatestStock(productId: number) {
  const stockItem = await prisma.stockItem.findFirst({
    where: {
      productId
    },
    orderBy: {
      createdAt: 'desc'
    }
  })
  return stockItem
}