import { prisma } from '@cend/commons/prisma';
import {
  OrderType
} from '@prisma/client';
import { updateStock } from './update-stock.service'

export type UpdatePayload = {
  description?: string;
  shipping: string;
  tax: number;
  discount: number;
  targetUserId: number;
}

export async function update(id: number, payload: UpdatePayload) {
  const { targetUserId, ...rest } = payload;

  const updateResult = await prisma.order.updateMany({
    where: {
      AND: [
        { id }
      ]
    },
    data: {
      ...rest,
      targetUserId
    }
  })
  await updateStock(id)
  return updateResult
}
