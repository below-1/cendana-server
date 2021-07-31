import { prisma } from '@cend/commons/prisma';
import {
  OrderStatus, 
  OrderType
} from '@prisma/client';

export type CreatePayload = {
  description?: string;
  authorId: number;
  targetUserId: number;
  createdAt?: string | Date;
}

export async function create(payload: CreatePayload) {
  const { authorId, targetUserId, ...rest } = payload;
  const sale = await prisma.order.create({
    data: {
      ...rest,
      grandTotal: 0,
      subTotal: 0,
      tax: 0,
      shipping: 0,
      discount: 0,
      orderStatus: OrderStatus.OPEN,
      orderType: OrderType.SALE,
      author: {
        connect: { id: authorId }
      },
      targetUser: {
        connect: { id: targetUserId }
      }
    }
  })
  return sale;
}
