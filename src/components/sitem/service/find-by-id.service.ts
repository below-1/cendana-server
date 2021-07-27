import { prisma } from '@cend/commons/prisma';

export async function findById(id: number) {
  const stockItem = await prisma.stockItem.findFirst({ where: { id } });
  return stockItem;
}
