import { prisma } from '@cend/commons/prisma';
import { FindOptions } from '@cend/commons/find';

export async function findTransactions(keyword: string, options: FindOptions.Marker) {
  const totalData = await prisma.transaction.count({
    where: {
      opexId: {
        gte: 1
      }
    }
  });

  const perPage = options.perPage == -1 ? totalData : options.perPage
  const totalPage = Math.ceil(totalData / perPage)
  const offset = perPage * options.page

  const items = await prisma.transaction.findMany({
    where: {
      opex: {
        title: {
          contains: keyword
        }
      }
    },
    include: {
      opex: true,
      author: true
    },
    skip: offset,
    take: perPage,
    orderBy: {
      createdAt: 'desc'
    }
  })

  return {
    totalPage,
    totalData,
    items
  }
}
