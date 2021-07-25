import { prisma } from '@cend/commons/prisma';
import { Order, StockItem, OrderStatus, OrderType } from '@prisma/client';

export async function findPurchaseById(id: number) {
  const purchase = await prisma.order.findFirst({
    where: {
      AND: [
        { id },
        { orderType: OrderType.BUY }
      ]
    }
  });
  if (!purchase) {
    throw new Error(`Purchase(id=${id}) can't be found`);
  }
  return purchase;
}