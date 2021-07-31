import { prisma } from '@cend/commons/prisma';
import { TransactionType } from '@prisma/client';
import * as DTO from '../opex.dto';

export async function removeTransaction(id: number, transactionId: number) {
  const count = await prisma.transaction.count({
    where: {
      AND: [
        { id: transactionId },
        { opexId: id }
      ]
    }
  });
  if (count == 0) {
    throw new Error(`Opex(id=${id}) can't be found`);
  }
  await prisma.transaction.deleteMany({
    where: {
      AND: [
        { id: transactionId },
        { opexId: id }
      ]
    }
  });
}