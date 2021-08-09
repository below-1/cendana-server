import { prisma } from '@cend/commons/prisma';
import { FindOptions } from '@cend/commons/find';

export async function find(keyword: string, options: FindOptions.Marker) {
  const totalData = await prisma.product.count({
    where: {
      name: {
        contains: keyword
      }
    }
  })
  const perPage = options.perPage == -1 ? totalData : options.perPage;
  const totalPage = Math.ceil(totalData / perPage);
  const offset = perPage * options.page;

  const items = await prisma.product.findMany({
    where: {
      name: {
        contains: keyword
      }
    },
    skip: offset,
    take: perPage,
    orderBy: {
      updatedAt: 'desc'
    }
  })
  return {
    totalPage,
    totalData,
    items
  }
}
