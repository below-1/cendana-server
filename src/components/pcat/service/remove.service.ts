import { prisma } from '@cend/commons/prisma'
import * as DTO from '../product-category.dto'

export async function remove(id: number) {
  const result = await prisma.productCategory.delete({
    where: { id }
  });
  return result;
}
