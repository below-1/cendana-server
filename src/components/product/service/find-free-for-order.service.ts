import { prisma } from '@cend/commons/prisma'

type FindOptions = {
  keyword: string;
  page: number;
  perPage: number;
}

export async function findFreeForOrder(orderId: number, options: FindOptions) {
  const currentOrderItems = await prisma.orderItem.findMany({
    where: {
      orderId
    }
  })
  const existIds = currentOrderItems.map(o => o.productId)
  const totalData = await prisma.product.count({
    where: {
      AND: [
        {available: {gt: 0}},
        {id: { notIn: existIds }},
        {name: { contains: options.keyword }}
      ]
    }
  })
  const perPage = options.perPage == -1 ? totalData : options.perPage;
  const totalPage = Math.ceil(totalData / perPage);
  const offset = perPage * options.page

  const items = await prisma.product.findMany({
    where: {
      AND: [
        {available: {gt: 0}},
        {id: { notIn: existIds }},
        {name: { contains: options.keyword }}
      ]
    },
    include: {
      stockRecords: {
        orderBy: {
          createdAt: 'desc'
        },
        take: 1
      }
    },
    skip: offset,
    take: perPage
  })
  return {
    totalPage,
    totalData,
    items
  }
}