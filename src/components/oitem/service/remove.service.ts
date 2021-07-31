import { prisma } from '@cend/commons/prisma';
import { OrderStatus, OrderType } from '@prisma/client';

export async function remove(id: number) {
  const orderItem = await prisma.orderItem.findFirst({ 
    where: { id }
  });
  if (!orderItem) {
    throw new Error(`OrderItem(id=${id}) can't be found`);
  }
  const { orderId } = orderItem;

  const order = await prisma.order.findFirst({
    where: {
      id: orderId
    }
  });

  if (!order) {
    throw new Error(`Sale(id=${orderId}) can't be found`);
  }
  if (order.orderType != OrderType.SALE) {
    throw new Error(`Order(id=${orderId}) is not SALE`);
  }
  if (order.orderStatus != OrderStatus.OPEN) {
    throw new Error(`Sale(id=${orderId}) is not OPEN`);
  }

  const deleted = await prisma.orderItem.delete({
    where: { id }
  });

  return deleted;
}
