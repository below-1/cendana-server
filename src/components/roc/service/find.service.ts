import { prisma } from '@cend/commons/prisma';
import { FindOptions } from '@cend/commons/find';
import { OrderType } from '@prisma/client';
import { toDateUpperLower } from '@cend/commons/to-date-upper-lower'

export type Conditions = {
  year: number;
  month: number;
  keyword: string;
}

export async function find(
  conditions: Conditions, 
  options: FindOptions.Marker
) {
  const { page } = options
  // transform year and month into upper and lower date
  const { month, year } = conditions
  const { lower: lowerDate, upper: upperDate } = toDateUpperLower(year, month)
  const where = {
    AND: [
      { pengembalianModalFlag: { gt: 0 } },
      { createdAt: {
        gte: lowerDate,
        lte: upperDate
      }}
    ]
  }

  const totalData = await prisma.transaction.count({
    where
  });

  const perPage = options.perPage == -1 ? totalData : options.perPage;
  const totalPage = perPage == 0 ? 0 : Math.ceil(totalData / perPage);
  const offset = perPage * options.page;

  const items = await prisma.transaction.findMany({
    where,
    skip: offset,
    take: options.perPage,
    orderBy: {
      createdAt: 'desc'
    },
    include: {
      author: true
    }
  })

  return {
    totalPage,
    totalData,
    items
  };
}