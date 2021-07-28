import { prisma } from '@cend/commons/prisma';

export async function findOne(id: number) {
  const where = { id };
  const productCategory = await prisma.productCategory.findFirst({ where });
  return productCategory;
}
