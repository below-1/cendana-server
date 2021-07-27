import { prisma } from '@cend/commons/prisma';

export async function findForOrder(orderId: number) {
  const items = await prisma.stockItem.findMany({
    where: {
      orderId
    }
  });
  return items;
}