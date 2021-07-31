import { prisma } from '@cend/commons/prisma';

export async function findOneUserByUsername(username: string) {
  const result = await prisma.user.findFirst({
    where: { 
      username
    }
  });
  return result;
}
