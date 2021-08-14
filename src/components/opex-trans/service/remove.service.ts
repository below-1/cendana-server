import { prisma } from '@cend/commons/prisma'

export async function remove(id: number) {
  const trans = await prisma.transaction.delete({ where: { id } })
  return trans
}