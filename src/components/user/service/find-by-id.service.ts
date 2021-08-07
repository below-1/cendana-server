import { prisma } from '@cend/commons/prisma';

export async function findById(id: number) {
  const result = await prisma.user.findFirst({
    where: { 
      id
    }
  });
  return result;
}
