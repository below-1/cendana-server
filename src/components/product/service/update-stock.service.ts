import { prisma } from '@cend/commons/prisma';
import { OrderStatus } from '@prisma/client';

export async function updateStocks(id: number) {
  const currentStockInfo = await prisma.stockItem.aggregate({
    _sum: {
      available: true,
      defect: true,
      returned: true,
      sold: true
    },
    where: {
      productId: id,
      available: {
        gt: 0
      }
    }
  });
  const stockItems = await prisma.stockItem.findMany({
    take: 1,
    where: { productId: id },
    orderBy: {
      createdAt: 'desc'
    }
  })

  // Reset all fields to 0 if there is no purchase for this product
  let data: any = {};
  if (stockItems.length == 0) {
    data.available = 0
    data.defect = 0
    data.returned = 0
    data.buyPrice = '0'
    data.sellPrice = '0'
    data.discount = 0
  } else {
    const [ lastStockItem ] = stockItems;
    data.buyPrice = lastStockItem.buyPrice
    data.sellPrice = lastStockItem.sellPrice
    data.discount = lastStockItem.discount
    data.available = currentStockInfo._sum.available
    data.defect = currentStockInfo._sum.defect
    data.returned = currentStockInfo._sum.returned
    data.sold = currentStockInfo._sum.sold
  }

  await prisma.product.update({
    where: {
      id
    },
    data
  })
}
