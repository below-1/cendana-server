import { prisma } from '@cend/commons/prisma';
import { Role } from '@prisma/client';
import * as DTO from './user.dto';

export async function create(payload: DTO.Create.Marker) {
  const user = await prisma.user.create({
    data: payload
  });
  return user;
}

export async function update(id: number, payload: DTO.Update.Marker) {
  const user = await prisma.user.update({
    where: { id },
    data: payload
  });
  return user;
}

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

export async function findOneUserByUsername(username: string) {
  const result = await prisma.user.findFirst({
    where: { 
      username
    }
  });
  return result;
}
