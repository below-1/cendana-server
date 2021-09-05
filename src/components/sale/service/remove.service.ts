import { prisma } from '@cend/commons/prisma';
import {
  OrderStatus, 
  OrderType
} from '@prisma/client';
import { services as productServices } from '@cend/components/product'

export async function remove(id: number) {
  const order = await prisma.order.findFirst({ 
    where: { id }
  });
  if (!order) {
    throw new Error(`Order(id=${id}) can't be found`);
  }
  if (order.orderType != OrderType.SALE) {
    throw new Error(`Order(id=${id}) is not a SALE`);
  }
  // if (order.orderStatus != OrderStatus.OPEN) {
  //   throw new Error(`Order(id=${id}) is not OPEN`);
  // }
  const orderItems = await prisma.orderItem.findMany({
    where: {
      orderId: id
    },
    include: {
      product: true
    }
  })

  // restore products stock
  let statements: any = []
  for (let orderItem of orderItems) {
    const { product } = orderItem
    const updateStockStatement = prisma.product.update({
      where: { id: product.id },
      data: {
        available: product.available + orderItem.quantity,
        sold: product.sold - orderItem.quantity
      }
    })
    statements.push(updateStockStatement)
  }

  const deleteStatement = prisma.order.delete({ where: { id } })
  statements.push(deleteStatement)

  // const updateProductDataPromises = orderItems.map(item => 
  //   productServices.updateStocks(item.productId))

  await prisma.$transaction(statements)

  return order
}