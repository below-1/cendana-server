import { FindOptions } from '@cend/commons/find';
import { prisma } from '@cend/commons/prisma';

export async function find(keyword: string, options: FindOptions.Marker) {
  const where = {
    title: {
      contains: keyword
    }
  };
  const totalData = await prisma.productCategory.count({ where });
  let perPage = options.perPage == -1 ? totalData : options.perPage;
  const totalPage = Math.ceil(totalData / perPage);
  const offset = options.perPage * options.page;
  const items = await prisma.productCategory.findMany({
    where,
    skip: offset,
    take: perPage,
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
