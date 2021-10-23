import { prisma } from '@cend/commons/prisma'
import {
  TransactionStatus,
  TransactionType, 
  PaymentMethod 
} from '@prisma/client'
import * as DTO from '../equity.dto'

export async function create(payload: DTO.Create.Marker) {
  const {
    user,
    createdAt,
    ...transactionData
  } = payload
  const transaction = await prisma.transaction.create({
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