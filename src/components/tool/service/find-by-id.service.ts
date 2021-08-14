import { prisma } from '@cend/commons/prisma';

export async function findById(id: number) {
  const tool = await prisma.tool.findFirst({ where: { id } })
  return tool
}