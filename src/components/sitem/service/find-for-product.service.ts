import { prisma } from '@cend/commons/prisma';
import { StockItem } from '@prisma/client';
import { FindResult, FindOptions } from '@cend/commons/find';

export async function findForProduct(productId: number, options: FindOptions.Marker): Promise<FindResult<StockItem>> {
  const totalData = await prisma.stockItem.count({
    where: {
      productId
    }
  });
  const totalPage = Math.ceil(totalData / options.perPage);
  const offset = options.page * options.perPage;
  const items = await prisma.stockItem.findMany({
    where: {
      productId
    },
    skip: offset,
    take: options.perPage,
    orderBy: {
      createdAt: 'desc'
    }
  })
  return {
    totalData,
    totalPage,
    items
  }
}
