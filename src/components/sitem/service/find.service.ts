import { prisma } from '@cend/commons/prisma';
import { StockItem } from '@prisma/client';
import { FindResult, FindOptions } from '@cend/commons/find';

export async function find(options: FindOptions.Marker): Promise<FindResult<StockItem>> {
  const totalData = await prisma.stockItem.count();
  const totalPage = Math.ceil(totalData / options.perPage);
  const offset = options.page * options.perPage;
  const items = await prisma.stockItem.findMany({
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