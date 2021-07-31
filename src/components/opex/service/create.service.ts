import { prisma } from '@cend/commons/prisma';
import { TransactionType } from '@prisma/client';
import * as DTO from '../opex.dto';

export async function create(payload: DTO.Create.Marker) {
  const { title, ...rest } = payload;
  const opex = await prisma.opex.create({
    data: {
      title
    }
  });
  return opex;
}