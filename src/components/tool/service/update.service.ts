import { prisma } from '@cend/commons/prisma';
import * as DTO from '../tool.dto';

export async function update(id: number, payload: DTO.Update.Marker) {
  const result = await prisma.tool.update({
    where: { id },
    data: payload
  })
  return result
}
