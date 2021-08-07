import { prisma } from '@cend/commons/prisma';
import { TransactionType } from '@prisma/client';
import * as DTO from '../opex.dto';

export async function addTransaction(id: number, payload: DTO.AddTransaction.Marker) {
  const { authorId, ...rest } = payload;
  const transaction = await prisma.transaction.create({
    data: {
      ...rest,
      type: TransactionType.CREDIT,
      author: { connect: { id: authorId } },
      opex: { connect: { id } }
    }
  });
  return transaction;
}