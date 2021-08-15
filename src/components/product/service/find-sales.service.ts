import { prisma } from '@cend/commons/prisma'
import { FindOptions } from '@cend/commons/find'
import {
  TransactionStatus,
  OrderStatus
} from '@prisma/client';

export async function findSales(
  productId: number, 
  options: FindOptions.Marker
) {
  const totalData = await prisma.orderItem.count({
    where: {
      AND: [
        { productId },
        {
          order: {
            orderStatus: OrderStatus.SEALED,
            transaction: {
              status: TransactionStatus.SUCCESS
            }
          }
        }
      ]
    }
  })

  const perPage = options.perPage == -1 ? totalData : options.perPage;
  const totalPage = Math.ceil(totalData / perPage);
  const offset = perPage * options.page;

  const items = await prisma.orderItem.findMany({
    where: {
      productId
    },
    orderBy: {
      createdAt: 'desc'
    },
    include: {
      order: {
        include: {
          targetUser: true
        }
      },
      author: true
    }
  })

  return {
    items,
    totalPage,
    totalData
  }
}