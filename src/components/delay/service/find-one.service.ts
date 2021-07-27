import { prisma } from '@cend/commons/prisma';

export async function findOne(id: number) {
  const delay = await prisma.delay.findFirst({ where: { id } });
  return delay;
}
