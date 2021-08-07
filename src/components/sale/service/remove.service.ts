import { prisma } from '@cend/commons/prisma';
import {
  OrderStatus, 
  OrderType
} from '@prisma/client';
import { services as productServices } from '@cend/components/product'

export async function remove(id: number) {
  const order = await prisma.order.findFirst({ where: { id } });
  if (!order) {
    throw new Error(`Order(id=${id}) can't be found`);
  }
  if (order.orderType != OrderType.SALE) {
    throw new Error(`Order(id=${id}) is not a SALE`);
  }
  if (order.orderStatus != OrderStatus.OPEN) {
    throw new Error(`Order(id=${id}) is not OPEN`);
  }
  const orderItems = await prisma.orderItem.findMany({
    where: {
      orderId: id
    }
  })
  await prisma.order.delete({ where: { id } })
  const updateProductDataPromises = orderItems.map(item => 
    productServices.updateStocks(item.productId))
  await Promise.all(updateProductDataPromises)
  return order;
}