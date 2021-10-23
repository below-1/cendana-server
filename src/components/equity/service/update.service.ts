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
    ...transactionData
  } = payload
  const transaction = await prisma.transaction.update({
    where: { id },
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
        create: {
          user
        }
      }
    }
  })
  return transaction
}