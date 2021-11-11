import { prisma } from '@cend/commons/prisma';
import {
  TransactionType
} from '@prisma/client';
import * as DTO from '../roc.dto'

export async function create(payload: DTO.Create.Marker) {
  const { authorId, ...rest } = payload;
  const transaction = await prisma.transaction.create({
    data: {
      ...rest,
      type: TransactionType.CREDIT,
      author: {
        connect: { id: authorId }
      }
    }
  })
  return transaction
}