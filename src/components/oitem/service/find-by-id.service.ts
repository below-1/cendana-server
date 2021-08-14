import { prisma } from '@cend/commons/prisma';

export async function findById(id: number) {
  const orderItem = await prisma.orderItem.findFirst({ where: { id } });
  return orderItem;
}
