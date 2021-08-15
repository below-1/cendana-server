import { prisma } from '@cend/commons/prisma';
import { FindOptions } from '@cend/commons/find';

export async function find(keyword: string, options: FindOptions.Marker) {
  const totalData = await prisma.opex.count({
    where: {
      title: {
        contains: keyword
      }
    }
  });

  const perPage = options.perPage == -1 ? totalData : options.perPage;
  const totalPage = Math.ceil(totalData / perPage);
  const offset = perPage * options.page;

  const items = await prisma.opex.findMany({
    where: {
      title: {
        contains: keyword
      }
    },
    skip: offset,
    take: perPage,
    orderBy: {
      title: 'asc'
    }
  })

  return {
    totalPage,
    totalData,
    items
  }
}
