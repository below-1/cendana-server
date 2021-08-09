import { prisma } from '@cend/commons/prisma';
import * as DTO from '../product.dto';

export async function update(id: number, payload: DTO.Update.Marker) {
  const { categories, ...rest } = payload;
  const result = await prisma.product.update({
    where: { id },
    data: {
      ...rest,
      categories: {
        connect: categories.map(it => ({ id: it.id }))
      }
    }
  });
  return result;
}
