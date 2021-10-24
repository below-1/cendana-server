import { prisma } from '@cend/commons/prisma'

export async function remove(id: number) {
  const result = await prisma.investment.delete({ where: { id } })
  return result
}