import { prisma } from '@cend/commons/prisma';

export async function findOne(id: number) {
  return prisma.equityChange.findFirst({
    where: { id },
    include: {
      transaction: true
    }
  })
}