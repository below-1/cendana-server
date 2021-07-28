import { FindOptions } from '@cend/commons/find';
import { prisma } from '@cend/commons/prisma';

export async function find(keyword: string, options: FindOptions.Marker) {
  const where = {
    title: {
      contains: keyword
    }
  };
  const totalData = await prisma.productCategory.count({ where });
  const totalPage = Math.ceil(totalData / options.perPage);
  const offset = options.perPage * options.page;
  const items = await prisma.productCategory.findMany({
    where,
    skip: offset,
    take: options.perPage,
    orderBy: {
      title: 'asc'
    }
  })
  return {
    totalData,
    totalPage,
    items
  }
}
