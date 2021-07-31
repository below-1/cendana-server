import { prisma } from '@cend/commons/prisma';
import { Role } from '@prisma/client';
import { FindOptions } from '@cend/commons/find';

export async function find(role: Role, keyword: string, options: FindOptions.Marker) {
  const totalData = await prisma.user.count({
    where: {
      AND: [
        { role },
        { name: { contains: keyword } }
      ]
    }
  });
  const perPage = options.perPage == -1 ? totalData : options.perPage;
  const totalPage = perPage == 0 ? 0 : Math.ceil(totalData / perPage);
  const offset = perPage * options.page;
  const items = await prisma.user.findMany({
    where: {
      AND: [
        { role },
        { name: { contains: keyword } }
      ]
    },
    skip: offset,
    take: perPage,
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
