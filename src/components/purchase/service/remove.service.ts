import { prisma } from '@cend/commons/prisma';
import { services as productServices } from '@cend/components/product'

export async function remove(id: number) {
  const stockItems = await prisma.stockItem.findMany({
    where: {
      orderId: id
    }
  })
  const purchase = await prisma.order.delete({
    where: { id }
  })
  const updateProductDataPromises = stockItems.map(item => 
    productServices.updateStocks(item.productId))
  await Promise.all(updateProductDataPromises)

  return purchase
}
