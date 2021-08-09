import { prisma } from '@cend/commons/prisma';
import {
  TransactionStatus,
  TransactionType,
  PaymentMethod
} from '@prisma/client';

export async function remove(id: number) {
  const transaction = await prisma.transaction.deleteMany({
    where: {
      AND: [
        { id },
        { OR: [
          // Only direct delete opex and tools
          { opexId: { gt: 0 } },
          { toolId: { gt: 0 } }
        ]}
      ]
    }
  })
  return transaction;
}
