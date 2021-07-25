import { prisma } from '@cend/commons/prisma';
import { Role, Prisma } from '@prisma/client';
import * as DTO from './user.dto';
import { FindOptions } from '@cend/commons/find';

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

export async function findUser(role: Role, keyword: string, options: FindOptions.Marker) {
  const totalData = await prisma.user.count({
    where: {
      AND: [
        { role },
        { name: { contains: keyword } }
      ]
    }
  });
  const totalPage = Math.ceil(totalData / options.perPage);
  const offset = options.page * options.perPage;
  const items = await prisma.user.findMany({
    where: {
      AND: [
        { role },
        { name: { contains: keyword } }
      ]
    },
    skip: offset,
    take: options.perPage,
    orderBy: {
      name: 'desc'
    }
  })
  return {
    totalData,
    totalPage,
    items
  }
}
