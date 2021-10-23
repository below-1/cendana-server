import { prisma } from '@cend/commons/prisma';
import { FindOptions } from '@cend/commons/find';

export async function find(options: FindOptions.Marker) {
  const totalData = await prisma.equityChange.count()
  let totalPage = totalData;
  if (options.perPage != -1) {
    totalPage = Math.ceil(totalData / options.perPage);
  }
  const offset = options.perPage * options.page;
  const items = prisma.equityChange.findMany({
    include: {
      transaction: true
    },
    skip: offset,
    take: options.perPage
  })
  return {
    totalPage,
    totalData,
    items
  }
}