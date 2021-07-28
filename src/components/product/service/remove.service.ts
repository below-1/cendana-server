import { prisma } from '@cend/commons/prisma';

export async function remove(id: number) {
  const result = await prisma.product.delete({
    where: { id }
  });
  return result;
}
