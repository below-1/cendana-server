import { prisma } from '@cend/commons/prisma';

export async function findForDelay(delayId: number) {
  const payments = await prisma.transaction.findMany({
    where: {
      delayId
    }
  })
  return payments;
}
