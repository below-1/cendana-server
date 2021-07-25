import { prisma } from '@cend/commons/prisma';
import { StockItem } from '@prisma/client';
import { FindResult, FindOptions } from '@cend/commons/find';

export async function findById(id: number) {
  const stockItem = await prisma.stockItem.findFirst({ where: { id } });
  return stockItem;
}

export async function findForOrder(orderId: number) {
  const items = await prisma.stockItem.findMany({
    where: {
      orderId
    }
  });
  return items;
}

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

export async function findAll(options: FindOptions.Marker): Promise<FindResult<StockItem>> {
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