import { prisma } from '@cend/commons/prisma';
import {
  TransactionStatus,
  TransactionType,
  PaymentMethod
} from '@prisma/client';

export type CreatePayload = {
  authorId: number;
  paymentMethod: PaymentMethod;
  type: TransactionType;
  status: TransactionStatus;
  nominal: string;
  orderId?: number;
  opexId?: number;
  delayId?: number;
}

export async function create(payload: CreatePayload) {
  const transaction = await prisma.transaction.create({
    data: payload
  })
  return transaction;
}