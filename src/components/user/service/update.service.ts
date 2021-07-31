import { prisma } from '@cend/commons/prisma';
import { Role } from '@prisma/client';

export type UpdatePayload = {
  name?: string;
  address?: string;
  mobile?: string;
  email?: string;
}

export async function update(id: number, payload: UpdatePayload) {
  const user = await prisma.user.update({
    where: { id },
    data: payload
  });
  return user;
}