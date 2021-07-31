import { prisma } from '@cend/commons/prisma';
import { TransactionType } from '@prisma/client';
import * as DTO from '../opex.dto';

export async function update(id: number, payload: DTO.Update.Marker) {
  const { title, ...rest } = payload;
  const opex = await prisma.opex.update({
    where: { id },
    data: {
      title
    }
  });
  return opex;
}
