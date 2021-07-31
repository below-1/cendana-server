import { prisma } from '@cend/commons/prisma';

export async function findOne(id: number) {
  const product = await prisma.opex.findFirst({ 
    where: { id }
  });
  return product;
}
