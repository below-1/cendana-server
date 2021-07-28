import { prisma } from '@cend/commons/prisma';

export async function findOne(id: number) {
  const product = await prisma.product.findFirst({ 
    where: { id },
    include: {
      categories: true
    }
  });
  return product;
}
