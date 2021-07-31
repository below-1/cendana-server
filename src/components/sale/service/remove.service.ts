import { prisma } from '@cend/commons/prisma';
import {
  OrderStatus, 
  OrderType
} from '@prisma/client';

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
  await prisma.order.delete({ where: { id } });
  return order;
}