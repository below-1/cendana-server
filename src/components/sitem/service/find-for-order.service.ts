import { prisma } from '@cend/commons/prisma';
import { FindResult, FindOptions } from '@cend/commons/find';

export async function findForOrder(orderId: number, options: FindOptions.Marker) {
  const totalData = await prisma.stockItem.count({
    where: {
      orderId
    }
  });
  const perPage = options.perPage == -1 ? totalData : options.perPage;
  const totalPage = Math.ceil(totalData / perPage);
  const offset = options.page * perPage;
  const items = await prisma.stockItem.findMany({
    where: {
      orderId
    },
    include: {
      product: true
    },
    skip: offset,
    take: perPage
  });
  return {
    items,
    totalPage,
    totalData
  };
}