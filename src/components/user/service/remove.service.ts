import { prisma } from '@cend/commons/prisma';
import { Role } from '@prisma/client';

export async function remove(id: number, role: Role) {
  const result = await prisma.user.deleteMany({
    where: {
      AND: [
        { id },
        { role }
      ]
    }
  });
  return result;
}
