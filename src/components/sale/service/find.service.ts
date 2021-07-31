import { prisma } from '@cend/commons/prisma';
import { OrderType } from '@prisma/client';
import { FindOptions } from '@cend/commons/find';


export async function find(options: FindOptions.Marker) {
  const totalData = await prisma.order.count({
    where: {
      AND: [
        { orderType: OrderType.SALE }
      ]
    }
  });
  const perPage = options.perPage == -1 ? totalData : options.perPage;
  const totalPage = perPage == 0 ? 0 : Math.ceil(totalData / perPage);
  const offset = perPage * options.page;
  const items = await prisma.order.findMany({
    where: {
      AND: [
        { orderType: OrderType.SALE }
      ]
    },
    skip: offset,
    take: options.perPage,
    orderBy: {
      createdAt: 'desc'
    },
    include: {
      transaction: true,
      delay: true,
      author: true,
      targetUser: true
    }
  });
  return {
    totalPage,
    totalData,
    items
  };
}
