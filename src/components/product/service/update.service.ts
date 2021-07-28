import { prisma } from '@cend/commons/prisma';
import * as DTO from '../product.dto';

export async function update(id: number, payload: DTO.Update.Marker) {
  const result = await prisma.product.update({
    where: { id },
    data: payload
  });
  return result;
}
