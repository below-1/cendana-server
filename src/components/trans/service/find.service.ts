import { prisma } from '@cend/commons/prisma';
import {
  TransactionStatus,
  TransactionType,
  PaymentMethod
} from '@prisma/client';
import { FindOptions as BaseOptions } from '@cend/commons/find';

export enum TransType {
  PURCHASE = 'PURCHASE',
  SALE = 'SALE',
  OPEX = 'OPEX',
  ALL = 'ALL'
}

interface FindOptions extends BaseOptions.Marker {
  keyword?: string;
}

export async function findTransactions(t: TransType, options: FindOptions) {
  let where: any
  switch (t) {
    
    case TransType.PURCHASE:
      where = {AND: [ 
          {orderId: { gte: 1 }},
          {type: TransactionType.CREDIT}
      ]}
      break;

    case TransType.SALE:
      where = {AND: [ 
          {orderId: { gte: 1 }},
          {type: TransactionType.DEBIT}
      ]}
      break;

    case TransType.OPEX:
      where = {AND: [ 
          {opexId: { gte: 1 }},
          {opex: { title: { contains: options.keyword }}},
          {type: TransactionType.CREDIT}
      ]}
      break;

    case TransType.ALL:
      where = {}
      break;
    default:
      throw new Error('unknown t')
  }

  const totalData = await prisma.transaction.count({
    where
  })

  const perPage = options.perPage == -1 ? totalData : options.perPage
  const totalPage = Math.ceil(totalData / perPage)
  const offset = perPage * options.page

  const items = await prisma.transaction.findMany({
    where,
    include: {
      opex: true,
      order: true,
      author: true
    },
    orderBy: {
      createdAt: 'desc'
    },
    take: perPage,
    skip: offset
  })

  return {
    totalPage,
    totalData,
    items
  }
}