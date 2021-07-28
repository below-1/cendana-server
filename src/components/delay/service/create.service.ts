import { prisma } from '@cend/commons/prisma';
import {
  DelayType
} from '@prisma/client';

export type CreatePayload = {
  authorId: number;
  type: DelayType;
  orderId: number;
  dueDate: Date;
  total: string;
}

export async function create(payload: CreatePayload) {
  const { authorId, orderId, ...rest } = payload;
  const delay = await prisma.delay.create({
    data: {
      ...rest,
      complete: false,
      order: {
        connect: { id: orderId }
      },
      author: {
        connect: { id: authorId }
      }
    }
  });
  return delay;
}
