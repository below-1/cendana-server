import { prisma } from '@cend/commons/prisma';
import { Role } from '@prisma/client';

export type CreatePayload = {
  name: string;
  role: Role;
  address?: string;
  mobile?: string;
  email?: string;
}

export async function create(payload: CreatePayload) {
  const user = await prisma.user.create({
    data: payload
  });
  return user;
}
