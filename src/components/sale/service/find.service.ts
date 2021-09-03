import { prisma } from '@cend/commons/prisma';
import { OrderType } from '@prisma/client';
import { FindOptions } from '@cend/commons/find';
import { toDateUpperLower } from '@cend/commons/to-date-upper-lower'

export type Conditions = {
  year: number;
  month: number;
  keyword: string;
}


export async function find(conditions: Conditions, options: FindOptions.Marker) {
  const { page } = options
  // transform year and month into upper and lower date
  const { month, year } = conditions
  const { lower: lowerDate, upper: upperDate } = toDateUpperLower(year, month)
  const where = {
    AND: [
      { orderType: OrderType.SALE },
      { targetUser: { name: { contains: '' } } },
      { createdAt: {
        gte: lowerDate,
        lte: upperDate
      }}
    ]
  }

  const totalData = await prisma.order.count({
    where
  });

  const perPage = options.perPage == -1 ? totalData : options.perPage;
  const totalPage = perPage == 0 ? 0 : Math.ceil(totalData / perPage);
  const offset = perPage * options.page;
  const items = await prisma.order.findMany({
    where,
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
