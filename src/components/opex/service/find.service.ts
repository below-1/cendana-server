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
  const totalPage = Math.ceil(totalData / options.perPage);
  const offset = options.perPage * options.page;
  const items = await prisma.opex.findMany({
    where: {
      title: {
        contains: keyword
      }
    },
    skip: offset,
    take: options.perPage,
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
