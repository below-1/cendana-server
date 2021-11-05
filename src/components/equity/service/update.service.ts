import { prisma } from '@cend/commons/prisma'
import {
  TransactionStatus,
  TransactionType, 
  PaymentMethod 
} from '@prisma/client'
import * as DTO from '../equity.dto'

export async function update(id: number, payload: DTO.Update.Marker) {
  const {
    user,
    createdAt,
    transactionId,
    ...transactionData
  } = payload
  const transaction = await prisma.transaction.update({
    where: { id: transactionId },
    data: {
      createdAt: payload.createdAt,
      type: payload.type,
      paymentMethod: payload.paymentMethod,
      status: payload.status,
      nominal: payload.nominal,
      author: {
        connect: {
          id: payload.authorId
        }
      },
      equityChange: {
        update: {
          user
        }
      }
    }
  })
  return transaction
}