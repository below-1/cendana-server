import { prisma } from '@cend/commons/prisma'

export async function findOne(id: number) {
  const trans = await prisma.transaction.findFirst({
    where: { id },
    include: {
      opex: true
    }
  })
  return trans
}