import { prisma } from '@cend/commons/prisma'

export async function remove(id: number) {
  const tool = await prisma.tool.delete({ where: { id } })
  return tool
}