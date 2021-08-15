import { prisma } from '@cend/commons/prisma';
import { Decimal } from '@prisma/client/runtime';
import { OrderStatus, OrderType } from '@prisma/client';
import { services as saleServices } from '@cend/components/sale'

export type UpdatePayload = {
  quantity?: number;
  discount?: number;
  description?: string;
  sellPrice?: string;
}

export async function update(id: number, payload: UpdatePayload) {
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

  const result = await prisma.orderItem.update({
    where: { id },
    data: payload
  });

  await saleServices.updateStock(orderId)
  
  return result;
}