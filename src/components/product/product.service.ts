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
  await prisma.product.update({
    where: {
      id
    },
    data: {
      available: currentStockInfo._sum.available!,
      defect: currentStockInfo._sum.defect!,
      sold: currentStockInfo._sum.sold!,
      returned: currentStockInfo._sum.returned!
    }
  })
}