import { prisma } from '@cend/commons/prisma'
import * as DTO from '../product-category.dto'

export async function update(id: number, payload: DTO.Update.Marker) {
  const result = await prisma.productCategory.update({
    where: { id },
    data: payload
  });
  return result;
}
