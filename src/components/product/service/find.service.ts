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
  const totalPage = Math.ceil(totalData / options.perPage);
  const offset = options.perPage * options.page;
  const items = await prisma.product.findMany({
    where: {
      name: {
        contains: keyword
      }
    },
    skip: offset,
    take: options.perPage,
    orderBy: {
      name: 'asc'
    }
  })
  return {
    totalPage,
    totalData,
    items
  }
}
