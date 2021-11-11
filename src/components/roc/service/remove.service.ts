import { prisma } from '@cend/commons/prisma';
import { ROCNotFound } from './errors'

export async function remove(id: number) {
  const deleteResult = await prisma.transaction.deleteMany({
    where: {
      AND: [
        { id },
        { pengembalianModalFlag: { gt: 0 } }
      ]
    }
  })
  if (deleteResult.count == 0) {
    throw new ROCNotFound(id)
  }
}