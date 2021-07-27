import { prisma } from '@cend/commons/prisma';

export async function remove(id: number) {
  const purchase = await prisma.order.delete({
    where: { id }
  });
  return purchase;
}
