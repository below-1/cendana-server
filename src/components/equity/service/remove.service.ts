import { prisma } from '@cend/commons/prisma';

export async function remove(id: number) {
  const transaction = await prisma.transaction.delete({
    where: { id }
  })
  return transaction
}