import createError from 'fastify-error'
import { prisma } from '@cend/commons/prisma';
import {
  TransactionType
} from '@prisma/client';
import * as DTO from '../roc.dto'

const UpdateFail = createError(
  'FST_ROC_UPDATE_FAIL', 
  'Fail to update ROC(id=%s)',
  500)

export async function update(id: number, payload: DTO.Update.Marker) {
  const { authorId, ...rest } = payload;
  const updateResult = await prisma.transaction.updateMany({
    where: {
      AND: [
        { id },
        { type: TransactionType.CREDIT },
        { pengembalianModalFlag: { gt: 0 } }
      ]
    },
    data: {
      ...rest,
      authorId
    }
  })
  if (updateResult.count != 1) {
    throw new UpdateFail(id)
  }
}