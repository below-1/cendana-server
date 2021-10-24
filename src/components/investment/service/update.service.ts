import { prisma } from '@cend/commons/prisma';
import * as DTO from '../investment.dto';

export async function update(id: number, payload: DTO.Update.Marker) {
  const result = await prisma.investment.update({
    where: { id },
    data: payload
  })
  return result
}
