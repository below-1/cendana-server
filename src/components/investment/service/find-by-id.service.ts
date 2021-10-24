import { prisma } from '@cend/commons/prisma';

export async function findById(id: number) {
  const investment = await prisma.investment.findFirst({ where: { id } })
  return investment
}